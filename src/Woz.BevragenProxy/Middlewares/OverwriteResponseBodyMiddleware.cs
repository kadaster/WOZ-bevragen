using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using System.IO;
using System.IO.Compression;
using System.Linq;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using Woz.BevragenProxy.Domain;

namespace Woz.BevragenProxy.Middlewares
{
    public class OverwriteResponseBodyMiddleware
    {
        private readonly RequestDelegate _next;
        private readonly ILogger<OverwriteResponseBodyMiddleware> _logger;
        private static readonly Regex _isRaadpleegActueelWozobjectEndpoint = new(@"\/wozobjecten\/\d{12}");

        public OverwriteResponseBodyMiddleware(RequestDelegate next, ILogger<OverwriteResponseBodyMiddleware> logger)
        {
            _next = next;
            _logger = logger;
        }

        public async Task InvokeAsync(HttpContext context)
        {
            var orgBodyStream = context.Response.Body;

            using var newBodyStream = new MemoryStream();
            context.Response.Body = newBodyStream;

            await _next(context);

            var body = await context.Response.ReadBodyAsync();

            _logger.LogInformation($"original:{body}");

            if (context.Response.StatusCode == StatusCodes.Status200OK)
            {
                var modifiedBody = body.Transform(_isRaadpleegActueelWozobjectEndpoint.IsMatch(context.Request.Path));
                _logger.LogInformation($"modified:{modifiedBody}");

                using var modifiedBodyStream = modifiedBody.ToMemoryStream();

                context.Response.ContentLength = modifiedBodyStream.Length;
                await modifiedBodyStream.CopyToAsync(orgBodyStream);
            }
            else
            {
                _logger.LogInformation($"received status code:{context.Response.StatusCode}");

                using var modifiedBodyStream = body.ToMemoryStream();

                context.Response.ContentLength = modifiedBodyStream.Length;
                await modifiedBodyStream.CopyToAsync(orgBodyStream);
            }
        }
    }

    public static class WozObjectHelpers
    {
        public static string Transform(this string payload, bool isObject)
        {
            string retval;

            if (isObject)
            {
                var wozObject = JsonConvert.DeserializeObject<DataTransferObjects.WozObjectHal>(payload);
                wozObject.Waarden = wozObject.Waarden.BepaalRelevanteWaarden()?.ToArray();

                retval = JsonConvert.SerializeObject(wozObject);
            }
            else
            {
                var wozObjecten = JsonConvert.DeserializeObject<DataTransferObjects.WozObjectHalCollectie>(payload);
                foreach (var wozObject in wozObjecten._embedded.WozObjecten)
                {
                    wozObject.Waarden = wozObject.Waarden.BepaalRelevanteWaarden()?.ToArray();
                }

                retval = JsonConvert.SerializeObject(wozObjecten);
            }

            return retval;
        }
    }

    public static class HttpResponseHelpers
    {
        public static async Task<string> ReadBodyAsync(this HttpResponse response)
        {
            response.Body.Seek(0, SeekOrigin.Begin);

            var gzipStream = new GZipStream(response.Body, CompressionMode.Decompress);
            var streamReader = new StreamReader(gzipStream);

            var retval = await streamReader.ReadToEndAsync();

            response.Body.Seek(0, SeekOrigin.Begin);

            return retval;
        }
    }

    public static class MemoryStreamHelpers
    {
        public static MemoryStream ToMemoryStream(this string data)
        {
            var retval = new MemoryStream();

            var gzipStream = new GZipStream(retval, CompressionMode.Compress);
            var streamWriter = new StreamWriter(gzipStream);

            streamWriter.Write(data);
            streamWriter.Flush();

            retval.Seek(0, SeekOrigin.Begin);

            return retval;
        }
    }
}

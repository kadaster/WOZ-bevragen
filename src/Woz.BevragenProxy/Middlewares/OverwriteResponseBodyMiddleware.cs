using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Logging;
using System.IO;
using System.IO.Compression;
using System.Threading.Tasks;

namespace Woz.BevragenProxy.Middlewares
{
    public class OverwriteResponseBodyMiddleware
    {
        private readonly RequestDelegate _next;
        private readonly ILogger<OverwriteResponseBodyMiddleware> _logger;

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

            _logger.LogInformation(body);

            using var modifiedBodyStream = ("modified: " + body).ToMemoryStream();

            context.Response.ContentLength = modifiedBodyStream.Length;
            await modifiedBodyStream.CopyToAsync(orgBodyStream);
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

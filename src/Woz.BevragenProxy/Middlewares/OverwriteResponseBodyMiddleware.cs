using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using System.IO;
using System.IO.Compression;
using System.Linq;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using Woz.BevragenProxy.Domain;

namespace Woz.BevragenProxy.Middlewares;

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

            using var modifiedBodyStream = modifiedBody.ToMemoryStream(context.Response.UseGzip());

            context.Response.ContentLength = modifiedBodyStream.Length;
            await modifiedBodyStream.CopyToAsync(orgBodyStream);
        }
        else
        {
            _logger.LogInformation($"received status code:{context.Response.StatusCode}");

            using var modifiedBodyStream = body.ToMemoryStream(context.Response.UseGzip());

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
            if(wozObjecten._embedded.WozObjecten != null)
            {
                foreach (var wozObject in wozObjecten._embedded.WozObjecten)
                {
                    wozObject.Waarden = wozObject.Waarden.BepaalRelevanteWaarden()?.ToArray();
                }
            }

            retval = JsonConvert.SerializeObject(wozObjecten);
        }

        return retval;
    }
}

public static class HttpResponseHelpers
{
    public static bool UseGzip(this HttpResponse response) => response.Headers.ContentEncoding.Contains("gzip");

    public static async Task<string> ReadBodyAsync(this HttpResponse response)
    {
        try
        {
            if (response.UseGzip())
            {
                return await ReadCompressedBodyAsync(response);
            }
            else
            {
                return await ReadUncompressedBodyAsync(response);
            }
        }
        catch (InvalidDataException)
        {
            return await ReadUncompressedBodyAsync(response);
        }
    }

    private static async Task<string> ReadCompressedBodyAsync(this HttpResponse response)
    {
        try
        {
            response.Body.Seek(0, SeekOrigin.Begin);

            GZipStream gzipStream = new(response.Body, CompressionMode.Decompress);
            StreamReader streamReader = new(gzipStream);

            return await streamReader.ReadToEndAsync();
        }
        finally
        {
            response.Body.Seek(0, SeekOrigin.Begin);
        }
    }

    private static async Task<string> ReadUncompressedBodyAsync(this HttpResponse response)
    {
        try
        {
            response.Body.Seek(0, SeekOrigin.Begin);

            StreamReader streamReader = new(response.Body);

            return await streamReader.ReadToEndAsync();
        }
        finally
        {
            response.Body.Seek(0, SeekOrigin.Begin);
        }
    }
}

public static class MemoryStreamHelpers
{
    public static MemoryStream ToMemoryStream(this string data, bool gzipCompress)
    {
        MemoryStream retval = new();

        StreamWriter streamWriter = gzipCompress
            ? new StreamWriter(new GZipStream(retval, CompressionMode.Compress))
            : new StreamWriter(retval);

        streamWriter.Write(data);
        streamWriter.Flush();

        retval.Seek(0, SeekOrigin.Begin);

        return retval;
    }
}

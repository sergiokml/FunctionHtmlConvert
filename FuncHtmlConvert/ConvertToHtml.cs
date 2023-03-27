using System.IO;
using System.Threading.Tasks;

using FuncHtmlConvert.Services;

using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using Microsoft.WindowsAzure.Storage.Blob;

namespace FuncHtmlConvert
{
    internal class ConvertToHtml
    {
        private readonly BlobContainerService blobContainer;

        public ConvertToHtml(IConfiguration configuration, BlobContainerService blobContainer)
        {
            this.blobContainer = blobContainer;
            _ = configuration.GetValue<string>("AzureWebJobsStorage");
        }

        [FunctionName("convert")]
        public async Task<IActionResult> Run(
            [HttpTrigger(AuthorizationLevel.Anonymous, "post", Route = "convert")] HttpRequest req,
            ILogger log
        )
        {
            string htmlContent;
            try
            {
                StreamReader body = new(req.Body);
                CloudBlockBlob blob = await blobContainer.LoadBlobAsync();
                if (blob != null)
                {
                    byte[] bytes = new byte[blob.Properties.Length];
                    _ = await blob.DownloadToByteArrayAsync(bytes, 0);
                    XsltHelperService xsltservice = new(bytes);
                    string requestBody = body.ReadToEnd();
                    htmlContent = xsltservice.GenerateHtml(requestBody);
                }
                else
                {
                    string requestBody = body.ReadToEnd();
                    XsltHelperService xsltservice = new();
                    htmlContent = xsltservice.GenerateHtml(requestBody);
                }
                //var htmlToPdf = new NReco.PdfGenerator.HtmlToPdfConverter();
                //var pdfBytes = htmlToPdf.GeneratePdf(htmlContent);
                return new OkObjectResult(htmlContent);
            }
            catch (System.Exception)
            {
                throw;
            }
        }
    }
}

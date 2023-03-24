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
    internal class ConvertToPdf
    {
        private readonly BlobContainerService blobContainer;

        public ConvertToPdf(IConfiguration configuration, BlobContainerService blobContainer)
        {
            this.blobContainer = blobContainer;
            _ = configuration.GetValue<string>("AzureWebJobsStorage");
        }

        [FunctionName("ConvertToPdf")]
        public async Task<IActionResult> Run(
            [HttpTrigger(AuthorizationLevel.Anonymous, "get", "post", Route = null)]
                HttpRequest req,
            ILogger log
        )
        {
            try
            {
                CloudBlockBlob blob = await blobContainer.LoadBlobAsync();
                byte[] bytes = new byte[blob.Properties.Length];
                _ = await blob.DownloadToByteArrayAsync(bytes, 0);
                XsltHelperService xsltservice = new(bytes);
                StreamReader body = new(req.Body);
                string requestBody = body.ReadToEnd();
                string htmlContent = xsltservice.GenerateHtml(requestBody);

                var htmlToPdf = new NReco.PdfGenerator.HtmlToPdfConverter();
                var pdfBytes = htmlToPdf.GeneratePdf(htmlContent);
                return new FileContentResult(pdfBytes, "application/pdf");
            }
            catch (System.Exception)
            {
                throw;
            }
        }
    }
}

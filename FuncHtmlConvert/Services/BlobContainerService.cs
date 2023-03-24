using System.Threading.Tasks;

using Microsoft.Extensions.Configuration;
using Microsoft.WindowsAzure.Storage;
using Microsoft.WindowsAzure.Storage.Blob;

namespace FuncHtmlConvert.Services
{
    internal class BlobContainerService
    {
        private readonly IConfiguration configuration;

        public BlobContainerService(IConfiguration configuration)
        {
            this.configuration = configuration;
        }

        public async Task<CloudBlockBlob> LoadBlobAsync()
        {
            if (
                CloudStorageAccount.TryParse(
                    configuration.GetValue<string>("AzureWebJobsStorage"),
                    out CloudStorageAccount account
                )
            )
            {
                CloudBlobClient cliente = account.CreateCloudBlobClient();
                CloudBlobContainer cont = cliente.GetContainerReference(
                    configuration.GetValue<string>("ADConfig:Container")
                );
                if (await cont.ExistsAsync())
                {
                    CloudBlockBlob block = cont.GetBlockBlobReference(
                        configuration.GetValue<string>("ADConfig:Template")
                    );
                    if (await block.ExistsAsync())
                    {
                        return block;
                    }
                }
            }
            return null;
        }
    }
}

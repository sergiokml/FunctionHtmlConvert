using FuncHtmlConvert;
using FuncHtmlConvert.Services;

using Microsoft.Azure.Functions.Extensions.DependencyInjection;
using Microsoft.Extensions.DependencyInjection;

[assembly: FunctionsStartup(typeof(Startup))]

namespace FuncHtmlConvert
{
    internal class Startup : FunctionsStartup
    {
        public override void Configure(IFunctionsHostBuilder builder)
        {
            _ = builder.Services.AddSingleton<BlobContainerService>();
        }
    }
}

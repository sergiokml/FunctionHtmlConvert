<br />
<p align="center">
  <a href="" target="_blank">
    <img width="20%" src="https://coralogix.com/wp-content/uploads/2021/02/Azure-Functions_large.png" alt="Azure Function">
  </a>
</p>
<br />
<p align="center">
  <a href="LICENSE.txt" target="_blank">
    <img src="https://img.shields.io/badge/License-MIT-yellow.svg" alt="">
  </a>
  <a href="https://github.com/sergiokml/FunctionHtmlConvert/releases" target="_blank">
    <img src="https://img.shields.io/github/tag/sergiokml/FunctionHtmlConvert.svg" alt="">
  </a>
  <a href="https://github.com/sergiokml/" target="_blank">
    <img src="https://img.shields.io/github/commit-activity/y/sergiokml/FunctionHtmlConvert.svg" alt="">
  </a>
  <a href="https://github.com/sergiokml/FunctionHtmlConvert/contributors" target="_blank">
    <img src="https://img.shields.io/github/contributors-anon/sergiokml/FunctionHtmlConvert.svg" alt="">
  </a>
  <a href="https://github.com/sergiokml/FunctionHtmlConvert/releases" target="_blank">
    <img alt="GitHub all releases" src="https://img.shields.io/github/downloads/sergiokml/FunctionHtmlConvert/total">
  </a> 
</p>
<br />

Function Azure that allows to convert an XML file to an HTML file following the standards for electronic invoices set by [Servicio de Impuestos Internos](https://www.sii.cl/). 
<p align="center">
  <a href="" target="_blank">
    <img width="30%" src="https://user-images.githubusercontent.com/6364350/227446074-04a5c5b2-c7c1-4b3f-84a5-4077b11c969b.png" alt="Pdf417">
  </a>
</p>




Transforms the node "TED" to a barcode PDF417 and embeds it in the result as base64 image then, transforms the content via an XLST template. The file template must be hosted in an Azure storage blob container for consume.

The resulting file is content ready to convert to PDF in browser.

### 📝&nbsp; Details

<table>
  <thead>
  </thead>
  <tbody>     
    <tr>   
      <td style="text-align: left;">Azure Funtions 4.1.1</td>      
    </tr>   
      <tr>   
      <td style="text-align: left;">ZXing.Net 0.16.9</td>      
    </tr> 
         <tr>   
      <td style="text-align: left;">ZXing.Net Drawing 0.16.5-beta</td>      
    </tr>     
  </tbody>
</table>


### ✅&nbsp; Requirements

+ File template in format XSL/XSLT. ([XslCompiledTransform Class](https://learn.microsoft.com/en-us/dotnet/standard/data/xml/how-to-perform-an-xslt-transformation-by-using-an-assembly))
+ DTE Document node.


### 🚀&nbsp; Usage

This function can be hosted on a server and called from a POST request, upload the file and wait for the result in HTML content. You need config the Blob Container for host the template.

Curl: 
```
curl --location 'http://localhost:30374/api/convert' --header 'Content-Type: application/xml' --data '@/C:/Users/.../file.xml'
```

```json
  "Values": {
    "AzureWebJobsStorage": "UseDevelopmentStorage=true",
    "FUNCTIONS_WORKER_RUNTIME": "dotnet",
    "ADConfig:Container": "templates-xslt", // Blob Container name
    "ADConfig:Template": "dte_fromat.sxl" // template name
  }
```
![image](https://user-images.githubusercontent.com/6364350/228015935-4ac06dcc-e632-471b-857d-52565ed9f797.png)

If the templates not exists into *Blob Container* you may use template from "Resources" proyect.


### 📫&nbsp; Have a question? Found a Bug? 

Feel free to **file a new issue** with a respective title and description on the [FunctionHtmlConvert/issues](https://github.com/sergiokml/FunctionHtmlConvert/issues) repository.

### ❤️&nbsp; Community and Contributions

I think that **Knowledge Doesn’t Belong to Just Any One Person**, and I always intend to share my knowledge with other developers, a voluntary monetary contribution or contribute ideas and/or comments to improve these tools would be appreciated.

<p align="center">
    <a href="https://www.paypal.com/donate/?hosted_button_id=PTKX9BNY96SNJ" target="_blank">
        <img width="15%" src="https://img.shields.io/badge/PayPal-00457C?style=for-the-badge&logo=paypal&logoColor=white" alt="Azure Function">
    </a>
</p>


### 📘&nbsp; License

All my repository content is released under the terms of the [MIT License](LICENSE.txt).

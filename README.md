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

Function Azure that allows to convert an XML file to an HTML file following the standards for electronic invoices set by [Servicio de Impuestos Internos](https://www.sii.cl/). Transforms the node "TED" to a barcode Pdf417 and embeds it in the result as base64 image then, transforms the content via an XLST template provided in this repository.

The resulting file is content ready to convert to PDF in browser.

### 📝&nbsp; Details

<table>
  <thead>
  </thead>
  <tbody>
    <tr>    
      <td style="text-align: left;">Framework .Net 6.0</td>      
    </tr>    
    <tr>   
      <td style="text-align: left;">Azure Funtions 4.1.1</td>      
    </tr>
    <tr>   
      <td style="text-align: left;">Sdk Graph 5.2.0</td>      
    </tr>
    <tr>   
      <td style="text-align: left;">Azure Identity 1.8.2</td>      
    </tr>
  </tbody>
</table>


### ✅&nbsp; Requirements

+ A subscription account [Office365](https://developer.microsoft.com/en-us/microsoft-365/dev-program).
+ Register an Application in Azure AD & assign permissions.


### 🚀&nbsp; Usage

This function can be hosted on a server and called from a POST request, upload the file and wait for the result in HTML content.


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

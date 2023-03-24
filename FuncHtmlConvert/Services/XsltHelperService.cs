using System;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Xml;
using System.Xml.Linq;
using System.Xml.Xsl;

using ZXing;
using ZXing.CoreCompat.Rendering;
using ZXing.PDF417;
using ZXing.PDF417.Internal;

namespace FuncHtmlConvert.Services
{
    public class XsltHelperService
    {
        private readonly XslCompiledTransform xlstFile = null!;
        private readonly XsltArgumentList xlstArgs = null!;
        private BarcodeWriter<Bitmap> barcodeWriter = null!;

        private void SetBarCode()
        {
            // https://www.sii.cl/factura_electronica/instructivo_emision.pdf Pag. 22
            barcodeWriter = new()
            {
                Format = BarcodeFormat.PDF_417,
                Options = new PDF417EncodingOptions
                {
                    ErrorCorrection = PDF417ErrorCorrectionLevel.L5,
                    Height = 4,
                    Width = 9,
                    Compaction = Compaction.BYTE,
                    Margin = 2
                },
                Renderer = new BitmapRenderer()
            };
        }

        public XsltHelperService(byte[] bytes)
        {
            xlstFile = new XslCompiledTransform();
            xlstArgs = new XsltArgumentList();
            using MemoryStream ms = new(bytes);
            XmlReaderSettings settings = new() { Async = true };
            using XmlReader xr = XmlReader.Create(ms, settings);
            xlstFile.Load(xr);
            SetBarCode();
        }

        private static string GetNode(string inputXml)
        {
            XDocument t = XDocument.Parse(inputXml, LoadOptions.None);
            XElement ted = t!
                .Descendants()
                .Elements()
                .ToList()
                .Where(c => c.Name.LocalName == "TED")
                .FirstOrDefault();
            // https://www.sii.cl/factura_electronica/instructivo_emision.pdf Pag.21
            Match match = Regex.Match(ted!.ToString(), @"(<DD.*?</DD>)", RegexOptions.Singleline);
            string res = match.Value;
            if (match.Success)
            {
                res = Regex.Replace(res, @">\s+<", @"><");
            }
            return res! ?? null!;
        }

        public string GenerateHtml(string inputXml)
        {
            // RECIBE NODO <DTE> </DTE>
            string ted = GetNode(inputXml);
            try
            {
                using StringReader sr = new(inputXml);
                using XmlReader reader = XmlReader.Create(sr);
                using StringWriter xml = new();
                using MemoryStream imagen = new();
                Bitmap timbre = barcodeWriter.Write(ted);
                using Bitmap bitmap = new(timbre);
                bitmap.Save(imagen, ImageFormat.Png);
                string imagenBase64 = Convert.ToBase64String(imagen.GetBuffer());
                xlstArgs.AddParam("TedTimbre", "", "data:image/png;base64," + imagenBase64);
                xlstFile.Transform(reader, xlstArgs, xml);
                return xml.ToString();
            }
            catch (Exception)
            {
                throw;
            }
        }
    }
}

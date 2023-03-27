<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                              xmlns:SiiDte="http://www.sii.cl/SiiDte"
                              xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:variable name="Cantidad" select="count(//SiiDte:EnvioDTE/SiiDte:SetDTE/SiiDte:DTE)"/>
  <xsl:variable name="NroResol" select="//SiiDte:EnvioDTE/SiiDte:SetDTE/SiiDte:Caratula/SiiDte:NroResol"/>
  <xsl:variable name="FchResol" select="//SiiDte:EnvioDTE/SiiDte:SetDTE/SiiDte:Caratula/SiiDte:FchResol"/>
  <xsl:variable name="watermark" select="''"/>
  <xsl:variable name="Cantidadx" select="count(//DTE)"/>
  <xsl:variable name="NroResolx" select="$NroResol"/>
  <xsl:variable name="FchResolx" select="$FchResol"/>
 <xsl:variable name ="v1" select= "-p-"/>


	<xsl:param name="TedTimbre"></xsl:param>


  <xsl:template match="/">
    <HTML>
      <HEAD>
        <TITLE>Documentos Electronicos</TITLE>
        <STYLE>
          .Cabecera_Resumen {font-size:24pt;color:black;font-family:Impact;}
          .Linea_Resumen0 {}
          .Linea_Resumen1 {}
          .Linea_Resumen_Fin {}
          .Cabecera_Detalle {font-size:14pt;color:white;background-color:#6699CC;}
          Table TH b{
          font-size: 18px;
          }
          Table TD{
          font-size:12px;
          }
          Table TH{
          font-size: 14px;
          }
          .TablaFactura{
          WIDTH: 650px;
          POSITION: static;
          }
          .bordeIzq{
          border-left:medium;
          border-left-color:black;
          border-left-style:solid;
          border-left-width:thin;
          }
          .boderContendor{
          border-width:thin;border-style:solid;border-color:#000;
          }

        </STYLE>
      </HEAD>
      <BODY>
        <xsl:for-each select="*">
          <xsl:apply-templates/>
        </xsl:for-each>     
      </BODY>
    </HTML>
  </xsl:template>
  <xsl:template match="SiiDte:Caratula">
    <xsl:if test="$Cantidad!=1">
      <TABLE border = "1" BORDERCOLOR="black" CELLSPACING="0" CELLPADDING="0">
        <xsl:for-each select="SiiDte:SubTotDTE">
          <xsl:if test="position()=1">
            <TR class="Cabecera_Resumen">
              <TD>
                <CENTER>Tipo Documento</CENTER>
              </TD>
              <TD>Cantidad Documentos</TD>
            </TR>
          </xsl:if>
          <TR class="Linea_Resumen{position() mod 2}">
            <TD>
              (<xsl:value-of select="SiiDte:TpoDTE"/>)<xsl:apply-templates select="SiiDte:TpoDTE" mode="tipodte"/>
            </TD>
            <TD>
              <CENTER>
                <xsl:value-of select="SiiDte:NroDTE"/>
              </CENTER>
            </TD>
          </TR>
        </xsl:for-each>
      </TABLE>
    </xsl:if>
  </xsl:template>
  <xsl:template match="SiiDte:Documento">
    <xsl:variable name="CantidadUmed" select="count(SiiDte:Detalle/SiiDte:UnmdItem)"/>
    <xsl:variable name="CantidadCant" select="count(SiiDte:Detalle/SiiDte:QtyItem)"/>
    <xsl:variable name="CantidadDesc" select="count(SiiDte:Detalle/SiiDte:DescuentoMonto)"/>
    <xsl:variable name="CantidadReca" select="count(SiiDte:Detalle/SiiDte:RecargoMonto)"/>
    <xsl:variable name="CantidadPUni" select="count(SiiDte:Detalle/SiiDte:PrcItem)"/>



    <TABLE BORDER="0" class="TablaFactura">
      <TR>
        <TD>
          <div style="position:absolute;font-size:130;font-family:Times New Roman;color:#F0F0F0;z-index:-1">
            <xsl:value-of select="$watermark"/>
          </div>
          <TABLE BORDER="0" style="WIDTH: 650px">
            <TR>
              <TD>
                <TABLE>
                  <TR>
                    <TH colspan="2"  ALIGN="Left">
                      <font style="font-size:24;">
                        <B>
                          <xsl:value-of select="SiiDte:Encabezado/SiiDte:Emisor/SiiDte:RznSoc"/>
                        </B>
                      </font>
                    </TH>
                  </TR>
                  <br></br>
                  <TR>
                    <TD ALIGN="Left">
                      <B>Giro:</B>
                    </TD>
                    <TD>
                      <xsl:value-of select="SiiDte:Encabezado/SiiDte:Emisor/SiiDte:GiroEmis"/>
                    </TD>
                  </TR>
                  <TR>
                    <TD ALIGN="Left">
                      <B>Direccion:</B>
                    </TD>
                    <TD>
                      <!--<xsl:value-of select="SiiDte:Encabezado/SiiDte:Emisor/SiiDte:DirOrigen"/> - <xsl:value-of select="SiiDte:Encabezado/SiiDte:Emisor/SiiDte:CmnaOrigen"/>-->

                      <xsl:value-of select="$v1" />
                    </TD>
                  </TR>
                  <TR>
                    <TD ALIGN="Left">
                      <B>Fecha:</B>
                    </TD>
                    <TD><xsl:apply-templates select="SiiDte:Encabezado/SiiDte:IdDoc/SiiDte:FchEmis" mode="fecha"/></TD>
                    <TD>          
                    </TD>
                  </TR>
                </TABLE>
              </TD>
              <TD ALIGN="RIGHT">
                <TABLE border="1" BORDERCOLOR="red" CELLSPACING="0" CELLPADDING="0">
                  <TR>
                    <TD>
                      <TABLE border="0" WIDTH="190">
                        <TR>
                          <TD>
                            <font style="color:red;">
                              <center>
                                <b>
                                  R.U.T.:<xsl:apply-templates select="SiiDte:Encabezado/SiiDte:Emisor/SiiDte:RUTEmisor" mode="rut"/>
                                </b>
                              </center>
                            </font>
                          </TD>
                        </TR>
                        <TR>
                          <TD>
                            <font style="color:red;">
                              <center>
                                <b>
                                  <xsl:apply-templates select="SiiDte:Encabezado/SiiDte:IdDoc/SiiDte:TipoDTE" mode="tipodte"/>
                                </b>
                              </center>
                            </font>
                          </TD>
                        </TR>
                        <TR>
                          <TD>
                            <font style="color:red;">
                              <center>
                                <b>
                                  Nº <xsl:value-of select="SiiDte:Encabezado/SiiDte:IdDoc/SiiDte:Folio"/>
                                </b>
                              </center>
                            </font>
                          </TD>
                        </TR>
                      </TABLE>
                    </TD>
                  </TR>
                </TABLE>
              </TD>
            </TR>
          </TABLE>
          <div class="boderContendor">
            <TABLE style="WIDTH: 650px">
              <TR>
                <TD>
                  <B>Nombre:</B>
                </TD>
                <TD>
                  <xsl:value-of select="SiiDte:Encabezado/SiiDte:Receptor/SiiDte:RznSocRecep"/>
                </TD>
                <TD/>
                <TD>
                  <B>R.U.T.:</B>
                </TD>
                <TD>
                  <xsl:apply-templates select="SiiDte:Encabezado/SiiDte:Receptor/SiiDte:RUTRecep" mode="rut"/>
                </TD>
              </TR>
              <TR>
                <TD>
                  <B>Direccion :</B>
                </TD>
                <TD>
                  <xsl:value-of select="SiiDte:Encabezado/SiiDte:Receptor/SiiDte:DirRecep"/>
                </TD>
                <TD/>
                <TD>
                  <B>Vencimiento :</B>
                </TD>
                <TD>
                  <xsl:apply-templates select="SiiDte:Encabezado/SiiDte:IdDoc/SiiDte:FchVenc" mode="fecha"/>
                </TD>
              </TR>
              <TR>
                <TD>
                  <B>Comuna :</B>
                </TD>
                <TD>
                  <xsl:value-of select="SiiDte:Encabezado/SiiDte:Receptor/SiiDte:CmnaRecep"/>
                </TD>
                <TD/>
                <TD>
                  <B>Ciudad :</B>
                </TD>
                <TD>
                  <xsl:value-of select="SiiDte:Encabezado/SiiDte:Receptor/SiiDte:CiudadRecep"/>
                </TD>
              </TR>
              <TR>
                <TD>
                  <B>Giro :</B>
                </TD>
                <TD>
                  <xsl:value-of select="SiiDte:Encabezado/SiiDte:Receptor/SiiDte:GiroRecep"/>
                </TD>
                <TD/>
                <TD>
                  <B>Vendedor :</B>
                </TD>
                <TD>
                  <xsl:value-of select="SiiDte:Encabezado/SiiDte:Receptor/SiiDte:CdgVendedor"/>
                </TD>
              </TR>
            </TABLE>
          </div>
          <br></br>
          <div>
            <TABLE BORDER="0" style="WIDTH: 650px">
              <TR>
                <TD>
                  <TABLE border="1" style="WIDTH: 650px" BORDERCOLOR="black" CELLSPACING="0" CELLPADDING="0">
                    <xsl:for-each select="SiiDte:Detalle">
                      <xsl:if test="position()=1">
                        <TR class="Cabecera_Detalle">
                          <TH colspan="8">Detalle Productos/Servicios</TH>
                        </TR>
                        <TR class="Cabecera_Detalle">
                          <TH style="WIDTH: 1%; POSITION: static">Item</TH>
                          <xsl:if test="$CantidadCant!=0">
                            <TH style="WIDTH: 2%">Cantidad</TH>
                          </xsl:if>
                          <xsl:if test="$CantidadUmed!=0">
                            <TH style="WIDTH: 2%">U.Med.</TH>
                          </xsl:if>
                          <xsl:if test="$CantidadPUni!=0">
                            <TH>Descripcion</TH>
                          </xsl:if>
                          <xsl:if test="$CantidadPUni=0">
                            <TH colspan="2">Descripcion</TH>
                          </xsl:if>
                          <xsl:if test="$CantidadPUni!=0">
                            <TH>P.Unit.</TH>
                          </xsl:if>
                          <xsl:if test="$CantidadDesc!=0">
                            <TH>Desc.</TH>
                          </xsl:if>
                          <xsl:if test="$CantidadReca!=0">
                            <TH>Reca.</TH>
                          </xsl:if>
                          <TH>Monto</TH>
                        </TR>
                      </xsl:if>
                      <TR>
                        <TD style="VERTICAL-ALIGN: top">
                          <xsl:value-of select="SiiDte:NroLinDet"/>
                        </TD>
                        <xsl:if test="$CantidadCant!=0">
                          <xsl:apply-templates select="SiiDte:QtyItem" mode="montox"/>
                        </xsl:if>
                        <xsl:if test="$CantidadUmed!=0">
                          <TD style="VERTICAL-ALIGN: top">
                            <xsl:value-of select="SiiDte:UnmdItem"/>.
                          </TD>
                        </xsl:if>
                        <xsl:if test="$CantidadPUni!=0">
                          <xsl:choose>
                            <xsl:when test="SiiDte:DscItem">
                              <TD>
                                <TABLE>
                                  <TR>
                                    <TD>
                                      <xsl:value-of select="SiiDte:NmbItem"/>
                                    </TD>
                                  </TR>
                                  <TR>
                                    <TD>
                                      <xsl:value-of select="SiiDte:DscItem"/>
                                    </TD>
                                  </TR>
                                </TABLE>
                              </TD>
                            </xsl:when>
                            <xsl:otherwise>
                              <TD>
                                <xsl:value-of select="SiiDte:NmbItem"/>
                              </TD>
                            </xsl:otherwise>
                          </xsl:choose>
                        </xsl:if>
                        <xsl:if test="$CantidadPUni=0">
                          <xsl:choose>
                            <xsl:when test="SiiDte:DscItem">
                              <TD colspan="2">
                                <TABLE>
                                  <TR>
                                    <TD>
                                      <xsl:value-of select="SiiDte:NmbItem"/>
                                    </TD>
                                  </TR>
                                  <TR>
                                    <TD>
                                      <xsl:value-of select="SiiDte:DscItem"/>
                                    </TD>
                                  </TR>
                                </TABLE>
                              </TD>
                            </xsl:when>
                            <xsl:otherwise>
                              <TD colspan="2">
                                <xsl:value-of select="SiiDte:NmbItem"/>
                              </TD>
                            </xsl:otherwise>
                          </xsl:choose>
                        </xsl:if>
                        <xsl:if test="$CantidadPUni!=0">
                          <xsl:apply-templates select="SiiDte:PrcItem" mode="montox"/>
                        </xsl:if>
                        <xsl:if test="$CantidadDesc!=0">
                          <xsl:apply-templates select="SiiDte:DescuentoMonto" mode="montox"/>
                        </xsl:if>
                        <xsl:if test="$CantidadReca!=0">
                          <xsl:apply-templates select="SiiDte:RecargoMonto" mode="montox"/>
                        </xsl:if>
                        <xsl:apply-templates select="SiiDte:MontoItem" mode="monto"/>
                      </TR>
                    </xsl:for-each>
                    <TR>
                      <xsl:if test="$CantidadUmed!=0">
                        <xsl:if test="$CantidadCant!=0">
                          <xsl:if test="$CantidadDesc!=0">
                            <xsl:if test="$CantidadReca!=0">
                              <TD colspan="6" rowspan="4">
                                <xsl:apply-templates select="SiiDte:TED" mode="zonatimbre"/>
                              </TD>
                            </xsl:if>
                            <xsl:if test="$CantidadReca=0">
                              <TD colspan="5" rowspan="4">
                                <xsl:apply-templates select="SiiDte:TED" mode="zonatimbre"/>
                              </TD>
                            </xsl:if>
                          </xsl:if>
                          <xsl:if test="$CantidadDesc=0">
                            <xsl:if test="$CantidadReca!=0">
                              <TD colspan="5" rowspan="4">
                                <xsl:apply-templates select="SiiDte:TED" mode="zonatimbre"/>
                              </TD>
                            </xsl:if>
                            <xsl:if test="$CantidadReca=0">
                              <TD colspan="4" rowspan="4">
                                <xsl:apply-templates select="SiiDte:TED" mode="zonatimbre"/>
                              </TD>
                            </xsl:if>
                          </xsl:if>
                        </xsl:if>
                        <xsl:if test="$CantidadCant=0">
                          <xsl:if test="$CantidadDesc!=0">
                            <xsl:if test="$CantidadReca!=0">
                              <TD colspan="5" rowspan="4">
                                <xsl:apply-templates select="SiiDte:TED" mode="zonatimbre"/>
                              </TD>
                            </xsl:if>
                            <xsl:if test="$CantidadReca=0">
                              <TD colspan="4" rowspan="4">
                                <xsl:apply-templates select="SiiDte:TED" mode="zonatimbre"/>
                              </TD>
                            </xsl:if>
                          </xsl:if>
                          <xsl:if test="$CantidadDesc=0">
                            <xsl:if test="$CantidadReca!=0">
                              <TD colspan="4" rowspan="4">
                                <xsl:apply-templates select="SiiDte:TED" mode="zonatimbre"/>
                              </TD>
                            </xsl:if>
                            <xsl:if test="$CantidadReca=0">
                              <TD colspan="3" rowspan="4">
                                <xsl:apply-templates select="SiiDte:TED" mode="zonatimbre"/>
                              </TD>
                            </xsl:if>
                          </xsl:if>
                        </xsl:if>
                      </xsl:if>
                      <xsl:if test="$CantidadUmed=0">
                        <xsl:if test="$CantidadCant!=0">
                          <xsl:if test="$CantidadDesc!=0">
                            <xsl:if test="$CantidadReca!=0">
                              <TD colspan="5" rowspan="4">
                                <xsl:apply-templates select="SiiDte:TED" mode="zonatimbre"/>
                              </TD>
                            </xsl:if>
                            <xsl:if test="$CantidadReca=0">
                              <TD colspan="4" rowspan="4">
                                <xsl:apply-templates select="SiiDte:TED" mode="zonatimbre"/>
                              </TD>
                            </xsl:if>
                          </xsl:if>
                          <xsl:if test="$CantidadDesc=0">
                            <xsl:if test="$CantidadReca!=0">
                              <TD colspan="4" rowspan="4">
                                <xsl:apply-templates select="SiiDte:TED" mode="zonatimbre"/>
                              </TD>
                            </xsl:if>
                            <xsl:if test="$CantidadReca=0">
                              <TD colspan="3" rowspan="4">
                                <xsl:apply-templates select="SiiDte:TED" mode="zonatimbre"/>
                              </TD>
                            </xsl:if>
                          </xsl:if>
                        </xsl:if>
                        <xsl:if test="$CantidadCant=0">
                          <xsl:if test="$CantidadDesc!=0">
                            <xsl:if test="$CantidadReca!=0">
                              <TD colspan="4" rowspan="4">
                                <xsl:apply-templates select="SiiDte:TED" mode="zonatimbre"/>
                              </TD>
                            </xsl:if>
                            <xsl:if test="$CantidadReca=0">
                              <TD colspan="3" rowspan="4">
                                <xsl:apply-templates select="SiiDte:TED" mode="zonatimbre"/>
                              </TD>
                            </xsl:if>
                          </xsl:if>
                          <xsl:if test="$CantidadDesc=0">
                            <xsl:if test="$CantidadReca!=0">
                              <TD colspan="3" rowspan="4">
                                <xsl:apply-templates select="SiiDte:TED" mode="zonatimbre"/>
                              </TD>
                            </xsl:if>
                            <xsl:if test="$CantidadReca=0">
                              <TD colspan="2" rowspan="4">
                                <xsl:apply-templates select="SiiDte:TED" mode="zonatimbre"/>
                              </TD>
                            </xsl:if>
                          </xsl:if>
                        </xsl:if>
                      </xsl:if>
                      <TD style="VERTICAL-ALIGN: bottom; TEXT-ALIGN: right">
                        <xsl:if test="SiiDte:Encabezado/SiiDte:Totales/SiiDte:MntNeto">
                          <B>Neto :</B>
                        </xsl:if>
                      </TD>
                      <xsl:apply-templates select="SiiDte:Encabezado/SiiDte:Totales/SiiDte:MntNeto" mode="monto"/>
                    </TR>
                    <TR>
                      <TD  style="VERTICAL-ALIGN: bottom; TEXT-ALIGN: right">
                        <xsl:if test="SiiDte:Encabezado/SiiDte:Totales/SiiDte:MntExe">
                          <B>Exento :</B>
                        </xsl:if>
                      </TD>
                      <xsl:apply-templates select="SiiDte:Encabezado/SiiDte:Totales/SiiDte:MntExe" mode="monto"/>
                    </TR>
                    <TR>
                      <TD  style="VERTICAL-ALIGN: bottom; TEXT-ALIGN: right">
                        <xsl:if test="SiiDte:Encabezado/SiiDte:Totales/SiiDte:IVA">
                          <B>IVA :</B>
                        </xsl:if>
                      </TD>
                      <xsl:apply-templates select="SiiDte:Encabezado/SiiDte:Totales/SiiDte:IVA" mode="monto"/>
                    </TR>
                    <TR>
                      <TD  style="VERTICAL-ALIGN: bottom; TEXT-ALIGN: right">
                        <B>Total :</B>
                      </TD>
                      <xsl:apply-templates select="SiiDte:Encabezado/SiiDte:Totales/SiiDte:MntTotal" mode="monto"/>
                    </TR>
                  </TABLE>
                </TD>
              </TR>
            </TABLE>
          </div>
        </TD>
      </TR>
    </TABLE>
  </xsl:template>
  <xsl:template match="*">
  </xsl:template>
  <xsl:template match="SiiDte:EnvioDTE">
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="SiiDte:SetDTE">
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="SiiDte:DTE">
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="SiiDte:Detalle">
  </xsl:template>
  <xsl:template match="SiiDte:Signature">
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="Documento">
    <xsl:variable name="CantidadUmed" select="count(Detalle/UnmdItem)"/>
    <xsl:variable name="CantidadCant" select="count(Detalle/QtyItem)"/>
    <xsl:variable name="CantidadDesc" select="count(Detalle/DescuentoMonto)"/>
    <xsl:variable name="CantidadReca" select="count(Detalle/RecargoMonto)"/>
    <xsl:variable name="CantidadPUni" select="count(Detalle/PrcItem)"/>
    <TABLE BORDER="1" style="WIDTH: 650px;  POSITION: static">
      <TR>
        <TD>
          <div style="position:absolute;font-size:130;font-family:Times New Roman;color:#F0F0F0;z-index:-1">
            <xsl:value-of select="$watermark"/>
          </div>
          <TABLE BORDER="0" style="WIDTH: 650px">
            <TR>
              <TD>
                <TABLE>
                  <TR>
                    <TH colspan="2">
                      <font style="font-size:24;">
                        <B>
                          <xsl:value-of select="Encabezado/Emisor/RznSoc"/>
                        </B>
                      </font>
                    </TH>
                  </TR>
                  <TR>
                    <TD ALIGN="right">
                      <B>Giro:</B>
                    </TD>
                    <TD>
                      <xsl:value-of select="Encabezado/Emisor/GiroEmis"/>
                    </TD>
                  </TR>
                  <TR>
                    <TD ALIGN="right">
                      <B>Direccion:</B>
                    </TD>
                    <TD>
                      <!--<xsl:value-of select="Encabezado/Emisor/DirOrigen"/> - <xsl:value-of select="Encabezado/Emisor/CmnaOrigen"/>-->
                      <xsl:value-of select="$v1" />
                    </TD>
                  </TR>
                  <TR>
                    <TD ALIGN="right">
                      <B>Fecha:</B>
                    </TD>
                    <TD><xsl:apply-templates select="Encabezado/IdDoc/FchEmis" mode="fecha"/></TD>

                    <TD>                
                     
                    </TD>
                  </TR>
                </TABLE>
              </TD>
              <TD ALIGN="RIGHT">
                <TABLE border="1" BORDERCOLOR="red" CELLSPACING="0" CELLPADDING="0">
                  <TR>
                    <TD>
                      <TABLE border="0" WIDTH="190">
                        <TR>
                          <TD>
                            <font style="color:red;">
                              <center>
                                <b>
                                  R.U.T.:<xsl:apply-templates select="Encabezado/Emisor/RUTEmisor" mode="rut"/>
                                </b>
                              </center>
                            </font>
                          </TD>
                        </TR>
                        <TR>
                          <TD>
                            <font style="color:red;">
                              <center>
                                <b>
                                  <xsl:apply-templates select="Encabezado/IdDoc/TipoDTE" mode="tipodte"/>
                                </b>
                              </center>
                            </font>
                          </TD>
                        </TR>
                        <TR>
                          <TD>
                            <font style="color:red;">
                              <center>
                                <b>
                                  Nº <xsl:value-of select="Encabezado/IdDoc/Folio"/>
                                </b>
                              </center>
                            </font>
                          </TD>
                        </TR>
                      </TABLE>
                    </TD>
                  </TR>
                </TABLE>
              </TD>
            </TR>
          </TABLE>
          <TABLE style="WIDTH: 650px">
            <TR>
              <TD>
                <B>Nombre:</B>
              </TD>
              <TD>
                <xsl:value-of select="Encabezado/Receptor/RznSocRecep"/>
              </TD>
              <TD/>
              <TD>
                <B>R.U.T.:</B>
              </TD>
              <TD>
                <xsl:apply-templates select="Encabezado/Receptor/RUTRecep" mode="rut"/>
              </TD>
            </TR>
            <TR>
              <TD>
                <B>Direccion :</B>
              </TD>
              <TD>
                <xsl:value-of select="Encabezado/Receptor/DirRecep"/>
              </TD>
              <TD/>
              <TD>
                <B>Vencimiento :</B>
              </TD>
              <TD>
                <xsl:apply-templates select="Encabezado/IdDoc/FchVenc" mode="fecha"/>
              </TD>
            </TR>
            <TR>
              <TD>
                <B>Comuna :</B>
              </TD>
              <TD>
                <xsl:value-of select="Encabezado/Receptor/CmnaRecep"/>
              </TD>
              <TD/>
              <TD>
                <B>Ciudad :</B>
              </TD>
              <TD>
                <xsl:value-of select="Encabezado/Receptor/CiudadRecep"/>
              </TD>
            </TR>
            <TR>
              <TD>
                <B>Giro :</B>
              </TD>
              <TD>
                <xsl:value-of select="Encabezado/Receptor/GiroRecep"/>
              </TD>
              <TD/>
              <TD>
                <B>Vendedor :</B>
              </TD>
              <TD>
                <xsl:value-of select="Encabezado/Receptor/CdgVendedor"/>
              </TD>
            </TR>
          </TABLE>
          <TABLE BORDER="0" style="WIDTH: 650px">
            <TR>
              <TD>
                <TABLE border="1" style="WIDTH: 650px">
                  <xsl:for-each select="Detalle">
                    <xsl:if test="position()=1">
                      <TR class="Cabecera_Detalle">
                        <TH colspan="8">Detalle Productos/Servicios</TH>
                      </TR>
                      <TR class="Cabecera_Detalle">
                        <TH style="WIDTH: 1%; POSITION: static">Item</TH>
                        <xsl:if test="$CantidadCant!=0">
                          <TH style="WIDTH: 2%">Cantidad</TH>
                        </xsl:if>
                        <xsl:if test="$CantidadUmed!=0">
                          <TH style="WIDTH: 2%">U.Med.</TH>
                        </xsl:if>
                        <xsl:if test="$CantidadPUni!=0">
                          <TH>Descripcion</TH>
                        </xsl:if>
                        <xsl:if test="$CantidadPUni=0">
                          <TH colspan="2">Descripcion</TH>
                        </xsl:if>
                        <xsl:if test="$CantidadPUni!=0">
                          <TH>P.Unit.</TH>
                        </xsl:if>
                        <xsl:if test="$CantidadDesc!=0">
                          <TH>Desc.</TH>
                        </xsl:if>
                        <xsl:if test="$CantidadReca!=0">
                          <TH>Reca.</TH>
                        </xsl:if>
                        <TH>Monto</TH>
                      </TR>
                    </xsl:if>
                    <TR>
                      <TD style="VERTICAL-ALIGN: top">
                        <xsl:value-of select="NroLinDet"/>
                      </TD>
                      <xsl:if test="$CantidadCant!=0">
                        <xsl:apply-templates select="QtyItem" mode="montox"/>
                      </xsl:if>
                      <xsl:if test="$CantidadUmed!=0">
                        <TD style="VERTICAL-ALIGN: top">
                          <xsl:value-of select="UnmdItem"/>.
                        </TD>
                      </xsl:if>
                      <xsl:if test="$CantidadPUni!=0">
                        <xsl:choose>
                          <xsl:when test="DscItem">
                            <TD>
                              <TABLE>
                                <TR>
                                  <TD>
                                    <xsl:value-of select="NmbItem"/>
                                  </TD>
                                </TR>
                                <TR>
                                  <TD>
                                    <xsl:value-of select="DscItem"/>
                                  </TD>
                                </TR>
                              </TABLE>
                            </TD>
                          </xsl:when>
                          <xsl:otherwise>
                            <TD>
                              <xsl:value-of select="NmbItem"/>
                            </TD>
                          </xsl:otherwise>
                        </xsl:choose>
                      </xsl:if>
                      <xsl:if test="$CantidadPUni=0">
                        <xsl:choose>
                          <xsl:when test="DscItem">
                            <TD colspan="2">
                              <TABLE>
                                <TR>
                                  <TD>
                                    <xsl:value-of select="NmbItem"/>
                                  </TD>
                                </TR>
                                <TR>
                                  <TD>
                                    <xsl:value-of select="DscItem"/>
                                  </TD>
                                </TR>
                              </TABLE>
                            </TD>
                          </xsl:when>
                          <xsl:otherwise>
                            <TD colspan="2">
                              <xsl:value-of select="NmbItem"/>
                            </TD>
                          </xsl:otherwise>
                        </xsl:choose>
                      </xsl:if>
                      <xsl:if test="$CantidadPUni!=0">
                        <xsl:apply-templates select="PrcItem" mode="montox"/>
                      </xsl:if>
                      <xsl:if test="$CantidadDesc!=0">
                        <xsl:apply-templates select="DescuentoMonto" mode="montox"/>
                      </xsl:if>
                      <xsl:if test="$CantidadReca!=0">
                        <xsl:apply-templates select="RecargoMonto" mode="montox"/>
                      </xsl:if>
                      <xsl:apply-templates select="MontoItem" mode="monto"/>
                    </TR>
                  </xsl:for-each>
                  <TR>
                    <xsl:if test="$CantidadUmed!=0">
                      <xsl:if test="$CantidadCant!=0">
                        <xsl:if test="$CantidadDesc!=0">
                          <xsl:if test="$CantidadReca!=0">
                            <TD colspan="6" rowspan="4">
                              <xsl:apply-templates select="TED" mode="zonatimbre"/>
                            </TD>
                          </xsl:if>
                          <xsl:if test="$CantidadReca=0">
                            <TD colspan="5" rowspan="4">
                              <xsl:apply-templates select="TED" mode="zonatimbre"/>
                            </TD>
                          </xsl:if>
                        </xsl:if>
                        <xsl:if test="$CantidadDesc=0">
                          <xsl:if test="$CantidadReca!=0">
                            <TD colspan="5" rowspan="4">
                              <xsl:apply-templates select="TED" mode="zonatimbre"/>
                            </TD>
                          </xsl:if>
                          <xsl:if test="$CantidadReca=0">
                            <TD colspan="4" rowspan="4">
                              <xsl:apply-templates select="TED" mode="zonatimbre"/>
                            </TD>
                          </xsl:if>
                        </xsl:if>
                      </xsl:if>
                      <xsl:if test="$CantidadCant=0">
                        <xsl:if test="$CantidadDesc!=0">
                          <xsl:if test="$CantidadReca!=0">
                            <TD colspan="5" rowspan="4">
                              <xsl:apply-templates select="TED" mode="zonatimbre"/>
                            </TD>
                          </xsl:if>
                          <xsl:if test="$CantidadReca=0">
                            <TD colspan="4" rowspan="4">
                              <xsl:apply-templates select="TED" mode="zonatimbre"/>
                            </TD>
                          </xsl:if>
                        </xsl:if>
                        <xsl:if test="$CantidadDesc=0">
                          <xsl:if test="$CantidadReca!=0">
                            <TD colspan="4" rowspan="4">
                              <xsl:apply-templates select="TED" mode="zonatimbre"/>
                            </TD>
                          </xsl:if>
                          <xsl:if test="$CantidadReca=0">
                            <TD colspan="3" rowspan="4">
                              <xsl:apply-templates select="TED" mode="zonatimbre"/>
                            </TD>
                          </xsl:if>
                        </xsl:if>
                      </xsl:if>
                    </xsl:if>
                    <xsl:if test="$CantidadUmed=0">
                      <xsl:if test="$CantidadCant!=0">
                        <xsl:if test="$CantidadDesc!=0">
                          <xsl:if test="$CantidadReca!=0">
                            <TD colspan="5" rowspan="4">
                              <xsl:apply-templates select="TED" mode="zonatimbre"/>
                            </TD>
                          </xsl:if>
                          <xsl:if test="$CantidadReca=0">
                            <TD colspan="4" rowspan="4">
                              <xsl:apply-templates select="TED" mode="zonatimbre"/>
                            </TD>
                          </xsl:if>
                        </xsl:if>
                        <xsl:if test="$CantidadDesc=0">
                          <xsl:if test="$CantidadReca!=0">
                            <TD colspan="4" rowspan="4">
                              <xsl:apply-templates select="TED" mode="zonatimbre"/>
                            </TD>
                          </xsl:if>
                          <xsl:if test="$CantidadReca=0">
                            <TD colspan="3" rowspan="4">
                              <xsl:apply-templates select="TED" mode="zonatimbre"/>
                            </TD>
                          </xsl:if>
                        </xsl:if>
                      </xsl:if>
                      <xsl:if test="$CantidadCant=0">
                        <xsl:if test="$CantidadDesc!=0">
                          <xsl:if test="$CantidadReca!=0">
                            <TD colspan="4" rowspan="4">
                              <xsl:apply-templates select="TED" mode="zonatimbre"/>
                            </TD>
                          </xsl:if>
                          <xsl:if test="$CantidadReca=0">
                            <TD colspan="3" rowspan="4">
                              <xsl:apply-templates select="TED" mode="zonatimbre"/>
                            </TD>
                          </xsl:if>
                        </xsl:if>
                        <xsl:if test="$CantidadDesc=0">
                          <xsl:if test="$CantidadReca!=0">
                            <TD colspan="3" rowspan="4">
                              <xsl:apply-templates select="TED" mode="zonatimbre"/>
                            </TD>
                          </xsl:if>
                          <xsl:if test="$CantidadReca=0">
                            <TD colspan="2" rowspan="4">
                              <xsl:apply-templates select="TED" mode="zonatimbre"/>
                            </TD>
                          </xsl:if>
                        </xsl:if>
                      </xsl:if>
                    </xsl:if>
                    <TD  style="VERTICAL-ALIGN: bottom; TEXT-ALIGN: right">
                      <xsl:if test="Encabezado/Totales/MntNeto">
                        <B>Neto :</B>
                      </xsl:if>
                    </TD>
                    <xsl:apply-templates select="Encabezado/Totales/MntNeto" mode="monto"/>
                  </TR>
                  <TR>
                    <TD  style="VERTICAL-ALIGN: bottom; TEXT-ALIGN: right">
                      <xsl:if test="Encabezado/Totales/MntExe">
                        <B>Exento :</B>
                      </xsl:if>
                    </TD>
                    <xsl:apply-templates select="Encabezado/Totales/MntExe" mode="monto"/>
                  </TR>
                  <TR>
                    <TD  style="VERTICAL-ALIGN: bottom; TEXT-ALIGN: right">
                      <xsl:if test="Encabezado/Totales/IVA">
                        <B>IVA :</B>
                      </xsl:if>
                    </TD>
                    <xsl:apply-templates select="Encabezado/Totales/IVA" mode="monto"/>
                  </TR>
                  <TR>
                    <TD  style="VERTICAL-ALIGN: bottom; TEXT-ALIGN: right">
                      <B>Total :</B>
                    </TD>
                    <xsl:apply-templates select="Encabezado/Totales/MntTotal" mode="monto"/>
                  </TR>
                </TABLE>
              </TD>
            </TR>
          </TABLE>
        </TD>
      </TR>
    </TABLE>
  </xsl:template>
  <xsl:template match="*">
  </xsl:template>
  <xsl:template match="EnvioDTE">
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="SetDTE">
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="DTE">
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="Detalle">
  </xsl:template>
  <xsl:template match="Signature">
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="*" mode="monto">
    <TD style="VERTICAL-ALIGN: bottom; TEXT-ALIGN: right">
      <xsl:choose>
        <xsl:when test=".">
          <xsl:value-of select="format-number(.,'###,##0.00')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="format-number(0,'###,##0.00')"/>
        </xsl:otherwise>
      </xsl:choose>
    </TD>
  </xsl:template>
  <xsl:template match="*" mode="montox">
    <TD style="VERTICAL-ALIGN: top; TEXT-ALIGN: right">
      <xsl:choose>
        <xsl:when test=".">
          <xsl:value-of select="format-number(.,'###,##0.00')"/>
        </xsl:when>
        <xsl:otherwise>.</xsl:otherwise>
      </xsl:choose>
    </TD>
  </xsl:template>
  <xsl:template match="*" mode="fecha">
    <xsl:value-of select="format-number(number(substring(., 9, 2)), '00')" />
    <xsl:text>/</xsl:text>
    <xsl:value-of select="format-number(number(substring(., 6, 2)), '00')" />
    <xsl:text>/</xsl:text>
    <xsl:value-of select="format-number(number(substring(., 1, 4)), '0000')" />
  </xsl:template>
  <xsl:template match="*" mode="rut">
    <xsl:value-of select="format-number(number(substring(., 1, string-length(.) - 2)), '###,###,###,##0')"/>
    <xsl:value-of select="substring(., string-length(.) - 1, 2)"/>
  </xsl:template>
  <xsl:template match="*" mode="tipodte">
    <xsl:choose>
      <xsl:when test=". = 33">FACTURA</xsl:when>
      <xsl:when test=". = 34">FACTURA EXENTA</xsl:when>
      <xsl:when test=". = 46">FACTURA DE COMPRA</xsl:when>
      <xsl:when test=". = 52">GUIA DE DESPACHO</xsl:when>
      <xsl:when test=". = 56">NOTA DE DEBITO</xsl:when>
      <xsl:when test=". = 61">NOTA DE CREDITO</xsl:when>
      <xsl:otherwise>Otro Documento</xsl:otherwise>
    </xsl:choose> ELECTRONICA
  </xsl:template>
  <xsl:template match="*" mode="zonatimbre">
    <xsl:call-template name="timbrePDF">
      <xsl:with-param name="value">
        <xsl:copy>
          <xsl:value-of disable-output-escaping="yes" select="."/>
        </xsl:copy>
      </xsl:with-param>
    </xsl:call-template>
    <BR/>
    <xsl:if test="$NroResol">
      <Center>
        SII Res. <xsl:value-of select="$NroResol"/>  de <xsl:value-of select="format-number(number(substring($FchResol, 1, 4)), '0000')"/> Verifique: www.sii.cl
      </Center>
    </xsl:if>
    <xsl:if test="$NroResolx!=0">
      <Center>
        SII Res. <xsl:value-of select="$NroResolx"/>  de <xsl:value-of select="format-number(number(substring($FchResolx, 1, 4)), '0000')"/> Verifique: www.sii.cl
      </Center>
    </xsl:if>
  </xsl:template>
  <xsl:template name="timbrePDF">
    <xsl:param name="value"/>     
        <div style="font-size:7">       
          <img border="0" width="352px" height="152px">
            <xsl:attribute name="src">
              <xsl:value-of select="$TedTimbre" />
            </xsl:attribute>
          </img>
        </div>    
  </xsl:template>
</xsl:stylesheet>

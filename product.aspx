<%@ Page Language="VB" %>
<script runat="server">

    Public feedback As String = "<b>Search Criteria: </b>"
    
    Sub Page_Load
        
        With DataList1
            .Connection = Application("appConn")
            .SqlSelect = "SELECT *, LEFT(Description, 200) Description2  FROM [Products] WHERE ([Products].[MakeAvailable] = 1)"
            If ((Productid.Text = "") And (keyword.Text = "") And (outerwear_type.SelectedIndex = 0)) Then
                feedback &= "All"
            End If
            If Productid.Text <> "" Then
                .SqlSelect &= "AND ([Products].[ProductID] = " & Productid.Text & ")"
                feedback &= "ProductID(" & Productid.Text & ");"
            End If
            If keyword.Text <> "" Then
                .SqlSelect &= "AND (([Products].[Keywords] LIKE '%" & keyword.Text & "%') OR ([Products].[Title] LIKE '%" & keyword.Text & "%'))"
                feedback &= "Keyword(" & keyword.Text & ");"
            End If
            If outerwear_type.SelectedIndex <> 0 Then
                .SqlSelect &= " AND ([Products].[Type] = '" & outerwear_type.SelectedItem.Value & "')"
                feedback &= "Type(" & outerwear_type.SelectedItem.Text & ");"
            End If
            .SqlSelect &= "ORDER BY [Products].[ProductID] DESC"
            If .RecordCount = 0 Then
                feedback &= "<b> No Product found - Try again</b><br />"
            End If
            'If .RecordCount <= 10 And .RecordCount >= 1 Then
            '    feedback &= "<b> " & .RecordCount & " Product(s) found </b>"
            'End If
        End With
        DataBind()
    
        'DataList2.DataSource = adquery()
        'DataList2.DataBind()
    End Sub

</script>
<%@ Register TagPrefix="a4u" Namespace="ASPDOTNET4U" Assembly="pagingdatalist"%>
<html>
<head>
    <title>Esse Designs - Products</title> 
    <meta content="Essé Designs" name="TITLE" />
    <meta content="Esse Designs" name="DESCRIPTION" />
    <meta content="esse designs, collections, bridal, prom, outerwear, bolero, shrugs, jacket, shawl, bridesmaid" name="KEYWORDS" />
    <meta content="me006q7041@blueyonder.co.uk" name="OWNER" />
    <meta content="Essé Designs" name="AUTHOR" />
    <meta http-equiv="EXPIRES" content="" />
    <meta http-equiv="CHARSET" content="ISO-8859-1" />
    <meta http-equiv="CONTENT-LANGUAGE" content="English" />
    <meta http-equiv="VW96.OBJECT TYPE" content="Homepage" />
    <meta content="General" name="RATING" />
    <meta content="index,follow" name="ROBOTS" />
    <meta content="3 days" name="REVISIT-AFTER" />
    <link href="styles1.css" type="text/css" rel="stylesheet" />
    <link href="styles2.css" type="text/css" rel="stylesheet" />

    <style type="text/css">
<!--
.style1 {
	font-family: English, englishfont, "French Script MT", "ITC Zapf Chancery", "Freestyle Script", Coronet, "Bradley Hand ITC";
	color: #666666;
}
body {
	margin-left: 0px;
	background-color: #ffffff;
}
.style2 {
	color: #666666;
	font-weight: bold;
}
.style3 {
	color: #666666;
	font-size: 8pt;
}
-->
    </style>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"></head>
<body>
    <table border="0" align="center" cellspacing="0" bordercolor="white" bgcolor="#FFFFFF" style="WIDTH: 800; HEIGHT: 100%">
        <tbody>
            <tr>
              <td colspan="3" width="81%" align="left" valign="middle" style="height: 9px"><div align="left"><span class="style1" style="font-size: 32pt">Alero Collections</span> an authorised reseller for <a href="http://www.essedesigns.com/">Essé Designs</a></div></td>
              </td>
          </tr>
            <tr>
              <td colspan="3" align="left" valign="middle" style="height: 9px">
                <hr color="#666666" /></td>
            </tr>
			<tr>
                <td height="10" colspan="3" bgcolor="#ffffff" class="errata" style="text-align: left; width: 76px;"> 
					<a href="default.aspx"><b>Home</b></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="product.aspx"><b>Products</b></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="contact.aspx"><b>Contact</b></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="faq.html"><b>Help/FAQs</b></a>
				</td>
			</tr>
          <tr><td colspan="2" valign=top>
            <center>
                <form id="searchform" runat="server">
                    <table style="WIDTH: 630px; HEIGHT: 65px" cellspacing="0" cellpadding="5" bgcolor="#e0e0e0" border="0">
                        <tbody>
                            <tr>
                                <td>
                                    Product ID:</td>
                                <td style="width: 184px">
                                    <asp:TextBox id="Productid" runat="server" Width="129px" Font-Size="XX-Small"></asp:TextBox>
                                </td>
                                <td style="width: 67px">
                                    Product Type:</td>
                                <td>
                                    &nbsp;<asp:DropDownList ID="outerwear_type" runat="server" Font-Size="XX-Small">
                                        <asp:ListItem Selected="True">------</asp:ListItem>
	                                        <asp:ListItem Value="outerwear">Outerwear</asp:ListItem>
	                                        <asp:ListItem Value="fabric">Fabric</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Keyword or Title:
                                </td>
                                <td colspan="2">
                                    <asp:TextBox id="keyword" runat="server" Width="272px" Font-Size="XX-Small"></asp:TextBox>
                                </td>
                                <td>
                                    <p align="left">
                                        <asp:Button id="search" runat="server" Text="Search" CausesValidation="False"></asp:Button>
                                    </p>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <table style="WIDTH: 620px">
                        <tbody>
                            <tr>
                                <td valign="top" style="height: 192px">
                                    <A4U:PAGINGDATALIST id="DataList1" runat="server" Width="100%" PageSize="10" NextText="Next" PageCount="1" LastText="Last" RecordCount="0" TotalText=" " AddPagerTo="Footer" CurrentPage="1" FirstText="First" PreviousText="Previous" PageOfText="Page: {0} of {1}" CellPadding="4" Font-Names="Verdana" Font-Size="X-Small" HorizontalAlign="Justify" RepeatColumns="2" RepeatDirection="Horizontal">
                                        <HEADERSTYLE backcolor="#E0E0E0"></HEADERSTYLE>
                                        <FOOTERSTYLE backcolor="#E0E0E0"></FOOTERSTYLE>
                                        <HEADERTEMPLATE>
                                            <%# feedback %>
                                        </HEADERTEMPLATE>
                                        <ITEMTEMPLATE>
                                            <p><table border="0" cellpadding="1" cellspacing="0" width="100%">
                                                <tr>
                                                    <td width="80" valign="top">
                                                    <a href=ProductDetails.aspx?ProductID=<%# DataBinder.Eval(Container.DataItem, "ProductID") %>>
                                                        <img src=picture.aspx?size=70&url=images/cust<%#DataBinder.Eval(Container.DataItem, "CustomerID")%>/<%#DataBinder.Eval(Container.DataItem, "Image1")%> /></a>
                                                    </td>
                                                    <td valign="top">
                                                    <a href=ProductDetails.aspx?ProductID=<%# DataBinder.Eval(Container.DataItem, "ProductID") %>><%# DataBinder.Eval(Container.DataItem, "Title") %></a>
                                                <br />
                                                <%# DataBinder.Eval(Container.DataItem, "Description2")%>...
                                                <br />
                                                <font size="1"><b>Price:</b>£<%#DataBinder.Eval(Container.DataItem, "Price")%> </font>
                                                <br />
                                                </td>
                                                </tr>
                                            </table></p>
                                        </ITEMTEMPLATE>
                                        <FOOTERTEMPLATE></FOOTERTEMPLATE>
                                    </A4U:PAGINGDATALIST>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </form>
                </center>
          </td>
          <td valign=top><div align=right><a href=checkout.aspx><img src=images/checkout.jpg /></a></div></td></tr>
          </tr>
            <tr>
                <td colspan="3" bgcolor="#ffffff" style="height: 41px">
                    <div align="center">
                <span><span style="font-size: 7pt">Copyright © 2011&nbsp; Essé Designs. All rights reserved. |</span><a href="terms-conditions.html"><span style="font-size: 7pt">Terms
                        of use</span></a><span style="font-size: 7pt"> | </span><a href="contact.aspx"><span
                            style="font-size: 7pt">Contact Us</span></a><span style="font-size: 7pt">&nbsp;|
                                |&nbsp;<br />
                                By using this website, you accept its full </span><a href="terms-conditions.html"><span
                                    style="font-size: 7pt">Terms and
                                    Conditions</span></a><span style="font-size: 7pt">. To learn more about how we use your information, see our </span>
                </span>
                <a href="privacy.html"><span style="font-size: 7pt">Privacy Policy</span></a><span
                    style="font-size: 7pt"> </span></div>
                </td>
           </tr>
        </tbody>
    </table>
</body>
</html>
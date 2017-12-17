<%@ Page Language="VB" %>
<script runat="server">

    Sub Page_Load()
        Dim Productdata As System.Data.SqlClient.SqlDataReader = GetProducts()
        If Productdata.Read Then
            feature1.ImageUrl = "picture.aspx?size=150&url=images/cust" & Productdata.Item("CustomerID") & "/" & Productdata.Item("Image1")
            feature1.NavigateUrl = "ProductDetails" & ".aspx?ProductID=" & Productdata.Item("ProductID")
            Label1.Text = Productdata.Item("Title") & " - £" & Productdata.Item("Price")
        End If
        If Productdata.Read Then
            feature2.ImageUrl = "picture.aspx?size=150&url=images/cust" & Productdata.Item("CustomerID") & "/" & Productdata.Item("Image1")
            feature2.NavigateUrl = "ProductDetails" & ".aspx?ProductID=" & Productdata.Item("ProductID")
            Label2.Text = Productdata.Item("Title") & " - £" & Productdata.Item("Price")
        End If
        If Productdata.Read Then
            feature3.ImageUrl = "picture.aspx?size=150&url=images/cust" & Productdata.Item("CustomerID") & "/" & Productdata.Item("Image1")
            feature3.NavigateUrl = "ProductDetails" & ".aspx?ProductID=" & Productdata.Item("ProductID")
            Label3.Text = Productdata.Item("Title") & " - £" & Productdata.Item("Price")
        End If
        If Productdata.Read Then
            feature4.ImageUrl = "picture.aspx?size=150&url=images/cust" & Productdata.Item("CustomerID") & "/" & Productdata.Item("Image1")
            feature4.NavigateUrl = "ProductDetails" & ".aspx?ProductID=" & Productdata.Item("ProductID")
            Label4.Text = Productdata.Item("Title") & " - £" & Productdata.Item("Price")
        End If
        'Productdata.Read()
        'feature5.ImageUrl = "picture.aspx?size=120&url=images/cust" & Productdata.Item("CustomerID") & "/" & Productdata.Item("Image1")
        'feature5.NavigateUrl = "ProductDetails" & ".aspx?ProductID=" & Productdata.Item("ProductID")
        'Productdata.Read()
        'feature6.ImageUrl = "picture.aspx?size=120&url=images/cust" & Productdata.Item("CustomerID") & "/" & Productdata.Item("Image1")
        'feature6.NavigateUrl = "ProductDetails" & ".aspx?ProductID=" & Productdata.Item("ProductID")
        'Productdata.Read()
        'feature7.ImageUrl = "picture.aspx?size=120&url=images/cust" & Productdata.Item("CustomerID") & "/" & Productdata.Item("Image1")
        'feature7.NavigateUrl = "ProductDetails" & ".aspx?ProductID=" & Productdata.Item("ProductID")
        'Productdata.Read()
        'feature8.ImageUrl = "picture.aspx?size=120&url=images/cust" & Productdata.Item("CustomerID") & "/" & Productdata.Item("Image1")
        'feature8.NavigateUrl = "ProductDetails" & ".aspx?ProductID=" & Productdata.Item("ProductID")
        'Productdata.Read()
        'feature9.ImageUrl = "picture.aspx?size=120&url=images/cust" & Productdata.Item("CustomerID") & "/" & Productdata.Item("Image1")
        'feature9.NavigateUrl = "ProductDetails" & ".aspx?ProductID=" & Productdata.Item("ProductID")

        'DataList2.DataSource = adquery()
        'DataList2.DataBind()
    End Sub
    
    Function GetProducts() As System.Data.SqlClient.SqlDataReader
        Dim connectionString As String = Application("appConn")
        Dim sqlConnection As System.Data.SqlClient.SqlConnection = New System.Data.SqlClient.SqlConnection(connectionString)

        Dim queryString As String = "SELECT TOP 4 * FROM Products " & _
            "WHERE(Len(Image1) > 1) ORDER BY NEWID()"
        Dim sqlCommand As System.Data.SqlClient.SqlCommand = New System.Data.SqlClient.SqlCommand(queryString, sqlConnection)

        sqlConnection.Open()
        Dim dataReader As System.Data.SqlClient.SqlDataReader = sqlCommand.ExecuteReader(System.Data.CommandBehavior.CloseConnection)

        Return dataReader
    End Function

</script>
<html>
<head>
    <title>Alero Collections</title> 
	<meta name="google-site-verification" content="ueWN2wlUnBo4grQv5M-4icOi1KYWMxP_sli-TD2NCJE" />
    <meta content="Alero Collections" name="TITLE" />
    <meta content="Alero Collections - Specialist in Fabric / Textiles and Outerwear" name="DESCRIPTION" />
    <meta content="fabric, textiles, esse designs, collections, bridal, prom, outerwear, bolero, shrugs, jacket, shawl, bridesmaid" name="KEYWORDS" />
    <meta content="me006q7041@blueyonder.co.uk" name="OWNER" />
    <meta content="essedesigns.com" name="AUTHOR" />
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
.style5 {
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
            <tr>
            <td></td>
                <td align="center" valign="middle">
                  <table style="text-align: center; width: 60%;">
                  <tr>
                      <td style="height: 18px" colspan="2" bgcolor="#ffffff">
                          <strong>Featured Products </strong>
                      </td>
                  </tr>
                  <tr>
                    <td width="50%" style="height: 18px">
                        <asp:HyperLink ID="feature1" runat="server" ImageUrl="images/blank.gif">[feature1]</asp:HyperLink></td>
                    <td width="50%" style="height: 18px">
                        <asp:HyperLink ID="feature2" runat="server" ImageUrl="images/blank.gif">[feature2]</asp:HyperLink></td>
                 </tr>
                  <tr>
                      <td style="height: 34px" width="50%" valign=top>
                          <asp:Label ID="Label1" runat="server" Text=" "></asp:Label><br />
                      </td>
                      <td width="50%" valign=top style="height: 34px">
                          <asp:Label ID="Label2" runat="server" Text=" "></asp:Label></td>
                  </tr>
                 <tr>
                    <td width="50%" style="height: 18px">
                        <asp:HyperLink ID="feature3" runat="server" ImageUrl="images/blank.gif">[feature3]</asp:HyperLink></td>
                    <td width="50%">
                        <asp:HyperLink ID="feature4" runat="server" ImageUrl="images/blank.gif">[feature4]</asp:HyperLink></td>
                 </tr>   
                  <tr>
                      <td style="height: 18px" width="50%" valign=top>
                          <asp:Label ID="Label3" runat="server" Text=" "></asp:Label></td>
                      <td width="50%" valign=top>
                          <asp:Label ID="Label4" runat="server" Text=" "></asp:Label></td>
                  </tr>
                  <tr>
                      <td style="height: 18px" colspan="2" bgcolor="#ffffff">
                      </td>
                  </tr>
                 <%--<tr>
                    <td width="33.3%">
                        <asp:HyperLink ID="feature5" runat="server" ImageUrl="images/blank.gif">[feature5]</asp:HyperLink></td>
                    <td width="33.3%">
                        <asp:HyperLink ID="feature6" runat="server" ImageUrl="images/blank.gif">[feature6]</asp:HyperLink></td>
                    <td width="33.3%">
                        <asp:HyperLink ID="feature7" runat="server" ImageUrl="images/blank.gif">[feature7]</asp:HyperLink>                    </td>
                    <td width="33.3%">
                        <asp:HyperLink ID="feature8" runat="server" ImageUrl="images/blank.gif">[feature8]</asp:HyperLink></td>
                    <td width="33.3%">
                        <asp:HyperLink ID="feature9" runat="server" ImageUrl="images/blank.gif">[feature9]</asp:HyperLink></td>
              </tr>--%></table>
              </td>
          <td valign=top><div align=right><a href=checkout.aspx><img src=images/checkout.jpg /></a></div>
          </td>
          </tr>
            <tr>
                <td colspan="3" align="center" valign="bottom">
                  <hr color="#666666" />
                     <table width="400" align="center" cellpadding="5" cellspacing="0">
                        <tr>
                                <td valign="top">
                        &nbsp;<img src="images/pointer.gif" border="0" />&nbsp;<a href="product.aspx"><strong>View
                            all Products</strong></a><br /></td>
                                <td valign="top">
                        &nbsp;<img src="images/pointer.gif" border="0" />&nbsp;<span style="color: #666666"><a
                            href="forum.aspx"><strong>Forum</strong></a></span><br />
								</td>
                            </tr>
                        </table>
                    </td>
            </tr>
            <tr>
                <td height="30" colspan="3" bgcolor="#ffffff">
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
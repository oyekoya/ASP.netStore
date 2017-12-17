<%@ Page Language="VB" %>
<%@ import Namespace="System.Drawing" %>
<%@ import Namespace="System.Drawing.Imaging" %>
<%@ import Namespace="System.IO" %>
<%@ import Namespace="System.Data.SqlClient" %>
<%@ import Namespace="System.Data" %>
<%@ import Namespace="System.Net" %>
<script runat="server">

    ' ----------------------------------------

    Function GetCustomerDetails() As System.Data.SqlClient.SqlDataReader
        Dim connectionString As String = Application("appConn")
        Dim sqlConnection As System.Data.SqlClient.SqlConnection = New System.Data.SqlClient.SqlConnection(connectionString)

        Dim queryString As String = "SELECT [Customer].[EmailAddress] FROM [Customer] WHERE [Customer].[CustomerID] = " & Request.ServerVariables("AUTH_USER")
        Dim sqlCommand As System.Data.SqlClient.SqlCommand = New System.Data.SqlClient.SqlCommand(queryString, sqlConnection)

        sqlConnection.Open()
        Dim dataReader As System.Data.SqlClient.SqlDataReader = sqlCommand.ExecuteReader(System.Data.CommandBehavior.CloseConnection)

        Return dataReader
    End Function

    ' ----------------------------------------
    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            Dim strAdId As String
            strAdId = Request.QueryString("productid")
            If strAdId = "" Then
                  Response.Redirect("default.aspx")
              Exit Sub
            End If
            Dim customerdata As System.Data.SqlClient.SqlDataReader = GetCustomerDetails()
            If customerdata.Read Then
                If "" & customerdata.Item("EmailAddress") = "sales@essedesigns.com" Then
                    ProductDetailsTable.Visible = True
                    productid.Text = Request.QueryString("productid")
                    Hyperlink1.NavigateUrl="productdetails.aspx?productid=" & Request.QueryString("productid")
                Else
                    Response.Redirect("default.aspx")
                    Exit Sub
                End If
            End If
        End If
    End Sub
    
    Protected Sub AddProductDetailsButton_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        'If Len(title.Text) > 0 Then
            InsertProductDetails.Insert()
            ProductDetailsTable.Visible = False
            ProductDetailsAdded.Visible = True
        'End If
    End Sub


</script>
<html>
<head>
    <title>Add Product</title> 
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <link href="../style.css" type="text/css" rel="stylesheet" />
    <link href="../../styles1.css" type="text/css" rel="stylesheet" />
    <link href="../../styles2.css" type="text/css" rel="stylesheet" />
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
</head>
<body>
    <table border="0" align="center" cellspacing="0" bordercolor="white" bgcolor="#FFFFFF" style="WIDTH: 800; HEIGHT: 100%">
        <tbody>
            <tr>
              <td colspan="6" width="81%" align="left" valign="middle" style="height: 9px"><div align="left"><span class="style1" style="font-size: 32pt">Alero Collections</span> an authorised reseller for <a href="http://www.essedesigns.com/">Essé Designs</a></div></td>
              </td>
          </tr>
            <tr>
              <td colspan="6" align="left" valign="middle" style="height: 9px">
                <hr color="#666666" /></td>
            </tr>
			<tr>
                <td height="10" colspan="6" bgcolor="#ffffff" class="errata" style="text-align: left; width: 76px;"> 
					<a href="../../default.aspx"><b>Home</b></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="../../product.aspx"><b>Products</b></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="../../contact.aspx"><b>Contact</b></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="../../faq.html"><b>Help/FAQs</b></a>
				</td>
			</tr>
            <tr height="21">
                <td bgcolor="#e0e0e0" style="text-align: left; height: 20px;" bordercolor="#e0e0e0">
                        <font color="#666666"><a href="../../myaccount/reg/default.aspx">MyAccount</a></font></td>
                <td bgcolor="#e0e0e0" style="text-align: left; height: 20px;" bordercolor="#e0e0e0">
                     <a href="../../myaccount/forum/default.aspx">Forum</a></td>
                <td bgcolor="#e0e0e0" style="text-align: center; height: 20px; width: 76px;" bordercolor="#e0e0e0">
                    <strong class="menu"></strong></td>
                <td bgcolor="#e0e0e0" style="text-align: center; height: 20px; width: 281px;" bordercolor="#e0e0e0">
                    <font color="#666666"><b></b></font></td>
                <td bgcolor="#e0e0e0" style="text-align: right; height: 20px;">
                    &nbsp;<a href="../../myaccount/reg/updatecustomer.aspx">Edit Account</a></td>
                <td bgcolor="#e0e0e0" style="text-align: right; height: 20px; border-right-style: solid; border-right-color: #e0e0e0;">
                        <a href="../../myaccount/logout.aspx"><font size="2"><span style="font-size: 8pt">Logout</span></font></a></td>
            </tr>
            <tr height="21">
                <td bordercolor="#e0e0e0" bgcolor="#e0e0e0" colspan="6" height="20">
                    <div align="left"><font color="#003366"><strong>Add&nbsp;Product Details</strong></font>&nbsp; 
                    </div>
                </td>
            </tr>
            <tr valign="top">
                <td bordercolor="#e0e0e0" colspan="6" height="100%" style="border-left-color: #e0e0e0; border-bottom-color: #e0e0e0; border-top-style: solid; border-top-color: #e0e0e0; border-right-style: solid; border-left-style: solid; border-right-color: #e0e0e0; border-bottom-style: solid; height: 100%;" valign="top">
                    <form id="Form1" runat="server" enctype="multipart/form-data" method="post">
                        <table id="ProductDetailsTable" cellspacing="0" cellpadding="5" width="100%" border="0" runat="server" visible="False">
                            <tbody>
                                <tr>
                                    <td style="width: 122px; height: 34px">
                                        <strong>&nbsp;ProductID:</strong></td>
                                    <td style="height: 34px">
                                        <asp:Label ID="productid" runat="server" Text="Label"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td style="width: 122px">
                                        <strong>&nbsp;Colour Code:</strong></td>
                                    <td>
                                        <p>
                                            <asp:DropDownList ID="colourcode" runat="server" AppendDataBoundItems="True" DataSourceID="colours_db"
                                                DataTextField="ColourAndCode" DataValueField="ColourCode" Font-Size="XX-Small">
                                                <asp:ListItem></asp:ListItem>
                                            </asp:DropDownList><asp:SqlDataSource ID="colours_db" runat="server" ConnectionString="<%$ ConnectionStrings:esseConnectionString %>"
                                                DataSourceMode="DataReader" SelectCommand="SELECT ColourCode, ColourCode + ' - ' + Colour AS ColourAndCode FROM Colour ORDER BY ColourCode">
                                            </asp:SqlDataSource>
                                            &nbsp;<strong><font color="#ff0000">* 
                                            <asp:RequiredFieldValidator id="RequiredFieldValidator2" runat="server" Display="Dynamic" ControlToValidate="colourcode" BackColor="White" ErrorMessage="Required" Font-Bold="False"></asp:RequiredFieldValidator></font></strong></p>
                                    </td>
                                </tr>
	                             <tr>
	                            <td>
	                                <strong>&nbsp;Size:</strong></td>
	                                <td>
										<asp:TextBox id="size" runat="server" MaxLength="50" Font-Size="XX-Small" Width="76px">8</asp:TextBox>
											&nbsp;<strong><font color="#ff0000">*
												<asp:RequiredFieldValidator ID="size_required" runat="server" BackColor="White"
													ControlToValidate="size" Display="Dynamic" ErrorMessage="Required" Font-Bold="False"></asp:RequiredFieldValidator></font></strong>
									</td>
	                            </tr>
                                <tr>
                                    <td style="width: 122px; height: 34px">
                                        <strong>&nbsp;Quantity:</strong></td>
                                    <td style="height: 34px">
                                        <asp:TextBox id="quantity" runat="server" MaxLength="50" Font-Size="XX-Small" Width="76px">0</asp:TextBox>
                                            &nbsp;<strong><font color="#ff0000">*
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" BackColor="White"
                                                    ControlToValidate="quantity" Display="Dynamic" ErrorMessage="Required" Font-Bold="False"></asp:RequiredFieldValidator></font></strong></td>
                                </tr>
                                <tr>
                                    <td style="width: 122px">
                                        &nbsp; <strong>Price:</strong></td>
                                    <td>
                                        <asp:TextBox ID="price" runat="server" MaxLength="50" Font-Size="XX-Small" Width="104px"></asp:TextBox>
                                            &nbsp;<strong><font color="#ff0000">*
                                                <asp:RequiredFieldValidator ID="keword_required" runat="server" BackColor="White"
                                                    ControlToValidate="price" Display="Dynamic" ErrorMessage="Required" Font-Bold="False"></asp:RequiredFieldValidator></font></strong></td>
                                </tr>
                                <tr>
                                    <td style="width: 122px">
                                    </td>
                                    <td>
                                        <asp:Button OnClick="AddProductDetailsButton_Click" id="addbutton" runat="server" Text="Add Product Details" Font-Size="XX-Small"></asp:Button>
                                        <asp:SqlDataSource ID="InsertProductDetails" runat="server" ConnectionString="<%$ ConnectionStrings:esseConnectionString %>"
                                            InsertCommand="INSERT INTO ProductColour(ProductID, ColourCode, Quantity, Size, Price) VALUES (@ProductID,@Code,@Quantity,@Size,@Price)" ProviderName="<%$ ConnectionStrings:esseConnectionString.ProviderName %>">
                                            <InsertParameters>
                                                <asp:QueryStringParameter Name="ProductID" QueryStringField="productid" />
                                                <asp:ControlParameter ControlID="colourcode" Name="Code" PropertyName="SelectedValue" />
                                                <asp:ControlParameter ControlID="quantity" Name="Quantity" PropertyName="Text" />
                                                <asp:ControlParameter ControlID="size" Name="Size" PropertyName="Text" />
                                                <asp:ControlParameter ControlID="price" Name="Price" PropertyName="Text" />
                                            </InsertParameters>
                                        </asp:SqlDataSource>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </form>
                    <asp:Literal id="ProductDetailsAdded" runat="server" Visible="False" Text="Product Details Added."></asp:Literal>&nbsp;<br />
                    <br />
                    &nbsp;Back to 
                    <asp:HyperLink ID="HyperLink1" runat="server" Font-Bold="False">Product Details</asp:HyperLink><br />
                </td>
            </tr>
          <tr><td colspan="6">
          </td></tr>
            <tr>
                <td height="30" colspan="6" bgcolor="#ffffff">
                    <div align="center">
                <span><span style="font-size: 7pt">Copyright © 2011&nbsp; Essé Designs. All rights reserved. |</span><a href="../../terms-conditions.html"><span style="font-size: 7pt">Terms
                        of use</span></a><span style="font-size: 7pt"> | </span><a href="../../contact.aspx"><span
                            style="font-size: 7pt">Contact Us</span></a><span style="font-size: 7pt">&nbsp;|
                                &nbsp;<br />
                                By using this website, you accept its full </span><a href="../../terms-conditions.html"><span
                                    style="font-size: 7pt">Terms and
                                    Conditions</span></a><span style="font-size: 7pt">. To learn more about how we use your information, see our </span>
                </span>
                <a href="../../privacy.html"><span style="font-size: 7pt">Privacy Policy</span></a><span
                    style="font-size: 7pt"> </span></div>
                </td>
           </tr>
        </tbody>
    </table>
</body>
</html>
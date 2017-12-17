<%@ Page Language="VB" %>
<%@ import Namespace="System.Data" %>
<%@ import Namespace="System.Data.SqlClient" %>
<%@ import Namespace="System.Drawing" %>
<%@ import Namespace="System.Drawing.Imaging" %>
<%@ import Namespace="System.IO" %>
<script runat="server">

    Sub Page_Load (sender As Object, e As EventArgs)
      If Not Page.IsPostBack Then
        Dim strAdId As String
        strAdId = Request.QueryString("productid")
        If strAdId = "" Then
              Response.Redirect("default.aspx")
          Exit Sub
        End If
       If Not IsNumeric(strAdId) Then
         status.Text = "Product ID '" & strAdId & _
                            "' is non-numeric."
          status.Visible=True
         updatedata.Visible = False
         deletebutton.Visible = False
         Exit Sub
       End If
        Dim customerdata As System.Data.SqlClient.SqlDataReader = GetCustomerDetails()
        If customerdata.Read Then
            If "" & customerdata.Item("EmailAddress") <> "sales@essedesigns.com" Then
                Response.Redirect("default.aspx")
                Exit Sub
            End If
        End If

        Dim productdata As System.Data.SqlClient.SqlDataReader = GetProduct(strAdId)

    If productdata.Read Then
          productid.Text = productdata.Item("ProductID")
          title.Text = productdata.Item("Title")
          desc.Text = productdata.Item("Description")
          keyword.Text = productdata.Item("Keywords")
          title2.Text = productdata.Item("Title")
          'length.Text = productdata.Item("Length")
          price.Text = productdata.Item("Price")
          Postage.Text = "" & productdata.Item("Postage")
          AdditionalPostage.Text = "" & productdata.Item("AdditionalPostage")
          PostageContinent.Text = "" & productdata.Item("PostageContinent")
          AdditionalPostageContinent.Text = "" & productdata.Item("AdditionalPostageContinent")
          PostageWorld.Text = "" & productdata.Item("PostageWorld")
          AdditionalPostageWorld.Text = "" & productdata.Item("AdditionalPostageWorld")
          type.Text = productdata.Item("Type")

         If "" & productdata.Item("Image1") <> "" Then
           productimage1.Src = "../../images/cust" & productdata.Item("CustomerID") & "/" & productdata.Item("Image1")
           productimage1.Visible = True
         End If
         If "" & productdata.Item("Image2") <> "" Then
           productimage2.Src = "../../images/cust" & productdata.Item("CustomerID") & "/" & productdata.Item("Image2")
           productimage2.Visible = True
         End If
         tableproduct1.Visible = True
         If "" & productdata.Item("Image3") <> "" Then
           productimage3.Src = "../../images/cust" & productdata.Item("CustomerID") & "/" & productdata.Item("Image3")
           productimage3.Visible = True
         End If
         If "" & productdata.Item("Image4") <> "" Then
           productimage4.Src = "../../images/cust" & productdata.Item("CustomerID") & "/" & productdata.Item("Image4")
           productimage4.Visible = True
         End If
          tableproduct2.Visible = True
          table1.Visible = True
      Else
          status.Text = "Product ID '" & strAdId & "' not found"
          status.Visible=True
          updatedata.Visible = False
          deletebutton.Visible = False
        End If
     End If
    End Sub

    Function GetCustomerDetails() As System.Data.SqlClient.SqlDataReader
        Dim connectionString As String = Application("appConn")
        Dim sqlConnection As System.Data.SqlClient.SqlConnection = New System.Data.SqlClient.SqlConnection(connectionString)

        Dim queryString As String = "SELECT [Customer].[EmailAddress] FROM [Customer] WHERE [Customer].[CustomerID] = " & Request.ServerVariables("AUTH_USER")
        Dim sqlCommand As System.Data.SqlClient.SqlCommand = New System.Data.SqlClient.SqlCommand(queryString, sqlConnection)

        sqlConnection.Open()
        Dim dataReader As System.Data.SqlClient.SqlDataReader = sqlCommand.ExecuteReader(System.Data.CommandBehavior.CloseConnection)

        Return dataReader
    End Function

    Function GetProduct(ByVal productID As Integer) As System.Data.SqlClient.SqlDataReader
            Dim connectionString As String = Application("appConn")
            Dim sqlConnection As System.Data.SqlClient.SqlConnection = New System.Data.SqlClient.SqlConnection(connectionString)

            Dim queryString As String = "SELECT [Products].* FROM [Products] "& _
    "WHERE ([Products].[ProductID] = @ProductID)"
            Dim sqlCommand As System.Data.SqlClient.SqlCommand = New System.Data.SqlClient.SqlCommand(queryString, sqlConnection)

            sqlCommand.Parameters.Add("@ProductID", System.Data.SqlDbType.Int).Value = productID

            sqlConnection.Open
            Dim dataReader As System.Data.SqlClient.SqlDataReader = sqlCommand.ExecuteReader(System.Data.CommandBehavior.CloseConnection)

            Return dataReader
    End Function



    Function UpdateProduct(ByVal productID As Integer, ByVal description As String) As Integer
            Dim connectionString As String = Application("appConn")
            Dim sqlConnection As System.Data.SqlClient.SqlConnection = New System.Data.SqlClient.SqlConnection(connectionString)

            Dim queryString As String = "UPDATE [Products] SET [Description]=@Description, [Title]=@Title, [Keywords]=@Keywords, [Price]=@Price, "& _
				"[Postage]=@Postage, [AdditionalPostage]=@AdditionalPostage, [PostageContinent]=@PostageContinent, [AdditionalPostageContinent]=@AdditionalPostageContinent,"& _ 
				"[PostageWorld]=@PostageWorld, [AdditionalPostageWorld]=@AdditionalPostageWorld WHERE ([Products].[ProductID] = @ProductID)"
            Dim sqlCommand As System.Data.SqlClient.SqlCommand = New System.Data.SqlClient.SqlCommand(queryString, sqlConnection)

            sqlCommand.Parameters.Add("@ProductID", System.Data.SqlDbType.Int).Value = productID
            sqlCommand.Parameters.Add("@Description", System.Data.SqlDbType.NVarChar).Value = description
            sqlCommand.Parameters.Add("@Keywords", System.Data.SqlDbType.NVarChar).Value = keyword.Text
            sqlCommand.Parameters.Add("@Title", System.Data.SqlDbType.NVarChar).Value = title2.Text
            sqlCommand.Parameters.Add("@Price", System.Data.SqlDbType.NVarChar).Value = price.Text
            sqlCommand.Parameters.Add("@Postage", System.Data.SqlDbType.NVarChar).Value = Postage.Text
            sqlCommand.Parameters.Add("@AdditionalPostage", System.Data.SqlDbType.NVarChar).Value = AdditionalPostage.Text
            sqlCommand.Parameters.Add("@PostageContinent", System.Data.SqlDbType.NVarChar).Value = PostageContinent.Text
            sqlCommand.Parameters.Add("@AdditionalPostageContinent", System.Data.SqlDbType.NVarChar).Value = AdditionalPostageContinent.Text
            sqlCommand.Parameters.Add("@PostageWorld", System.Data.SqlDbType.NVarChar).Value = PostageWorld.Text
            sqlCommand.Parameters.Add("@AdditionalPostageWorld", System.Data.SqlDbType.NVarChar).Value = AdditionalPostageWorld.Text

            Dim rowsAffected As Integer = 0
            sqlConnection.Open
            Try
                rowsAffected = sqlCommand.ExecuteNonQuery
				sqlConnection.Close()
            Finally
                sqlConnection.Close
            End Try

            Return rowsAffected
    End Function

    Sub updatedata_Click(sender As Object, e As EventArgs)
          If Page.IsPostBack Then
            Page.Validate
          If Page.IsValid() Then
            If Len(desc.Text) > 1000
                desclimit.text = "- number of characters should not be more than 1000"
                Exit Sub
            Else
                desclimit.Visible = False
            End If
            UpdateProduct(productid.Text, desc.Text)
            status.Text = "Your changes have been updated"
          status.Visible=True
          End If
          End If
    End Sub


    Function DeleteProduct(ByVal productID As Integer) As Integer
            Dim connectionString As String = Application("appConn")
            Dim sqlConnection As System.Data.SqlClient.SqlConnection = New System.Data.SqlClient.SqlConnection(connectionString)

            Dim queryString As String = "DELETE FROM [Products] WHERE ([Products].[ProductID] = @ProductID)"
            Dim sqlCommand As System.Data.SqlClient.SqlCommand = New System.Data.SqlClient.SqlCommand(queryString, sqlConnection)

            sqlCommand.Parameters.Add("@ProductID", System.Data.SqlDbType.Int).Value = productID

            Dim rowsAffected As Integer = 0
            sqlConnection.Open
            Try
                rowsAffected = sqlCommand.ExecuteNonQuery
				sqlConnection.Close()
            Finally
                sqlConnection.Close
            End Try

            Return rowsAffected
    End Function


    Sub deletebutton_Click(sender As Object, e As EventArgs)
        DeleteProduct(productid.Text)
        Dim temp_file As String 

        If productimage1.Src <> "../../images/blank.gif" Then
            temp_file = Server.Mappath(productimage1.Src)
            File.Delete(temp_file)
        End If
        If productimage2.Src <> "../../images/blank.gif" Then
            temp_file = Server.Mappath(productimage2.Src)
            File.Delete(temp_file)
        End If
        If productimage3.Src <> "../../images/blank.gif" Then
            temp_file = Server.Mappath(productimage3.Src)
            File.Delete(temp_file)
        End If
        If productimage4.Src <> "../../images/blank.gif" Then
            temp_file = Server.Mappath(productimage4.Src)
            File.Delete(temp_file)
        End If
        Response.Redirect("myproduct.aspx")
    End Sub

</script>
<html>
<head>
    <title>Edit Product</title>
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
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"></head>
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
                <td bgcolor="#e0e0e0" style="text-align: left; height: 20px;">
                        <font color="#666666"><a href="../../myaccount/reg/default.aspx">MyAccount</a></font></td>
                <td bgcolor="#e0e0e0" style="text-align: left; height: 20px;" bordercolor="#e0e0e0">
                     <a href="../../myaccount/forum/default.aspx">Forum</a></td>
                <td bgcolor="#e0e0e0" style="text-align: center; height: 20px; width: 76px;" bordercolor="#e0e0e0">
                    </td>
                <td bgcolor="#e0e0e0" style="text-align: center; height: 20px; width: 281px;" bordercolor="#e0e0e0">
                    <font color="#666666"><b></b></font></td>
                <td bgcolor="#e0e0e0" style="text-align: right; height: 20px;">
                    &nbsp;<a href="../../myaccount/reg/updatecustomer.aspx">Edit Account</a></td>
                <td bgcolor="#e0e0e0" style="text-align: right; height: 20px; border-right-style: solid; border-right-color: #e0e0e0;">
                        <a href="../../myaccount/logout.aspx"><font size="2"><span style="font-size: 8pt">Logout</span></font></a></td>
            </tr>
            <tr height="21">
                <td bordercolor="#e0e0e0" bgcolor="#e0e0e0" colspan="6" height="20">
                    <div align="left"><font color="#003366"><strong>My&nbsp;Product(s)</strong></font>&nbsp;
                    </div>
                </td>
            </tr>
            <tr valign="top">
                <td bordercolor="#e0e0e0" colspan="6" height="100%" style="border-left-color: #e0e0e0; border-bottom-color: #e0e0e0; border-top-style: solid; border-top-color: #e0e0e0; border-right-style: solid; border-left-style: solid; border-right-color: #e0e0e0; border-bottom-style: solid;">
                    <p align="center">
                    </p>
                    <form runat="server" id="Form1">
                        <p>
                            <asp:Literal id="status" runat="server" Visible="False"></asp:Literal><strong> </strong>
                        </p>
                        <p dir="ltr" align="left" style="text-align: right">
                            <table id="table1" style="WIDTH: 100%; HEIGHT: 131px" bordercolor="#e0e0e0" cellspacing="0" cellpadding="5" width="584" border="0" runat="server" visible="false">
                                <tbody>
                                    <tr>
                                        <td bgcolor="#e0e0e0" colspan="2">
                                            <strong>
                                            <asp:Literal id="title" runat="server"></asp:Literal>
                                            </strong></td>
                                        <td width="86" bgcolor="#e0e0e0">
                                            <strong>Product ID:</strong>
                                        </td>
                                        <td width="43" bgcolor="#e0e0e0">
                                            <asp:Literal id="productid" runat="server"></asp:Literal>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 32px">
                                            <strong>&nbsp;Title: </strong>
                                        </td>
                                        <td>
                                            <p>
                                                &nbsp;<asp:TextBox ID="title2" runat="server" MaxLength="50" Font-Size="XX-Small"></asp:TextBox>
                                                &nbsp;<strong><font color="#ff0000">*
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" BackColor="White"
                                                        ControlToValidate="title2" Display="Dynamic" ErrorMessage="Required" Font-Bold="False"></asp:RequiredFieldValidator>
                                                </font></strong>
                                            </p>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 32px; height: 34px">
                                            <strong>&nbsp;Keywords: </strong>
                                        </td>
                                        <td style="height: 34px">
                                            <p>
                                                &nbsp;<asp:TextBox ID="keyword" runat="server" MaxLength="50" Font-Size="XX-Small"></asp:TextBox>
                                                &nbsp;<strong><font color="#ff0000">*
                                                    <asp:RequiredFieldValidator ID="keword_required" runat="server" BackColor="White"
                                                        ControlToValidate="keyword" Display="Dynamic" ErrorMessage="Required" Font-Bold="False"></asp:RequiredFieldValidator>
                                                </font></strong>
                                            </p>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="98">
                                            <strong>Description: </strong></td>
                                        <td colspan="4">
                                            <p>
                                                &nbsp;Max 1000 chars&nbsp;
                                                <asp:Label ID="desclimit" runat="server" ForeColor="Red"></asp:Label><br />
                                                <asp:TextBox id="desc" runat="server" Width="436px" TextMode="MultiLine" Height="128px" Font-Size="X-Small" MaxLength="1000" Font-Names="Arial"></asp:TextBox>
                                                &nbsp;<strong><font color="#ff0000">*
                                                <asp:RequiredFieldValidator id="RequiredFieldValidator1" runat="server" ErrorMessage="Required" BackColor="White" ControlToValidate="desc" Display="Dynamic"></asp:RequiredFieldValidator>
                                                </font></strong>
                                            </p>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="98">
                                            <strong>Type: </strong></td>
                                        <td colspan="4">
                                            <asp:Literal id="type" runat="server"></asp:Literal>
                                            </td>
                                    </tr>
                                    <tr>
                                        <td width="98">
                                            <strong>Guide Price: </strong>
                                        </td>
                                        <td colspan="4">
                                            From £
                                            <asp:TextBox ID="price" runat="server" Font-Size="XX-Small" MaxLength="50"></asp:TextBox>
                                            &nbsp;<strong><font color="#ff0000">*
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" BackColor="White"
                                                    ControlToValidate="price" Display="Dynamic" ErrorMessage="Required" Font-Bold="False"></asp:RequiredFieldValidator>
                                            </font></strong>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <strong>Postage: </strong>
                                        </td>
                                        <td colspan="4">
                                            <asp:TextBox ID="Postage" runat="server" Font-Size="XX-Small" MaxLength="20"></asp:TextBox>
                                            &nbsp;&nbsp;<strong>Additional Postage: </strong>
                                            &nbsp;&nbsp;<asp:TextBox ID="AdditionalPostage" runat="server" Font-Size="XX-Small" MaxLength="20"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="98">
                                            <strong>Postage (Continent): </strong>
                                        </td>
                                        <td colspan="4">
                                             <asp:TextBox ID="PostageContinent" runat="server" Font-Size="XX-Small" MaxLength="50"></asp:TextBox>
                                             &nbsp;&nbsp;<strong>Additional Postage (Continent): </strong>
                                             &nbsp;&nbsp;<asp:TextBox ID="AdditionalPostageContinent" runat="server" Font-Size="XX-Small" MaxLength="50"></asp:TextBox>
                                       </td>
                                    </tr>
                                    <tr>
                                        <td width="98">
                                            <strong>Postage (World): </strong>
                                        </td>
                                        <td colspan="4">
                                            <asp:TextBox ID="PostageWorld" runat="server" Font-Size="XX-Small" MaxLength="50"></asp:TextBox>
                                            &nbsp;&nbsp;<strong>Additional Postage (World): </strong>
                                            &nbsp;&nbsp;<asp:TextBox ID="AdditionalPostageWorld" runat="server" Font-Size="XX-Small" MaxLength="50"></asp:TextBox>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </p>
                        <br />
                        <table id="tableproduct1" dir="ltr" cellspacing="0" cellpadding="5" width="100%" border="0" runat="server" visible="false">
                            <tbody>
                                <tr>
                                    <td style="height: 23px">
                                        <p align="center">
                                            &nbsp;<img id="productimage1" src="../../images/blank.gif" runat="server" visible="false" />
                                        </p>
                                    </td>
                                    <td style="height: 23px">
                                        <p align="center">
                                            &nbsp;<img id="productimage2" src="../../images/blank.gif" runat="server" visible="false" />
                                        </p>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        <table id="tableproduct2" dir="ltr" cellspacing="0" cellpadding="5" width="100%" border="0" runat="server" visible="false">
                            <tbody>
                                <tr>
                                    <td>
                                        <p align="center">
                                            &nbsp;<img id="productimage3" src="../../images/blank.gif" runat="server" visible="false" />
                                        </p>
                                    </td>
                                    <td>
                                        <p align="center">
                                            &nbsp;<img id="productimage4" src="../../images/blank.gif" runat="server" visible="false" />
                                        </p>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        <p dir="ltr" align="left">
                            <asp:Button id="updatedata" onclick="updatedata_Click" runat="server" Width="142px" BackColor="#003366" Text="Save Changes" Font-Bold="True" BorderColor="#E0E0E0" ForeColor="White" Font-Size="XX-Small"></asp:Button>
                            &nbsp;&nbsp;
                                        <asp:Button id="deletebutton" onclick="deletebutton_Click" runat="server" Width="104px" BackColor="#003366" Text="Delete" Font-Bold="True" BorderColor="#E0E0E0" ForeColor="White" Font-Size="XX-Small"></asp:Button></p>
                        <p>
                            &nbsp;Back to <a href="myproduct.aspx">My Products</a></p>
                    </form>
                </td>
            </tr>
            <tr>
                <td height="30" colspan="6" bgcolor="#ffffff">
                    <div align="center">
                <span><span style="font-size: 7pt">Copyright © 2011&nbsp; Essé Designs. All rights reserved. |</span><a href="../../terms-conditions.html"><span style="font-size: 7pt">Terms
                        of use</span></a><span style="font-size: 7pt"> | </span><a href="../../contact.aspx"><span
                            style="font-size: 7pt">Contact Us</span></a><span style="font-size: 7pt">&nbsp;|
                                |&nbsp;<br />
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
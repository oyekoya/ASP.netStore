<%@ Page Language="VB" %>
<script runat="server">

    Sub Page_Load(sender As Object, e As EventArgs)
        LinkButton1.PostBackUrl = "register.aspx?ReturnUrl=" & Request.QueryString("ReturnUrl")
    End Sub

    Sub LoginBtn_Click(Sender As Object, E As EventArgs)
    
        If Page.IsValid Then
        'Dim membership as String
        Dim userdata As System.Data.SqlClient.SqlDataReader = GetCustomerID(UserName.Text, UserPass.Text)
        If userdata.Read Then
                Dim cust_num As Integer = userdata.Item("CustomerID")
                FormsAuthentication.RedirectFromLoginPage(cust_num, False)
                Session("Verified") = userdata.Item("Verify")
                'Dim paymentdata As System.Data.SqlClient.SqlDataReader = GetPaymentDetails(cust_num)
                'While paymentdata.Read
                '    membership = paymentdata.Item("PaymentStatus")
                '    If ((membership="Standard") or (membership="Premium")) Then
                '        Session("membership") = membership
                '        Session("enddate") = paymentdata.Item("EndDate")
                '    End If
                'End While
            Else
                Msg.Text = "Invalid Username and/or password: Please try again"
        End If
        End If
    End Sub
    
    
    Function GetCustomerID(ByVal emailAddress As String, ByVal password As String) As System.Data.SqlClient.SqlDataReader
            Dim connectionString As String = Application("appConn")
            Dim sqlConnection As System.Data.SqlClient.SqlConnection = New System.Data.SqlClient.SqlConnection(connectionString)
    
        Dim queryString As String = "SELECT [Customer].[CustomerID], [Customer].[EmailAddress], [Customer].[Password], [Customer].[Verify] FROM [Customer] " & _
            "WHERE (([Customer].[EmailAddress] = @EmailAddress) AND ([Customer].[Password] = @Password))"
            Dim sqlCommand As System.Data.SqlClient.SqlCommand = New System.Data.SqlClient.SqlCommand(queryString, sqlConnection)
    
            sqlCommand.Parameters.Add("@EmailAddress", System.Data.SqlDbType.NVarChar).Value = emailAddress
            sqlCommand.Parameters.Add("@Password", System.Data.SqlDbType.NVarChar).Value = password
    
            sqlConnection.Open
            Dim dataReader As System.Data.SqlClient.SqlDataReader = sqlCommand.ExecuteReader(System.Data.CommandBehavior.CloseConnection)
    
            Return dataReader
    End Function

</script>
<html>
<head>
    <title>Login to your account</title> 
    <link href="style.css" type="text/css" rel="stylesheet" />
    <link href="../styles1.css" type="text/css" rel="stylesheet" />
    <link href="../styles2.css" type="text/css" rel="stylesheet" />
    
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
					<a href="../default.aspx"><b>Home</b></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="../product.aspx"><b>Products</b></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="../contact.aspx"><b>Contact</b></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="../faq.html"><b>Help/FAQs</b></a>
				</td>
          </tr>
          <tr><td colspan="3" height="100%">
             <div align="center">
                <form id="Form1" runat="server">
                    <table style="WIDTH: 367px; HEIGHT: 201px" cellspacing="0" cellpadding="4" align="center" border="2">
                        <tbody>
                            <tr>
                                <td align="right">
                                    <div align="center">
                                        <table style="WIDTH: 338px; HEIGHT: 168px" cellspacing="0" cellpadding="2" align="center" bgcolor="#e0e0e0">
                                            <tbody>
                                                <tr>
                                                    <td colspan="2">
                                                        <p align="center">
                                                            Existing users: please sign in 
                                                        </p>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td nowrap="nowrap" align="right">
                                                        Username:</td>
                                                    <td>
                                                        &nbsp;<asp:TextBox id="UserName" runat="server" Font-Size="XX-Small"></asp:TextBox>
                                                        <asp:RequiredFieldValidator id="Requiredfieldvalidator1" runat="server" ErrorMessage="*" Display="Static" ControlToValidate="UserName"></asp:RequiredFieldValidator>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td nowrap="nowrap" align="right">
                                                        Password:</td>
                                                    <td>
                                                        &nbsp;<asp:TextBox id="UserPass" runat="server" TextMode="Password" Font-Size="XX-Small"></asp:TextBox>
                                                        <asp:RequiredFieldValidator id="Requiredfieldvalidator2" runat="server" ErrorMessage="*" Display="Static" ControlToValidate="UserPass"></asp:RequiredFieldValidator>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td bordercolor="darkblue">
                                                        &nbsp; 
                                                    </td>
                                                    <td>
                                                        &nbsp;<asp:button id="LoginBtn" onclick="LoginBtn_Click" runat="server" text="Login" Font-Size="XX-Small"></asp:button>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">
                                                        <p>
                                                            <asp:Label id="Msg" runat="server" ForeColor="red"></asp:Label>
                                                        </p>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
            <p align="center">
                New users: click 
                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False">here</asp:LinkButton> to register and/or subscribe for updates<br />
                Click <a href="forgotten.aspx">here</a> if you have forgotten your password 
            </p>
                 </form>
            </div>
          </td></tr>
            <tr>
                <td height="30" colspan="3" bgcolor="#ffffff">
                    <div align="center">
                <span><span style="font-size: 7pt">Copyright © 2011&nbsp; Essé Designs. All rights reserved. |</span><a href="../terms-conditions.html"><span style="font-size: 7pt">Terms
                        of use</span></a><span style="font-size: 7pt"> | </span><a href="../contact.aspx"><span
                            style="font-size: 7pt">Contact Us</span></a><span style="font-size: 7pt">&nbsp;|
                                |&nbsp;<br />
                                By using this website, you accept its full </span><a href="../terms-conditions.html"><span
                                    style="font-size: 7pt">Terms and
                                    Conditions</span></a><span style="font-size: 7pt">. To learn more about how we use your information, see our </span>
                </span>
                <a href="../privacy.html"><span style="font-size: 7pt">Privacy Policy</span></a><span
                    style="font-size: 7pt"> </span></div>
                </td>
           </tr>
        </tbody>
    </table>
</body>
</html>
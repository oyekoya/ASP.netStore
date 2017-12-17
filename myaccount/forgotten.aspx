<%@ Page Language="VB" %>
<%--<%@ import Namespace="System.Web.Mail" %>--%>
<%@ import Namespace="System.Net" %>
<%@ import Namespace="System.Net.Mail" %>
<script runat="server">

    Function GetPassword(ByVal emailAddress As String, ByVal birthdate As Date) As System.Data.SqlClient.SqlDataReader
         Dim connectionString As String = Application("appConn")
         Dim sqlConnection As System.Data.SqlClient.SqlConnection = New System.Data.SqlClient.SqlConnection(connectionString)

         Dim queryString As String = "SELECT [Customer].[Password] FROM [Customer] WHERE (([Customer].[EmailAddress] = "& _
    "@EmailAddress) AND ([Customer].[Birthdate] = @Birthdate))"
         Dim sqlCommand As System.Data.SqlClient.SqlCommand = New System.Data.SqlClient.SqlCommand(queryString, sqlConnection)

         sqlCommand.Parameters.Add("@EmailAddress", System.Data.SqlDbType.NVarChar).Value = emailAddress
         sqlCommand.Parameters.Add("@Birthdate", System.Data.SqlDbType.SmallDateTime).Value = birthdate

         sqlConnection.Open
         Dim dataReader As System.Data.SqlClient.SqlDataReader = sqlCommand.ExecuteReader(System.Data.CommandBehavior.CloseConnection)

         Return dataReader
     End Function


    Sub Button1_Click(sender As Object, e As EventArgs)
        If Page.IsPostBack Then
            Page.Validate
            If Page.IsValid() Then
                'Check values with database.
                Dim birthdate As Date = day.SelectedItem.Value & "/" & month.SelectedItem.Value & "/" & year.Text
                Dim querydata As System.Data.SqlClient.SqlDataReader = GetPassword(email.Text, birthdate)
                If querydata.Read Then 'Email password reminder
                    ' Build a MailMessage
                    Dim from As String = "enquiries@essedesigns.com"
                    Dim [to] As String = email.Text
                    Dim subj As String = "Password Reminder"
                    Dim body As String = " Your password is " & querydata.Item("Password") & vbCrLf & vbCrLf & _
                                         " Please delete this email once you have logged in successfully" & vbCrLf & vbCrLf & _
                                         "Esse Designs Team"
                    Dim smtpServer As String = Application("mailserver")
                    Dim message As New MailMessage(from, [to], subj, body)
                    Dim smtpClient As New SmtpClient(smtpServer)
                    smtpClient.UseDefaultCredentials = False
                    Dim credentials As New NetworkCredential(Application("Username"), Application("Password"))
                    smtpClient.Credentials = credentials
                    smtpClient.Send(message)
                    
                    remindertable.Visible=False
                    status.Text="<p>Password has been emailed to " & email.Text & "</p>Please click <a href='reg/default.aspx'>here</a> to login"
                Else
                    status.Text="Email does not exist"
                End If
            End If
        End If
    End Sub

</script>
<html>
<head>
    <title>Esse Designs - Forgotten Password</title> 
    <link href="../styles1.css" type="text/css" rel="stylesheet" />
    <link href="../styles2.css" type="text/css" rel="stylesheet" />
    <link href="style.css" type="text/css" rel="stylesheet" />
    
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
          <tr><td colspan="3" valign="top">
        <form id="Form1" runat="server">
        <div align="center">
            <br />
            <table id="remindertable" style="WIDTH: 760px; HEIGHT: 78px" cellspacing="0" cellpadding="5" align="center" runat="server">
                <tbody>
                    <tr valign="top">
                        <td width="170" style="height: 7px">
                            <p align="center">
                            </p>
                        </td>
                        <td width="80" style="height: 7px">
                            Email:</td>
                        <td style="height: 7px">
                            <asp:TextBox id="email" runat="server" Font-Size="XX-Small"></asp:TextBox>
                            <font color="red">*</font></td>
                        <td width="290" style="height: 7px">
                            <asp:RequiredFieldValidator id="RequiredFieldValidator1" runat="server" ControlToValidate="email" Font-Bold="True" Font-Size="XX-Small" ErrorMessage="Required" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator id="RegularExpressionValidator1" runat="server" ControlToValidate="email" Font-Bold="True" ErrorMessage="Enter a valid email address" Display="Dynamic" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" Font-Size="XX-Small"></asp:RegularExpressionValidator>
                        </td>
                    </tr>
                    <tr valign="top">
                        <td width="170" style="height: 5px">
                        </td>
                        <td width="80" style="height: 5px">
                            BirthDate:</td>
                        <td style="height: 5px">
                            <asp:DropDownList id="day" runat="server" Width="41px" Font-Size="XX-Small">
                                <asp:ListItem Value="1">1</asp:ListItem>
                                <asp:ListItem Value="2">2</asp:ListItem>
                                <asp:ListItem Value="3">3</asp:ListItem>
                                <asp:ListItem Value="4">4</asp:ListItem>
                                <asp:ListItem Value="5">5</asp:ListItem>
                                <asp:ListItem Value="6">6</asp:ListItem>
                                <asp:ListItem Value="7">7</asp:ListItem>
                                <asp:ListItem Value="8">8</asp:ListItem>
                                <asp:ListItem Value="9">9</asp:ListItem>
                                <asp:ListItem Value="10">10</asp:ListItem>
                                <asp:ListItem Value="11">11</asp:ListItem>
                                <asp:ListItem Value="12">12</asp:ListItem>
                                <asp:ListItem Value="13">13</asp:ListItem>
                                <asp:ListItem Value="14">14</asp:ListItem>
                                <asp:ListItem Value="15">15</asp:ListItem>
                                <asp:ListItem Value="16">16</asp:ListItem>
                                <asp:ListItem Value="17">17</asp:ListItem>
                                <asp:ListItem Value="18">18</asp:ListItem>
                                <asp:ListItem Value="19">19</asp:ListItem>
                                <asp:ListItem Value="20">20</asp:ListItem>
                                <asp:ListItem Value="21">21</asp:ListItem>
                                <asp:ListItem Value="22">22</asp:ListItem>
                                <asp:ListItem Value="23">23</asp:ListItem>
                                <asp:ListItem Value="24">24</asp:ListItem>
                                <asp:ListItem Value="25">25</asp:ListItem>
                                <asp:ListItem Value="26">26</asp:ListItem>
                                <asp:ListItem Value="27">27</asp:ListItem>
                                <asp:ListItem Value="28">28</asp:ListItem>
                                <asp:ListItem Value="29">29</asp:ListItem>
                                <asp:ListItem Value="30">30</asp:ListItem>
                                <asp:ListItem Value="31">31</asp:ListItem>
                            </asp:DropDownList>
                            / 
                            <asp:DropDownList id="month" runat="server" Width="49px" Font-Size="XX-Small">
                                <asp:ListItem Value="1">Jan</asp:ListItem>
                                <asp:ListItem Value="2">Feb</asp:ListItem>
                                <asp:ListItem Value="3">Mar</asp:ListItem>
                                <asp:ListItem Value="4">Apr</asp:ListItem>
                                <asp:ListItem Value="5">May</asp:ListItem>
                                <asp:ListItem Value="6">Jun</asp:ListItem>
                                <asp:ListItem Value="7">Jul</asp:ListItem>
                                <asp:ListItem Value="8">Aug</asp:ListItem>
                                <asp:ListItem Value="9">Sept</asp:ListItem>
                                <asp:ListItem Value="10">Oct</asp:ListItem>
                                <asp:ListItem Value="11">Nov</asp:ListItem>
                                <asp:ListItem Value="12">Dec</asp:ListItem>
                            </asp:DropDownList>
                            &nbsp;/&nbsp;<asp:TextBox id="year" runat="server" Width="51px" Font-Size="XX-Small"></asp:TextBox>
                            <font color="red" size="2">*</font></td>
                        <td width="290" style="height: 5px">
                            <asp:RequiredFieldValidator id="RequiredFieldValidator8" runat="server" ControlToValidate="day" Font-Bold="True" Font-Size="XX-Small" ErrorMessage="Required" Display="Dynamic" BackColor="White"></asp:RequiredFieldValidator>
                            <asp:RequiredFieldValidator id="RequiredFieldValidator9" runat="server" ControlToValidate="month" Font-Bold="True" Font-Size="XX-Small" ErrorMessage="Required" Display="Dynamic" BackColor="White"></asp:RequiredFieldValidator>
                            <asp:RangeValidator id="validateyear" runat="server" ControlToValidate="year" Font-Bold="True" ErrorMessage="1900-2000" Display="Dynamic" Type="Integer" MinimumValue="1900" MaximumValue="2000" Font-Size="XX-Small"></asp:RangeValidator>
                        </td>
                    </tr>
                    <tr valign="top">
                        <td width="170">
                        </td>
                        <td colspan="2">
                            <div align="center">
                                <asp:Button id="Button1" onclick="Button1_Click" runat="server" Text="Email Password" Font-Size="XX-Small"></asp:Button>
                            </div>
                        </td>
                        <td width="290">
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
        </form>
        <p align="center">
            <asp:Literal id="status" runat="server"></asp:Literal>
        </p>
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
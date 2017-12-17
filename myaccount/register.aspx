<%@ Page Language="VB" %>
<%--<%@ import Namespace="System.Web.Mail" %>--%>
<%@ import Namespace="System.Net" %>
<%@ import Namespace="System.Net.Mail" %>
<script runat="server">

    Dim x As New Random
    Dim verify as Integer = x.NextDouble()*32767
    '
    Function CheckEmail(ByVal emailAddress As String) As System.Data.SqlClient.SqlDataReader
            Dim connectionString As String = Application("appConn")
            Dim sqlConnection As System.Data.SqlClient.SqlConnection = New System.Data.SqlClient.SqlConnection(connectionString)
    
            Dim queryString As String = "SELECT [Customer].[CustomerID], [Customer].[Password] FROM [Customer] WHERE ([Customer].[EmailAddress] ="& _
    " @EmailAddress)"
            Dim sqlCommand As System.Data.SqlClient.SqlCommand = New System.Data.SqlClient.SqlCommand(queryString, sqlConnection)
    
            sqlCommand.Parameters.Add("@EmailAddress", System.Data.SqlDbType.NVarChar).Value = emailAddress
    
            sqlConnection.Open
            Dim dataReader As System.Data.SqlClient.SqlDataReader = sqlCommand.ExecuteReader(System.Data.CommandBehavior.CloseConnection)
    
            Return dataReader
        End Function
    
    
        Function SubscribeUpdate(ByVal emailAddress As String) As Integer
            Dim connectionString As String = Application("appConn")
            Dim sqlConnection As System.Data.SqlClient.SqlConnection = New System.Data.SqlClient.SqlConnection(connectionString)
    
            Dim queryString As String = "UPDATE [Customer] SET [Subscribe]=1 WHERE ([Customer].[EmailAddress] = @EmailAddr"& _
    "ess)"
            Dim sqlCommand As System.Data.SqlClient.SqlCommand = New System.Data.SqlClient.SqlCommand(queryString, sqlConnection)
    
            sqlCommand.Parameters.Add("@EmailAddress", System.Data.SqlDbType.NVarChar).Value = emailAddress
    
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
    
    
        Function SubscribeInsert(ByVal emailAddress As String) As Integer
            Dim connectionString As String = Application("appConn")
            Dim sqlConnection As System.Data.SqlClient.SqlConnection = New System.Data.SqlClient.SqlConnection(connectionString)
    
            Dim queryString As String = "INSERT INTO [Customer] ([EmailAddress], [Subscribe]) VALUES (@EmailAddress, 1)"
            Dim sqlCommand As System.Data.SqlClient.SqlCommand = New System.Data.SqlClient.SqlCommand(queryString, sqlConnection)
    
            sqlCommand.Parameters.Add("@EmailAddress", System.Data.SqlDbType.NVarChar).Value = emailAddress
    
            Dim rowsAffected As Integer = 0
            sqlConnection.Open
            Try
                rowsAffected = sqlCommand.ExecuteNonQuery
				sqlConnection.Close()
            Finally
                sqlConnection.Close
            End Try
    
             If rowsAffected <> 0 Then
                Dim from As String = "enquiries@essedesigns.com"
                Dim [to] As String = email.Text
                Dim subj As String = "Esse Designs - Registration"
                Dim body As String = "Thank you for registering for Updates" & vbCrLf & vbCrLf & _
                                    "Stay connected with Esse Designs!" & vbCrLf & vbCrLf & _
                                    "Esse Designs Team"
                Dim smtpServer As String = Application("mailserver")
                Dim message As New MailMessage(from, [to], subj, body)
                Dim smtpClient As New SmtpClient(smtpServer)
                smtpClient.UseDefaultCredentials = False
                Dim credentials As New NetworkCredential(Application("Username"), Application("Password"))
                smtpClient.Credentials = credentials
                smtpClient.Send(message)
             End If
            Return rowsAffected
        End Function
    
        Sub emailconfirm_Click(sender As Object, e As EventArgs)
             If Page.IsPostBack Then
             Page.Validate
             If Page.IsValid() Then
                Dim emaildata As System.Data.SqlClient.SqlDataReader = CheckEmail(email.Text)
    
                If emaildata.Read Then
                    if "" & emaildata.Item("Password") = "" Then
                        SubscribeUpdate(email.Text)
                        email.ReadOnly = True
                        emailconfirm.Visible = False
                        status.Text = "<p> You are already subscribed. </p> Please fill in the rest of the form"
                        DetailsTable.Visible = True
                    Else
                    status.Text = "Email already exists! Try again"
                    End If
                Else
                    SubscribeInsert(email.Text)
                    email.ReadOnly = True
                    emailconfirm.Visible = False
                    status.Text = "<p> You are now subscribed for updates. </p> Please fill in the rest of the form to complete registration"
                    DetailsTable.Visible = True
                End If
             End If
             End If
        End Sub
    
    Sub SubmitButton_Click(sender As Object, e As EventArgs)
          If Page.IsPostBack Then
          Page.Validate
          If Page.IsValid() Then
            If password.Text = password2.Text Then
    
            'Register User and log them in
            Dim connectionString As String = Application("appConn")
            Dim sqlConnection As System.Data.SqlClient.SqlConnection = New System.Data.SqlClient.SqlConnection(connectionString)
    
            Dim queryString As String = "UPDATE [Customer] SET [FirstName]=@FirstName, [LastName]=@LastName, [State]=@Stat"& _
    "e, [Interest2]=@Interest2, [Interest3]=@Interest3, [Interest1]=@Interest1, [FaxN"& _
    "umber]=@FaxNumber, [OrganizationName]=@OrganizationName, [City]=@City, [PostalCo"& _
    "de]=@PostalCode, [Telephone]=@Telephone, [Gender]=@Gender, [Address]=@Address, ["& _
    "MobilePhone]=@MobilePhone, [Country]=@Country, [Birthdate]=@Birthdate, [Password"& _
    "]=@Password, [Verify]=@Verify WHERE ([Customer].[EmailAddress] = @EmailAddress)"
            Dim sqlCommand As System.Data.SqlClient.SqlCommand = New System.Data.SqlClient.SqlCommand(queryString, sqlConnection)
    
            sqlCommand.Parameters.Add("@EmailAddress", System.Data.SqlDbType.NVarChar).Value = email.Text
            sqlCommand.Parameters.Add("@Password", System.Data.SqlDbType.NVarChar).Value = password.Text
            sqlCommand.Parameters.Add("@FirstName", System.Data.SqlDbType.NVarChar).Value = firstname.Text
            sqlCommand.Parameters.Add("@LastName", System.Data.SqlDbType.NVarChar).Value = surname.Text
            sqlCommand.Parameters.Add("@Gender", System.Data.SqlDbType.NVarChar).Value = gender.SelectedItem.Text
            sqlCommand.Parameters.Add("@OrganizationName", System.Data.SqlDbType.NVarChar).Value = org.Text
            sqlCommand.Parameters.Add("@Address", System.Data.SqlDbType.NVarChar).Value = address.Text
            sqlCommand.Parameters.Add("@City", System.Data.SqlDbType.NVarChar).Value = city.Text
            sqlCommand.Parameters.Add("@State", System.Data.SqlDbType.NVarChar).Value = state.Text
            sqlCommand.Parameters.Add("@PostalCode", System.Data.SqlDbType.NVarChar).Value = postalcode.Text
            sqlCommand.Parameters.Add("@Country", System.Data.SqlDbType.NVarChar).Value = country.Text
            sqlCommand.Parameters.Add("@Telephone", System.Data.SqlDbType.NVarChar).Value = telephone.Text
            sqlCommand.Parameters.Add("@MobilePhone", System.Data.SqlDbType.NVarChar).Value = mobile.Text
            sqlCommand.Parameters.Add("@FaxNumber", System.Data.SqlDbType.NVarChar).Value = fax.Text
            Dim birthdate As Date = day.SelectedItem.Value & "/" & month.SelectedItem.Value & "/" & year.Text
            sqlCommand.Parameters.Add("@Birthdate", System.Data.SqlDbType.SmallDateTime).Value = birthdate
            sqlCommand.Parameters.Add("@Verify", System.Data.SqlDbType.SmallInt).Value = verify
            sqlCommand.Parameters.Add("@Interest1", System.Data.SqlDbType.Char).Value = interest1.SelectedItem.Text
            sqlCommand.Parameters.Add("@Interest2", System.Data.SqlDbType.Char).Value = interest2.SelectedItem.Text
            sqlCommand.Parameters.Add("@Interest3", System.Data.SqlDbType.Char).Value = interest3.SelectedItem.Text
    
            Dim rowsAffected As Integer = 0
            sqlConnection.Open
            Try
                rowsAffected = sqlCommand.ExecuteNonQuery
				sqlConnection.Close()
            Finally
                sqlConnection.Close
            End Try
    
            status.Text = "<p>You have now been registered. </p>Please click <a href='login.aspx?ReturnUrl=" & Request.QueryString("ReturnUrl") & _
                    "'>here</a> to login" & _
                    "<br><br>An email has been sent to the email address specified for verification." & _
                    "<br><br>Click the link in the email to verify your email address and have full access to all functionalities within the website."
            DetailsTable.Visible = False
            If rowsAffected <> 0 Then
                Dim from As String = "enquiries@essedesigns.com"
                Dim [to] As String = email.Text & "," & "enquiries@essedesigns.com"
                Dim subj As String = "Esse Designs - Registration Complete"
                Dim body As String = "Hi " & firstname.Text & " " & surname.Text & ","  & vbCrLf & vbCrLf & _
                                    "Welcome to Essé Designs! " & vbCrLf & vbCrLf & _
                                    "username is: " & email.Text & vbCrLf & _
                                    "password: " & password.Text  & vbCrLf & vbCrLf & _
                                    "Thanks for completing the registration. You are now a member." & vbCrLf & vbCrLf & _
                                    "Click http://www.essedesigns.com/store/myaccount/reg/verify.aspx?v=" & verify & " to verify your email address" & vbCrLf & vbCrLf & _
                                    "Stay connected with Esse Designs to keep up to date with the latest styles!" & vbCrLf & vbCrLf & _
                                    "Esse Designs respects your privacy. If you have any concerns about your privacy, please view our Privacy page on http://www.essedesigns.com/store/privacy.html." & vbCrLf & vbCrLf & _
                                    "Terms and Conditions are available on http://www.essedesigns.com/store/terms-conditions.html." & vbCrLf & vbCrLf & _
                                    "Thanks for joining us!" & vbCrLf & vbCrLf & _
                                    "Esse Designs Team"
                Dim smtpServer As String = Application("mailserver")
                Dim message As New MailMessage(from, [to], subj, body)
                'message.CC = "enquiries@essedesigns.com"
                Dim smtpClient As New SmtpClient(smtpServer)
                smtpClient.UseDefaultCredentials = False
                Dim credentials As New NetworkCredential(Application("Username"), Application("Password"))
                smtpClient.Credentials = credentials
                smtpClient.Send(message)
             End If
            Else
            'passwords do not match
            passwordmatch.Text="Passwords do not match, Please re-enter"
            End If
          End If
          End If
        End Sub

</script>
<html>
<head>
    <title>Register</title> 
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
          <tr><td valign=top colspan="3">
          <form runat=server>
            <table><tbody>
                <tr>
                    <td colspan="2">
                        <strong><u>Logon Details</u></strong></td>
                </tr>
                <tr>
                    <td valign="top">
                        Email:</td>
                    <td valign="top">
                        <asp:TextBox id="email" runat="server" MaxLength="50" Font-Size="XX-Small" Width="178px"></asp:TextBox>
                        &nbsp;<font color="red" size="2"><strong>* 
                        <asp:RequiredFieldValidator id="RequiredFieldValidator1" runat="server" Display="Dynamic" ErrorMessage="Required" Font-Size="XX-Small" BackColor="White" Font-Bold="True" ControlToValidate="email"></asp:RequiredFieldValidator>
                        &nbsp;<asp:RegularExpressionValidator id="RegularExpressionValidator2" runat="server" Display="Dynamic" ErrorMessage="Please enter a valid email address" Font-Size="XX-Small" BackColor="White" Font-Bold="True" ControlToValidate="email" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                        </strong></font></td>
                </tr>
                <tr>
                    <td valign="top">
                    </td>
                    <td valign="top">
                        <p align="left">
                            <asp:Button id="emailconfirm" onclick="emailconfirm_Click" runat="server" Text="Next" Font-Size="XX-Small"></asp:Button>
                        </p>
                    </td>
                </tr>
                <tr>
                    <td valign="top" width="300" colspan="2">
                        <p align="center">
                            <asp:Literal id="status" runat="server"></asp:Literal>
                        </p>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <table id="DetailsTable" style="WIDTH: 750px" cellspacing="0" cellpadding="5" width="750" align="center" border="0" runat="server" visible="false">
                            <tbody>
                                <tr>
                                    <td colspan="4">
                                        <strong><u>Personal Details</u></strong></td>
                                </tr>
                                <tr>
                                    <td valign="top" style="width: 75px">
                                        Password:</td>
                                    <td valign="top" style="width: 221px">
                                        <asp:TextBox id="password" runat="server" MaxLength="50" TextMode="Password" Font-Size="XX-Small"></asp:TextBox>
                                        &nbsp;<strong><font color="#ff0000" size="2">* 
                                        <asp:RequiredFieldValidator id="RequiredFieldValidator2" runat="server" Display="Dynamic" ErrorMessage="Required" Font-Size="XX-Small" BackColor="White" Font-Bold="True" ControlToValidate="password"></asp:RequiredFieldValidator>
                                        </font></strong></td>
                                    <td valign="top" width="92">
                                        Confirm Password:</td>
                                    <td valign="top" width="207">
                                        <asp:TextBox id="password2" runat="server" MaxLength="50" TextMode="Password" Font-Size="XX-Small"></asp:TextBox>
                                        &nbsp;<strong><font color="#ff0000" size="2">*<asp:RequiredFieldValidator id="RequiredFieldValidator3" runat="server" Display="Dynamic" ErrorMessage="Required" Font-Size="XX-Small" BackColor="White" Font-Bold="True" ControlToValidate="password2"></asp:RequiredFieldValidator>
                                        </font></strong></td>
                                </tr>
                                <tr>
                                    <td colspan="4">
                                        <p align="center">
                                            <font color="red">
                                            <asp:Literal id="passwordmatch" runat="server"></asp:Literal>
                                            </font>
                                        </p>
                                    </td>
                                </tr>
                                <tr>
                                    <td valign="top" style="width: 75px">
                                        First Name:</td>
                                    <td valign="top" style="width: 221px">
                                        <asp:TextBox id="firstname" runat="server" MaxLength="50" Font-Size="XX-Small"></asp:TextBox>
                                        <strong><font color="#ff0000" size="2">*<asp:RequiredFieldValidator id="RequiredFieldValidator4" runat="server" Display="Dynamic" ErrorMessage="Required" Font-Size="XX-Small" BackColor="White" Font-Bold="True" ControlToValidate="firstname"></asp:RequiredFieldValidator>
                                        </font></strong></td>
                                    <td valign="top" width="92">
                                        Surname:</td>
                                    <td valign="top" width="207">
                                        <asp:TextBox id="surname" runat="server" MaxLength="50" Font-Size="XX-Small"></asp:TextBox>
                                        <strong><font color="#ff0000" size="2">*<asp:RequiredFieldValidator id="RequiredFieldValidator5" runat="server" Display="Dynamic" ErrorMessage="Required" Font-Size="XX-Small" BackColor="White" Font-Bold="True" ControlToValidate="surname"></asp:RequiredFieldValidator>
                                        </font></strong></td>
                                </tr>
                                <tr>
                                    <td valign="top" style="width: 75px">
                                        Gender:</td>
                                    <td valign="top" style="width: 221px">
                                        <asp:DropDownList id="gender" runat="server" Font-Size="XX-Small">
                                            <asp:ListItem Value="Male">Male</asp:ListItem>
                                            <asp:ListItem Value="Female">Female</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                    <td valign="top">
                                        Organization:</td>
                                    <td valign="top">
                                        <asp:TextBox id="org" runat="server" Font-Size="XX-Small"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td valign="top" style="width: 75px">
                                        Address: 
                                    </td>
                                    <td valign="top" style="width: 221px">
                                        <asp:TextBox id="address" runat="server" Font-Size="XX-Small"></asp:TextBox>
                                        <strong><font color="#ff0000" size="2">*</font></strong> 
                                        <asp:RequiredFieldValidator id="RequiredFieldValidator6" runat="server" Display="Dynamic" ErrorMessage="Required" Font-Size="XX-Small" BackColor="White" Font-Bold="True" ControlToValidate="address"></asp:RequiredFieldValidator>
                                    </td>
                                    <td valign="top" width="92">
                                        City:</td>
                                    <td valign="top" width="207">
                                        <asp:TextBox id="city" runat="server" Font-Size="XX-Small"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td valign="top" style="width: 75px">
                                        State:</td>
                                    <td valign="top" style="width: 221px">
                                        <asp:TextBox id="state" runat="server" Font-Size="XX-Small"></asp:TextBox>
                                    </td>
                                    <td valign="top" width="92">
                                        Postal Code:</td>
                                    <td valign="top" width="207">
                                        <asp:TextBox id="postalcode" runat="server" Font-Size="XX-Small"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td valign="top" style="width: 75px">
                                        Country:</td>
                                    <td valign="top" style="width: 221px">
                                        <asp:TextBox id="country" runat="server" Font-Size="XX-Small"></asp:TextBox>
                                        <strong><font color="#ff0000" size="2">*</font></strong> 
                                        <asp:RequiredFieldValidator id="RequiredFieldValidator7" runat="server" Display="Dynamic" ErrorMessage="Required" Font-Size="XX-Small" BackColor="White" Font-Bold="True" ControlToValidate="country"></asp:RequiredFieldValidator>
                                    </td>
                                    <td valign="top" width="92">
                                        Telephone:</td>
                                    <td valign="top" width="207">
                                        <asp:TextBox id="telephone" runat="server" MaxLength="50" Font-Size="XX-Small"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td valign="top" style="width: 75px">
                                        Mobile:</td>
                                    <td valign="top" style="width: 221px">
                                        <asp:TextBox id="mobile" runat="server" Font-Size="XX-Small"></asp:TextBox>
                                    </td>
                                    <td valign="top" width="92">
                                        Fax:</td>
                                    <td valign="top" width="207">
                                        <asp:TextBox id="fax" runat="server" Font-Size="XX-Small"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td valign="top" style="width: 75px">
                                        BirthDate:</td>
                                    <td valign="top" style="width: 221px">
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
                                        /<asp:DropDownList id="month" runat="server" Width="49px" Font-Size="XX-Small">
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
                                        /&nbsp;<asp:TextBox id="year" runat="server" Width="51px" Font-Size="XX-Small"></asp:TextBox>
                                        <font color="red" size="2"><strong>* 
                                        <asp:RequiredFieldValidator id="RequiredFieldValidator8" runat="server" Display="Dynamic" ErrorMessage="Required" Font-Size="XX-Small" BackColor="White" Font-Bold="True" ControlToValidate="day"></asp:RequiredFieldValidator>
                                        <asp:RequiredFieldValidator id="RequiredFieldValidator9" runat="server" Display="Dynamic" ErrorMessage="Required" Font-Size="XX-Small" BackColor="White" Font-Bold="True" ControlToValidate="month"></asp:RequiredFieldValidator>
                                        <asp:RangeValidator id="validateyear" runat="server" Display="Dynamic" ErrorMessage="1900-2000" ControlToValidate="year" MaximumValue="2000" MinimumValue="1900" Type="Integer" Font-Size="XX-Small"></asp:RangeValidator>
                                        </strong></font></td>
                                    <td valign="top" colspan="2">
                                        This information is needed for security, in case you forget your password. 
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4">
                                        <strong><u>Interests</u></strong></td>
                                </tr>
                                <tr>
                                    <td valign="top" style="width: 75px">
                                        Interest(s): 
                                    </td>
                                    <td valign="top" style="width: 221px">
                                        <asp:DropDownList id="interest1" runat="server" Font-Size="XX-Small">
                                            <asp:ListItem Value="all" Selected="True">All</asp:ListItem>
	                                        <asp:ListItem Value="outerwear">Outerwear</asp:ListItem>
	                                        <asp:ListItem Value="fabric">Fabric</asp:ListItem>
                                            <asp:ListItem Value="networking">Networking</asp:ListItem>
	                                        <asp:ListItem Value="other">Other</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                    <td valign="top" width="92">
                                        <asp:DropDownList id="interest2" runat="server" Font-Size="XX-Small">
                                            <asp:ListItem Value="all" Selected="True">All</asp:ListItem>
	                                        <asp:ListItem Value="outerwear">Outerwear</asp:ListItem>
	                                        <asp:ListItem Value="fabric">Fabric</asp:ListItem>
                                            <asp:ListItem Value="networking">Networking</asp:ListItem>
	                                        <asp:ListItem Value="other">Other</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                    <td valign="top" width="207">
                                        <asp:DropDownList id="interest3" runat="server" Font-Size="XX-Small">
                                            <asp:ListItem Value="all" Selected="True">All</asp:ListItem>
	                                        <asp:ListItem Value="outerwear">Outerwear</asp:ListItem>
	                                        <asp:ListItem Value="fabric">Fabric</asp:ListItem>
                                            <asp:ListItem Value="networking">Networking</asp:ListItem>
	                                        <asp:ListItem Value="other">Other</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 75px">
                                        &nbsp; 
                                    </td>
                                    <td style="width: 221px">
                                        <div align="left">
                                        </div>
                                    </td>
                                    <td valign="top" width="92">
                                        <asp:Button id="SubmitButton" onclick="SubmitButton_Click" runat="server" Text="Register" Font-Size="XX-Small"></asp:Button>
                                    </td>
                                    <td valign="top" width="207">
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                </tr>
             </tbody></table>
          </form>
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
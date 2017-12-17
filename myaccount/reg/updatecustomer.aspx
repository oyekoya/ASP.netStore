<%@ Page Language="VB" %>
<script runat="server">

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            Dim customerdata As System.Data.SqlClient.SqlDataReader = GetCustomerDetails()
            If customerdata.Read Then
                email.Text = "" & customerdata.Item("EmailAddress")
                firstname.Text = "" & customerdata.Item("FirstName")
                surname.Text = "" & customerdata.Item("LastName")
                gender.SelectedItem.Text = "" & customerdata.Item("Gender")
                org.Text = "" & customerdata.Item("OrganizationName")
                address.Text = "" & customerdata.Item("Address")
                city.Text = "" & customerdata.Item("City")
                state.Text = "" & customerdata.Item("State")
                postalcode.Text = "" & customerdata.Item("PostalCode")
                country.Text = "" & customerdata.Item("Country")
                telephone.Text = "" & customerdata.Item("Telephone")
                mobile.Text = "" & customerdata.Item("MobilePhone")
                fax.Text = "" & customerdata.Item("FaxNumber")
                birthdate.Text = "" & customerdata.Item("Birthdate")
            End If
        End If
    End Sub

    ' ----------------------------------------
    Function GetCustomerDetails() As System.Data.SqlClient.SqlDataReader
        Dim connectionString As String = Application("appConn")
        Dim sqlConnection As System.Data.SqlClient.SqlConnection = New System.Data.SqlClient.SqlConnection(connectionString)

        Dim queryString As String = "SELECT * FROM Customer WHERE CustomerID = " & Request.ServerVariables("AUTH_USER")
        Dim sqlCommand As System.Data.SqlClient.SqlCommand = New System.Data.SqlClient.SqlCommand(queryString, sqlConnection)

        sqlConnection.Open()
        Dim dataReader As System.Data.SqlClient.SqlDataReader = sqlCommand.ExecuteReader(System.Data.CommandBehavior.CloseConnection)

        Return dataReader
    End Function
    
    Function UpdateCustomerDetails() As Integer
        Dim connectionString As String = Application("appConn")
        Dim sqlConnection As System.Data.SqlClient.SqlConnection = New System.Data.SqlClient.SqlConnection(connectionString)

        Dim queryString As String = "UPDATE [Customer] SET [FirstName]=@FirstName, [LastName]=@LastName, [State]=@State, " & _
"[FaxNumber]=@FaxNumber, [OrganizationName]=@OrganizationName, [City]=@City, [PostalCode]=" & _
"@PostalCode, [Telephone]=@Telephone, [Gender]=@Gender, [Address]=@Address, [" & _
"MobilePhone]=@MobilePhone, [Country]=@Country, [Birthdate]=@Birthdate, [Password]=" & _
"@Password WHERE ([Customer].[CustomerID] = " & Request.ServerVariables("AUTH_USER") & ")"
        Dim sqlCommand As System.Data.SqlClient.SqlCommand = New System.Data.SqlClient.SqlCommand(queryString, sqlConnection)
    
        'sqlCommand.Parameters.Add("@EmailAddress", System.Data.SqlDbType.NVarChar).Value = email.Text
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
        sqlCommand.Parameters.Add("@Birthdate", System.Data.SqlDbType.SmallDateTime).Value = birthdate.Text

        Dim rowsAffected As Integer = 0
        sqlConnection.Open()
        Try
            rowsAffected = sqlCommand.ExecuteNonQuery
			sqlConnection.Close()
        Finally
            sqlConnection.Close()
        End Try

        Return rowsAffected
    End Function
    
    Protected Sub SubmitButton_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        UpdateCustomerDetails()
        Label1.Visible = True
    End Sub
</script>
<html>
<head>
    <title>My account</title> 
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
                <td bgcolor="#e0e0e0" style="text-align: left; height: 20px; " bordercolor="#e0e0e0">
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
                <td bgcolor="#e0e0e0" colspan="6" style="height: 15px">
                    <div align="center" style="text-align: left">
                        <strong>&nbsp;Edit Account Details&nbsp;</strong></div>
                </td>
            </tr>
            <tr valign="top">
                <td colspan="6" height="100%" style="border-left-color: #e0e0e0; border-bottom-color: #e0e0e0; border-top-style: solid; border-top-color: #e0e0e0; border-right-style: solid; border-left-style: solid; border-right-color: #e0e0e0; border-bottom-style: solid">
                    <font size="4"> 
                    <p align="center" style="text-align: left">
                        <span style="font-size: 8pt"></span></p>
                        <p>
                            <form id="Form1" runat=server>
                                <table id="DetailsTable" runat="server" align="center" border="0" cellpadding="5"
                                    cellspacing="0" visible="true" width="100%">
                                    <tbody>
                                        <tr>
                                            <td valign="top" style="width: 100px">
                                                Email:</td>
                                            <td colspan="3" valign="top">
                                                <asp:Label ID="email" runat="server" Text="Label"></asp:Label>
                                                &nbsp;<font color="red" size="2"><strong> &nbsp;&nbsp;
                                                </strong></font>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td valign="top" style="width: 100px">
                                                Password:</td>
                                            <td valign="top" style="width: 213px">
                                                <asp:TextBox ID="password" runat="server" Font-Size="XX-Small" MaxLength="50" TextMode="Password" Width="109px"></asp:TextBox>
                                                &nbsp;<strong><font color="#ff0000" size="2">*
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" BackColor="White"
                                                        ControlToValidate="password" Display="Dynamic" ErrorMessage="Required" Font-Bold="True"
                                                        Font-Size="XX-Small"></asp:RequiredFieldValidator>
                                                </font></strong>
                                            </td>
                                            <td valign="top" style="width: 146px">
                                                Confirm Password:</td>
                                            <td valign="top" style="width: 258px">
                                                <asp:TextBox ID="password2" runat="server" Font-Size="XX-Small" MaxLength="50" TextMode="Password" Width="109px"></asp:TextBox>
                                                &nbsp;<strong><font color="#ff0000" size="2">*
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" BackColor="White"
                                                        ControlToValidate="password2" Display="Dynamic" ErrorMessage="Required" Font-Bold="True"
                                                        Font-Size="XX-Small"></asp:RequiredFieldValidator>
                                                <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="password2"
                                                            ControlToValidate="password" ErrorMessage="Password does not match" Font-Size="XX-Small"></asp:CompareValidator></font></strong></td>
                                        </tr>
                                        <tr>
                                            <td valign="top" style="width: 100px">
                                                First Name:</td>
                                            <td valign="top" style="width: 213px">
                                                <asp:TextBox ID="firstname" runat="server" Font-Size="XX-Small" MaxLength="50" Width="142px"></asp:TextBox>
                                                <strong><font color="#ff0000" size="2">*<asp:RequiredFieldValidator ID="RequiredFieldValidator4"
                                                    runat="server" BackColor="White" ControlToValidate="firstname" Display="Dynamic"
                                                    ErrorMessage="Required" Font-Bold="True" Font-Size="XX-Small"></asp:RequiredFieldValidator>
                                                </font></strong>
                                            </td>
                                            <td valign="top" style="width: 146px">
                                                Surname:</td>
                                            <td valign="top" style="width: 258px">
                                                <asp:TextBox ID="surname" runat="server" Font-Size="XX-Small" MaxLength="50" Width="142px"></asp:TextBox>
                                                <font color="#ff0000" size="2"><strong><span style="color: red">*</span></strong><asp:RequiredFieldValidator
                                                    ID="RequiredFieldValidator5" runat="server" BackColor="White" ControlToValidate="surname"
                                                    Display="Dynamic" ErrorMessage="Required" Font-Bold="True" Font-Size="XX-Small"></asp:RequiredFieldValidator><strong>
                                                    </strong></font>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td valign="top" style="width: 100px; height: 34px">
                                                Gender:</td>
                                            <td style="font-weight: bold; font-size: 10pt; color: #ff0000; width: 213px; height: 34px;" valign="top">
                                                <asp:DropDownList ID="gender" runat="server" Font-Size="XX-Small">
                                                    <asp:ListItem Value="Female">Female</asp:ListItem>
                                                    <asp:ListItem Value="Male">Male</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                            <td valign="top" style="width: 146px; height: 34px">
                                                Organization:</td>
                                            <td valign="top" style="width: 258px; height: 34px">
                                                <asp:TextBox ID="org" runat="server" Font-Size="XX-Small" Width="142px"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td valign="top" style="width: 100px">
                                                Address:
                                            </td>
                                            <td valign="top" style="width: 213px">
                                                <asp:TextBox ID="address" runat="server" Font-Size="XX-Small" Width="142px"></asp:TextBox>
                                                <font color="red" size="2"><span style="color: red"><strong>*</strong></span></font>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" BackColor="White"
                                                    ControlToValidate="address" Display="Dynamic" ErrorMessage="Required" Font-Bold="True"
                                                    Font-Size="XX-Small"></asp:RequiredFieldValidator>
                                            </td>
                                            <td valign="top" style="width: 146px">
                                                City:</td>
                                            <td valign="top" style="width: 258px">
                                                <asp:TextBox ID="city" runat="server" Font-Size="XX-Small" Width="142px"></asp:TextBox><strong><span
                                                    style="text-decoration: underline"> </span></strong>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td valign="top" style="width: 100px">
                                                State:</td>
                                            <td valign="top" style="width: 213px">
                                                <asp:TextBox ID="state" runat="server" Font-Size="XX-Small" Width="142px"></asp:TextBox>
                                            </td>
                                            <td valign="top" style="width: 146px">
                                                Postal Code:</td>
                                            <td valign="top" style="width: 258px">
                                                <asp:TextBox ID="postalcode" runat="server" Font-Size="XX-Small" Width="142px"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td valign="top" style="width: 100px">
                                                Country:</td>
                                            <td valign="top" style="width: 213px">
                                                <asp:TextBox ID="country" runat="server" Font-Size="XX-Small" Width="142px"></asp:TextBox>
                                                <strong><font color="#ff0000" size="2">*</font></strong>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" BackColor="White"
                                                    ControlToValidate="country" Display="Dynamic" ErrorMessage="Required" Font-Bold="True"
                                                    Font-Size="XX-Small"></asp:RequiredFieldValidator>
                                            </td>
                                            <td valign="top" style="width: 146px">
                                                Telephone:</td>
                                            <td valign="top" style="width: 258px">
                                                <asp:TextBox ID="telephone" runat="server" Font-Size="XX-Small" MaxLength="50" Width="142px"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td valign="top" style="width: 100px">
                                                Mobile:</td>
                                            <td valign="top" style="width: 213px">
                                                <asp:TextBox ID="mobile" runat="server" Font-Size="XX-Small" Width="142px"></asp:TextBox>
                                            </td>
                                            <td valign="top" style="width: 146px">
                                                Fax:</td>
                                            <td valign="top" style="width: 258px">
                                                <asp:TextBox ID="fax" runat="server" Font-Size="XX-Small" Width="142px"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td valign="top" style="width: 100px">
                                                BirthDate(dd/mm/yyyy):</td>
                                            <td valign="top" style="width: 213px">
                                                <asp:TextBox ID="birthdate" runat="server" Font-Size="XX-Small" Width="142px"></asp:TextBox>
                                                &nbsp;<strong><font color="#ff0000">*
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" BackColor="White"
                                                        ControlToValidate="birthdate" Display="Dynamic" ErrorMessage="Required" Font-Bold="True"
                                                        Font-Size="XX-Small"></asp:RequiredFieldValidator>
                                                    <asp:CompareValidator ID="datevalidator" runat="server" ControlToValidate="birthdate"
                                                        Display="Dynamic" ErrorMessage="Must be in date format dd/mm/yyyy" Font-Size="XX-Small"
                                                        Operator="DataTypeCheck" Type="Date"></asp:CompareValidator>
                                                </font></strong>
                                            </td>
                                            <td colspan="2" valign="top">
                                                This information is needed for security, in case you forget your password.
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: center;" colspan="2">
                                                &nbsp;<asp:Label ID="Label1" runat="server" Font-Bold="True" ForeColor="Green" Text="Your details have been updated."
                                                    Visible="False"></asp:Label></td>
                                            <td valign="top" style="width: 146px">
                                                <asp:Button ID="SubmitButton" runat="server" Font-Size="XX-Small" 
                                                    Text="Save Changes" OnClick="SubmitButton_Click" />
                                            </td>
                                            <td valign="top" style="width: 258px">
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </form>
                        </p>
                    </font>
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
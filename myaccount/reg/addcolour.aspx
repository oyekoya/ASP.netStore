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
            Dim customerdata As System.Data.SqlClient.SqlDataReader = GetCustomerDetails()
            If customerdata.Read Then
                If "" & customerdata.Item("EmailAddress") = "sales@essedesigns.com" Then
                    ColourTable.Visible = True
                    Else
                        Response.Redirect("default.aspx")
                        Exit Sub
                End If
            End If
        End If
    End Sub
    
    Protected Sub AddColourButton_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        'If Len(title.Text) > 0 Then
            InsertColour.Insert()
            ColourTable.Visible = False
            ColourAdded.Visible = True
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
                <td bgcolor="#e0e0e0" style="text-align: left; height: 20px;" bordercolor="#ffffff">
                        <font color="#666666"><a href="../../myaccount/reg/default.aspx">MyAccount</a></font></td>
                <td bgcolor="#e0e0e0" style="text-align: left; height: 20px;" bordercolor="#ffffff">
                     <a href="../../myaccount/forum/default.aspx">Forum</a></td>
                <td bgcolor="#e0e0e0" style="text-align: center; height: 20px; width: 76px;" bordercolor="#ffffff">
                    </td>
                <td bgcolor="#e0e0e0" style="text-align: center; height: 20px; width: 281px;" bordercolor="#ffffff">
                    <font color="#666666"><b></b></font></td>
                <td bgcolor="#e0e0e0" style="text-align: right; height: 20px;">
                    &nbsp;<a href="../../myaccount/reg/updatecustomer.aspx">Edit Account</a></td>
                <td bgcolor="#e0e0e0" style="text-align: right; height: 20px; border-right-style: solid; border-right-color: #ffffff;">
                        <a href="../../myaccount/logout.aspx"><font size="2"><span style="font-size: 8pt">Logout</span></font></a></td>
            </tr>
            <tr height="21">
                <td bordercolor="#ffffff" bgcolor="#ffffff" colspan="6" height="20">
                    <div align="left"><font color="#003366"><strong>Add&nbsp;Colour</strong></font>&nbsp; 
                    </div>
                </td>
            </tr>
            <tr valign="top">
                <td bordercolor="#ffffff" colspan="6" height="100%" style="border-left-color: #ffffff; border-bottom-color: #ffffff; border-top-style: solid; border-top-color: #ffffff; border-right-style: solid; border-left-style: solid; border-right-color: #ffffff; border-bottom-style: solid;">
                    <form id="Form1" runat="server" enctype="multipart/form-data" method="post">
<%--                        <table id="AuctionTable" style="WIDTH: 522px" cellspacing="0" cellpadding="5" width="522" border="0" runat="server" visible="False">
                            <tbody>
                                <tr>
                                    <td colspan="2">
                                        <strong>Are you interested in auctioning your product? 
                                        <asp:DropDownList id="auctioninterest" runat="server" OnSelectedIndexChanged="auctioninterest_SelectedIndexChanged" AutoPostBack="True">
                                            <asp:ListItem Value="0">--</asp:ListItem>
                                            <asp:ListItem Value="Yes">Yes</asp:ListItem>
                                            <asp:ListItem Value="No">No</asp:ListItem>
                                        </asp:DropDownList>
                                        <font color="red">&nbsp;&nbsp;</font><strong><font color="blue"> 
                                        <asp:Literal id="auctionchoice" runat="server" Text="(Choose an option before continuing)"></asp:Literal>
                                        </font></strong></strong></td>
                                </tr>
                            </tbody>
                        </table>
--%>                        <table id="ColourTable" cellspacing="0" cellpadding="5" width="100%" border="0" runat="server" visible="False">
                            <tbody>
                                <tr>
                                    <td style="width: 122px">
                                        <strong>&nbsp;Colour Code:</strong></td>
                                    <td>
                                        <p>
                                            &nbsp;<asp:TextBox id="code" runat="server" MaxLength="50" Font-Size="XX-Small" Width="98px"></asp:TextBox>
                                            &nbsp;<strong><font color="#ff0000">* 
                                            <asp:RequiredFieldValidator id="RequiredFieldValidator2" runat="server" Display="Dynamic" ControlToValidate="code" BackColor="White" ErrorMessage="Required" Font-Bold="False"></asp:RequiredFieldValidator></font></strong></p>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 122px; height: 34px">
                                        <strong>&nbsp;Colour Description:</strong></td>
                                    <td style="height: 34px">
                                        <p>
                                            &nbsp;<asp:TextBox ID="colour" runat="server" MaxLength="50" Font-Size="XX-Small" Width="218px"></asp:TextBox>
                                            &nbsp;<strong><font color="#ff0000">*
                                                <asp:RequiredFieldValidator ID="keword_required" runat="server" BackColor="White"
                                                    ControlToValidate="colour" Display="Dynamic" ErrorMessage="Required" Font-Bold="False"></asp:RequiredFieldValidator></font></strong></p>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 122px">
                                        &nbsp; 
                                    </td>
                                    <td>
                                        <asp:Button OnClick="AddColourButton_Click" id="addbutton" runat="server" Text="Add Colour" Font-Size="XX-Small"></asp:Button>
                                        <asp:SqlDataSource ID="InsertColour" runat="server" ConnectionString="<%$ ConnectionStrings:esseConnectionString %>"
                                            InsertCommand="INSERT INTO Colour(ColourCode, Colour) VALUES (@Code,@Colour)" ProviderName="<%$ ConnectionStrings:esseConnectionString.ProviderName %>">
                                            <InsertParameters>
                                                <asp:ControlParameter ControlID="code" Name="Code" PropertyName="Text" />
                                                <asp:ControlParameter ControlID="colour" Name="Colour" PropertyName="Text" />
                                            </InsertParameters>
                                        </asp:SqlDataSource>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </form>
                    <asp:Literal id="ColourAdded" runat="server" Visible="False" Text="Colour Added."></asp:Literal>&nbsp;<br />
                    <br />
                    &nbsp;Back to <a href="myproduct.aspx">My Products</a></td>
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
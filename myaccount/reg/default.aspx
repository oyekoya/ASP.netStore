<%@ Page Language="VB" %>
<%@ import Namespace="System.Data.SqlClient" %>
<%@ import Namespace="System.Data" %>
<script runat=server>

Sub Page_Load(sender As Object, e As EventArgs)

    'Dim cust_num as Integer = Request.ServerVariables("AUTH_USER")
    'Dim membership as String
    'Dim paymentdata As System.Data.SqlClient.SqlDataReader = GetPaymentDetails(cust_num)

    'While paymentdata.Read
    '    membership = paymentdata.Item("PaymentStatus")
    '    If ((membership="Standard") or (membership="Premium")) Then
    '        Session("membership") = membership
    '        Session("enddate") = paymentdata.Item("EndDate")
    '        Label1.Text = membership
    '        LinkButton1.Enabled = False
    '        LinkButton2.PostBackUrl = "~/reg/payment.aspx?upgrade_option=3"
    '        If (membership="Premium") Then
    '            LinkButton2.Enabled = False
    '        End If
    '    End If
    'End While

End Sub

' ----------------------------------------
'Function GetPaymentDetails(ByVal customerID As Integer) As System.Data.SqlClient.SqlDataReader
'    Dim connectionString As String = Application("appConn")
'    Dim sqlConnection As System.Data.SqlClient.SqlConnection = New System.Data.SqlClient.SqlConnection(connectionString)
'
'    Dim queryString As String = "SELECT [Payment].* FROM [Payment] WHERE ([Payment].[CustomerID] = @CustomerID) AND ([Payment].[EndDate]"& _
'        " > @enddate)"
'    Dim sqlCommand As System.Data.SqlClient.SqlCommand = New System.Data.SqlClient.SqlCommand(queryString, sqlConnection)

'    sqlCommand.Parameters.Add("@CustomerID", System.Data.SqlDbType.Int).Value = customerID
'    sqlCommand.Parameters.Add("@enddate", System.Data.SqlDbType.SmallDateTime).Value = Today
'    'sqlCommand.Parameters.Add("@PaymentStatus", System.Data.SqlDbType.NVarChar).Value = "Standard"

'    sqlConnection.Open
'    Dim dataReader As System.Data.SqlClient.SqlDataReader = sqlCommand.ExecuteReader(System.Data.CommandBehavior.CloseConnection)

'    Return dataReader
'End Function

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
                <td bgcolor="#e0e0e0" style="text-align: left; height: 20px;" bordercolor="#ffffff">
                        <font color="#666666"><b><a href="../../myaccount/reg/default.aspx">MyAccount</a></b></font></td>
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
            <tr valign="top">
                <td colspan="6" height="100%" style="border-left-color: #ffffff; border-bottom-color: #ffffff; border-top-style: solid; border-top-color: #ffffff; border-right-style: solid; border-left-style: solid; border-right-color: #ffffff; border-bottom-style: solid">
                <form id="Form1" runat=server>
                    <font size="4"> 
                    <p align="center" style="text-align: center">
                        <span style="font-size: 8pt"></span>&nbsp;</p>
                        <p align="center" style="text-align: center">
                            <span style="font-size: 8pt; text-decoration: underline;"></span>&nbsp;</p>
                        <p align="center" style="text-align: center">
                            <span style="font-size: 24pt">Thanks </span>
                        </p>
                        <p align="center" style="text-align: center">
                            <span style="font-size: 24pt">for joining </span>
                        </p>
                        <p align="center" style="text-align: center">
                            <span style="font-size: 24pt">essedesigns.com</span></p>
                        <p align="center" style="text-align: center">
                            <span style="font-size: 8pt; text-decoration: underline;"></span>&nbsp;</p>
                    </font>
                    </form></td>
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
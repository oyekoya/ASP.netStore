<%@ Page Language="VB" %>
<script runat="server">
  
    Sub Page_Load(Sender As Object, E As EventArgs)
    
        FormsAuthentication.SignOut()
        If (Request.IsAuthenticated = true) Then
            Status.Text = "User " & User.Identity.Name & " has been logged out."
        Else 
            Status.Text = "You are currently logged out."
        End If
        'Session.Abandon
    End Sub

</script>
<html>
<head>
    <title>Logout</title> 
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
          <tr><td colspan="3"  height="100%">
            <div align="center">
            <form id="Form1" runat="server">
                <p align="center">
                </p>
                <p align="center">
                </p>
                <p align="center">
                    &nbsp;</p>
                <p align="center">
                    &nbsp;<asp:Label id="status" runat="server" ForeColor="red"></asp:Label>
                </p>
                <p>
                    &nbsp;</p>
                <p>
                    <a href="../product.aspx"><span style="color: #0000ff">View Products</span></a><br />
                    <span style="color: #000099"><a href="../forum.aspx">
                        Forum</a></span><br />
                    <span style="color: #000099"><a href="../myaccount/reg/default.aspx">
                        Login to Account</a></span><br />
                </p>
                <p>
                    &nbsp;</p>
                <p>
                    <span style="color: #000099"><span style="color: #000099"></span></span>&nbsp;</p>
             </form></div>
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
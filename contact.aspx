<%@ Page Language="VB" %>
<%--<%@ import Namespace="System.Web.Mail" %>--%>
<%@ import Namespace="System.Net" %>
<%@ import Namespace="System.Net.Mail" %>

<script runat="server">

    Sub Page_Load (sender As Object, e As EventArgs)
        If Page.IsPostBack Then
            Page.Validate
            If Page.IsValid() Then
                ' Build an auto-reply MailMessage to the user
                Dim from As String = "enquiries@essedesigns.com"
                Dim [to] As String = email.Text
                Dim subj As String = "Re: " & subject.Text
                Dim body As String = "Hello " & firstname.Text & " " & surname.Text & vbCrLf & vbCrLf & enquiry.SelectedItem.Text & " Enquiry from " & vbCrLf & vbCrLf & comment.Text & _
                                    vbCrLf & vbCrLf & "This is an acknowledgement of your email." & vbCrLf & vbCrLf & _
                                    "essedesigns.com Team"
                Dim smtpServer As String = Application("mailserver")
                Dim message As New MailMessage(from, [to], subj, body)
                Dim smtpClient As New SmtpClient(smtpServer)
                smtpClient.UseDefaultCredentials = False
                Dim credentials As New NetworkCredential(Application("Username"), Application("Password"))
                smtpClient.Credentials = credentials
                smtpClient.Send(message)
                
                ' Build a MailMessage and send to me006q7041@blueyonder.co.uk
                from = email.Text
                [to] = "enquiries@essedesigns.com"
                subj = subject.Text
                body = enquiry.SelectedItem.Text & " Enquiry from: " & firstname.Text & " " & surname.Text & vbCrLf & vbCrLf & comment.Text
                Dim message2 As New MailMessage(from, [to], subj, body)
                smtpClient.Send(message2)
        
                'Dim comment2 As String = Left(comment.Text, 500)
                'InsertEnquiry(firstname.Text, surname.Text, enquiry.SelectedItem.Text, email.Text, subject.Text, comment2)
                contacttable.Visible = False
                Label1.Text = "Thank you for contacting us. We'll be in touch."
                Label1.Visible = True
            End If
        End If
    End Sub
    
</script>
<html>
<head>
    <title>Contact Essé Designs</title> 
    <meta content="Essé Designs" name="TITLE" />
    <meta content="Esse Designs" name="DESCRIPTION" />
    <meta content="esse designs, collections, bridal, prom, outerwear, bolero, shrugs, jacket, shawl, bridesmaid" name="KEYWORDS" />
    <meta content="me006q7041@blueyonder.co.uk" name="OWNER" />
    <meta content="Essé Designs" name="AUTHOR" />
    <meta http-equiv="EXPIRES" content="" />
    <meta http-equiv="CHARSET" content="ISO-8859-1" />
    <meta http-equiv="CONTENT-LANGUAGE" content="English" />
    <meta http-equiv="VW96.OBJECT TYPE" content="Homepage" />
    <meta content="General" name="RATING" />
    <meta content="index,follow" name="ROBOTS" />
    <meta content="7 days" name="REVISIT-AFTER" />
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
					<a href="default.aspx"><b>Home</b></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="product.aspx"><b>Products</b></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="contact.aspx"><b>Contact</b></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="faq.html"><b>Help/FAQs</b></a>
				</td>
			</tr>
          <tr>
            <td colspan="3" bgcolor="#ffffff" align=center valign="top">
             <table height="400" width="100%"><tbody><tr><td valign="top">
                <p><b>Address:</b> 
                </p>
                 <p>
                     Essé Designs<br />
                     130 Lenthall Avenue<br />
                     Grays<br />
                     Essex<br />
                     RM17 5AB</p>
                 <p>
                     <strong>Contact Form:</strong></p>
                <blockquote> 
                <form id="Form1" name="EnquiryForm" runat="server">
                    <table style="WIDTH: 638px;" cellspacing="0" cellpadding="5" border="0" id="contacttable" runat=server>
                        <tbody>
                            <tr>
                                <td colspan="2" valign="top" style="height: 14px">
                    Please fill in the enquiry form below. 
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" style="width: 168px; height: 15px;">
                                    Enquiry is in reference to: 
                                </td>
                                <td valign="top" style="height: 15px">
                                    <asp:DropDownList id="enquiry" runat="server" Font-Size="XX-Small">
                                        <asp:ListItem Value="general" Selected="True">General</asp:ListItem>
                                        <asp:ListItem Value="Account">Account</asp:ListItem>
                                        <asp:ListItem Value="billing">Billing</asp:ListItem>
                                        <asp:ListItem Value="delivery">Delivery</asp:ListItem>
                                        <asp:ListItem Value="retailer">Retailers</asp:ListItem>
                                        <asp:ListItem Value="supplier">Supplier</asp:ListItem>
                                        <asp:ListItem Value="outerwear">Outerwear</asp:ListItem>
                                        <asp:ListItem Value="fabric">Fabric</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" style="width: 168px; height: 11px;">
                                    First Name:</td>
                                <td valign="top" style="height: 11px">
                                    <asp:TextBox id="firstname" runat="server" MaxLength="50" Font-Size="XX-Small"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" style="width: 168px; height: 15px;">
                                    Surname:</td>
                                <td valign="top" style="height: 15px">
                                    <asp:TextBox id="surname" runat="server" MaxLength="50" Font-Size="XX-Small"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" style="width: 168px; height: 20px;">
                                    Email Address:</td>
                                <td valign="top" style="height: 20px">
                                    <asp:TextBox id="email" runat="server" MaxLength="50" Font-Size="XX-Small"></asp:TextBox>
                                    <asp:RequiredFieldValidator id="RequiredFieldValidator1" runat="server" ErrorMessage="Required" Font-Size="XX-Small" BackColor="White" Font-Bold="True" ControlToValidate="email"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator id="RegularExpressionValidator1" runat="server" ErrorMessage="Please enter a valid email address" Font-Size="XX-Small" BackColor="White" Font-Bold="True" ControlToValidate="email" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" style="width: 168px; height: 18px;">
                                    Subject: 
                                </td>
                                <td valign="top" style="height: 18px">
                                    <asp:TextBox id="subject" runat="server" MaxLength="50" Font-Size="XX-Small"></asp:TextBox>
                                    <asp:RequiredFieldValidator id="RequiredFieldValidator2" runat="server" ErrorMessage="Required" Font-Size="XX-Small" BackColor="White" Font-Bold="True" ControlToValidate="subject"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" style="width: 168px; height: 191px;">
                                    Comment: 
                                </td>
                                <td valign="top" style="height: 191px">
                                    <asp:TextBox id="comment" runat="server" MaxLength="500" TextMode="MultiLine" Width="380px" Height="200px" Font-Size="XX-Small"></asp:TextBox>
                                    <asp:RequiredFieldValidator id="RequiredFieldValidator3" runat="server" ErrorMessage="Required" Font-Size="X-Small" BackColor="White" Font-Bold="True" ControlToValidate="comment"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 168px; height: 27px;">
                                    &nbsp;</td>
                                <td style="height: 27px">
                                    <div align="center">
                                        <input type="submit" value="Submit" name="Submit" />
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <asp:Label ID="Label1" runat="server" Visible="False" Font-Bold="True" ForeColor="Green" Text="Label"></asp:Label></form>
                <p>
                    &nbsp;</p>
                </blockquote>
                </td></tr></tbody></table>
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
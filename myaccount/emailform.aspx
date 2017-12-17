<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Page Language="VB" %>
<%@ import Namespace="System.IO" %>
<%@ import Namespace="System.Net" %>
<%@ import Namespace="System.Net.Mail" %>

<script runat="server">
    Dim message As String
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Try
            message = Request.Params("answers")
            'message = Encoding.ASCII.GetString(Request.BinaryRead(Request.ContentLength))
            'Dim strToSend As String = Request.Form.ToString()
            ''Create the string to post back to PayPal system to validate
            'strToSend &= "&did_mail_send=yes"

            ''Initialize the WebRequest.
            ''Dim myRequest As HttpWebRequest = CType(HttpWebRequest.Create("https://www.sandbox.paypal.com/cgi-bin/webscr"), HttpWebRequest)
            'Dim myRequest As HttpWebRequest = CType(HttpWebRequest.Create("https://www.paypal.com/cgi-bin/webscr"), HttpWebRequest)
            'myRequest.AllowAutoRedirect = False
            'myRequest.Method = "POST"
            'myRequest.ContentType = "application/x-www-form-urlencoded"

            ''Create post stream
            'Dim RequestStream As Stream = myRequest.GetRequestStream()
            'Dim SomeBytes() As Byte = Encoding.UTF8.GetBytes(strToSend)

            'RequestStream.Write(SomeBytes, 0, SomeBytes.Length)
            'RequestStream.Close()

            ''Send request and get response
            'Dim myResponse As HttpWebResponse = CType(myRequest.GetResponse(), HttpWebResponse)

            'If myResponse.StatusCode = HttpStatusCode.OK Then
            MailUsTheOrder(message)
            status.Text = "Email Sent" & vbCrLf & message
            'End If
        Catch ee As Exception
            'do error handling
            MailUsTheOrder("Some error.")
            status.Text = "Some error"
        End Try
    End Sub

    Public Sub MailUsTheOrder(ByVal TagMsg As String)
        Const a As String = vbCrLf
        Dim from As String = "enquiries@essedesigns.com"
        Dim [to] As String = "w.oyekoya@cs.ucl.ac.uk"
        Dim subj As String = "Gaze Model Experiment"
        Dim body As String = TagMsg
        Dim smtpServer As String = Application("mailserver")
        Dim message As New MailMessage(from, [to], subj, body)
        Dim smtpClient As New SmtpClient(smtpServer)
        smtpClient.UseDefaultCredentials = False
        Dim credentials As New NetworkCredential(Application("Username"), Application("Password"))
        smtpClient.Credentials = credentials
        smtpClient.Send(message)
    End Sub


</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Email</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:Label ID="status" runat="server" Height="30px" Width="477px"></asp:Label></div>
    </form>
</body>
</html>

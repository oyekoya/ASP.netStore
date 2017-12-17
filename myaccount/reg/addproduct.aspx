<%@ Page Language="VB" %>
<%@ import Namespace="System.Drawing" %>
<%@ import Namespace="System.Drawing.Imaging" %>
<%@ import Namespace="System.IO" %>
<%@ import Namespace="System.Data.SqlClient" %>
<%@ import Namespace="System.Data" %>
<%@ import Namespace="System.Net" %>
<%--<%@ import Namespace="System.Web.Mail" %>--%>
<%@ import Namespace="System.Net.Mail" %>
<script runat="server">
    ' ----------------------------------------
    Dim errormessage As String
    Dim strFileName As String

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
                    ProductTable.Visible = True
                    Else
                        Response.Redirect("default.aspx")
                        Exit Sub
                End If
            End If
        End If
    End Sub

    ' ----------------------------------------
    Function InsertProduct( _
              ByVal title As String, _
              ByVal keyword As String, _
              ByVal description As String, _
              ByVal image1 As String, _
              ByVal image2 As String, _
              ByVal image3 As String, _
              ByVal image4 As String, _
              ByVal price As Double, _
              ByVal Postage As Double, _
              ByVal AdditionalPostage As Double, _
              ByVal PostageContinent As Double, _
              ByVal AdditionalPostageContinent As Double, _
              ByVal PostageWorld As Double, _
              ByVal AdditionalPostageWorld As Double, _
              ByVal type As String) As Integer
        Dim conClasf As SqlConnection
        Dim dapAds As SqlDataAdapter
        Dim dstAds As DataSet
        Dim dtbAds As DataTable
        Dim rowAds As DataRow
        Dim bldAds As SqlCommandBuilder
        Dim strSQL As String

        conClasf = New SqlConnection(Application("appConn"))
        conClasf.Open()

        strSQL = "SELECT * FROM Products WHERE 1=0"
        dapAds = New SqlDataAdapter(strSQL, conClasf)
        dstAds = New DataSet()
        dapAds.Fill(dstAds, "Products")

        bldAds = New SqlCommandBuilder(dapAds)
        dapAds.InsertCommand = bldAds.GetInsertCommand()

        AddHandler dapAds.RowUpdated, _
                New SqlRowUpdatedEventHandler(AddressOf OnRowUpd2)

        rowAds = dstAds.Tables("Products").NewRow()
        rowAds("Title") = title
        rowAds("Description") = description
        rowAds("Keywords") = keyword
        rowAds("Image1") = image1
        rowAds("Image2") = image2
        rowAds("Image3") = image3
        rowAds("Image4") = image4
        rowAds("Type") = type
        rowAds("Price") = CDec(price)
        rowAds("Postage") = CDec(Postage)
        rowAds("AdditionalPostage") = CDec(AdditionalPostage)
        rowAds("PostageContinent") = CDec(PostageContinent)
        rowAds("AdditionalPostageContinent") = CDec(AdditionalPostageContinent)
        rowAds("PostageWorld") = CDec(PostageWorld)
        rowAds("AdditionalPostageWorld") = CDec(AdditionalPostageWorld)
        rowAds("MakeAvailable") = 1
        rowAds("CustomerID") = Request.ServerVariables("AUTH_USER")
        dstAds.Tables("Products").Rows.Add(rowAds)

        dapAds.Update(dstAds, "Products")
        status.Text = "Product " & rowAds("ProductID") & " posted."
        conClasf.Close()
    End Function

    ' ----------------------------------------
    Sub OnRowUpd2(ByVal sender As Object, _
    ByVal e As SqlRowUpdatedEventArgs)
        Dim intNewId As Integer = 0
        Dim cmdId As SqlCommand
        If e.StatementType = StatementType.Insert Then
            If e.TableMapping.DataSetTable = "Products" Then
                cmdId = New SqlCommand("select @@identity", _
           e.Command.Connection)
                intNewId = cmdId.ExecuteScalar()
                e.Row("ProductID") = intNewId
            End If
        End If
    End Sub

    ' ----------------------------------------
    Function VerifyImage(ByVal fupUpload As System.Web.UI.HtmlControls.HtmlInputFile) As Boolean
        Dim imgUpload As System.Drawing.Image
        Dim verification As Boolean = False
        If (fupUpload.PostedFile.FileName.Trim().Length < 1) Or (fupUpload.PostedFile Is Nothing) Then
            Return verification
            Exit Function
        End If
        If (fupUpload.PostedFile.ContentLength < 1) Then
            errormessage = " - Uploaded file is empty."
            Return verification
            Exit Function
        End If

        Try
            imgUpload = System.Drawing.Image.FromStream( _
          fupUpload.PostedFile.InputStream)
        Catch ex As Exception
            errormessage = " - Uploaded file isn't a " & _
             "valid picture."
            Return verification
            Exit Function
        End Try
        If imgUpload.RawFormat.Equals(ImageFormat.GIF) Then
            ' "GIF"
        ElseIf imgUpload.RawFormat.Equals(ImageFormat.JPEG) Then
            ' "JPEG"
        Else
            errormessage = " - Uploaded file isn't a valid picture format."
            Return verification
            Exit Function
        End If
        Dim fi As New FileInfo(Server.Mappath("../../images/cust" & Request.ServerVariables("AUTH_USER") & _
          "/" & Path.GetFileName(fupUpload.PostedFile.FileName)))
        'If fi.Exists = True Then
        '    errormessage = " - You have a file with the same name on our server. Please rename and retry."
        '    Return verification
        '    Exit Function
        'End If
        verification = True
        Return verification
    End Function

    ' ----------------------------------------
    Function VerifyFile(ByVal fupUpload As System.Web.UI.HtmlControls.HtmlInputFile, ByVal ddl As DropDownList) As Boolean
        Dim verification As Boolean = False
        If (fupUpload.PostedFile.FileName.Trim().Length < 1) Or (fupUpload.PostedFile Is Nothing) Then
            Return verification
            Exit Function
        End If
        If (fupUpload.PostedFile.ContentLength < 1) Then
            errormessage = " - Uploaded file is empty."
            Return verification
            Exit Function
        End If
        If (Path.GetExtension(fupUpload.PostedFile.FileName) <> ddl.SelectedItem.Value) Then
            errormessage = Path.GetExtension(fupUpload.PostedFile.FileName) & " - File extension does not match the selected file type"
            Return verification
            Exit Function
        End If
        Dim fi As New FileInfo(Server.Mappath("../../images/cust" & Request.ServerVariables("AUTH_USER") & _
          "/" & Path.GetFileName(fupUpload.PostedFile.FileName)))
        If fi.Exists = True Then
            errormessage = " - You have a file with the same name on our server. Please rename and retry."
            Return verification
            Exit Function
        End If
        verification = True
        Return verification
    End Function

    ' ----------------------------------------
    'Insert Product button function
    Sub addbutton_Click(ByVal sender As Object, ByVal e As EventArgs)
        If Page.IsPostBack Then
            Page.Validate()
            If Page.IsValid() Then
                Dim x As Integer = 0
                If Len(desc.Text) > 1000
                    desclimit.text = "- number of characters should not be more than 1000"
                    Exit Sub
                Else
                    desclimit.Visible = False
                End If

                'Verify image
                If VerifyImage(imageupload1) = True Then
                    'x = x + imageupload1.PostedFile.ContentLength
                ElseIf (imageupload1.PostedFile.FileName.Trim().Length < 1) Or (imageupload1.PostedFile Is Nothing) Then
                    'Do nothing
                Else
                    imageupload1error.Text = errormessage
                    imageupload1error.Visible = True
                    Exit Sub
                End If
                If VerifyImage(imageupload2) = True Then
                    'x = x + imageupload2.PostedFile.ContentLength
                ElseIf (imageupload2.PostedFile.FileName.Trim().Length < 1) Or (imageupload2.PostedFile Is Nothing) Then
                    'Do nothing
                Else
                    imageupload2error.Text = errormessage
                    imageupload2error.Visible = True
                    Exit Sub
                End If
                If VerifyImage(imageupload3) = True Then
                    'x = x + imageupload3.PostedFile.ContentLength
                ElseIf (imageupload3.PostedFile.FileName.Trim().Length < 1) Or (imageupload3.PostedFile Is Nothing) Then
                    'Do nothing
                Else
                    imageupload3error.Text = errormessage
                    imageupload3error.Visible = True
                    Exit Sub
                End If
                If VerifyImage(imageupload4) = True Then
                    'x = x + imageupload4.PostedFile.ContentLength
                ElseIf (imageupload4.PostedFile.FileName.Trim().Length < 1) Or (imageupload4.PostedFile Is Nothing) Then
                    'Do nothing
                Else
                    imageupload4error.Text = errormessage
                    imageupload4error.Visible = True
                    Exit Sub
                End If

                'If (x > max_size) Then
                '    imageupload1error.Text = "Total size of images must not exceed " & max_size & " bytes"
                '    imageupload1error.Visible = True
                '    Exit Sub
                'End If
                'Insert into database and save
                InsertProduct(title.Text, keyword.Text, desc.Text, insert(imageupload1), insert(imageupload2), _
                      insert(imageupload3), insert(imageupload4), price.Text, Postage.Text, AdditionalPostage.Text, _
					  PostageContinent.Text, AdditionalPostageContinent.Text, PostageWorld.Text, AdditionalPostageWorld.Text, outerwear_type.SelectedItem.Value)
                If (imageupload1.PostedFile.FileName.Trim().Length > 0) Then
                    SaveFile(imageupload1, False, 270, title.Text & "1.jpg")
                End If
                If (imageupload2.PostedFile.FileName.Trim().Length > 0) Then
                    SaveFile(imageupload2, False, 270, title.Text & "2.jpg")
                End If
                If (imageupload3.PostedFile.FileName.Trim().Length > 0) Then
                    SaveFile(imageupload3, False, 270, title.Text & "3.jpg")
                End If
                If (imageupload4.PostedFile.FileName.Trim().Length > 0) Then
                    SaveFile(imageupload4, False, 270, title.Text & "4.jpg")
                End If

                ' Build an auto-reply MailMessage to the user and enquiries@essedesigns.com
                Dim from As String = "enquiries@essedesigns.com"
                Dim [to] As String = "sales@essedesigns.com"
                Dim subj As String = "Your Product Submission: " & title.Text
                Dim body As String = "This is an acknowledgement of your product submission " & vbCrLf & vbCrLf & _
                                   "Title: " & title.Text & vbCrLf & _
                                   "Keywords: " & keyword.Text & vbCrLf & _
                                   "Price: " & price.Text & vbCrLf & _
                                   "Description: " & desc.Text & vbCrLf & _
                                   "Type: " & outerwear_type.SelectedItem.Text & vbCrLf & _
                                   "Thank you for your submission" & vbCrLf & _
                                   "Essé Designs"
                Dim smtpServer As String = Application("mailserver")
                Dim message As New MailMessage(from, [to], subj, body)
                Dim smtpClient As New SmtpClient(smtpServer)
                smtpClient.UseDefaultCredentials = False
                Dim credentials As New NetworkCredential(Application("Username"), Application("Password"))
                smtpClient.Credentials = credentials
                smtpClient.Send(message)

                ProductTable.Visible = False
                status.Text = status.Text & vbCrLf & vbCrLf & "Your product information has been uploaded. "
                status.Visible = True
            End If
        End If
    End Sub


    ' ----------------------------------------
    Function SaveFile(ByVal fupUpload As System.Web.UI.HtmlControls.HtmlInputFile, _
                    ByVal Is_File As Boolean, ByVal re_size As Integer, ByVal file_str As String)
        Dim di As New DirectoryInfo(Server.Mappath("../../images/cust" & _
                 Request.ServerVariables("AUTH_USER") & "/"))
        If di.Exists = False Then
            ' create the directory, only if it doesn't exist
            di.Create()

        End If
        Dim thefilename As String = Path.GetFileName(fupUpload.PostedFile.FileName)
        Dim file_path = Server.Mappath("../../images/cust" & _
                 Request.ServerVariables("AUTH_USER") & "/") & file_str
        fupUpload.PostedFile.SaveAs(file_path)
        If Is_File = False Then
            Resize_Picture(re_size, file_path)
        End If
    End Function


    ' ----------------------------------------
    Function insert(ByVal fupUpload As System.Web.UI.HtmlControls.HtmlInputFile) As String
		Static index As Integer = 1
        If (fupUpload.PostedFile.FileName.Trim().Length > 0) Then
            insert = title.Text & CStr(index) & ".jpg" 'Path.GetFileName(fupUpload.PostedFile.FileName)
			index = index + 1
        End If
    End Function

    Sub Resize_Picture(ByVal w As Integer, ByVal image_file As String)
        Dim imgTmp As System.Drawing.Image
        Dim sf As Double
        Dim imgFoto As System.Drawing.Bitmap

        imgTmp = System.Drawing.Image.FromFile(image_file)
        'If (imgTmp.Width > w) Then
            sf = imgTmp.Width / w
            imgFoto = New System.Drawing.Bitmap(w, CInt(imgTmp.Height / sf))
            Dim recDest As New Rectangle(0, 0, w, imgFoto.Height)
            Dim gphCrop As Graphics = Graphics.FromImage(imgFoto)
            gphCrop.SmoothingMode = Drawing2D.SmoothingMode.HighQuality
            gphCrop.CompositingQuality = Drawing2D.CompositingQuality.HighQuality
            gphCrop.InterpolationMode = Drawing2D.InterpolationMode.HighQualityBicubic

            gphCrop.DrawImage(imgTmp, recDest, 0, 0, imgTmp.Width, imgTmp.Height, GraphicsUnit.Pixel)
            'Create a font
			Dim PFC As System.Drawing.Text.PrivateFontCollection
			Dim English_FF As FontFamily
		    PFC = New System.Drawing.Text.PrivateFontCollection()
		    PFC.AddFontFile("E:\web\essedesi\store\English.ttf")
		    English_FF = PFC.Families(0)

            Dim F As New Font(English_FF, 20)
			'Create a brush
			'Dim customColor As Color = Color.FromArgb(50, Color.Gray)
			Dim B As New SolidBrush(Color.FromArgb(172,161,154))
			'Draw some text
			gphCrop.DrawString("Essé", F, B, 100, 180)
        'Else
        '    imgFoto = imgTmp
        'End If
        Dim myEncoder As System.Drawing.Imaging.Encoder
        Dim myEncoderParameter As System.Drawing.Imaging.EncoderParameter
        Dim myEncoderParameters As System.Drawing.Imaging.EncoderParameters

        Dim arrayICI() As System.Drawing.Imaging.ImageCodecInfo = System.Drawing.Imaging.ImageCodecInfo.GetImageEncoders()
        Dim jpegICI As System.Drawing.Imaging.ImageCodecInfo = Nothing
        Dim x As Integer = 0
        For x = 0 To arrayICI.Length - 1
            If (arrayICI(x).FormatDescription.Equals("JPEG")) Then
                jpegICI = arrayICI(x)
                Exit For
            End If
        Next
        myEncoder = System.Drawing.Imaging.Encoder.Quality
        myEncoderParameters = New System.Drawing.Imaging.EncoderParameters(1)
        myEncoderParameter = New System.Drawing.Imaging.EncoderParameter(myEncoder, 100L)
        myEncoderParameters.Param(0) = myEncoderParameter
        imgTmp.Dispose()
        imgFoto.Save(image_file, jpegICI, myEncoderParameters)
        imgFoto.Dispose()
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
                <td bgcolor="#e0e0e0" style="text-align: left; height: 20px;" bordercolor="#e0e0e0">
                        <font color="#666666"><a href="../../myaccount/reg/default.aspx">MyAccount</a></font></td>
                <td bgcolor="#e0e0e0" style="text-align: left; height: 20px;" bordercolor="#e0e0e0">
                    <a href="../../myaccount/forum/default.aspx">Forum</a></td>
                <td bgcolor="#e0e0e0" style="text-align: center; height: 20px; width: 76px;" bordercolor="#e0e0e0">
                    </td>
                <td bgcolor="#e0e0e0" style="text-align: center; height: 20px; width: 281px;" bordercolor="#e0e0e0">
                    <font color="#666666"></font></td>
                <td bordercolor="#e0e0e0" bgcolor="#e0e0e0" style="text-align: right; height: 20px;">
                    &nbsp;<a href="../../myaccount/reg/updatecustomer.aspx">Edit Account</a></td>
                <td bordercolor="#e0e0e0" bgcolor="#e0e0e0" style="text-align: right; height: 20px;">
                        <a href="../../myaccount/logout.aspx"><font size="2"><span style="font-size: 8pt">Logout</span></font></a></td>
            </tr>
            <tr height="21">
                <td bordercolor="#e0e0e0" bgcolor="#e0e0e0" colspan="6" height="20">
                    <div align="left"><font color="#003366"><strong>Add&nbsp;Product</strong></font>&nbsp; 
                    </div>
                </td>
            </tr>
            <tr valign="top">
                <td bordercolor="#e0e0e0" colspan="6" height="100%" style="border-left-color: #e0e0e0; border-bottom-color: #e0e0e0; border-top-style: solid; border-top-color: #e0e0e0; border-right-style: solid; border-left-style: solid; border-right-color: #e0e0e0; border-bottom-style: solid;">
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
--%>                        <table id="ProductTable" cellspacing="0" cellpadding="5" width="100%" border="0" runat="server" visible="False">
                            <tbody>
                                <tr>
                                    <td style="width: 32px">
                                        <strong>&nbsp;Title:</strong></td>
                                    <td>
                                        <p>
                                            &nbsp;<asp:TextBox id="title" runat="server" MaxLength="50" Font-Size="XX-Small"></asp:TextBox>
                                            &nbsp;<strong><font color="#ff0000">* 
                                            <asp:RequiredFieldValidator id="RequiredFieldValidator2" runat="server" Display="Dynamic" ControlToValidate="title" BackColor="White" ErrorMessage="Required" Font-Bold="False"></asp:RequiredFieldValidator></font></strong></p>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 32px; height: 34px">
                                        <strong>&nbsp;Keywords:</strong></td>
                                    <td style="height: 34px">
                                        <p>
                                            &nbsp;<asp:TextBox ID="keyword" runat="server" MaxLength="50" Font-Size="XX-Small"></asp:TextBox>
                                            &nbsp;<strong><font color="#ff0000">*
                                                <asp:RequiredFieldValidator ID="keword_required" runat="server" BackColor="White"
                                                    ControlToValidate="keyword" Display="Dynamic" ErrorMessage="Required" Font-Bold="False"></asp:RequiredFieldValidator></font></strong></p>
                                    </td>
                                </tr>
                                 <tr>
                                    <td valign="top" style="width: 32px">
                                        <p>
                                            <strong>&nbsp;Description:</strong></p>
                                    </td>
                                    <td>
                                         
                                        <p>
                                            &nbsp;Max 1000 chars&nbsp;
                                            <asp:Label ID="desclimit" runat="server" ForeColor="Red"></asp:Label><br />
                                            <asp:TextBox id="desc" runat="server" Width="436px" Height="128px" TextMode="MultiLine" MaxLength="1000" Font-Size="X-Small" Font-Names="Arial"></asp:TextBox>
                                            <strong><span style="color: #ff0000">*</span></strong>
                                            <strong><font color="#ff0000"><asp:RequiredFieldValidator id="RequiredFieldValidator1" runat="server" Display="Dynamic" ControlToValidate="desc" BackColor="White" ErrorMessage="Required" Font-Bold="False"></asp:RequiredFieldValidator></font></strong></p>
                                        </td>
                                </tr>
                                <tr>
                                    <td style="width: 32px">
                                        <strong>Guide Price:</strong></td>
                                    <td>
                                        &nbsp;From £<asp:TextBox ID="price" runat="server" Font-Size="XX-Small" MaxLength="50" Width="88px"></asp:TextBox>
                                        &nbsp;<strong><font color="#ff0000">*
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" BackColor="White"
                                                ControlToValidate="price" Display="Dynamic" ErrorMessage="Required" Font-Bold="False"></asp:RequiredFieldValidator></font></strong></td>
                                </tr>
                                <tr>
                                    <td style="height: 32px; width: 32px;">
                                        <strong>&nbsp;Product Type:</strong></td>
                                    <td style="height: 32px">
                                        <p>
                                            &nbsp;<asp:DropDownList id="outerwear_type" runat="server" Font-Size="XX-Small">
		                                        <asp:ListItem Value="outerwear" Selected="True">Outerwear</asp:ListItem>
		                                        <asp:ListItem Value="fabric">Fabric</asp:ListItem>
                                            </asp:DropDownList>
                                        </p>
                                    </td>
                                </tr>
								<tr>
									<td>
										<strong>Postage: </strong>
									</td>
									<td>
										<asp:TextBox ID="Postage" runat="server" Font-Size="XX-Small" MaxLength="50"></asp:TextBox>
									</td>
								</tr>
								<tr>
									<td>
										<strong>Additional Postage: </strong>
									</td>
									<td colspan="2">
										<asp:TextBox ID="AdditionalPostage" runat="server" Font-Size="XX-Small" MaxLength="50"></asp:TextBox>
									</td>
								</tr>
								<tr>
									<td>
										<strong>Postage (Continent): </strong>
									</td>
									<td>
										<asp:TextBox ID="PostageContinent" runat="server" Font-Size="XX-Small" MaxLength="50"></asp:TextBox>
									</td>
								</tr>
								<tr>
									<td>
										<strong>Additional Postage (Continent): </strong>
									</td>
									<td>
										<asp:TextBox ID="AdditionalPostageContinent" runat="server" Font-Size="XX-Small" MaxLength="50"></asp:TextBox>
									</td>
								</tr>
								<tr>
									<td width="98">
										<strong>Postage (World): </strong>
									</td>
									<td>
										<asp:TextBox ID="PostageWorld" runat="server" Font-Size="XX-Small" MaxLength="50"></asp:TextBox>
									</td>
								</tr>
								<tr>
									<td>
										<strong>Additional Postage (World): </strong>
									</td>
									<td>
										<asp:TextBox ID="AdditionalPostageWorld" runat="server" Font-Size="XX-Small" MaxLength="50"></asp:TextBox>
									</td>
								</tr>
                                <tr>
                                    <td colspan="2" style="height: 118px">
                                        <table id="tableproduct" cellspacing="0" cellpadding="5" width="100%" border="0" runat="server" visible="true">
                                            <tbody>
                                                <tr>
                                                    <td valign="top" style="width: 63px">
                                                        <strong>Image 1:</strong></td>
                                                    <td>
                                                        <input id="imageupload1" type="file" runat="server" style="font-size: xx-small" />
                                                        <asp:Literal id="imageupload1error" runat="server" Visible="False" EnableViewState="False"></asp:Literal>
                                                        <asp:RequiredFieldValidator ID="imageupload1_required" runat="server" ControlToValidate="imageupload1"
                                                            ErrorMessage="Required"></asp:RequiredFieldValidator></td>
                                                </tr>
                                                <tr>
                                                    <td valign="top" style="width: 63px">
                                                        <strong>
                                                        <asp:Literal id="image2label" runat="server" Text="Image 2:"></asp:Literal>
                                                        </strong></td>
                                                    <td>
                                                        <input id="imageupload2" type="file" runat="server" style="font-size: xx-small" />
                                                        <asp:Literal id="imageupload2error" runat="server" Visible="False" EnableViewState="False"></asp:Literal>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td valign="top" style="width: 63px; height: 16px;">
                                                        <strong>
                                                        <asp:Literal id="image3label" runat="server" Text="Image 3:"></asp:Literal>
                                                        </strong></td>
                                                    <td style="height: 16px">
                                                        <input id="imageupload3" type="file" runat="server" style="font-size: xx-small" />
                                                        <asp:Literal id="imageupload3error" runat="server" Visible="False" EnableViewState="False"></asp:Literal>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td valign="top" style="width: 64px">
                                                        <strong>Image 4:</strong></td>
                                                    <td>
                                                        <input id="imageupload4" type="file" runat="server" style="font-size: xx-small" />
                                                        <asp:Literal id="imageupload4error" runat="server" Visible="False" EnableViewState="False"></asp:Literal>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 32px">
                                        &nbsp; 
                                    </td>
                                    <td>
                                        <asp:Button id="addbutton" onclick="addbutton_Click" runat="server" Text="Submit Product" Font-Size="XX-Small"></asp:Button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </form>
                    <asp:Literal id="status" runat="server" Visible="False"></asp:Literal>&nbsp;<br />
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
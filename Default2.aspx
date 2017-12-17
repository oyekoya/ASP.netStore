<%@ Page Language="VB" %>
<%@ import Namespace="System.Drawing" %>
<%@ import Namespace="System.Drawing.Imaging" %>
<%@ import Namespace="System.IO" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        'SaveFile(imageupload1, False, 270)
        Resize_Picture(270, "E:\web\essedesi\store\images\cust2\_DSC2639.jpg")
    End Sub
      
    ' ----------------------------------------


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
        Response.ContentType = "image/jpeg"
        imgFoto.Save(Response.OutputStream, jpegICI, myEncoderParameters)
        'imgFoto.Save(image_file, jpegICI, myEncoderParameters) 'CAREFUL - overwrites original file
        imgFoto.Dispose()
    End Sub

</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    </div>
    </form>
</body>
</html>

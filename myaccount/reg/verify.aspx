<%@ Page Language="VB" %>
<script runat="server">
    
    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        Dim strAdId As String
        strAdId = Request.QueryString("v")
        VerifyUpdate(CInt(strAdId))
    End Sub
    
    
    Function VerifyUpdate(ByVal verify As Integer) As Integer
        Dim connectionString As String = Application("appConn")
        Dim sqlConnection As System.Data.SqlClient.SqlConnection = New System.Data.SqlClient.SqlConnection(connectionString)

        Dim queryString As String = "UPDATE [Customer] SET [Verify]=1 WHERE ([Customer].[CustomerID] = @CustomerID) " & _
    "AND [Verify]=@Verify"
        Dim sqlCommand As System.Data.SqlClient.SqlCommand = New System.Data.SqlClient.SqlCommand(queryString, sqlConnection)

        sqlCommand.Parameters.Add("@CustomerID", System.Data.SqlDbType.Int).Value = Request.ServerVariables("AUTH_USER")
        sqlCommand.Parameters.Add("@Verify", System.Data.SqlDbType.SmallInt).Value = verify

        Dim rowsAffected As Integer = 0
        sqlConnection.Open()
        Try
            rowsAffected = sqlCommand.ExecuteNonQuery
            sqlConnection.Close()
        Finally
            sqlConnection.Close()
        End Try
        If rowsAffected <> 0 Then
            verify_label.Text = "Email Address has been verified. " & _
                "You can now add topics and post messages on the <a href=../forum/default.aspx>website</a>"
        End If
        Return rowsAffected
    End Function

</script>

<html>
<head>
    <title>Email Verification Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:Label ID="verify_label" runat="server" Font-Names="Arial" Font-Size="Small"
            Text="Unable to verify. Please ensure that the verify-link is correct."></asp:Label></div>
    </form>
</body>
</html>

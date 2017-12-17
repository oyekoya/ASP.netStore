<%@ Page Language="VB" %>
<%@ import Namespace="System.Data" %>
<%@ import Namespace="System.Data.SqlClient" %>
<script runat="server">

    Sub Page_Load(Sender As Object, E As EventArgs)
        If Not Page.IsPostBack Then
            Dim strAdId As String
            strAdId = Request.QueryString("productid")
            If strAdId = "" Then
                  Response.Redirect("default.aspx")
              Exit Sub
            End If
            Dim customerdata As System.Data.SqlClient.SqlDataReader = GetCustomerDetails()
            If customerdata.Read Then
                If "" & customerdata.Item("EmailAddress") <> "sales@essedesigns.com" Then
                    Response.Redirect("default.aspx")
                    Exit Sub
                Else
                    Hyperlink1.NavigateUrl="addproductdetails.aspx?productid=" & Request.QueryString("productid")
                    HyperLink1.Text = HyperLink1.Text & " for Product " & Request.QueryString("productid")
                End If
            End If           
            
            ' Databind the data grid on the first request only
            ' (on postback, rebind only in paging and sorting commands)
            BindGrid()
        End If
    End Sub

    Function GetCustomerDetails() As System.Data.SqlClient.SqlDataReader
        Dim connectionString As String = Application("appConn")
        Dim sqlConnection As System.Data.SqlClient.SqlConnection = New System.Data.SqlClient.SqlConnection(connectionString)

        Dim queryString As String = "SELECT [Customer].[EmailAddress] FROM [Customer] WHERE [Customer].[CustomerID] = " & Request.ServerVariables("AUTH_USER")
        Dim sqlCommand As System.Data.SqlClient.SqlCommand = New System.Data.SqlClient.SqlCommand(queryString, sqlConnection)

        sqlConnection.Open()
        Dim dataReader As System.Data.SqlClient.SqlDataReader = sqlCommand.ExecuteReader(System.Data.CommandBehavior.CloseConnection)

        Return dataReader
    End Function

    Sub DataGrid_Page(Sender As Object, e As DataGridPageChangedEventArgs)

        DataGrid1.CurrentPageIndex = e.NewPageIndex
        BindGrid()

    End Sub

    Sub DataGrid_Sort(Sender As Object, e As DataGridSortCommandEventArgs)

        DataGrid1.CurrentPageIndex = 0
        SortField = e.SortExpression
        BindGrid()

    End Sub


    '---------------------------------------------------------
    '
    ' Helpers
    '
    ' use a property to keep track of the sort field, and
    ' save it in viewstate between postbacks

    Property SortField() As String

        Get
            Dim o As Object = ViewState("SortField")
            If o Is Nothing Then
                Return String.Empty
            End If
            Return CStr(o)
        End Get

        Set(ByVal Value As String)
            ViewState("SortField") = Value
        End Set

    End Property



    Sub BindGrid()

        ' TODO: update the ConnectionString value for your application
        Dim ConnectionString As String = Application("appConn")
        Dim CommandText As String

        ' TODO: update the CommandText value for your application
        If SortField = String.Empty Then
            CommandText = "SELECT [ProductColour].* FROM [ProductColour] WHERE ([ProductColour].[ProductID]" & _
    " = " & Request.QueryString("productid") & ")"
        Else
            CommandText = "SELECT [ProductColour].* FROM [ProductColour] WHERE ([ProductColour].[ProductID]" & _
    " = " & Request.QueryString("productid") & ") order by " & SortField
        End If

        Dim myConnection As New SqlConnection(ConnectionString)
        Dim myCommand As New SqlDataAdapter(CommandText, myConnection)

        Dim ds As New DataSet()
        myCommand.Fill(ds)

        DataGrid1.DataSource = ds
        DataGrid1.DataBind()

    End Sub

</script>
<html>
<head>
    <title>Product Details</title>
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
                <td bgcolor="#e0e0e0" style="text-align: left; height: 20px;" bordercolor="#e0e0e0">
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
                <td bordercolor="#e0e0e0" bgcolor="#e0e0e0" colspan="6" height="20">
                    <div align="left"><font color="#003366"><strong>My&nbsp;Products</strong></font>&nbsp;
                    </div>
                </td>
            </tr>
            <tr valign="top">
                <td bordercolor="#e0e0e0" colspan="6" height="100%" style="border-left-color: #e0e0e0; border-bottom-color: #e0e0e0; border-top-style: solid; border-top-color: #e0e0e0; border-right-style: solid; border-left-style: solid; border-right-color: #e0e0e0; border-bottom-style: solid">
                    <p align="center">
                    </p>
                    <form id="Form1" runat="server">
                        <p align="left">
                        </p>
                        <p align="left">
                        </p>
                        <p align="left">
                        </p>
                        <p align="left">
                            &nbsp;</p>
                        <p align="left">
                            &nbsp;<img src="../../images/pointer.gif" border="0" />&nbsp;<asp:HyperLink ID="HyperLink1"
                                runat="server" Font-Bold="True">Add New Colour, Quantity and Price</asp:HyperLink>
                            <br />
                            <asp:datagrid id="DataGrid1" runat="server" width="100%" OnPageIndexChanged="DataGrid_Page" OnSortCommand="DataGrid_Sort" BorderColor="#ffffff" BorderWidth="1px" BorderStyle="None" CellPadding="3" BackColor="White" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False">
                                <FooterStyle forecolor="#000066" backcolor="#ffffff"></FooterStyle>
                                <HeaderStyle font-bold="True" forecolor="Black" backcolor="#ffffff"></HeaderStyle>
                                <PagerStyle horizontalalign="Right" forecolor="Black" backcolor="#ffffff" NextPageText="   Next&amp;gt;" PrevPageText="&amp;lt;Previous   " Font-Bold="True"></PagerStyle>
                                <SelectedItemStyle font-bold="True" forecolor="Black" backcolor="#ffffff"></SelectedItemStyle>
                                <ItemStyle forecolor="#000066"></ItemStyle>
                                <Columns>
                                    <asp:BoundColumn DataField="ProductID" SortExpression="ProductID" ReadOnly="True" HeaderText="Product ID"></asp:BoundColumn>
                                    <asp:BoundColumn DataField="ColourCode" SortExpression="ColourCode" ReadOnly="True" HeaderText="Colour Code"></asp:BoundColumn>
                                    <asp:BoundColumn DataField="Size" HeaderText="Size" SortExpression="Size">
                                    </asp:BoundColumn>
                                    <asp:BoundColumn DataField="Quantity" HeaderText="Quantity" SortExpression="Quantity">
                                    </asp:BoundColumn>
                                    <asp:BoundColumn DataField="Price" HeaderText="Price" SortExpression="Price"></asp:BoundColumn>
                                    <asp:HyperLinkColumn Text="Edit/Delete" DataNavigateUrlField="id" DataNavigateUrlFormatString="modifyproductdetails.aspx?id={0}"></asp:HyperLinkColumn>
                                </Columns>
                            </asp:datagrid>
                        </p>
                            <p>
                                &nbsp; Back to <a href="myproduct.aspx">My Products</a></p>
                    </form>
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
<%@ Page language="VB" %>

<script runat="server">
    Sub Page_Load(ByVal Sender As Object, ByVal E As EventArgs)
        If Not Page.IsPostBack Then
            Dim topicdata As System.Data.SqlClient.SqlDataReader = GetTopicDetails()
            If topicdata.Read Then
                'userid.Value = Request.ServerVariables("AUTH_USER")
                TopicLabel.Text = topicdata.Item("Title")
                title2.Text = topicdata.Item("Title")
                postmessage.NavigateUrl = "myaccount/forum/viewtopic.aspx?id=" & Request.QueryString("id")
                'If ((topicdata.Item("Status") = True) And (Session("Verified") = 1)) Then
                '    PostMessageLink.Visible = True
                '    PostMessageLink1.Visible = True
                'End If
                'If (topicdata.Item("Owner") = Request.ServerVariables("AUTH_USER")) Then
                '    StatusCheckBox.Checked = topicdata.Item("Status")
                '    UpdateTopicTable.Visible = True
                'End If
            Else
                Response.Redirect("forum.aspx")
            End If
        End If
    End Sub
            
    Function GetTopicDetails() As System.Data.SqlClient.SqlDataReader
        Dim connectionString As String = Application("appConn")
        Dim sqlConnection As System.Data.SqlClient.SqlConnection = New System.Data.SqlClient.SqlConnection(connectionString)

        Dim queryString As String = "SELECT * FROM Topic WHERE TopicID = " & Request.QueryString("id")
        Dim sqlCommand As System.Data.SqlClient.SqlCommand = New System.Data.SqlClient.SqlCommand(queryString, sqlConnection)

        sqlConnection.Open()
        Dim dataReader As System.Data.SqlClient.SqlDataReader = sqlCommand.ExecuteReader(System.Data.CommandBehavior.CloseConnection)

        Return dataReader
    End Function
    
    'Protected Sub PostMessageLink_Click(ByVal sender As Object, ByVal e As System.EventArgs)
    '    PostMessageLink.Visible = False
    '    PostMessageLink1.Visible = False
    '    PostDataList.Visible = False
    '    UpdateTopicTable.Visible = False
    '    PostMessageTable.Visible = True
    'End Sub

    'Protected Sub PostMessageButton_Click(ByVal sender As Object, ByVal e As System.EventArgs)
    '    If Len(message.Text) > 200 Then
    '        messagelimit.Text = "- number of characters should not be more than 200"
    '        Exit Sub
    '    End If
    '    InsertPost.Insert()
    '    PostMessageTable.Visible = False
    '    MessageAdded.Text = MessageAdded.Text & "<a href=viewtopic.aspx?id=" & Request.QueryString("id") & ">Topic</a>"
    '    MessageAdded.Visible = True
    'End Sub
    
    'Protected Sub UpdateTopicButton_Click(ByVal sender As Object, ByVal e As System.EventArgs)
    '    UpdateTopic.Update()
    '    PostMessageLink.Visible = False
    '    PostMessageLink1.Visible = False
    '    PostDataList.Visible = False
    '    UpdateTopicTable.Visible = False
    '    MessageAdded.Text = "Updated. Back to <a href=viewtopic.aspx?id=" & Request.QueryString("id") & ">Topic</a>"
    '    MessageAdded.Visible = True
    'End Sub

</script>
<%@ Register TagPrefix="a4u" Namespace="ASPDOTNET4U" Assembly="pagingdatalist"%>
<html>
<head>
    <title>Esse Designs Forum - <asp:Literal id="title2" runat="server"></asp:Literal></title> 
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
    <meta content="3 days" name="REVISIT-AFTER" />
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
              <td colspan="6" width="81%" align="left" valign="middle" style="height: 9px"><div align="left"><span class="style1" style="font-size: 32pt">Alero Collections</span> an authorised reseller for <a href="http://www.essedesigns.com/">Essé Designs</a></div></td>
              </td>
          </tr>
            <tr>
              <td colspan="6" align="left" valign="middle" style="height: 9px">
                <hr color="#666666" /></td>
            </tr>
			<tr>
                <td height="10" colspan="6" bgcolor="#ffffff" class="errata" style="text-align: left; width: 76px;"> 
					<a href="default.aspx"><b>Home</b></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="product.aspx"><b>Products</b></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="contact.aspx"><b>Contact</b></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="faq.html"><b>Help/FAQs</b></a>
				</td>
			</tr>
            <tr height="21">
                <td bgcolor="#e0e0e0" colspan="6" style="height: 20px; color: #003366;">
                    <div align="center" style="text-align: left">
                        <strong>&nbsp; Forum</strong></div>
                </td>
            </tr>
            <tr valign="top">
                <td colspan="6" height="100%">
		            <form id="Form1" method="post" runat="server">
                    <p style="text-align: right">
                        <br />
                        <table border="0" cellpadding="0" cellspacing="0" style="width: 100%; height: 16px">
                            <tr>
                                <td colspan="2">
                                    <strong>
                                                Topic: </strong>
                                <asp:Label ID="TopicLabel" runat="server" Font-Bold="True"></asp:Label></td>
                                <td style="width: 100px; text-align: right;">
                                    </td>
                            </tr>
                        </table>
                        <A4U:PAGINGDATALIST id="PostDataList" runat="server" DataKeyField="PostID" DataSourceID="AllPosts" 
                        Width="100%" PageSize="10" NextText="Next" PageCount="1" LastText="Last" RecordCount="0" TotalText="{0} POSTS" 
                        AddPagerTo="HeaderAndFooter" CurrentPage="1" FirstText="First" PreviousText="Previous" PageOfText="Page: {0} of {1}" 
                        CellPadding="4" Font-Names="Verdana" Font-Size="X-Small" HorizontalAlign="Justify">
                            <FooterStyle BackColor="#c6d7d5" Font-Bold="True" ForeColor="White" />
                            <HEADERTEMPLATE>
                            </HEADERTEMPLATE>
                            <ItemTemplate>
                                <div style="text-align: left">
                                    <table border="0" cellpadding="1" cellspacing="0" style="width: 625px">
                                        <tr>
                                            <td style="width: 150px" valign="top">
                                                <span style="text-decoration: underline">Posted by</span>:<br />
                                                user<%# Eval("CustomerID") %>
                                <asp:Label ID="PostDateTimeLabel" runat="server" Text='<%# Eval("PostDateTime") %>'>
                                </asp:Label></td>
                                            <td valign="top">
                                                Post
                                <asp:Label ID="PostIDLabel" runat="server" Text='<%# Eval("PostID") %>'></asp:Label>:<br />
                                <asp:Label ID="PostLabel" runat="server" Text='<%# Eval("Post") %>'></asp:Label></td>
                                        </tr>
                                    </table>
                                </div>
                            </ItemTemplate>
                            <FOOTERTEMPLATE></FOOTERTEMPLATE>
                            <SelectedItemStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
                            <HeaderStyle BackColor="#c6d7d5" Font-Bold="True" ForeColor="White" />
                            <ItemStyle BackColor="#E3EAEB" />
                            <AlternatingItemStyle BackColor="White" />
                        </A4U:PAGINGDATALIST>
                        <%--</asp:DataList>--%><asp:SqlDataSource ID="AllPosts" runat="server" ConnectionString="<%$ ConnectionStrings:esse-newConnectionString %>"
                            SelectCommand="SELECT * FROM Post WHERE (TopicID = @TopicID)">
                            <SelectParameters>
                                <asp:QueryStringParameter Name="TopicID" QueryStringField="id" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        </p>
                        <p style="text-align: center">
                            &nbsp;</p>
                        <p>
                            NOTE: Users have to verify their email addresses before they can <a href="myaccount/forum/default.aspx">
                                add topic</a> or 
                            <asp:HyperLink ID="postmessage" runat="server" NavigateUrl="myaccount/forum/default.aspx">post messages</asp:HyperLink>.</p>
                            <p>Back to <a href=forum.aspx>Forum Topics</a></p>
                    </form></td>
            </tr>
            <tr>
                <td height="30" colspan="6" bgcolor="#ffffff">
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
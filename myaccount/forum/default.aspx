<%@ Page Language="VB" %>
<script runat="server">

    Sub Page_Load(ByVal Sender As Object, ByVal E As EventArgs)
        If Not Page.IsPostBack Then
            userid.Value = Request.ServerVariables("AUTH_USER")
            If (Session("Verified") = 1) Then
                AddTopicLink.Visible = True
                AddTopicLink1.Visible = True
            End If
        End If
    End Sub
            
    Sub DataGrid_Page(ByVal Sender As Object, ByVal e As DataGridPageChangedEventArgs)

        TopicDataGrid.CurrentPageIndex = e.NewPageIndex
        TopicDataGrid.DataBind() 'BindGrid()

    End Sub

    Protected Sub AddTopicLink_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        AddTopicLink.Visible = False
        AddTopicLink1.Visible = False
        SearchTable.Visible = False
        TopicDataGrid.Visible = False
        AddTopicTable.Visible = True
    End Sub

    Protected Sub AddTopicButton_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        If ( (Len(title.Text) > 0) And (Len(title.Text) < 100) ) Then
            InsertTopic.Insert()
            AddTopicTable.Visible = False
            TopicAdded.Visible = True
        End If
    End Sub
</script>
<html>
<head>
    <title>Alero Collections</title> 
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
    <link href="../../styles1.css" type="text/css" rel="stylesheet" />
    <link href="../../styles2.css" type="text/css" rel="stylesheet" />
    <link href="../style.css" type="text/css" rel="stylesheet" />
    
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
                <td bgcolor="#ffffff" colspan="6" style="height: 20px; color: #003366;">
                    <div align="center" style="text-align: left">
                        <strong>&nbsp; Forum</strong></div>
                </td>
            </tr>
            <tr valign="top">
                <td colspan="6" height="100%" style="text-align: left">
		            <form id="Form1" method="post" runat="server">
                    <p style="text-align: right">
                        <br />
                        <table runat=server bgcolor="#ffffff" border="0" cellpadding="5" cellspacing="0" style="width: 100%;
                            height: 35px" id="SearchTable" visible="true">
                            <tbody>
                                <tr>
                                    <td style="width: 377px">
                                        Search Topic: &nbsp;<asp:TextBox ID="keyword" runat="server" Font-Size="XX-Small"
                                            Width="272px" AutoPostBack="True"></asp:TextBox></td>
                                    <td colspan="2">
                                        &nbsp;Type:&nbsp;
                                        <asp:DropDownList ID="type" runat="server" Font-Size="XX-Small" AutoPostBack="True">
                                            <asp:ListItem Selected="True" Value="%">All</asp:ListItem>
                                            <asp:ListItem>Any</asp:ListItem>
	                                        <asp:ListItem Value="outerwear">Outerwear</asp:ListItem>
	                                        <asp:ListItem Value="fabric">Fabric</asp:ListItem>
                                        </asp:DropDownList></td>
                                </tr>
                            </tbody>
                        </table>
                    </p>
                        <asp:Label ID="TopicAdded" runat="server" Text="Topic has been added. Click here to go back to <a href=default.aspx>Forum Topics</a>" Visible="False" Font-Bold="True"></asp:Label><asp:LinkButton ID="AddTopicLink1" runat="server" Font-Bold="True" OnClick="AddTopicLink_Click"
                            Visible="False">Add New Topic</asp:LinkButton><br />
                        <asp:DataGrid ID="TopicDataGrid" runat="server" OnPageIndexChanged="DataGrid_Page" AllowPaging="True"
                            AutoGenerateColumns="False" BackColor="White" BorderColor="#ffffff" BorderStyle="None"
                            BorderWidth="1px" CellPadding="3" DataSourceID="ForumTopics" 
                            Width="100%" PageSize="20">
                            <FooterStyle BackColor="#ffffff" ForeColor="#000066" />
                            <SelectedItemStyle BackColor="#003366" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#ffffff" Font-Bold="True" ForeColor="White" HorizontalAlign="Right"
                                NextPageText="   Next&amp;gt;" PrevPageText="&amp;lt;Previous   " />
                            <ItemStyle ForeColor="#000066" />
                            <HeaderStyle BackColor="#ffffff" Font-Bold="True" ForeColor="White" />
                            <Columns>
                                <asp:HyperLinkColumn DataNavigateUrlField="TopicID" DataNavigateUrlFormatString="viewtopic.aspx?id={0}" DataTextField="Title" HeaderText="Topic" SortExpression="Title"></asp:HyperLinkColumn>
                                <asp:BoundColumn DataField="Category" HeaderText="Category" ReadOnly="True"
                                    SortExpression="Category"></asp:BoundColumn>
                                <asp:BoundColumn DataField="TopicDate" DataFormatString="{0:d-MMM-yyy}" HeaderText="Posted Date"
                                    ReadOnly="True" SortExpression="TopicDate"></asp:BoundColumn>
                                <asp:BoundColumn DataField="Status2" HeaderText="Status" ReadOnly="True"
                                    SortExpression="Status"></asp:BoundColumn>
                            </Columns>
                        </asp:DataGrid><asp:SqlDataSource ID="ForumTopics" runat="server" ConnectionString="<%$ ConnectionStrings:esse-newConnectionString %>"
                            SelectCommand="SELECT *, CASE Status WHEN 0 then 'Closed' ELSE 'Open' END as Status2 FROM [Topic] WHERE (([Title] LIKE '%' + @Title + '%') AND ([Category] LIKE '%' + @Category + '%')) ORDER BY TopicDate DESC">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="keyword" Name="Title" PropertyName="Text" Type="String" DefaultValue="%" />
                                <asp:ControlParameter ControlID="type" Name="Category" PropertyName="SelectedValue"
                                    Type="String" ConvertEmptyStringToNull="False" DefaultValue="%" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:LinkButton ID="AddTopicLink" runat="server" OnClick="AddTopicLink_Click" Font-Bold="True" Visible="False">Add New Topic</asp:LinkButton><br />
                        <div style="text-align: center">
                            <table runat="server" visible=false id="AddTopicTable" border="0" cellpadding="5" cellspacing="0" style="border-right: gray thin solid;
                                border-top: gray thin solid; border-left: gray thin solid; width: 440px; border-bottom: gray thin solid">
                                <tr>
                                    <td colspan="2" style="height: 23px" bordercolor="gray">
                                        <strong>Add New Topic
                                            <input id="userid" runat="server" style="width: 121px; height: 18px" type="hidden" /></strong></td>
                                </tr>
                                <tr>
                                    <td style="width: 72px; height: 44px;">
                                        Title:</td>
                                    <td style="width: 100px; height: 44px;">
                                        <asp:TextBox ID="title" runat="server" Font-Size="XX-Small" Width="309px"></asp:TextBox><strong><span style="color: #ff0000"> * max 100 chars
                                    </span></strong></td>
                                </tr>
                                <tr>
                                    <td style="width: 72px">
                                        Category:</td>
                                    <td style="width: 100px">
                                        <asp:DropDownList ID="DropDownList1" runat="server" Font-Size="XX-Small" Width="135px">
                                            <asp:ListItem Selected="True">Any</asp:ListItem>
	                                        <asp:ListItem Value="outerwear">Outerwear</asp:ListItem>
	                                        <asp:ListItem Value="fabric">Fabric</asp:ListItem>
                                        </asp:DropDownList></td>
                                </tr>
                                <tr>
                                    <td colspan="2" style="text-align: center">
                                        <asp:Button ID="AddTopicButton" runat="server" Font-Size="X-Small" OnClick="AddTopicButton_Click"
                                            Text="Add Topic" />
                                        <asp:SqlDataSource ID="InsertTopic" runat="server" ConnectionString="<%$ ConnectionStrings:esse-newConnectionString %>"
                                            InsertCommand="INSERT INTO Topic(Title, Category, Status, TopicDate, Owner) VALUES (@Title, @Category, 1, getdate(), @Owner)"
                                            ProviderName="<%$ ConnectionStrings:esse-newConnectionString.ProviderName %>">
                                            <InsertParameters>
                                                <asp:ControlParameter ControlID="title" Name="Title" PropertyName="Text" />
                                                <asp:ControlParameter ControlID="DropDownList1" Name="Category" PropertyName="SelectedValue" />
<%--                                                <asp:ControlParameter ControlID="CheckBox1" Name="EnableAllPosts" PropertyName="Checked" />
                                                <asp:Parameter DefaultValue="0" Name="Status" />
                                                    <asp:Parameter DefaultValue="getdate()" Name="TopicDate" />
--%>                                                <asp:ControlParameter ControlID="userid" PropertyName="Value" Name="Owner" />
                                            </InsertParameters>
                                        </asp:SqlDataSource>
                                    </td>
                                </tr>
                            </table>
                            <br />
                            <p style="text-align: left">
                                NOTE: Users have to verify their email addresses before they can add topic or post
                                messages.</p>
                        </div>
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
<%@ Page Language="VB" %>
<%@ import Namespace="System.Math" %>
<script runat="server">

    Dim objDT As System.Data.DataTable
    Dim objDR As System.Data.DataRow

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            Dim strAdId As String
            strAdId = Request.QueryString("ProductID")
            If strAdId = "" Then
                desc.Text = "No Product ID specified."
                Exit Sub
            End If
            If Not IsNumeric(strAdId) Then
                desc.Text = "Product ID '" & strAdId & _
                                "' is non-numeric."
                Exit Sub
            End If
            Dim Productdata As System.Data.SqlClient.SqlDataReader = GetProduct(strAdId)
    
            If Productdata.Read Then
                Productid.Text = Productdata.Item("ProductID")
                title.Text = Productdata.Item("Title")
                'If ("" & Productdata.Item("Type") = "other") Then
                '    title2.Text = Productdata.Item("Title") & " " & Productdata.Item("Type") & " outerwear"
                'Else
                title2.Text = Productdata.Item("Title") & " " & Productdata.Item("Type")
                'End If
                desc.Text = Productdata.Item("Description")
                'length.Text = Productdata.Item("Length")
                'price.Text = Productdata.Item("Price")
                'If (Productdata.Item("Postage") = 0) Then
                '    postage.Text = "Inclusive"
                'Else
                '    postage.Text = Productdata.Item("Postage")
                'End If
                'additionalpostage.Text = Round((postage.Text / 2), 2)
                type.Text = Productdata.Item("Type")
				If ("" & Productdata.Item("Type") = "fabric") Then
					size.Visible = False
				End If
    
                If (("" & Productdata.Item("Image1") <> "") Or ("" & Productdata.Item("Image2") <> "")) Then
                    If "" & Productdata.Item("Image1") <> "" Then
                        Productimage1.Src = "images/cust" & Productdata.Item("CustomerID") & "/" & Productdata.Item("Image1")
                        Productimage1.Visible = True
                    End If
                    If "" & Productdata.Item("Image2") <> "" Then
                        Productimage2.Src = "images/cust" & Productdata.Item("CustomerID") & "/" & Productdata.Item("Image2")
                        Productimage2.Visible = True
                    End If
                    tableProduct1.Visible = True
                End If
    
                If (("" & Productdata.Item("Image3") <> "") Or ("" & Productdata.Item("Image4") <> "")) Then
                    If "" & Productdata.Item("Image3") <> "" Then
                        Productimage3.Src = "images/cust" & Productdata.Item("CustomerID") & "/" & Productdata.Item("Image3")
                        Productimage3.Visible = True
                    End If
                    If "" & Productdata.Item("Image4") <> "" Then
                        Productimage4.Src = "images/cust" & Productdata.Item("CustomerID") & "/" & Productdata.Item("Image4")
                        Productimage4.Visible = True
                    End If
                    tableProduct2.Visible = True
                End If
                'If "" & Productdata.Item("Type") <> "synthetic " Then
                '    choosecolour_row.Visible = False
                '    colourcode.SelectedItem.Value = "NA"
                '    colourcode.SelectedItem.Text = "NA - Not Applicable"
                '    colourcode.Enabled = False
                '    CheckStock()
                'End If
            Else
                desc.Text = "Product ID '" & strAdId & "' not found"
            End If
        End If
    End Sub
    
    
    
    Function GetProduct(ByVal productID As Integer) As System.Data.SqlClient.SqlDataReader
        Dim connectionString As String = Application("appConn")
        Dim sqlConnection As System.Data.SqlClient.SqlConnection = New System.Data.SqlClient.SqlConnection(connectionString)

        Dim queryString As String = "SELECT [Products].* FROM [Products]" & _
        " WHERE ([Products].[ProductID] = @ProductID)"
        Dim sqlCommand As System.Data.SqlClient.SqlCommand = New System.Data.SqlClient.SqlCommand(queryString, sqlConnection)

        sqlCommand.Parameters.Add("@ProductID", System.Data.SqlDbType.Int).Value = productID

        sqlConnection.Open()
        Dim dataReader As System.Data.SqlClient.SqlDataReader = sqlCommand.ExecuteReader(System.Data.CommandBehavior.CloseConnection)

        Return dataReader
    End Function
    
    Function CheckStock() As String
        CheckoutLink.Visible = False
        CheckoutLabel.Visible = False
        Dim Productdata As System.Data.SqlClient.SqlDataReader = GetProductStatus()
        If Productdata.Read Then
            stock_row.Visible = True
            qty_row.Visible = True
            cost_row.Visible = True
            button_row.Visible = True
            If (Productdata.Item("Quantity") > 0) Then
                stock_status.Text = "Available"
                stock_status.ForeColor = Drawing.Color.Green
                stock_status.Visible = True
                quantity.Visible = True
                QuantityLabel.Visible = True
                PoundSign.Visible = True
                cost.Text = Productdata.Item("Price")
                cost.Visible = True
                CostLabel.Visible = True
                AddToBasketButton.Visible = True
            Else
                stock_status.Text = "Sorry, this item is not available in this colour and size. You can <a href=contact.aspx>contact us</a> to arrange Made-to-order"
                stock_status.ForeColor = Drawing.Color.Red
                stock_status.Visible = True
                quantity.Visible = False
                QuantityLabel.Visible = False
                PoundSign.Visible = True
                cost.Text = Productdata.Item("Price")
                cost.Visible = True
                CostLabel.Visible = True
                AddToBasketButton.Visible = False
            End If
        Else
            stock_status.Text = "Sorry, this item is not available in this colour and size.  You can <a href=contact.aspx>contact us</a> to arrange Made-to-order"
            stock_status.ForeColor = Drawing.Color.Red
            stock_status.Visible = True
            quantity.Visible = False
            QuantityLabel.Visible = False
            PoundSign.Visible = False
            cost.Visible = False
            CostLabel.Visible = False
            AddToBasketButton.Visible = False
            stock_row.Visible = True
            qty_row.Visible = False
            cost_row.Visible = False
            button_row.Visible = False
        End If
        Return ""
    End Function

    Protected Sub colourcode_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        If colourcode.SelectedItem.Text <> ""
			CheckStock()
		End If
    End Sub
    
    Function GetProductStatus() As System.Data.SqlClient.SqlDataReader
        Dim connectionString As String = Application("appConn")
        Dim sqlConnection As System.Data.SqlClient.SqlConnection = New System.Data.SqlClient.SqlConnection(connectionString)

        Dim queryString As String = "SELECT [ProductColour].* FROM [ProductColour]" & _
        " WHERE ([ProductColour].[ProductID] = @ProductID) AND ([ProductColour].[ColourCode] = @ColourCode) AND ([ProductColour].[Size] = @Size)"
        Dim sqlCommand As System.Data.SqlClient.SqlCommand = New System.Data.SqlClient.SqlCommand(queryString, sqlConnection)

        sqlCommand.Parameters.Add("@ProductID", System.Data.SqlDbType.Int).Value = Productid.Text
        sqlCommand.Parameters.Add("@ColourCode", System.Data.SqlDbType.NVarChar).Value = colourcode.SelectedItem.Value
        sqlCommand.Parameters.Add("@Size", System.Data.SqlDbType.Int).Value = size.SelectedItem.Value

        sqlConnection.Open()
        Dim dataReader As System.Data.SqlClient.SqlDataReader = sqlCommand.ExecuteReader(System.Data.CommandBehavior.CloseConnection)

        Return dataReader
    End Function

    Protected Sub AddToBasketButton_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        objDT = Session("Cart")
        Dim Product = Productid.Text
        Dim blnMatch As Boolean = False

        For Each objDR In objDT.Rows
            If ((objDR("Product") = Product) And (objDR("Colour") = colourcode.SelectedItem.Value) And (objDR("Size") = size.SelectedItem.Text)) Then
                objDR("Qty") += quantity.Text
                blnMatch = True
                Exit For
            End If
        Next

        If Not blnMatch Then
            objDR = objDT.NewRow
            objDR("Product") = Productid.Text
            objDR("Item") = "<a href=ProductDetails.aspx?ProductID=" & Productid.Text & " >" & title.Text & "</a>"
            objDR("Type") = type.Text
            objDR("Title") = title.Text
            objDR("Colour") = colourcode.SelectedItem.Value
			If ("" & type.Text = "fabric") Then
				objDR("Size") = 0
			Else
				objDR("Size") = size.SelectedItem.Value
			End If
	        Dim Productdata As System.Data.SqlClient.SqlDataReader = GetProduct(Productid.Text)
	        If Productdata.Read Then
	            objDR("Postage") = CDec(Productdata.Item("Postage"))
	            objDR("AdditionalPostage") = CDec(Productdata.Item("AdditionalPostage"))
	            objDR("PostageContinent") = CDec(Productdata.Item("PostageContinent"))
	            objDR("AdditionalPostageContinent") = CDec(Productdata.Item("AdditionalPostageContinent"))
	            objDR("PostageWorld") = CDec(Productdata.Item("PostageWorld"))
	            objDR("AdditionalPostageWorld") = CDec(Productdata.Item("AdditionalPostageWorld"))
			End If
            objDR("Qty") = quantity.Text
            objDR("Cost") = Decimal.Parse(cost.Text)
            objDT.Rows.Add(objDR)
        End If
        Session("Cart") = objDT
        
        CheckoutLink.Visible = True
        CheckoutLabel.Visible = True
    End Sub

</script>
<html>
<head>
    <title>Esse Designs - <asp:Literal id="title2" runat="server"></asp:Literal></title>     
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
          <tr><td colspan="2" valign="top">
            <center> 
                <form id="Form1" runat="server">
                    <table style="WIDTH: 600px; HEIGHT: 131px" bordercolor="#e0e0e0" cellspacing="0" cellpadding="5" border="0">
                        <tbody>
                            <tr>
                                <td bgcolor="#e0e0e0" style="width: 90px">
                                    <strong>
                                    <asp:Literal id="title" runat="server"></asp:Literal>
                                    </strong></td>
                                <td bgcolor="#e0e0e0" style="text-align: right">
                                    <strong>Product ID:</strong> </td>
                                <td bgcolor="#e0e0e0">
                                    
                                    <asp:Literal id="Productid" runat="server"></asp:Literal><strong></strong></td>
                            </tr>
                            <tr>
                                <td style="width: 90px">
                                    <strong>Description: </strong></td>
                                <td colspan="2">
                                    
                                    <asp:Literal id="desc" runat="server"></asp:Literal>
                                    </td>
                            </tr>
                            <tr>
                                <td style="width: 90px">
                                    <strong>Type: </strong></td>
                                <td colspan="2">
                                    <asp:Literal id="type" runat="server"></asp:Literal>
                                    </td>
                            </tr>
                            <tr>
                            <td>
                                <strong>Size:</strong></td>
                                <td colspan="2">
                                    <asp:DropDownList id="size" runat="server" Font-Size="XX-Small" AutoPostBack="True" OnSelectedIndexChanged="colourcode_SelectedIndexChanged">
									<asp:ListItem Value="8" Selected="True">8</asp:ListItem>
									<asp:ListItem Value="10">10</asp:ListItem>
									<asp:ListItem Value="12">12</asp:ListItem>
								</asp:DropDownList></td>
                            </tr>
                            <tr runat=server id=choosecolour_row visible=true>
                            <td></td>
                                <td colspan="2">
                                    <strong>
                                Please choose colour to find out availability. Click </strong><a href="colourchart.html" target="_blank"><strong>here</strong></a><strong> for colour chart. </strong>
                                </td>
                            </tr>
                                <tr>
                                    <td style="width: 90px;">
                                        <strong>&nbsp;Colour Code:</strong></td>
                                    <td colspan="2" style="height: 5px">
                                            <asp:DropDownList ID="colourcode" runat="server" AppendDataBoundItems="True" DataSourceID="colours_db"
                                                DataTextField="ColourAndCode" DataValueField="ColourCode" Font-Size="XX-Small" AutoPostBack="True" OnSelectedIndexChanged="colourcode_SelectedIndexChanged">
                                                <asp:ListItem></asp:ListItem>
                                            </asp:DropDownList>
                                    </td>
                                </tr>
                            <tr runat=server id=stock_row visible=false>
                                <td style="width: 90px">
                                </td>
                                <td colspan="2">
                                        <asp:Label ID="stock_status" runat="server" Visible="False" Font-Bold="True" ForeColor="Green"></asp:Label>
                                </td>
                            </tr>
                            <tr runat=server id=cost_row visible=false>
                                <td style="width: 90px; height: 26px;">
                                    <asp:Label ID="CostLabel" runat="server" Font-Bold="True" Text="Cost:" Visible="False"></asp:Label></td>
                                <td colspan="2" style="height: 26px">
                                    <asp:Label ID="PoundSign" runat="server" Text="£" Visible="False"></asp:Label><asp:Label ID="cost" runat="server" Visible="False"></asp:Label></td>
                            </tr>
                            <tr runat=server visible=false id=qty_row>
                                <td style="width: 90px">
                                    <asp:Label ID="QuantityLabel" runat="server" Font-Bold="True" Text="Quantity:" Visible="False"></asp:Label></td>
                                <td colspan="2">
                                    &nbsp;<asp:TextBox ID="quantity" runat="server" Width="25px" Font-Size="XX-Small" Visible="False">1</asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="quantity"
                                        ErrorMessage="Required"></asp:RequiredFieldValidator></td>
                            </tr>
                            <tr runat=server visible=false id=button_row>
                                <td style="width: 90px">
                                </td>
                                <td colspan="2">
                                        <asp:Button ID="AddToBasketButton" runat="server" Font-Size="XX-Small" Text="Add to Basket"
                                            Visible="False" OnClick="AddToBasketButton_Click" />&nbsp;
                                    <asp:Label ID="CheckoutLabel" runat="server" Text="Added to shopping basket.  Finished shopping? Please proceed to"
                                        Visible="False" ForeColor="Red"></asp:Label>&nbsp;
                                    <asp:LinkButton ID="CheckoutLink" runat="server" PostBackUrl="~/checkout.aspx"
                                        Visible="False">Checkout</asp:LinkButton></td>
                            </tr>
                            <tr>
                                <td colspan="3">
                                    <table id="tableProduct1" cellspacing="0" cellpadding="5" width="100%" border="0" runat="server" visible="false">
                                        <tbody>
                                            <tr>
                                                <td>
                                                    <p align="center">
                                                        &nbsp;<img id="Productimage1" src="images/blank.gif" runat="server" visible="false" /> 
                                                    </p>
                                                </td>
                                                <td>
                                                    <p align="center">
                                                        &nbsp;<img id="Productimage2" src="images/blank.gif" runat="server" visible="false" /> 
                                                    </p>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3">
                                    <table id="tableProduct2" cellspacing="0" cellpadding="5" width="100%" border="0" runat="server" visible="false">
                                        <tbody>
                                            <tr>
                                                <td>
                                                    <p align="center">
                                                        &nbsp;<img id="Productimage3" src="images/blank.gif" runat="server" visible="false" /> 
                                                    </p>
                                                </td>
                                                <td>
                                                    <p align="center">
                                                        &nbsp;<img id="Productimage4" src="images/blank.gif" runat="server" visible="false" /> 
                                                    </p>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <font face="Tahoma"><strong><font size="1">
                    <!-- Insert content here --></font></strong></font>
                </form><br/>
             <a href="product.aspx">Back to products page</a><br />
           </center>
          </td>
          <td valign=top><div align=right><a href=checkout.aspx><img src=images/checkout.jpg /></a><asp:SqlDataSource ID="colours_db" runat="server" ConnectionString="<%$ ConnectionStrings:esseConnectionString %>"
                                                DataSourceMode="DataReader" SelectCommand="SELECT DISTINCT ProductColour.ColourCode, ProductColour.ColourCode + ' - ' + Colour AS ColourAndCode FROM ProductColour, Colour WHERE ProductID = @ProductID and ProductColour.ColourCode = Colour.ColourCode ORDER BY ProductColour.ColourCode">
	                                            <SelectParameters>
	                                                <asp:QueryStringParameter Name="ProductID" QueryStringField="ProductID" />
	                                            </SelectParameters>
                                            </asp:SqlDataSource>
                          </div></td></tr>
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
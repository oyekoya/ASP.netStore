<%@ Page Language="VB" %>
<%@ import Namespace="System.Data.SqlClient" %>
<%@ import Namespace="System.Data" %>
<script runat="server">

	Dim objDT As System.Data.DataTable 
    Dim objDR As System.Data.DataRow
    Dim paypal_link As String

' ----------------------------------------
    Function GetItemTotal() As Decimal
        Dim intCounter As Integer = 0
        Dim decRunningTotal As Decimal = 0.0
        Dim decRunningPostage As Decimal = 0.0
		Dim decRunningQty As Integer = -1

        For intCounter = 0 To objDT.Rows.Count - 1
            objDR = objDT.Rows(intCounter)
            decRunningTotal += (objDR("Cost") * objDR("Qty"))
			decRunningQty += objDR("Qty")
			If destination.SelectedIndex = 0 Then
				decRunningPostage += (objDR("Postage") + (objDR("AdditionalPostage") * (objDR("Qty")-1)))
			Else If destination.SelectedIndex = 1 Then
				decRunningPostage += (objDR("PostageContinent") + (objDR("AdditionalPostageContinent") * (objDR("Qty")-1)))
			Else If destination.SelectedIndex = 2 Then
				decRunningPostage += (objDR("PostageWorld") + (objDR("AdditionalPostageWorld") * (objDR("Qty")-1)))
			End If
        Next
		
        If (objDT.Rows.Count < 1) Then
            cart_status.Visible = True
            Image1.Visible = False
            Literal3.Visible = False
        Else
            cart_status.Visible = False
            Image1.Visible = True
            Literal3.Visible = True
        End If
        
        postage.Text = decRunningPostage
        decRunningTotal += decRunningPostage
        
        Return decRunningTotal
    End Function

    Sub Delete_Item(ByVal s As Object, ByVal e As DataGridCommandEventArgs)
        objDT = Session("Cart")
        objDT.Rows(e.Item.ItemIndex).Delete()
        Session("Cart") = objDT

        dg.DataSource = objDT
        dg.DataBind()

        lblTotal.Text = GetItemTotal()
    End Sub

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        'If Not Page.IsPostBack Then
        objDT = Session("Cart")
        dg.DataSource = objDT
        dg.DataBind()

        lblTotal.Text = GetItemTotal()
        'End If
    End Sub
    
    ' ----------------------------------------
    
    Protected Sub Image1_ServerClick(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs)
        Dim intCounter As Integer
        Dim temp As String
        Dim items As String = ""
        paypal_link = "http://www.paypal.com/cart/?upload=1&business=sales%40essedesigns.com"
        'paypal_link = "http://www.sandbox.paypal.com/cart/?upload=1&business=mail_1198951949_biz%40wolex.com"
        For intCounter = 0 To objDT.Rows.Count - 1
            objDR = objDT.Rows(intCounter)
            temp = objDR("Colour").ToString
            paypal_link &= "&quantity_" & intCounter + 1 & "=" & objDR("Qty") & "&item_name_" & _
            intCounter + 1 & "=" & objDR("Title") & "_" & temp.Replace("#", "%23") & "_" & objDR("Size") & "&item_number_" & intCounter + 1 & "=" & _
            objDR("Product") & "&amount_" & intCounter + 1 & "=" & objDR("Cost") & _
            "&shipping_" & intCounter + 1 & "=" & (objDR("Postage") + (objDR("AdditionalPostage") * (objDR("Qty")-1)))
            items &= objDR("Title") & "_" & temp.Replace("#", "%23") & "_" & objDR("Qty") &  "_" & objDR("Size") &"__"
        Next
        paypal_link &= "&currency_code=GBP&custom=" & items & "&return=http%3A//www.essedesigns.com/store/myaccount/successful.aspx" & _
        "&cancel_return=http%3A//www.essedesigns.com/store/checkout.aspx"
        Response.Redirect(paypal_link)
    End Sub
    
    Protected Sub DropDownList1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        lblTotal.Text = GetItemTotal()
    End Sub
</script>
<html>
<head>
    <title>Esse Designs - Checkout</title> 
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
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<META HTTP-EQUIV ="Expire" CONTENT ="0">
</head>
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
            <tr valign="top">
            <td></td>
                <td height="100%">
                    <p align="center">
                    </p>
                    <p align="center">
                    </p>
                    <p align="center">
                    </p>
                    <form runat=server>
                        <table id="maintable" style="WIDTH: 532px; HEIGHT: 311px" cellspacing="0" cellpadding="10" align="center" border="0" runat="server">
                            <tbody>
                                <tr>
                                    <td style="text-align: center">
                                        <p align="center">
                                        </p>
                                        <strong> 
                                            <asp:DataGrid ID="dg" runat="server" OnDeleteCommand="Delete_Item" PageSize="50" Width="100%" GridLines="None" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333">
                                                <Columns>
                                                    <asp:ButtonColumn CommandName="Delete" Text="Remove Item"></asp:ButtonColumn>
                                                    <asp:BoundColumn DataField="Product" HeaderText="Product" Visible="False"></asp:BoundColumn>
                                                    <asp:BoundColumn DataField="Postage" HeaderText="Postage" Visible="False"></asp:BoundColumn>
                                                    <asp:BoundColumn DataField="Type" HeaderText="Type" Visible="False"></asp:BoundColumn>
                                                    <asp:BoundColumn DataField="ID" HeaderText="ID" Visible="False"></asp:BoundColumn>
                                                    <asp:HyperLinkColumn DataNavigateUrlField="Product" DataNavigateUrlFormatString="ProductDetails.aspx?ProductID={0}"
                                                        DataTextField="Item" HeaderText="Item">
                                                        <HeaderStyle Width="50%" />
                                                    </asp:HyperLinkColumn>
                                                    <asp:BoundColumn DataField="Colour" HeaderText="Colour"></asp:BoundColumn>
                                                    <asp:BoundColumn DataField="Size" HeaderText="Size"></asp:BoundColumn>
                                                    <asp:BoundColumn DataField="Qty" HeaderText="Qty"></asp:BoundColumn>
                                                    <asp:BoundColumn DataField="Cost" HeaderText="Cost"></asp:BoundColumn>
                                                </Columns>
                                                <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                                                <EditItemStyle BackColor="#7C6F57" />
                                                <SelectedItemStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
                                                <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
                                                <AlternatingItemStyle BackColor="White" />
                                                <HeaderStyle Font-Bold="True" BackColor="#ffffff" />
                                            </asp:DataGrid><span style="color: #ff0000"> 
                        <asp:Literal id="cart_status" runat="server" Text="Your shopping cart is empty" Visible="False"></asp:Literal></span><br />
                                        </strong>
                                        <p style="text-align: right">
                                            Please select delivery destination:
                                            <asp:DropDownList ID="destination" runat="server"
                                                AutoPostBack="True" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" Font-Size="XX-Small">
                                                <asp:ListItem Value="4.00" Selected="True">UK</asp:ListItem>
                                                <asp:ListItem Value="5.00">Europe</asp:ListItem>
                                                <asp:ListItem Value="8.00">Rest of the World</asp:ListItem>
                                            </asp:DropDownList><span style="color: Red"><strong>*</strong></span><br />
                                            Postage and Packing:
                                            £<asp:Label ID="postage" runat="server"></asp:Label>
                                            <br />
                                            <strong>
                                            Total: £</strong><asp:Label ID="lblTotal" runat="server" Font-Bold="True"></asp:Label><strong>
                                            </strong>
                                        </p>
                                            <p align="center">
                                                &nbsp;</p>
                                        <p align="center">
                                            <font size="1">
                                            <asp:Literal id="Literal3" runat="server" Text='Click on "Buy Now" below to Make Payment' Visible="False"></asp:Literal>
                                            </font></p>
                                        </td>
                                </tr>
                                <!-- PayPal Logo -->
                                <tr>
                                    <td>
                                        <p align="center">
                                            <input runat=server type="image" alt="Make payments with PayPal - it's fast, free and secure!" src="images/buy-now-button.gif" border="0" name="submit" id="Image1" onserverclick="Image1_ServerClick" visible="false" />&nbsp;</p>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <p align="center">
                                            <font face="verdana,arial,helvetica" size="1"><b>Pay securely with any major credit
                                            card through PayPal!</b></font> 
                                        </p>
                                        <p align="center">
                                            <span style="color: Red"><strong>*</strong></span> Please ensure you select correct delivery
                                            destination to avoid delays to your order.</p>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </form>
                    <!-- End PayPal Logo -->
                    <p align="center">
                        &nbsp;<br />
                        &nbsp;</p>
                </td>
                <td valign=top><div align=right><a href=checkout.aspx><img src=images/checkout.jpg /></a></div></td></tr>
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
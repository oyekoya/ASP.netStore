Imports System
Imports System.Collections
Imports System.ComponentModel
Imports System.Data
Imports System.Text
Imports System.IO
Imports System.Net
Imports System.Web
'Imports System.Web.Mail
Imports System.Net.Mail
Imports System.Data.SqlClient


Public Class PayPalIPN
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

    Dim paymentId As Integer = 0

    Dim strToSend, OrderID, Txn_id, Payment_status, Receiver_email, num_items, Item_name, _
        Item_number, Quantity, Invoice, Custom, Shipping, item_details, _
        Payment_gross, Payer_email, Pending_reason, Payment_date, Payment_fee, _
        Txn_type, First_name, Last_name, Address_street, Address_city, Address_state, _
        Address_zip, Address_country, Address_status, Payer_status, Payment_type, _
        Notify_version, Verify_sign, Subscr_date, Period1, Period2, Period3, _
        Amount1, Amount2, Amount3, Recurring, Reattempt, Retry_at, Recur_times, _
        Username, Password, Subscr_id As String
	Dim totalQty As Integer

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Try
            ' assign posted variables to local variables
			Const line As String = ControlChars.Lf
			Const empty As String = ""
            Receiver_email = Request.Params("receiver_email")
			num_items = Request.Params("num_cart_items")
			For value As Integer = 1 To CInt(num_items)
	            'Item_name = Item_name & Request.Params("item_name" & CStr(value)) & ", "
	            'Item_number = Item_number & Request.Params("item_number" & CStr(value)) & ", "
	            'Quantity = Quantity & Request.Params("quantity" & CStr(value)) & ", "
				totalQty = totalQty + CInt(Request.Params("quantity" & CStr(value)))
				item_name = Request.Params("item_name" & CStr(value))
				item_name = item_name.Replace("      ",empty)
				item_name = item_name.Replace(line,empty)
				item_details = item_details & Request.Params("item_number" & CStr(value)) & vbTab & item_name & vbTab & Request.Params("quantity" & CStr(value)) & line
			Next
            Invoice = Request.Params("invoice")
            Custom = Request.Params("custom")
            Shipping = Request.Params("mc_shipping")
            Payment_status = Request.Params("payment_status")
            Pending_reason = Request.Params("pending_reason")
            Payment_date = Request.Params("payment_date")
            Payment_fee = Request.Params("payment_fee")
            Payment_gross = Request.Params("mc_gross")
            Txn_id = Request.Params("txn_id")
            Txn_type = Request.Params("txn_type")
            First_name = Request.Params("first_name")
            Last_name = Request.Params("last_name")
            Address_street = Request.Params("address_street")
            Address_city = Request.Params("address_city")
            Address_state = Request.Params("address_state")
            Address_zip = Request.Params("address_zip")
            Address_country = Request.Params("address_country")
            Address_status = Request.Params("address_status")
            Payer_email = Request.Params("payer_email")
            Payer_status = Request.Params("payer_status")
            Payment_type = Request.Params("payment_type")
            Notify_version = Request.Params("notify_version")
            Verify_sign = Request.Params("verify_sign")
            Subscr_date = Request.Params("subscr_date")   'Start date or cancellation date depending on whether transaction is "subscr_signup" or "subscr_cancel"
            Period1 = Request.Params("period1")           '(optional) Trial subscription interval in days, weeks, months, years (example: a 4 day interval is "period1: 4 d")
            Period2 = Request.Params("period2")           '(optional) Trial subscription interval in days, weeks, months, years
            Period3 = Request.Params("period3")           'Regular subscription interval in days, weeks, months, years
            Amount1 = Request.Params("amount1")           '(optional) Amount of payment for trial period1
            Amount2 = Request.Params("amount2")           '(optional) Amount of payment for trial period2
            Amount3 = Request.Params("amount3")           'Amount of payment for regular period3
            Recurring = Request.Params("recurring")       'Indicates whether regular rate recurs (1 is yes, 0 is no)
            Reattempt = Request.Params("reattempt")       'Indicates whether reattempts should occur upon payment failures (1 is yes, 0 is no)
            Retry_at = Request.Params("retry_at")         'Date we will retry failed subscription payment
            Recur_times = Request.Params("recur_times")   'How many payment installments will occur at the regular rate
            Username = Request.Params("username")         '(optional) Username generated by PayPal and given to subscriber to access the subscription
            Password = Request.Params("password")         '(optional) Password generated by PayPal and given to subscriber to access the subscription (password will be hashed).
            Subscr_id = Request.Params("subscr_id")       '(optional) ID generated by PayPal for the subscriber

            strToSend = Request.Form.ToString()
            'Create the string to post back to PayPal system to validate
            strToSend &= "&cmd=_notify-validate"

            'Initialize the WebRequest.
            'Dim myRequest As HttpWebRequest = CType(HttpWebRequest.Create("https://www.sandbox.paypal.com/cgi-bin/webscr"), HttpWebRequest)
            Dim myRequest As HttpWebRequest = CType(HttpWebRequest.Create("https://www.paypal.com/cgi-bin/webscr"), HttpWebRequest)
            myRequest.AllowAutoRedirect = False
            myRequest.Method = "POST"
            myRequest.ContentType = "application/x-www-form-urlencoded"

            'Create post stream
            Dim RequestStream As Stream = myRequest.GetRequestStream()
            Dim SomeBytes() As Byte = Encoding.UTF8.GetBytes(strToSend)

            RequestStream.Write(SomeBytes, 0, SomeBytes.Length)
            RequestStream.Close()

            'Send request and get response
            Dim myResponse As HttpWebResponse = CType(myRequest.GetResponse(), HttpWebResponse)

            If myResponse.StatusCode = HttpStatusCode.OK Then
                'Obtain a 'Stream' object associated with the response object.
                Dim ReceiveStream As Stream = myResponse.GetResponseStream()
                Dim encode As Encoding = System.Text.Encoding.GetEncoding("utf-8")

                'Pipe the stream to a higher level stream reader with the required encoding format. 
                Dim readStream As StreamReader = New StreamReader(ReceiveStream, encode)

                'Read result
                Dim Result As String = readStream.ReadLine()

                If Result = "INVALID" Then
                    MailUsTheOrder("Paypal String Invalid")
                    'Do something!
                ElseIf Result = "VERIFIED" Then
                    ' Check strTxn against the previous transaction
                    '
                    ' Do something!
                    ' check that Txn_id has not been previously processed
                    ' check that Receiver_email is an email address in your PayPal account
                    ' process payment

                    ' check that Payment_status=Completed
                    Select Case (Payment_status)
                        Case "Completed"        'The payment has been completed and the funds are successfully in your account balance
                            'If Receiver_email = "mail_1198951949_biz@wolex.com" Then
                            If Receiver_email = "sales@essedesigns.com" Then
                                Select Case (Txn_type)
                                    Case "web_accept", "cart"
                                        '"web_accept": The payment was sent by your customer via the Web Accept feature.
                                        '"cart": This payment was sent by your customer via the Shopping Cart feature
                                        MailUsTheOrder("Payment Completed")
                                        InsertPayment()

                                    Case "send_money"       'This payment was sent by your customer from the PayPal website, imports the "Send Money" tab
                                        MailUsTheOrder("PROCESS ME: Somebody sent us money!")

                                    Case "subscr_signup"    'This IPN is for a subscription sign-up
                                        MailUsTheOrder("PROCESS ME: Subscription signup.")

                                    Case "subscr_cancel"    'This IPN is for a subscription cancellation
                                        MailUsTheOrder("PROCESS ME: Subscription cancellation.")

                                    Case "subscr_failed"    'This IPN is for a subscription payment failure
                                        MailUsTheOrder("FAILURE: Subscription failed.")

                                    Case "subscr_payment"   'This IPN is for a subscription payment
                                        MailUsTheOrder("COOL: We got cash!")

                                    Case "subscr_eot"       'This IPN is for a subscription's end of term
                                        MailUsTheOrder("WHAT IS THIS?  Subscription end of term.")

                                End Select

                                Select Case (Address_status)
                                    Case "confirmed"    'Customer provided a Confirmed Address

                                    Case "unconfirmed"  'Customer provided an Unconfirmed Address

                                End Select

                                Select Case (Payer_status)
                                    Case "verified"         'Customer has a Verified U.S. PayPal account

                                    Case "unverified"       'Customer has an Unverified U.S. PayPal account

                                    Case "intl_verified"    'Customer has a Verified International PayPal account

                                    Case "intl_unverified"  'Customer has an Unverified International PayPal account

                                End Select

                                Select Case (Payment_type)
                                    Case "echeck"       'This payment was funded with an eCheck

                                    Case "instant"      'This payment was funded with PayPal balance, credit card, or Instant Transfer

                                End Select
                            Else
                                MailUsTheOrder("WEIRD: Someone is notifying us that the payments were received by someone else???")
                            End If


                        Case "Pending"          'The payment is pending - see the "pending reason" variable below for more information. Note: You will receive another instant payment notification when the payment becomes "completed", "failed", or "denied"

                            Select Case (Pending_reason)
                                Case "echeck"       'The payment is pending because it was made by an eCheck, which has not yet cleared

                                Case "intl"         'The payment is pending because you, the merchant, hold an international account and do not have a withdrawal mechanism. You must manually accept or deny this payment from your Account Overview

                                Case "verify"       'The payment is pending because you, the merchant, are not yet verified. You must verify your account before you can accept this payment

                                Case "address"      'The payment is pending because your customer did not include a confirmed shipping address and you, the merchant, have your Payment Receiving Preferences set such that you want to manually accept or deny each of these payments. To change your preference, go to the "Preferences" section of your "Profile"

                                Case "upgrade"      'The payment is pending because it was made via credit card and you, the merchant, must upgrade your account to Business or Premier status in order to receive the funds

                                Case "unilateral"   'The payment is pending because it was made to an email address that is not yet registered or confirmed

                                Case "other"        'The payment is pending for an "other" reason. For more information, contact customer service

                            End Select
                            MailUsTheOrder("PENDING: Order is waiting to be processed.")


                        Case "Failed"          'The payment has failed. This will only happen if the payment was made from your customer's bank account
                            MailUsTheOrder("FAILED: This only happens if the payment was made from our customer's bank account.")


                        Case "Denied"          'You, the merchant, denied the payment. This will only happen if the payment was previously pending due to one of the "pending reasons"
                            MailUsTheOrder("DENIED: We denied this payment.")
                    End Select
                End If
            End If

            'Close the response to free resources.
            myResponse.Close()        'If it is "OK"

        Catch ee As Exception
            'do error handling
			MailUsTheOrder(ee.Message)
        End Try
    End Sub

    Public Sub MailUsTheOrder(ByVal TagMsg As String)
        Const a As String = vbCrLf
        Dim from As String = "enquiries@essedesigns.com"
        Dim [to] As String = "sales@essedesigns.com"
        Dim subj As String = TagMsg
        Dim body As String = TagMsg & " " & a & a & "Order ID: " & OrderID & a _
                            & "Transaction ID:  " & Txn_id & a _
                            & "Transaction Type:" & Txn_type & a _
                            & "Payment Type:    " & Payment_type & a _
                            & "Payment Status:  " & Payment_status & a _
                            & "Pending Reason:  " & Pending_reason & a _
                            & "Payment Date:    " & Payment_date & a _
                            & "Receiver Email:  " & Receiver_email & a _
                            & "Invoice:         " & Invoice & a _
                            & "Item Details:    " & a & item_details & a _
                            & "Shipping:        " & Shipping & a _
                            & "Payment Gross:   " & Payment_gross & a _
                            & "Payment Fee:     " & Payment_fee & a & a _
                            & "Payer Details:   " & a & Payer_email & a _
                            & First_name & " " & Last_name & a _
                            & Address_street & a _
                            & Address_city & a _
                            & Address_state & a _
                            & Address_zip & a _
                            & Address_country & a & a _
                            & "Address Status:  " & Address_status & a _
                            & "Payer Status:    " & Payer_status & a _
                            & "Further info:    " & Custom & a _
                            & "Verify Sign:     " & Verify_sign & a _
                            & "Notify Version:  " & Notify_version & a & a _
                            & "EsseDesigns.com Team" & a
                            '& "Item Number:     " & Item_number & a _
                            '& "Item Name:       " & Item_name & a _
                            '& "Quantity:        " & Quantity & a _
                            '& "Subscriber Date: " & Subscr_date & a _
                            '& "Period 1:        " & Period1 & a _
                            '& "Period 2:        " & Period2 & a _
                            '& "Period 3:        " & Period3 & a _
                            '& "Amount 1:        " & Amount1 & a _
                            '& "Amount 2:        " & Amount2 & a _
                            '& "Amount 3:        " & Amount3 & a _
                            '& "Recurring:       " & Recurring & a _
                            '& "Reattempt:       " & Reattempt & a _
                            '& "Retry At:        " & Retry_at & a _
                            '& "Recur Times:     " & Recur_times & a _
                            '& "UserName:        " & Username & a _
                            '& "Password:        " & Password & a _
                            '& "Subscriber ID:   " & Subscr_id & a _
        Dim smtpServer As String = Application("mailserver")
        Dim message As New MailMessage(from, [to], subj, body)
        Dim smtpClient As New SmtpClient(smtpServer)
        smtpClient.UseDefaultCredentials = False
        Dim credentials As New NetworkCredential(Application("Username"), Application("Password"))
        smtpClient.Credentials = credentials
        smtpClient.Send(message)

    End Sub

    Function InsertPayment() As Integer
        Dim conClasf As SqlConnection
        Dim dapAds As SqlDataAdapter
        Dim dstAds As DataSet
        Dim rowAds As DataRow
        Dim bldAds As SqlCommandBuilder
        Dim strSQL As String

        conClasf = New SqlConnection(Application("appConn"))
        conClasf.Open()

        strSQL = "SELECT * FROM Payment WHERE 1=0"
        dapAds = New SqlDataAdapter(strSQL, conClasf)
        dstAds = New DataSet()
        dapAds.Fill(dstAds, "Payment")

        bldAds = New SqlCommandBuilder(dapAds)
        dapAds.InsertCommand = bldAds.GetInsertCommand()

        AddHandler dapAds.RowUpdated, _
                New SqlRowUpdatedEventHandler(AddressOf OnRowUpd)

        rowAds = dstAds.Tables("Payment").NewRow()
        rowAds("PaypalID") = Txn_id
        rowAds("PaymentDate") = Today
        rowAds("Items") = item_details
        rowAds("Quantity") = totalQty
        rowAds("PaymentAmount") = Decimal.Parse(Payment_gross)
        rowAds("Name") = First_name & " " & Last_name
        rowAds("Address") = Address_street & " " & Address_city & " " & Address_state & " " & Address_zip & " " & Address_country
        dstAds.Tables("Payment").Rows.Add(rowAds)

        dapAds.Update(dstAds, "Payment")
        conClasf.Close()
    End Function

    Sub OnRowUpd(ByVal sender As Object, _
    ByVal e As SqlRowUpdatedEventArgs)
        Dim cmdId As SqlCommand
        If e.StatementType = StatementType.Insert Then
            If e.TableMapping.DataSetTable = "Payment" Then
                cmdId = New SqlCommand("select @@identity", _
           e.Command.Connection)
                paymentId = cmdId.ExecuteScalar()
                e.Row("PaymentID") = paymentId
                OrderID = CStr(paymentId)
            End If
        End If
    End Sub

    'Function GetPaymentDetails(ByVal customerID As Integer) As System.Data.SqlClient.SqlDataReader
    '    Dim connectionString As String = Application("appConn")
    '    Dim sqlConnection As System.Data.SqlClient.SqlConnection = New System.Data.SqlClient.SqlConnection(connectionString)

    '    Dim queryString As String = "SELECT [Payment].* FROM [Payment] WHERE ([Payment].[CustomerID] = @CustomerID) AND ([Payment].[EndDate]" & _
    '        " > @enddate) AND ([Payment].[PaymentStatus] = @PaymentStatus)"
    '    Dim sqlCommand As System.Data.SqlClient.SqlCommand = New System.Data.SqlClient.SqlCommand(queryString, sqlConnection)

    '    sqlCommand.Parameters.Add("@CustomerID", System.Data.SqlDbType.Int).Value = customerID
    '    sqlCommand.Parameters.Add("@enddate", System.Data.SqlDbType.DateTime).Value = Today
    '    sqlCommand.Parameters.Add("@PaymentStatus", System.Data.SqlDbType.NVarChar).Value = "Standard"

    '    sqlConnection.Open()
    '    Dim dataReader As System.Data.SqlClient.SqlDataReader = sqlCommand.ExecuteReader(System.Data.CommandBehavior.CloseConnection)

    '    Return dataReader
    'End Function


End Class

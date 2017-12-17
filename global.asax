<SCRIPT LANGUAGE="VB" RUNAT="Server">

    Sub Application_OnStart()
        Application("appConn") = "server='tcp:host'; user id='mydb'; password='mypassword'; Database='myDB'"
		'"server='mysql'; user id='sa'; password=''; Database='mydb'"
		'"Data Source=tcp:host;Initial Catalog=myDB;User ID=myDB;Password=******;Integrated Security=False;"
        '"Server=host,1481;User=username;Password=password;Database=mydb"
        Application("mailserver") = ""
        Application("Username") = ""
        Application("Password") = ""
    End Sub

    Sub Session_OnStart()
        Dim objDT As System.Data.DataTable
        objDT = New System.Data.DataTable("Cart")
        objDT.Columns.Add("ID", GetType(Integer))
        objDT.Columns("ID").AutoIncrement = True
        objDT.Columns("ID").AutoIncrementSeed = 1

        objDT.Columns.Add("Product", GetType(String))
        objDT.Columns.Add("Type", GetType(String))
        objDT.Columns.Add("Title", GetType(String))
        objDT.Columns.Add("Item", GetType(String))
        objDT.Columns.Add("Colour", GetType(String))
        objDT.Columns.Add("Size", GetType(Integer))
        objDT.Columns.Add("Qty", GetType(Integer))
        objDT.Columns.Add("Cost", GetType(Decimal))
        objDT.Columns.Add("Postage", GetType(Decimal))
        objDT.Columns.Add("AdditionalPostage", GetType(Decimal))
        objDT.Columns.Add("PostageContinent", GetType(Decimal))
        objDT.Columns.Add("AdditionalPostageContinent", GetType(Decimal))
        objDT.Columns.Add("PostageWorld", GetType(Decimal))
        objDT.Columns.Add("AdditionalPostageWorld", GetType(Decimal))
 
        Session("Cart") = objDT
        Session("Verified") = 0
    End Sub
</SCRIPT>

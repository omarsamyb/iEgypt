<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Order_The_Contributor.aspx.cs" Inherits="Order_The_Contributor" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="Contributor ID" DataSourceID="SqlDataSource1">
                <Columns>
                    
                    <asp:BoundField DataField="Total Handled Requests throughout History" HeaderText="Total Handled Requests throughout History" ReadOnly="True" SortExpression="Total Handled Requests throughout History" />
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ddConnectionString %>" SelectCommand="Show_Possible_Contributors" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
        </div>
       
         <asp:Button ID = "button4" runat="server" Text="Profile Page" OnClick="button4_Click" />
    </form>
</body>
</html>

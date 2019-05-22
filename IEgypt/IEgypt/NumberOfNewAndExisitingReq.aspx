<%@ Page Language="C#" AutoEventWireup="true" CodeFile="NumberOfNewAndExisitingReq.aspx.cs" Inherits="Default2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        
        Show the number of new and existing requests created for new/original content(s) that belongs to a certain category.<br />
        <asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSource1" AutoGenerateColumns="False">
            <Columns>
                <asp:BoundField DataField="working_place" HeaderText="working_place" SortExpression="working_place" />
                <asp:BoundField DataField="category_type" HeaderText="category_type" SortExpression="category_type" />
                <asp:BoundField DataField="Cnt" HeaderText="Cnt" ReadOnly="True" SortExpression="Cnt" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ddConnectionString %>" DeleteCommand="Workingplace_Category_Relation" DeleteCommandType="StoredProcedure" InsertCommand="Workingplace_Category_Relation" InsertCommandType="StoredProcedure" SelectCommand="Workingplace_Category_Relation" SelectCommandType="StoredProcedure" UpdateCommand="Workingplace_Category_Relation" UpdateCommandType="StoredProcedure"></asp:SqlDataSource>
        <br />
        
    </form>
</body>
</html>

<%@ Page Language="C#" AutoEventWireup="true" CodeFile="NumberOfExistingRequests.aspx.cs" Inherits="NumberOfExistingRequests" %>

<!DOCTYPE html>



<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <p>
            Show number of existing requests for each original content
        </p>
        
        <asp:GridView ID="GridView1" runat="server" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" AutoGenerateColumns="False" DataKeyNames="ID" DataSourceID="SqlDataSource1" BackColor="LightGoldenrodYellow" BorderColor="Tan" BorderWidth="1px" CellPadding="2" ForeColor="Black" GridLines="None">
            <AlternatingRowStyle BackColor="PaleGoldenrod" />
            <Columns>
         
                <asp:BoundField DataField="Number of Requests" HeaderText="Number of Requests" ReadOnly="True" SortExpression="Number of Requests" />
            </Columns>
       
            <FooterStyle BackColor="Tan" />
            <HeaderStyle BackColor="Tan" Font-Bold="True" />
            <PagerStyle BackColor="PaleGoldenrod" ForeColor="DarkSlateBlue" HorizontalAlign="Center" />
            <SelectedRowStyle BackColor="DarkSlateBlue" ForeColor="GhostWhite" />
            <SortedAscendingCellStyle BackColor="#FAFAE7" />
            <SortedAscendingHeaderStyle BackColor="#DAC09E" />
            <SortedDescendingCellStyle BackColor="#E1DB9C" />
            <SortedDescendingHeaderStyle BackColor="#C2A47B" />
       
        </asp:GridView>
        
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ddConnectionString %>" SelectCommand="Most_Requested_Content" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
        
         <asp:Button ID = "button4" runat="server" Text="Profile Page" OnClick="button4_Click" />
    </form>
</body>
</html>

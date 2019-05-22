<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DeleteComent.aspx.cs" Inherits="DeleteComent" %>


<!DOCTYPE html>





<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server"> 
    <title> ShowAll Comments, Please Choose to Delete</title>
   
        
   </head>
    <body>

    <form id="form1" runat="server">
        <div>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" CellPadding="2" ForeColor="Black" GridLines="None" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" Width="288px" Height="100px" DataKeyNames="Viewer_id,original_content_id,date" DataSourceID="SqlDataSource1" BackColor="LightGoldenrodYellow" BorderColor="Tan" BorderWidth="1px">
                <AlternatingRowStyle BackColor="PaleGoldenrod" />
                <Columns>
                      
                
                    <asp:BoundField DataField="date" HeaderText="date" ReadOnly="True" SortExpression="date" />
                    <asp:BoundField DataField="text" HeaderText="text" SortExpression="text" />

                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkSelect1" Text="Delete" runat="server" CommandArgument='<%#Eval("Viewer_id") + ";" + Eval("original_content_id") + ";" + Eval("date")%>' OnClick="delete_Click"/>
                        </ItemTemplate>
                    </asp:TemplateField>
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
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ddConnectionString %>" SelectCommand="SELECT * FROM [Comment]"></asp:SqlDataSource>
            </div>
       

     
        
     
         <asp:Button ID = "button4" runat="server" Text="Profile Page" OnClick="button4_Click" />
     
    </form>
    
</body>
</html>

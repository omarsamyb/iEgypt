<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Filter.aspx.cs" Inherits="Filter" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>

            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="ID" DataSourceID="SqlDataSource1" Width="602px">
                <Columns>
     
                    <asp:CheckBoxField DataField="review_status" HeaderText="review_status" />
                    <asp:CheckBoxField DataField="filter_status" HeaderText="filter_status" />
                    <asp:BoundField DataField="rating" HeaderText="rating" />
                
                      <asp:TemplateField>
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkSelect1" Text="reviewer_filter" runat="server" CommandArgument='<%#Eval("ID") + ";" + Eval("reviewer_id") %>' OnClick="lnkSelect1_Click"/>
                        </ItemTemplate>
                    </asp:TemplateField>

                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ddConnectionString %>" SelectCommand="SELECT [ID], [content_manager_id], [reviewer_id], [review_status], [filter_status], [rating] FROM [Original_Content] WHERE ([review_status] IS NULL)">
            </asp:SqlDataSource>

        </div>
        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataKeyNames="ID" DataSourceID="SqlDataSource2">
            <Columns>
              
                <asp:CheckBoxField DataField="review_status" HeaderText="review_status" SortExpression="review_status" />
                <asp:CheckBoxField DataField="filter_status" HeaderText="filter_status" SortExpression="filter_status" />
                <asp:BoundField DataField="rating" HeaderText="rating" SortExpression="rating" />
           
                 <asp:TemplateField>
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkSelect2" Text="Manager_filter" runat="server" CommandArgument='<%#Eval("ID") + ";" + Eval("content_manager_id") %>' OnClick="lnkSelect2_Click"/>
                        </ItemTemplate>
                    </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ddConnectionString %>" SelectCommand="SELECT [ID], [content_manager_id], [reviewer_id], [review_status], [filter_status], [rating] FROM [Original_Content] WHERE (([review_status] = @review_status) AND ([filter_status] IS NULL))">
            <SelectParameters>
                <asp:Parameter DefaultValue="True" Name="review_status" Type="Boolean" />
            </SelectParameters>
        </asp:SqlDataSource>

         <asp:Button ID = "button4" runat="server" Text="Profile Page" OnClick="button4_Click" />
    </form>
</body>
</html>

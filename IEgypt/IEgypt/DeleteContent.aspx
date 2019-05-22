<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DeleteContent.aspx.cs" Inherits="DeleteContent" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="ID" DataSourceID="SqlDataSource1" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
                <Columns>
                   
                    <asp:BoundField DataField="link" HeaderText="link" SortExpression="link" />
                    <asp:BoundField DataField="uploaded_at" HeaderText="uploaded_at" SortExpression="uploaded_at" />
                    <asp:BoundField DataField="category_type" HeaderText="category_type" SortExpression="category_type" />
                    <asp:BoundField DataField="subcategory_name" HeaderText="subcategory_name" SortExpression="subcategory_name" />
                    <asp:BoundField DataField="type" HeaderText="type" SortExpression="type" />

                      <asp:TemplateField>
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkSelect1" Text="Delete" runat="server" CommandArgument='<%#Eval("ID") %>' OnClick="lnkSelect1_Click"/>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ddConnectionString %>" SelectCommand="SELECT * FROM [Content]"></asp:SqlDataSource>
        </div>
        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataKeyNames="ID" DataSourceID="SqlDataSource2" OnSelectedIndexChanged="GridView2_SelectedIndexChanged">
            <Columns>
               
                <asp:BoundField DataField="new_request_id" HeaderText="new_request_id" SortExpression="new_request_id" />
            
                 <asp:TemplateField>
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkSelect2" Text="Delete" runat="server" CommandArgument='<%#Eval("ID") %>' OnClick="lnkSelect2_Click"/>
                        </ItemTemplate>
                    </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ddConnectionString %>" SelectCommand="SELECT * FROM [New_Content]"></asp:SqlDataSource>
    
         <asp:Button ID = "button4" runat="server" Text="Profile Page" OnClick="button4_Click" />
    </form>
</body>
</html>

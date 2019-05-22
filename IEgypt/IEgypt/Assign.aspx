<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Assign.aspx.cs" Inherits="Assign" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>

            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="id" DataSourceID="SqlDataSource1">
                <Columns>
                    <asp:BoundField DataField="id" HeaderText="id" ReadOnly="True" SortExpression="id" InsertVisible="False" />
                    <asp:CheckBoxField DataField="accept_status" HeaderText="accept_status" SortExpression="accept_status" />
                    <asp:BoundField DataField="accepted_at" HeaderText="accepted_at" SortExpression="accepted_at" />

                     <asp:BoundField DataField="information" HeaderText="information" SortExpression="information" />
                    <asp:CheckBoxField DataField="specified" HeaderText="specified" SortExpression="specified" />
           
                    <asp:BoundField DataField="notif_obj_id" HeaderText="notif_obj_id" SortExpression="notif_obj_id" />
                 

                     <asp:TemplateField>
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkSelect1" Text="Assign" runat="server" CommandArgument='<%#Eval("id") %>' OnClick="lnkSelect1_Click"/>
                        </ItemTemplate>
                    </asp:TemplateField>

                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ddConnectionString %>" SelectCommand="SELECT [id], [accept_status], [accepted_at], [information], [specified], [viewer_id], [notif_obj_id], [contributer_id] FROM [New_Request] WHERE ([specified] = @specified)">
                <SelectParameters>
                    <asp:Parameter DefaultValue="False" Name="specified" Type="Boolean" />
                </SelectParameters>
            </asp:SqlDataSource>

        </div>
        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataKeyNames="Contributor ID" DataSourceID="SqlDataSource2">
            <Columns>
          
                <asp:BoundField DataField="Total Handled Requests throughout History" HeaderText="Total Handled Requests throughout History" ReadOnly="True" SortExpression="Total Handled Requests throughout History" />
           
             <asp:TemplateField>
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkSelect2" Text="Select contributor " runat="server" CommandArgument='<%#Eval("Contributor ID") %>' OnClick="lnkSelect2_Click"/>
                        </ItemTemplate>
                    </asp:TemplateField>
    
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ddConnectionString %>" SelectCommand="Show_Possible_Contributors" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
    
         <asp:Button ID = "button4" runat="server" Text="Profile Page" OnClick="button4_Click" />
    </form>
</body>
</html>

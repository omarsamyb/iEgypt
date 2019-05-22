<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ShowNotifications.aspx.cs" Inherits="ShowNotifications" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>

            <br />
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
                <Columns>
                 
                    <asp:BoundField DataField="ID" HeaderText="ID" SortExpression="ID" InsertVisible="False" ReadOnly="True" />
                    <asp:BoundField DataField="seen_at" HeaderText="seen_at" SortExpression="seen_at" />
                    <asp:BoundField DataField="sent_at" HeaderText="sent_at" SortExpression="sent_at" />
                    <asp:BoundField DataField="notified_person_id" HeaderText="notified_person_id" SortExpression="notified_person_id" />
                    <asp:BoundField DataField="notification_object_id" HeaderText="notification_object_id" SortExpression="notification_object_id" />
                    <asp:BoundField DataField="id1" HeaderText="id1" SortExpression="id1" InsertVisible="False" ReadOnly="True" />
                    <asp:BoundField DataField="city" HeaderText="city" SortExpression="city" />
                    <asp:BoundField DataField="description" HeaderText="description" SortExpression="description" />
                    <asp:BoundField DataField="entertainer" HeaderText="entertainer" SortExpression="entertainer" />
                    <asp:BoundField DataField="location" HeaderText="location" SortExpression="location" />
                    <asp:BoundField DataField="time" HeaderText="time" SortExpression="time" />
                    <asp:BoundField DataField="viewer_id" HeaderText="viewer_id" SortExpression="viewer_id" />
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ddConnectionString %>" SelectCommand="Show_Notification" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:SessionParameter DefaultValue="" Name="user_id" SessionField="ID" Type="Int32" />

                </SelectParameters>
            </asp:SqlDataSource>

             <asp:Button ID = "button4" runat="server" Text="Profile Page" OnClick="button4_Click" />

        </div>
    </form>
</body>
</html>

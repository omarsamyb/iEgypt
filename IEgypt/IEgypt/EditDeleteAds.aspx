<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EditDeleteAds.aspx.cs" Inherits="IEgypt.EditDeleteAds" %>

<!DOCTYPE html>

<html>
    <head runat = "server">
        <title>Edit-Delete Advertisements</title>
    </head>
    <body>
        <form id="form" runat="server">
            <asp:Button ID = "button1" runat="server" Text="Home" OnClick="button1Clicked" />
            <br />
            <br />
            <div id="edit" runat="server">
                <p>description</p>
                <br />
                <asp:TextBox ID="box1" runat="server"></asp:TextBox>
                <br />
                <p>location</p>
                <asp:TextBox ID="box2" runat="server"></asp:TextBox>
                <br />
            </div>
            <asp:Table ID="info" runat="server" Width="100%" BorderStyle="Solid" GridLines="Both" CellPadding="5" HorizontalAlign="Center">
            </asp:Table>
        </form>
    </body>
</html>
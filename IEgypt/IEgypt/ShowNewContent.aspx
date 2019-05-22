<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ShowNewContent.aspx.cs" Inherits="IEgypt.ShowNewContent" %>

<!DOCTYPE html>

<html>
    <head runat = "server">
        <title>ShowNewContent</title>
    </head>
    <body>
        <form id="form" runat="server">
            <asp:Button ID = "button1" runat="server" Text="Home" OnClick="button1Clicked" />
            <br />
            <br />
            <asp:Table ID="info" runat="server" Width="100%" BorderStyle="Solid" GridLines="Both" CellPadding="5" HorizontalAlign="Center">
            </asp:Table>
        </form>
    </body>
</html>

<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Search.aspx.cs" Inherits="IEgypt.Search" %>

<!DOCTYPE html>
<html>
    <head runat="server">
	    <title>Search</title>
    </head>
    <body>
        <form id="form" runat="server">
            <asp:Button ID="button1" runat="server" Text="Home" OnClick="button1Clicked" />
            <asp:Button ID="button2" runat="server" Text="Profile" OnClick="button2Clicked" />
        
            <asp:Table ID="table" runat="server" BorderStyle="Solid" GridLines="Both" CellPadding="5">

            </asp:Table>
            <asp:Panel ID="popup" Visible="false" runat="server" ScrollBars="Auto" Width="100%" Height="395px" >
                <asp:Label ID="popupText" runat="server" />
                <br />
                <asp:Button runat="server" Text="Ok, Got it!" OnClick="okButtonClicked" />
            </asp:Panel>
        </form>
    </body>
</html>



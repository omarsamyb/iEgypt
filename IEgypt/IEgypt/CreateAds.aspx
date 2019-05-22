<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CreateAds.aspx.cs" Inherits="CreateAds" %>

<!DOCTYPE html>

<html>
    <head runat = "server">
        <title>Create Advertisements</title>
    </head>
    <body>
        <form id="form" runat="server">
            <asp:Button ID = "button1" runat="server" Text="Home" OnClick="button1Clicked" />
            <br />
            <br />
            <div id="create" runat="server">
                <p>description</p>
                <br />
                <asp:TextBox ID="box1" runat="server"></asp:TextBox>
                <br />
                <p>location</p>
                <asp:TextBox ID="box2" runat="server"></asp:TextBox>
                <br />
                <asp:Button ID="btn" runat="server" Text="Create" OnClick="btnClicked" />
            </div>
        </form>
    </body>
</html>
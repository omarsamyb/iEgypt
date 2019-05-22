<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="IEgypt.Default" %>

<!DOCTYPE html>
<html>
<head runat="server">
	<title>IEgypt</title>
</head>
<body>
    <h1 style="text-align:center;">Welcome to IEgypt</h1>
    <br>
    <br>
	<form id="form1" runat="server">
        <div id="login_register" visible="true" runat="server">
            <asp:Button id="button1" runat="server" Text="Register" OnClick="button1Clicked" />            
            <asp:Button id="button2" runat="server" Text="Login" OnClick="button2Clicked" />
        </div>

		<div id="profile" visible ="false" runat="server">
            <asp:Button id="button3" runat="server" Text="Profile" OnClick="button3Clicked" />            
		</div>

        <div id="search" runat="server">
            <asp:Label runat="server" Text="Search Original Content by it's Type or Category" />
            <br />
            <asp:TextBox ID="typeTB" runat="server" PlaceHolder="Type" />
            <asp:TextBox ID="categoryTB" runat="server" PlaceHolder="Category" />
            <asp:Button id="button4" runat="server" Text="Search" OnClick="button4Clicked" />
            <br />
            <asp:Label runat="server" Text="Search Original Content by it's Contributor" />
            <br />
            <asp:TextBox ID="contributorName" runat="server" PlaceHolder="Contributor's Full Name" />
            <asp:Button id="button5" runat="server" Text="Search" OnClick="button5Clicked" />
            <br />
            <asp:Label runat="server" Text="Search Contributor by his Full Name" />
            <br />
            <asp:TextBox ID="nameTB" runat="server" PlaceHolder="Contributor's Full Name" />
            <asp:Button id="button6" runat="server" Text="Search" OnClick="button6Clicked" />
            <br />
            <asp:Label runat="server" Text="Or Show All Contributors Ordered by Highest Years of Experience" />
            <br />
            <asp:Button id="button7" runat="server" Text="Order" OnClick="button7Clicked" />
        </div>

        <asp:Panel ID="popup" Visible="false" runat="server" ScrollBars="Auto" Width="100%" Height="395px" >
            <asp:Label ID="popupText" runat="server" />
            <br />
            <asp:Button runat="server" Text="Ok, Got it!" OnClick="okButtonClicked" />
        </asp:Panel>
    </form>
</body>
</html>

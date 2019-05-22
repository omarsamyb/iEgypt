<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="IEgypt.Login" %>

<!DOCTYPE html>
<html>
<head runat="server">
	<title>Login</title>
</head>
<body>
	<form id="form1" runat="server">
        <p>Email</p>
        <asp:TextBox id="email_login" runat="server"/>
        <br>
        <p>Password</p>
        <asp:TextBox id="password_login" runat="server"/>
        <br>
        <asp:Button id="login_button" runat="server" Text="Login" OnClick="login_buttonClicked" />
        <asp:Button id="cancel_button" runat="server" Text="Cancel" OnClick="cancel_buttonClicked"/>
        <asp:Panel ID="popup" Visible="false" runat="server" ScrollBars="Auto" Width="100%" Height="395px" >
            <asp:Label ID="popupText" runat="server" />
            <br />
            <asp:Button runat="server" Text="Ok, Got it!" OnClick="okButtonClicked" />
        </asp:Panel>
	</form>
</body>
</html>
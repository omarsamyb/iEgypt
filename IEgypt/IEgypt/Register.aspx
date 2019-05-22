<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Register.aspx.cs" Inherits="IEgypt.Register" %>

<!DOCTYPE html>
<html>
<head runat="server">
	<title>Register</title>
</head>
<body>
	<form id="form" runat="server">
        <p>Type *</p>
        <asp:DropDownList id="typeList" runat="server" OnSelectedIndexChanged="typeList_SelectedIndexChanged" AutoPostBack="true">
            <asp:ListItem Text="Select Type" Value="-1" Disabled="disabled"></asp:ListItem>
            <asp:ListItem Text="Viewer" Value="1"></asp:ListItem>
            <asp:ListItem Text="Contributor" Value="2"></asp:ListItem>
            <asp:ListItem Text="Authorized Reviewer" Value="3"></asp:ListItem>
            <asp:ListItem Text="Content Manager" Value="4"></asp:ListItem>
        </asp:DropDownList>
        <br />
        <p>Email *</p>
        <asp:TextBox id="emailTB" runat="server"/>
        <br />
        <p>Password *</p>
        <asp:TextBox id="passwordTB" runat="server"/>
        <br />
        <p>First Name *</p>
        <asp:TextBox id="fnTB" runat="server"/>
        <br />
        <p>Middle Name *</p>
        <asp:TextBox id="mnTB" runat="server"/>
        <br />
        <p>Last Name *</p>
        <asp:TextBox id="lnTB" runat="server"/>
        <br />
        <p>Birth Date *</p>
        <asp:TextBox id="birthTB" runat="server" />
        <br />
        <div id="viewer" style="display:none" runat="server">
            <p>Working Place Name *</p>
            <asp:TextBox id="wpnTB" runat="server"/>
            <br />
            <p>Working Place Type *</p>
            <asp:TextBox id="wptTB" runat="server"/>
            <br />
            <p>Working Place Description</p>
            <asp:TextBox id="wpdTB" runat="server"/>
            <br />
        </div>
        <div id="contributor" style="display:none" runat="server">
            <p>Specialization</p>
            <asp:TextBox id="specializationTB" runat="server"/>
            <br />
            <p>Portofolio Link</p>
            <asp:TextBox id="plTB" runat="server"/>
            <br />
            <p>No. of Experience Years</p>
            <asp:TextBox id="expTB" runat="server"/>
            <br />
        </div>
        <div id="staff" style="display:none" runat="server">
            <p>Hire Date</p>
            <asp:TextBox id="hdTB" runat="server"/>
            <br />
            <p>Working Hours *</p>
            <asp:TextBox id="whTB" runat="server"/>
            <br />
            <p>Payment Rate *</p>
            <asp:TextBox id="prTB" runat="server"/>
            <br />
        </div>
        <asp:Button id="register_button" runat="server" Text="Register" OnClick="register_buttonClicked"/>
        <asp:Button id="cancel_button" runat="server" Text="Cancel" OnClick="cancel_buttonClicked"/>
        <asp:Panel ID="popup" Visible="false" runat="server" ScrollBars="Auto" Width="100%" Height="395px" >
            <asp:Label ID="popupText" runat="server" />
            <br />
            <asp:Button runat="server" Text="Ok, Got it!" OnClick="okButtonClicked" />
        </asp:Panel>

	</form>
</body>
</html>
<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Edit.aspx.cs" Inherits="IEgypt.Edit" %>

<!DOCTYPE html>

<html>
<head runat="server">
	<title>Edit</title>
</head>
<body>
    <form runat="server">
        <p>Email</p>
        <asp:TextBox id="emailTB" runat="server"/>
        <br />
        <p>Password</p>
        <asp:TextBox id="passwordTB" runat="server"/>
        <br />
        <p>First Name</p>
        <asp:TextBox id="fnTB" runat="server"/>
        <br />
        <p>Middle Name</p>
        <asp:TextBox id="mnTB" runat="server"/>
        <br />
        <p>Last Name</p>
        <asp:TextBox id="lnTB" runat="server"/>
        <br />
        <p>Birth Date</p>
        <asp:TextBox id="birthTB" runat="server" />
        <br />
        <div id="viewer" Visible="false" runat="server">
            <p>Working Place Name</p>
            <asp:TextBox id="wpnTB" runat="server"/>
            <br />
            <p>Working Place Type</p>
            <asp:TextBox id="wptTB" runat="server"/>
            <br />
            <p>Working Place Description</p>
            <asp:TextBox id="wpdTB" runat="server"/>
            <br />
        </div>
        <div id="contributor" Visible="false" runat="server">
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
        <div id="staff" Visible="false" runat="server">
            <p>Hire Date</p>
            <asp:TextBox id="hdTB" runat="server"/>
            <br />
            <p>Working Hours</p>
            <asp:TextBox id="whTB" runat="server"/>
            <br />
            <p>Payment Rate</p>
            <asp:TextBox id="prTB" runat="server"/>
            <br />
        </div>
        <br />
        <div id="manager" Visible="false" runat="server">
            <p>My Content Type Speciality</p>
            <asp:DropDownList id="typeList" runat="server">
            <asp:ListItem Text="Unchanged" Value="-1"></asp:ListItem>
            </asp:DropDownList>
        </div>
        <br />
        <br />
        <asp:Button id="edit_button" runat="server" Text="Edit" OnClick="edit_buttonClicked"/>
        <asp:Button id="cancel_button" runat="server" Text="Cancel" OnClick="cancel_buttonClicked"/>
        
        <asp:Panel ID="popup" Visible="false" runat="server" ScrollBars="Auto" Width="100%" Height="395px" >
            <asp:Label ID="popupText" runat="server" />
            <br />
            <asp:Button runat="server" Text="Ok, Got it!" OnClick="okButtonClicked" />
        </asp:Panel>
        </form>
</body>
</html>

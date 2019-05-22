<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Profile.aspx.cs" Inherits="IEgypt._Profile" %>

<!DOCTYPE html>

<html>
    <head runat = "server">
        <title>Profile</title>
    </head>
    <body>
        <form id="form" runat="server">
            <asp:Button ID = "button1" runat="server" Text="Home" OnClick="button1Clicked" />
            <asp:Button ID = "button2" runat="server" Text="Edit Profile" OnClick="button2Clicked" />
            <asp:Button ID = "button3" runat="server" Text="Deactivate Account" OnClick="button3Clicked" />
            <asp:Button ID = "button4" runat="server" Text="Sign Out" OnClick="button4Clicked" />
            <br />
            <br />
            <div id="viewer" runat="server" visible="false">
                <asp:Button ID = "button5" runat="server" Text="Create Event" OnClick="button5Clicked" />
                <asp:Button ID = "button6" runat="server" Text="Apply Existing Request" OnClick="button6Clicked" />
                <asp:Button ID = "button7" runat="server" Text="Apply New Request" OnClick="button7Clicked" />
                <asp:Button ID = "button8" runat="server" Text="Delete a New Request" OnClick="button8Clicked" />
                <asp:Button ID = "button9" runat="server" Text="Review Content" OnClick="button9Clicked" />
                <asp:Button ID = "button10" runat="server" Text="Add a Comment" OnClick="button10Clicked" />
                <asp:Button ID = "button11" runat="server" Text="Edit/Delete a Comment" OnClick="button11Clicked" />
                <asp:Button ID = "button12" runat="server" Text="Create an Advertisment" OnClick="button12Clicked" />
                <asp:Button ID = "button13" runat="server" Text="Edit/Delete my Ads." OnClick="button13Clicked" />
                <asp:Button ID = "button14" runat="server" Text="Show my New Content" OnClick="button14Clicked" />
            </div>
            <div id="contributor" runat="server" visible="false">
                <asp:Button ID = "button15" runat="server" Text="Upload Original Content" OnClick="button15Clicked" />
                <asp:Button ID = "button16" runat="server" Text="Recieve new Requests" OnClick="button16Clicked" />
                <asp:Button ID = "button17" runat="server" Text="Accept/Reject new Requests" OnClick="button17Clicked" />
                <asp:Button ID = "button18" runat="server" Text="Send/Recieve Messages" OnClick="button18Clicked" />
                <asp:Button ID = "button19" runat="server" Text="Upload New Content" OnClick="button19Clicked" />
                <asp:Button ID = "button20" runat="server" Text="Delete my Content" OnClick="button20Clicked" />
                <asp:Button ID = "button21" runat="server" Text="Show Notifications" OnClick="button21Clicked" />
                <asp:Button ID = "button22" runat="server" Text="Show Events" OnClick="button22Clicked" />
                <asp:Button ID = "button23" runat="server" Text="Show Advertisments" OnClick="button23Clicked" />
            </div>
            <div id="staff" runat="server" visible="false">
                <asp:Button ID = "button24" runat="server" Text="Filter Content" OnClick="button24Clicked" />
                <asp:Button ID = "button25" runat="server" Text="Create new (Sub)-Category" OnClick="button25Clicked" />
                <asp:Button ID = "button26" runat="server" Text="Create Content Type" OnClick="button26Clicked" />
                <asp:Button ID = "button27" runat="server" Text="Order Existing Requests" OnClick="button27Clicked" />
                <asp:Button ID = "button28" runat="server" Text="Show Requests in Relation to Category&Working Place Type" OnClick="button28Clicked" />
                <asp:Button ID = "button29" runat="server" Text="Show Notifications" OnClick="button29Clicked" />
                <asp:Button ID = "button30" runat="server" Text="Delete a Comment" OnClick="button30Clicked" />
                <asp:Button ID = "button31" runat="server" Text="Delete a Content" OnClick="button31Clicked" />
                <asp:Button ID = "button32" runat="server" Text="Order Contributors" OnClick="button32Clicked" />
                <asp:Button ID = "button33" runat="server" Text="Assign a Contributor to a Request" OnClick="button33Clicked" />
            </div>
       
            <br />
            <br />
            <asp:Table ID="info" runat="server" Width="100%" BorderStyle="Solid" GridLines="Both" CellPadding="5" HorizontalAlign="Center">

            </asp:Table>
        </form>
    </body>
</html>

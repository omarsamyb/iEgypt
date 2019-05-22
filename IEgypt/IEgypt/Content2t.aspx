<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Content2t.aspx.cs" Inherits="Content2t" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>

          <asp:TextBox id="content_type" runat="server"/>

             <asp:Button id="button2" runat="server" Text="add content" OnClick="button2Clicked" />

        <br />
        
        <asp:Button ID = "button4" runat="server" Text="Profile Page" OnClick="button4_Click" />
       
        </div>
    </form>
</body>
</html>

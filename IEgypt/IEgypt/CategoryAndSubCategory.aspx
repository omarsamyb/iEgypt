<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CategoryAndSubCategory.aspx.cs" Inherits="CategoryAndSubCategory" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
             <p>
            CategoryAndSubCategory</p>
        <p>
            <asp:TextBox ID="subCategory_type" runat="server"></asp:TextBox>
            <asp:TextBox ID="subCategory_name" runat="server"></asp:TextBox>
        </p>
        <p>
            <asp:Button ID="Button3" runat="server" Height="26px" OnClick="Button3_Click" Text="Add" Width="118px" />
        </p>
        </div>

         <asp:Button ID = "button4" runat="server" Text="Profile Page" OnClick="button4_Click" />
    </form>
</body>
</html>

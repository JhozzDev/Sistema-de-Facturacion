<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="formLogin.aspx.cs" Inherits="SistemaElectronico.Login.FormLogin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Sistema de facturacion</title>
<link rel="shortcut icon" type="image/x-icon" href="../Imagenes/Favicon.png"/>
    <link rel="stylesheet" href="../AppThemes/LoginForm/FormLoginCss.css"/>
</head>    
<body>
    <form id="form1" runat="server">
        

        <div id="bg" class="bg">
            <h1>
                Sistema Electronico de Facturacion
            </h1>
           <asp:Image ID="ImageCajasAlmacen" runat="server" ImageUrl="~/Imagenes/CajasAlmacen.png"/>
        </div>

        <div class="Container">
        <asp:Panel ID="PanelAcceso" runat="server" BackImageUrl="~/Imagenes/FondoLogin.png" class="Acceso">

         
            <asp:Panel ID="PanelControl" runat="server" class="HeaderLog">
                <asp:Label ID="LabelControl" runat="server" Text="Control de Acceso"></asp:Label> 
                
            </asp:Panel>
<div class="middleContent">
           <asp:Image ID="ImageCerradura" runat="server" ImageUrl="~/Imagenes/CerraduraRoja.png"/>

            <div class="rightContent">
            <asp:TextBox ID="TxtUser" runat="server" ToolTip="Introduzca su usuario" AutoCompleteType="Disabled" placeholder="Ingrese su Usuario"></asp:TextBox>     
            <asp:TextBox ID="TxtClave" runat="server" ToolTip="Introduzca la contrasena" AutoCompleteType="Disabled" placeholder="Ingrese su Usuario"></asp:TextBox>
            <asp:Button ID="BtnAceptar" runat="server" Text="Aceptar" OnClick="BtnAceptar_Click"
                /></div>
                </div>
            <asp:Panel ID="PanelMensaje" runat="server" class="mensaje">
            <asp:Label ID="LabelMensaje" runat="server" Text="Mensaje:"></asp:Label>
            </asp:Panel>
          


        </asp:Panel>
 </div>
    </form>
</body>
</html>

<%@ Page Title="" Language="C#" MasterPageFile="~/Mantenimiento/MpMantenimiento.master" AutoEventWireup="true" CodeBehind="formEmpresa.aspx.cs" Inherits="SistemaElectronico.Mantenimiento.FormEmpresa" %>

<asp:Content ContentPlaceHolderID="contenidoPrincipalMantenimiento" runat="server" class="bodega">

<asp:Panel ID="PnlBotonera" runat="server" CssClass="btns">
     <asp:Button ID="ImgNuevo" runat="server" OnClick="ImgNuevo_Click" Text="Nuevo"/>
    <asp:Button ID="ImgAceptar" runat="server" OnClick="ImgAceptar_Click" Text="Aceptar"/>
    <asp:Button ID="ImgCancelar" runat="server" OnClick="ImgCancelar_Click" Text="Cancelar"/>
    <asp:Button ID="ImgBuscar" runat="server" OnClick="ImgBuscar_Click" Text="Buscar"/>
    <asp:Button ID="ImgModificar" runat="server" OnClick="ImgModificar_Click" Text="Modificar"/>
</asp:Panel>

<asp:Panel runat="server" class="aaas">
  
    <asp:Panel ID="PnlMensaje" runat="server" class="msg">
        <asp:Image ID="ImgBarras" runat="server" ImageUrl="~/Imagenes/BarraAzul.png"></asp:Image>
        <asp:Label ID="LblMensaje" runat="server" Text="Mensaje: "></asp:Label> 
    </asp:Panel>

<asp:Panel ID="PnlDatos" runat="server" class="btns2">
        
       
        <asp:Label ID="LblNombre" runat="server" Text="Nombre: "></asp:Label>
        <asp:TextBox ID="TxtNombre" runat="server" ></asp:TextBox> 
    <asp:Label ID="LblDireccion" runat="server" Text="Direccion: "></asp:Label>
        <asp:TextBox ID="TxtDireccion" runat="server"></asp:TextBox>
        <asp:Label ID="LblTelefono" runat="server" Text="Telefono:"></asp:Label>
        <asp:TextBox ID="TxtTelefono" runat="server"></asp:TextBox>
     <asp:Label ID="LblRnc" runat="server" Text="Rnc:"></asp:Label> <asp:TextBox ID="TxtRnc" runat="server"></asp:TextBox>

  <asp:FileUpload runat="server" ID="fileUpload"></asp:FileUpload>    
  <asp:Image ImageUrl=" " ID="ImgPreview" runat="server" Height="300" Width="300"/>
</asp:Panel><h3>Crear Empresa</h3>
   </asp:Panel>
    


    

    <asp:ScriptManager ID="ScriptManager1" runat="server">    
</asp:ScriptManager>
   
</asp:Content>

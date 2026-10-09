<%@ Page Title="" Language="C#" MasterPageFile="~/Mantenimiento/MpMantenimiento.master" AutoEventWireup="true" CodeBehind="formClientes.aspx.cs" Inherits="SistemaElectronico.Mantenimiento.FormClientes" %>

<asp:Content ContentPlaceHolderID="contenidoPrincipalMantenimiento" runat="server" class="bodega">

<asp:Panel ID="PnlBotonera" runat="server" CssClass="btns">
     <asp:Button ID="ImgNuevo" runat="server" OnClick="ImgNuevo_Click" Text="Nuevo"/>
    <asp:Button ID="ImgAceptar" runat="server" OnClick="ImgAceptar_Click" Text="Aceptar"/>
    <asp:Button ID="ImgCancelar" runat="server" OnClick="ImgCancelar_Click" Text="Cancelar"/>
    <asp:Button ID="ImgBuscar" runat="server" OnClick="ImgBuscar_Click" Text="Buscar"/>
    <asp:Button ID="ImgModificar" runat="server" OnClick="ImgModificar_Click" Text="Modificar"/>
</asp:Panel>

<asp:Panel runat="server" class="aaas">
    <asp:Panel ID="PnlGridView" runat="server" CssClass="view">
        <asp:GridView ID="GridView1" scrollbar="auto" ToolTip="Buscar registro" runat="server" AutoGenerateColumns="false" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" CssClass="GridView1">

      
        <Columns>
        <asp:CommandField ButtonType="Image" ShowSelectButton="true" SelectImageUrl="~/Imagenes/Seleccion.png" />
        <asp:BoundField DataField="cli_codigo" HeaderText="Codigo" />
        <asp:BoundField DataField="cli_tipo" HeaderText="Tipo" />
        <asp:BoundField DataField="cli_nombre" HeaderText="Nombre" />
        <asp:BoundField DataField="cli_rnc" HeaderText="Rnc" />
        <asp:BoundField DataField="cli_contacto" HeaderText="Contacto" />
        <asp:BoundField DataField="cli_cargo" HeaderText="Cargo" />
        <asp:BoundField DataField="cli_pagina" HeaderText="Pagina" />
        <asp:BoundField DataField="cli_apellido" HeaderText="Apellido" />
        <asp:BoundField DataField="cli_cedula" HeaderText="Cedula" />
        <asp:BoundField DataField="cli_direccion" HeaderText="Direccion" />
        <asp:BoundField DataField="cli_telefono" HeaderText="Telefono" />
        <asp:BoundField DataField="cli_celular" HeaderText="Celular" />
        <asp:BoundField DataField="cli_correo" HeaderText="Correo" />
        <asp:BoundField DataField="cli_pais" HeaderText="Pais" />
        <asp:BoundField DataField="cli_provincia" HeaderText="Provincia" />
        </Columns>    
        </asp:GridView>
    </asp:Panel>
    <asp:Panel ID="PnlMensaje" runat="server" CssClass="msg">
        <asp:Image ID="ImgBarras" runat="server" ImageUrl="~/Imagenes/BarraAzul.png"></asp:Image>
        <asp:Label ID="LblMensaje" runat="server" Text="Mensaje: "></asp:Label>
    </asp:Panel>

<asp:Panel ID="PnlDatos" runat="server" CssClass="btns2">
        
        
        <asp:Label ID="LblCodigo" runat="server" Text="Codigo: "></asp:Label>
        <asp:TextBox ID="TxtCodigo" runat="server"></asp:TextBox>
        <asp:Label ID="LblTipo" runat="server" Text="Tipo: "></asp:Label>
        <asp:TextBox ID="TxtTipo" runat="server"></asp:TextBox>
        <asp:Label ID="LblNombre" runat="server" Text="Nombre: "></asp:Label>
        <asp:TextBox ID="TxtNombre" runat="server" ></asp:TextBox> 
        <asp:Label ID="LblApellido" runat="server" Text="Apellido: "></asp:Label>
        <asp:TextBox ID="TxtApellido" runat="server"></asp:TextBox>
        <asp:Label ID="LblRnc" runat="server" Text="Rnc: "></asp:Label>
        <asp:TextBox ID="TxtRnc" runat="server"></asp:TextBox>
        <asp:Label ID="LblCedula" runat="server" Text="Cedula: "></asp:Label>
        <asp:TextBox ID="TxtCedula" runat="server"></asp:TextBox>
        <asp:Label ID="LblContacto" runat="server" Text="Contacto: "></asp:Label>
        <asp:TextBox ID="TxtContacto" runat="server"></asp:TextBox>
        <asp:Label ID="LblCargo" runat="server" Text="Cargo: "></asp:Label>
        <asp:TextBox ID="TxtCargo" runat="server"></asp:TextBox>
        <asp:Label ID="LblPagina" runat="server" Text="Pagina: "></asp:Label>
        <asp:TextBox ID="TxtPagina" runat="server"></asp:TextBox>
        <asp:Label ID="LblDireccion" runat="server" Text="Direccion: "></asp:Label>
        <asp:TextBox ID="TxtDireccion" runat="server"></asp:TextBox>
        <asp:Label ID="LblTelefono" runat="server" Text="Telefono:"></asp:Label>
        <asp:TextBox ID="TxtTelefono" runat="server"></asp:TextBox>
        <asp:Label ID="LblCelular" runat="server" Text="Celular:"></asp:Label>
        <asp:TextBox ID="TxtCelular" runat="server"></asp:TextBox>
        <asp:Label ID="LblCorreo" runat="server" Text="Correo:"></asp:Label>
        <asp:TextBox ID="TxtCorreo" runat="server"></asp:TextBox>
        <asp:Label ID="LblPais" runat="server" Text="Pais:"></asp:Label>
        <asp:TextBox ID="TxtPais" runat="server"></asp:TextBox>
        <asp:Label ID="LblProvincia" runat="server" Text="Provincia:"></asp:Label>
        <asp:TextBox ID="TxtProvincia" runat="server"></asp:TextBox>

        <asp:FileUpload runat="server" ID="fileUpload"></asp:FileUpload>
        <asp:Image ImageUrl="" ID="ImgPreview" runat="server" Height="300" Width="300"/>
</asp:Panel><h3>Crear cliente</h3>
   </asp:Panel>
    
    

    <asp:Panel ID="PnlCuadroGridView" runat="server" ToolTip="Buscar registros" >
  
    </asp:Panel>

    <asp:ScriptManager ID="ScriptManager1" runat="server">    
</asp:ScriptManager>
    <asp:Timer ID="Timer1" runat="server" OnTick="Timer1_Tick" Enabled="false" Interval="4000"/>

</asp:Content>

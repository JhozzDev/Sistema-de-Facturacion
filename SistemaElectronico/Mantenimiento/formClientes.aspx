<%@ Page Title="" Language="C#" MasterPageFile="~/Mantenimiento/MpMantenimiento.master" AutoEventWireup="true" CodeBehind="formClientes.aspx.cs" Inherits="SistemaElectronico.Mantenimiento.FormClientes" %>

<asp:Content ContentPlaceHolderID="contenidoPrincipalMantenimiento" runat="server" class="bodega">

    <div class="pagina-mantenimiento">

        <asp:Panel ID="PnlBotonera" runat="server" CssClass="btns">
            <asp:Button ID="ImgNuevo" runat="server" OnClick="ImgNuevo_Click" Text="Nuevo" />
            <asp:Button ID="ImgAceptar" runat="server" OnClick="ImgAceptar_Click" Text="Aceptar" />
            <asp:Button ID="ImgCancelar" runat="server" OnClick="ImgCancelar_Click" Text="Cancelar" />
            <asp:Button ID="ImgBuscar" runat="server" OnClick="ImgBuscar_Click" Text="Buscar" />
            <asp:Button ID="ImgModificar" runat="server" OnClick="ImgModificar_Click" Text="Modificar" />
        </asp:Panel>

        <asp:Panel ID="PnlMensaje" runat="server" CssClass="msg">
            <asp:Image ID="ImgBarras" runat="server" ImageUrl="~/Imagenes/BarraAzul.png"></asp:Image>
            <asp:Label ID="LblMensaje" runat="server" Text="Mensaje: "></asp:Label>
        </asp:Panel>

        <div class="form-card">
            <h3>Crear cliente</h3>

            <asp:Panel ID="PnlDatos" runat="server" CssClass="campos">

                <div class="campo">
                    <asp:Label ID="LblCodigo" runat="server" Text="Codigo: " AssociatedControlID="TxtCodigo"></asp:Label>
                    <asp:TextBox ID="TxtCodigo" runat="server"></asp:TextBox>
                </div>
                <div class="campo">
                    <asp:Label ID="LblTipo" runat="server" Text="Tipo: " AssociatedControlID="TxtTipo"></asp:Label>
                    <asp:TextBox ID="TxtTipo" runat="server"></asp:TextBox>
                </div>
                <div class="campo">
                    <asp:Label ID="LblNombre" runat="server" Text="Nombre: " AssociatedControlID="TxtNombre"></asp:Label>
                    <asp:TextBox ID="TxtNombre" runat="server"></asp:TextBox>
                </div>
                <div class="campo">
                    <asp:Label ID="LblApellido" runat="server" Text="Apellido: " AssociatedControlID="TxtApellido"></asp:Label>
                    <asp:TextBox ID="TxtApellido" runat="server"></asp:TextBox>
                </div>
                <div class="campo">
                    <asp:Label ID="LblRnc" runat="server" Text="Rnc: " AssociatedControlID="TxtRnc"></asp:Label>
                    <asp:TextBox ID="TxtRnc" runat="server"></asp:TextBox>
                </div>
                <div class="campo">
                    <asp:Label ID="LblCedula" runat="server" Text="Cedula: " AssociatedControlID="TxtCedula"></asp:Label>
                    <asp:TextBox ID="TxtCedula" runat="server"></asp:TextBox>
                </div>
                <div class="campo">
                    <asp:Label ID="LblContacto" runat="server" Text="Contacto: " AssociatedControlID="TxtContacto"></asp:Label>
                    <asp:TextBox ID="TxtContacto" runat="server"></asp:TextBox>
                </div>
                <div class="campo">
                    <asp:Label ID="LblCargo" runat="server" Text="Cargo: " AssociatedControlID="TxtCargo"></asp:Label>
                    <asp:TextBox ID="TxtCargo" runat="server"></asp:TextBox>
                </div>
                <div class="campo">
                    <asp:Label ID="LblPagina" runat="server" Text="Pagina: " AssociatedControlID="TxtPagina"></asp:Label>
                    <asp:TextBox ID="TxtPagina" runat="server"></asp:TextBox>
                </div>
                <div class="campo">
                    <asp:Label ID="LblDireccion" runat="server" Text="Direccion: " AssociatedControlID="TxtDireccion"></asp:Label>
                    <asp:TextBox ID="TxtDireccion" runat="server"></asp:TextBox>
                </div>
                <div class="campo">
                    <asp:Label ID="LblTelefono" runat="server" Text="Telefono:" AssociatedControlID="TxtTelefono"></asp:Label>
                    <asp:TextBox ID="TxtTelefono" runat="server"></asp:TextBox>
                </div>
                <div class="campo">
                    <asp:Label ID="LblCelular" runat="server" Text="Celular:" AssociatedControlID="TxtCelular"></asp:Label>
                    <asp:TextBox ID="TxtCelular" runat="server"></asp:TextBox>
                </div>
                <div class="campo">
                    <asp:Label ID="LblCorreo" runat="server" Text="Correo:" AssociatedControlID="TxtCorreo"></asp:Label>
                    <asp:TextBox ID="TxtCorreo" runat="server"></asp:TextBox>
                </div>
                <div class="campo">
                    <asp:Label ID="LblPais" runat="server" Text="Pais:" AssociatedControlID="TxtPais"></asp:Label>
                    <asp:TextBox ID="TxtPais" runat="server"></asp:TextBox>
                </div>
                <div class="campo">
                    <asp:Label ID="LblProvincia" runat="server" Text="Provincia:" AssociatedControlID="TxtProvincia"></asp:Label>
                    <asp:TextBox ID="TxtProvincia" runat="server"></asp:TextBox>
                </div>

                <div class="campo campo-full">
                    <asp:Label ID="LblImagen" runat="server" Text="Imagen:" AssociatedControlID="fileUpload"></asp:Label>
                    <asp:FileUpload runat="server" ID="fileUpload"></asp:FileUpload>
                    <asp:Image ImageUrl="" ID="ImgPreview" runat="server" />
                </div>

            </asp:Panel>
        </div>

        <asp:Panel ID="PnlCuadroGridView" runat="server" ToolTip="Buscar registros">
            <asp:Panel ID="PnlGridView" runat="server" CssClass="view">
                <asp:GridView ID="GridView1" runat="server" ToolTip="Buscar registro" AutoGenerateColumns="false" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" CssClass="GridView1">
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
        </asp:Panel>

        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <asp:Timer ID="Timer1" runat="server" OnTick="Timer1_Tick" Enabled="false" Interval="4000" />

    </div>

</asp:Content>

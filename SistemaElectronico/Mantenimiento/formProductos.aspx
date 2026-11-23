<%@ Page Title="" Language="C#" MasterPageFile="~/Mantenimiento/MpMantenimiento.master" AutoEventWireup="true" CodeBehind="formProductos.aspx.cs" Inherits="SistemaElectronico.Mantenimiento.FormProductos" %>

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
            <h3>Crear producto</h3>

            <asp:Panel ID="PnlDatos" runat="server" CssClass="campos">

                <div class="campo">
                    <asp:Label ID="LblCodigo" runat="server" Text="Codigo:" AssociatedControlID="TxtCodigo"></asp:Label>
                    <asp:TextBox ID="TxtCodigo" runat="server"></asp:TextBox>
                </div>
                <div class="campo">
                    <asp:Label ID="LblNombre" runat="server" Text="Nombre:" AssociatedControlID="TxtNombre"></asp:Label>
                    <asp:TextBox ID="TxtNombre" runat="server"></asp:TextBox>
                </div>
                <div class="campo">
                    <asp:Label ID="LblFechaCompra" runat="server" Text="Fecha compra:" AssociatedControlID="TxtFechaCompra"></asp:Label>
                    <asp:TextBox ID="TxtFechaCompra" runat="server" placeholder="aaaa-mm-dd"></asp:TextBox>
                </div>
                <div class="campo">
                    <asp:Label ID="LblPrecioCompraRD" runat="server" Text="Precio RD:" AssociatedControlID="TxtPrecioCompraRD"></asp:Label>
                    <asp:TextBox ID="TxtPrecioCompraRD" runat="server"></asp:TextBox>
                </div>
                <div class="campo">
                    <asp:Label ID="LblPrecioCompraUS" runat="server" Text="Precio US:" AssociatedControlID="TxtPrecioCompraUS"></asp:Label>
                    <asp:TextBox ID="TxtPrecioCompraUS" runat="server"></asp:TextBox>
                </div>
                <div class="campo">
                    <asp:Label ID="LblBodega" runat="server" Text="Bodega:" AssociatedControlID="TxtBodega"></asp:Label>
                    <asp:TextBox ID="TxtBodega" runat="server"></asp:TextBox>
                </div>
                <div class="campo">
                    <asp:Label ID="LblUbicacion" runat="server" Text="Ubicacion:" AssociatedControlID="TxtUbicacion"></asp:Label>
                    <asp:TextBox ID="TxtUbicacion" runat="server"></asp:TextBox>
                </div>
                <div class="campo">
                    <asp:Label ID="LblStatus" runat="server" Text="Status (0/1):" AssociatedControlID="TxtStatus"></asp:Label>
                    <asp:TextBox ID="TxtStatus" runat="server" Text="1"></asp:TextBox>
                </div>
                <div class="campo">
                    <asp:Label ID="LblAplicarItbis" runat="server" Text="Aplicar ITBIS (0/1):" AssociatedControlID="TxtAplicarItbis"></asp:Label>
                    <asp:TextBox ID="TxtAplicarItbis" runat="server" Text="0"></asp:TextBox>
                </div>
                <div class="campo">
                    <asp:Label ID="LblFisico" runat="server" Text="Fisico (0/1):" AssociatedControlID="TxtFisico"></asp:Label>
                    <asp:TextBox ID="TxtFisico" runat="server" Text="1"></asp:TextBox>
                </div>
                <div class="campo">
                    <asp:Label ID="LblServicio" runat="server" Text="Servicio (0/1):" AssociatedControlID="TxtServicio"></asp:Label>
                    <asp:TextBox ID="TxtServicio" runat="server" Text="0"></asp:TextBox>
                </div>
                <div class="campo">
                    <asp:Label ID="LblOcacional" runat="server" Text="Ocasional (0/1):" AssociatedControlID="TxtOcacional"></asp:Label>
                    <asp:TextBox ID="TxtOcacional" runat="server" Text="0"></asp:TextBox>
                </div>
                <div class="campo">
                    <asp:Label ID="LblCantidadInicial" runat="server" Text="Cant. inicial:" AssociatedControlID="TxtCantidadInicial"></asp:Label>
                    <asp:TextBox ID="TxtCantidadInicial" runat="server"></asp:TextBox>
                </div>
                <div class="campo">
                    <asp:Label ID="LblCantidadMinima" runat="server" Text="Cant. minima:" AssociatedControlID="TxtCantidadMinima"></asp:Label>
                    <asp:TextBox ID="TxtCantidadMinima" runat="server"></asp:TextBox>
                </div>
                <div class="campo">
                    <asp:Label ID="LblFechaExpiracion" runat="server" Text="Fecha expiracion:" AssociatedControlID="TxtFechaExpiracion"></asp:Label>
                    <asp:TextBox ID="TxtFechaExpiracion" runat="server" placeholder="aaaa-mm-dd"></asp:TextBox>
                </div>
                <div class="campo">
                    <asp:Label ID="LblSuplidor" runat="server" Text="Suplidor:" AssociatedControlID="TxtSuplidor"></asp:Label>
                    <asp:TextBox ID="TxtSuplidor" runat="server"></asp:TextBox>
                </div>
                <div class="campo">
                    <asp:Label ID="LblMarca" runat="server" Text="Marca:" AssociatedControlID="TxtMarca"></asp:Label>
                    <asp:TextBox ID="TxtMarca" runat="server"></asp:TextBox>
                </div>
                <div class="campo">
                    <asp:Label ID="LblModelo" runat="server" Text="Modelo:" AssociatedControlID="TxtModelo"></asp:Label>
                    <asp:TextBox ID="TxtModelo" runat="server"></asp:TextBox>
                </div>
                <div class="campo">
                    <asp:Label ID="LblSerie" runat="server" Text="Serie:" AssociatedControlID="TxtSerie"></asp:Label>
                    <asp:TextBox ID="TxtSerie" runat="server"></asp:TextBox>
                </div>
                <div class="campo">
                    <asp:Label ID="LblColor" runat="server" Text="Color:" AssociatedControlID="TxtColor"></asp:Label>
                    <asp:TextBox ID="TxtColor" runat="server"></asp:TextBox>
                </div>
                <div class="campo">
                    <asp:Label ID="LblCategoria" runat="server" Text="Categoria:" AssociatedControlID="TxtCategoria"></asp:Label>
                    <asp:TextBox ID="TxtCategoria" runat="server"></asp:TextBox>
                </div>
                <div class="campo">
                    <asp:Label ID="LblSubcategoria" runat="server" Text="Subcategoria:" AssociatedControlID="TxtSubcategoria"></asp:Label>
                    <asp:TextBox ID="TxtSubcategoria" runat="server"></asp:TextBox>
                </div>
                <div class="campo">
                    <asp:Label ID="LblReferencia" runat="server" Text="Referencia:" AssociatedControlID="TxtReferencia"></asp:Label>
                    <asp:TextBox ID="TxtReferencia" runat="server"></asp:TextBox>
                </div>
                <div class="campo">
                    <asp:Label ID="LblVendepor" runat="server" Text="Vende por:" AssociatedControlID="TxtVendepor"></asp:Label>
                    <asp:TextBox ID="TxtVendepor" runat="server"></asp:TextBox>
                </div>
                <div class="campo">
                    <asp:Label ID="LblContieneVende" runat="server" Text="Contiene vende:" AssociatedControlID="TxtContieneVende"></asp:Label>
                    <asp:TextBox ID="TxtContieneVende" runat="server"></asp:TextBox>
                </div>
                <div class="campo">
                    <asp:Label ID="LblComprapor" runat="server" Text="Compra por:" AssociatedControlID="TxtComprapor"></asp:Label>
                    <asp:TextBox ID="TxtComprapor" runat="server"></asp:TextBox>
                </div>
                <div class="campo">
                    <asp:Label ID="LblContieneCompra" runat="server" Text="Contiene compra:" AssociatedControlID="TxtContieneCompra"></asp:Label>
                    <asp:TextBox ID="TxtContieneCompra" runat="server"></asp:TextBox>
                </div>
                <div class="campo campo-full">
                    <asp:Label ID="LblNota" runat="server" Text="Nota:" AssociatedControlID="TxtNota"></asp:Label>
                    <asp:TextBox ID="TxtNota" runat="server" TextMode="MultiLine" Rows="2"></asp:TextBox>
                </div>

            </asp:Panel>
        </div>

        <asp:Panel ID="PnlCuadroGridView" runat="server" ToolTip="Buscar registros">
            <asp:Panel ID="PnlGridView" runat="server" CssClass="view">
                <asp:GridView ID="GridView1" runat="server" ToolTip="Buscar registro" AutoGenerateColumns="false" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" CssClass="GridView1">
                    <Columns>
                        <asp:CommandField ButtonType="Image" ShowSelectButton="true" SelectImageUrl="~/Imagenes/Seleccion.png" />
                        <asp:BoundField DataField="pro_codigo" HeaderText="Codigo" />
                        <asp:BoundField DataField="pro_nombre" HeaderText="Nombre" />
                        <asp:BoundField DataField="pro_fechacompra" HeaderText="Fecha compra" />
                        <asp:BoundField DataField="pro_preciocomprard" HeaderText="Precio RD" />
                        <asp:BoundField DataField="pro_preciocompraus" HeaderText="Precio US" />
                        <asp:BoundField DataField="pro_bodega" HeaderText="Bodega" />
                        <asp:BoundField DataField="pro_ubicacion" HeaderText="Ubicacion" />
                        <asp:BoundField DataField="pro_status" HeaderText="Status" />
                        <asp:BoundField DataField="pro_aplicaritebis" HeaderText="Aplica ITBIS" />
                        <asp:BoundField DataField="pro_fisico" HeaderText="Fisico" />
                        <asp:BoundField DataField="pro_servicio" HeaderText="Servicio" />
                        <asp:BoundField DataField="pro_ocacional" HeaderText="Ocasional" />
                        <asp:BoundField DataField="pro_cantidadinicial" HeaderText="Cant. inicial" />
                        <asp:BoundField DataField="pro_cantidadminima" HeaderText="Cant. minima" />
                        <asp:BoundField DataField="pro_fechaexpiracion" HeaderText="Fecha expiracion" />
                        <asp:BoundField DataField="pro_supridor" HeaderText="Suplidor" />
                        <asp:BoundField DataField="pro_marca" HeaderText="Marca" />
                        <asp:BoundField DataField="pro_modelo" HeaderText="Modelo" />
                        <asp:BoundField DataField="pro_serie" HeaderText="Serie" />
                        <asp:BoundField DataField="pro_color" HeaderText="Color" />
                        <asp:BoundField DataField="pro_categoria" HeaderText="Categoria" />
                        <asp:BoundField DataField="pro_subcategoria" HeaderText="Subcategoria" />
                        <asp:BoundField DataField="pro_referecia" HeaderText="Referencia" />
                        <asp:BoundField DataField="pro_vendepor" HeaderText="Vende por" />
                        <asp:BoundField DataField="pro_contienevende" HeaderText="Contiene vende" />
                        <asp:BoundField DataField="pro_comprapor" HeaderText="Compra por" />
                        <asp:BoundField DataField="pro_contienecompra" HeaderText="Contiene compra" />
                        <asp:BoundField DataField="pro_nota" HeaderText="Nota" />
                    </Columns>
                </asp:GridView>
            </asp:Panel>
        </asp:Panel>

        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <asp:Timer ID="Timer1" runat="server" OnTick="Timer1_Tick" Enabled="false" Interval="4000" />

    </div>

</asp:Content>

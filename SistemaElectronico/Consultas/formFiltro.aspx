<%@ Page Title="Filtro" Language="C#" AutoEventWireup="true" CodeBehind="formFiltro.aspx.cs" MasterPageFile="~/Consultas/MpConsultas.master" Inherits="SistemaElectronico.Consultas.formFiltro" %>

<asp:Content ContentPlaceHolderID="contenidoPrincipalConsultas" runat="server" class="bodega">

    <asp:Panel runat="server" class="aaas">

        <h3>Filtro de registros</h3>

        <asp:Panel ID="PnlDatos" runat="server" class="btns2">

            <asp:Label ID="LblTabla" runat="server" Text="Tabla" AssociatedControlID="ddlProductos"></asp:Label>
            <asp:DropDownList ID="ddlProductos" runat="server" CssClass="form-select">
                <asp:ListItem Value="">Selecciona una categoria</asp:ListItem>
                <asp:ListItem Value="Bodega">Bodega</asp:ListItem>
                <asp:ListItem Value="Producto">Productos</asp:ListItem>
                <asp:ListItem Value="Cliente">Clientes</asp:ListItem>
                <asp:ListItem Value="Caja">Cajas</asp:ListItem>
            </asp:DropDownList>

            <asp:Label ID="LblFiltro" runat="server" Text="Código" AssociatedControlID="txtFiltro"></asp:Label>
            <asp:TextBox ID="txtFiltro" runat="server"></asp:TextBox>

        </asp:Panel> <asp:Panel ID="PnlBotonera" runat="server" CssClass="btns">
            <asp:Button ID="btnFiltrar" runat="server" Text="Filtrar" OnClick="Filtrar" />
        </asp:Panel>

    </asp:Panel>

    <asp:Panel ID="PnlGridView" runat="server" class="view">
        <asp:GridView ID="GridView1" runat="server" ToolTip="Resultado del filtro" AutoGenerateColumns="true" CssClass="GridView1"></asp:GridView>
    </asp:Panel>

</asp:Content>

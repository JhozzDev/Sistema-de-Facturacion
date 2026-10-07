<%@ Page Title="" Language="C#" MasterPageFile="~/Mantenimiento/MpMantenimiento.master" AutoEventWireup="true" CodeBehind="formCaja.aspx.cs" Inherits="SistemaElectronico.Mantenimiento.FormCaja" %>

<asp:Content ContentPlaceHolderID="contenidoPrincipalMantenimiento" runat="server" class="caja">


<asp:Panel ID="PnlBotonera" runat="server" CssClass="btns">
    <asp:ImageButton ID="ImgAceptar" ImageUrl="~/Imagenes/Aceptar.png" runat="server"  />
    <asp:ImageButton ID="ImgNuevo" ImageUrl="~/Imagenes/Nuevo.png" runat="server" />
    <asp:ImageButton ID="ImgCancelar" ImageUrl="~/Imagenes/Cancelar.png" runat="server" />
    <asp:ImageButton ID="ImgBuscar" ImageUrl="~/Imagenes/Buscar.png" runat="server" OnClick="ImgBuscar_Click"/>
    <asp:ImageButton ID="ImgModificar" ImageUrl="~/Imagenes/Modificar.png" runat="server" />
    <asp:ImageButton ID="ImgImprimir" ImageUrl="~/Imagenes/Printer.png" runat="server"/>
</asp:Panel>

<asp:Panel runat="server" class="aaas">
    <asp:Panel ID="PnlGridView" runat="server" class="view">
        <asp:GridView ID="GridView1" scrollbar="auto" ToolTip="Buscar registro" runat="server" AutoGenerateColumns="false" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">

      
        <Columns>
        <asp:CommandField ButtonType="Image" ShowSelectButton="true" SelectImageUrl="~/Imagenes/Seleccion.png" />
        <asp:BoundField DataField="caj_codigo" HeaderText="Codigo" />
        <asp:BoundField DataField="caj_referencia" HeaderText="Referencia" />
        <asp:BoundField DataField="caj_descripcion" HeaderText="Descripcion" />
        </Columns>    
        </asp:GridView>
    </asp:Panel>
    <asp:Panel ID="PnlMensaje" runat="server" class="msg">
        <asp:Image ID="ImgBarras" runat="server" ImageUrl="~/Imagenes/BarraAzul.png"></asp:Image>
        <asp:Label ID="LblMensaje" runat="server" Text="Mensaje: "></asp:Label>
    </asp:Panel>

<asp:Panel ID="PnlDatos" runat="server" class="btns2">
        
       
        <asp:Label ID="LblReferencia" runat="server" Text="Referencia: "></asp:Label>
        <asp:TextBox ID="TxtReferencia" runat="server" ></asp:TextBox> 
    <asp:Label ID="LblCodigo" runat="server" Text="Codigo: "></asp:Label>
        <asp:TextBox ID="TxtCodigo" runat="server"></asp:TextBox>
        <asp:Label ID="LblDescripcion" runat="server" Text="Descripcion:"></asp:Label>
        <asp:TextBox ID="TxtDescripcion" runat="server"></asp:TextBox>
</asp:Panel><h3>Crear Caja</h3>
   </asp:Panel>
    
    

    <asp:Panel ID="PnlCuadroGridView" runat="server" ToolTip="Buscar registros" >
  
    </asp:Panel>

    <asp:ScriptManager ID="ScriptManager1" runat="server">    
</asp:ScriptManager>
 <asp:Timer ID="Timer1" runat="server" Enabled="false" />

</asp:Content>

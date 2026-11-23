using SistemaElectronico.Clases;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SistemaElectronico.Mantenimiento
{
    public partial class FormProductos : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            TxtNombre.Focus();

            if (!IsPostBack)
            {
                try
                {
                    ContarRegistro();
                    ImgBuscar_Click(sender, e);
                }
                catch
                {
                    // Si la BD no esta disponible la pagina igual debe abrir.
                }
            }
        }

        // ---------- Helpers de conversion ----------
        // AddWithValue infiere el tipo desde el valor y puede generar
        // conversiones implicitas erroneas (fechas, decimales, DBNull).
        private static object Texto(string valor)
        {
            return string.IsNullOrWhiteSpace(valor) ? (object)DBNull.Value : valor.Trim();
        }

        private static int Entero(string valor)
        {
            int resultado;
            return int.TryParse(valor, out resultado) ? resultado : 0;
        }

        private static decimal Numero(string valor)
        {
            if (string.IsNullOrWhiteSpace(valor)) return 0m;

            // La grilla puede renderizar 1,00 (es-ES) y el usuario escribir 1.00.
            // Normalizamos a punto decimal antes de parsear con InvariantCulture.
            string texto = valor.Trim().Replace(" ", string.Empty);
            int coma = texto.LastIndexOf(',');
            int punto = texto.LastIndexOf('.');

            if (coma >= 0 && punto >= 0)
            {
                // El separador mas a la derecha es el decimal.
                texto = coma > punto
                    ? texto.Replace(".", string.Empty).Replace(",", ".")
                    : texto.Replace(",", string.Empty);
            }
            else if (coma >= 0)
            {
                texto = texto.Replace(",", ".");
            }

            decimal resultado;
            return decimal.TryParse(texto, NumberStyles.Any, CultureInfo.InvariantCulture, out resultado)
                ? resultado : 0m;
        }

        private static bool Booleano(string valor)
        {
            if (string.IsNullOrWhiteSpace(valor)) return false;
            return valor == "1" ||
                   valor.Equals("true", StringComparison.OrdinalIgnoreCase) ||
                   valor.Equals("si", StringComparison.OrdinalIgnoreCase) ||
                   valor.Equals("sí", StringComparison.OrdinalIgnoreCase);
        }

        private static object Fecha(string valor)
        {
            DateTime resultado;
            if (DateTime.TryParse(valor, CultureInfo.InvariantCulture, DateTimeStyles.None, out resultado))
                return resultado;
            return DBNull.Value;
        }

        private static void AgregarDecimal(SqlCommand cmd, string nombre, string valor)
        {
            SqlParameter p = cmd.Parameters.Add(nombre, SqlDbType.Decimal);
            p.Precision = 18;
            p.Scale = 2;
            p.Value = Numero(valor);
        }

        private static string Celda(GridViewRow fila, int indice)
        {
            return fila.Cells[indice].Text.Replace("&nbsp;", string.Empty).Trim();
        }

        private void MostrarMensaje(string texto, string barra)
        {
            ImgBarras.ImageUrl = "/Imagenes/" + barra + ".png";
            LblMensaje.Text = texto;
            Timer1.Enabled = true;
        }

        // ---------- Parametros compartidos por INSERT y UPDATE ----------
        // Un solo lugar define el contrato con el stored procedure (DRY).
        private void AgregarParametrosProducto(SqlCommand cmd)
        {
            cmd.Parameters.Add("@pro_codigo", SqlDbType.Int).Value = Entero(TxtCodigo.Text);
            cmd.Parameters.Add("@pro_nombre", SqlDbType.VarChar, 50).Value = Texto(TxtNombre.Text);
            cmd.Parameters.Add("@pro_fechacompra", SqlDbType.Date).Value = Fecha(TxtFechaCompra.Text);
            AgregarDecimal(cmd, "@pro_preciocomprard", TxtPrecioCompraRD.Text);
            AgregarDecimal(cmd, "@pro_preciocompraus", TxtPrecioCompraUS.Text);
            cmd.Parameters.Add("@pro_bodega", SqlDbType.VarChar, 25).Value = Texto(TxtBodega.Text);
            cmd.Parameters.Add("@pro_ubicacion", SqlDbType.VarChar, 25).Value = Texto(TxtUbicacion.Text);
            cmd.Parameters.Add("@pro_status", SqlDbType.Bit).Value = Booleano(TxtStatus.Text);
            cmd.Parameters.Add("@pro_aplicaritebis", SqlDbType.Bit).Value = Booleano(TxtAplicarItbis.Text);
            cmd.Parameters.Add("@pro_fisico", SqlDbType.Bit).Value = Booleano(TxtFisico.Text);
            cmd.Parameters.Add("@pro_servicio", SqlDbType.Bit).Value = Booleano(TxtServicio.Text);
            cmd.Parameters.Add("@pro_ocacional", SqlDbType.Bit).Value = Booleano(TxtOcacional.Text);
            AgregarDecimal(cmd, "@pro_cantidadinicial", TxtCantidadInicial.Text);
            AgregarDecimal(cmd, "@pro_cantidadminima", TxtCantidadMinima.Text);
            cmd.Parameters.Add("@pro_fechaexpiracion", SqlDbType.Date).Value = Fecha(TxtFechaExpiracion.Text);
            // La BD conserva las columnas historicas pro_supridor y pro_referecia.
            cmd.Parameters.Add("@pro_supridor", SqlDbType.VarChar, 50).Value = Texto(TxtSuplidor.Text);
            cmd.Parameters.Add("@pro_marca", SqlDbType.VarChar, 25).Value = Texto(TxtMarca.Text);
            cmd.Parameters.Add("@pro_modelo", SqlDbType.VarChar, 25).Value = Texto(TxtModelo.Text);
            cmd.Parameters.Add("@pro_serie", SqlDbType.VarChar, 25).Value = Texto(TxtSerie.Text);
            cmd.Parameters.Add("@pro_color", SqlDbType.VarChar, 15).Value = Texto(TxtColor.Text);
            cmd.Parameters.Add("@pro_categoria", SqlDbType.VarChar, 25).Value = Texto(TxtCategoria.Text);
            cmd.Parameters.Add("@pro_subcategoria", SqlDbType.VarChar, 25).Value = Texto(TxtSubcategoria.Text);
            cmd.Parameters.Add("@pro_referecia", SqlDbType.VarChar, 15).Value = Texto(TxtReferencia.Text);
            cmd.Parameters.Add("@pro_vendepor", SqlDbType.VarChar, 15).Value = Texto(TxtVendepor.Text);
            AgregarDecimal(cmd, "@pro_contienevende", TxtContieneVende.Text);
            cmd.Parameters.Add("@pro_comprapor", SqlDbType.VarChar, 15).Value = Texto(TxtComprapor.Text);
            AgregarDecimal(cmd, "@pro_contienecompra", TxtContieneCompra.Text);
            cmd.Parameters.Add("@pro_nota", SqlDbType.VarChar, 100).Value = Texto(TxtNota.Text);
        }

        private void ContarRegistro()
        {
            using (SqlConnection cn = ConexionDB.getInstancia().CrearConexion())
            {
                cn.Open();
                using (SqlCommand cmd = new SqlCommand("sp_ContarRegistro_Producto", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    TxtCodigo.Text = Convert.ToString(cmd.ExecuteScalar());
                }
            }
        }

        private void LimpiarControles(Control contenedor)
        {
            foreach (Control control in contenedor.Controls)
            {
                TextBox caja = control as TextBox;
                if (caja != null)
                    caja.Text = string.Empty;
                else if (control.HasControls())
                    LimpiarControles(control);
            }
        }

        private void Reiniciar()
        {
            LimpiarControles(PnlDatos);
            // Valores por defecto de los campos booleanos.
            TxtStatus.Text = "1";
            TxtFisico.Text = "1";
            TxtAplicarItbis.Text = "0";
            TxtServicio.Text = "0";
            TxtOcacional.Text = "0";

            ContarRegistro();
            TxtNombre.Focus();
            ImgBarras.ImageUrl = "/Imagenes/BarraAzul.png";
            LblMensaje.Text = "Mensaje: ";
        }

        // ---------- Eventos de botones ----------
        protected void ImgNuevo_Click(object sender, EventArgs e)
        {
            Reiniciar();
        }

        protected void ImgCancelar_Click(object sender, EventArgs e)
        {
            Reiniciar();
        }

        protected void Timer1_Tick(object sender, EventArgs e)
        {
            // El timer solo mantiene el mensaje visible unos segundos.
        }

        protected void ImgBuscar_Click(object sender, EventArgs e)
        {
            DataTable dt = new DataTable();

            using (SqlConnection cn = ConexionDB.getInstancia().CrearConexion())
            {
                cn.Open();
                using (SqlCommand cmd = new SqlCommand("sp_Consulta_GridProducto", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                    {
                        adapter.Fill(dt);
                    }
                }
            }

            GridView1.DataSource = dt;
            GridView1.DataBind();
        }

        protected void ImgAceptar_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(TxtNombre.Text))
            {
                MostrarMensaje("Debe completar el nombre del producto.", "BarraRoja");
                return;
            }

            try
            {
                // Siempre regenerar el codigo: el usuario pudo seleccionar una fila
                // antes de dar Aceptar y el TextBox conservaria ese codigo.
                ContarRegistro();

                using (SqlConnection cn = ConexionDB.getInstancia().CrearConexion())
                {
                    cn.Open();

                    // Codigo 0 = alta: ningun producto existente puede tenerlo.
                    using (SqlCommand existe = new SqlCommand("sp_RegistroExiste_Producto_Nombre", cn))
                    {
                        existe.CommandType = CommandType.StoredProcedure;
                        existe.Parameters.Add("@pro_codigo", SqlDbType.Int).Value = 0;
                        existe.Parameters.Add("@pro_nombre", SqlDbType.VarChar, 50).Value = TxtNombre.Text.Trim();

                        if (Convert.ToInt32(existe.ExecuteScalar()) == 1)
                        {
                            MostrarMensaje("Ya existe un producto con ese nombre.", "BarraAmarilla");
                            return;
                        }
                    }

                    using (SqlCommand cmd = new SqlCommand("sp_Insert_Producto", cn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        AgregarParametrosProducto(cmd);
                        cmd.ExecuteNonQuery();
                    }
                }

                Reiniciar();
                ImgBuscar_Click(sender, e);
                MostrarMensaje("Registro insertado correctamente.", "BarraVerde");
            }
            catch (Exception ex)
            {
                MostrarMensaje("Error al guardar: " + ex.Message, "BarraRoja");
            }
        }

        protected void ImgModificar_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(TxtNombre.Text))
            {
                MostrarMensaje("Debe completar el nombre del producto.", "BarraRoja");
                return;
            }

            try
            {
                using (SqlConnection cn = ConexionDB.getInstancia().CrearConexion())
                {
                    cn.Open();

                    // Excluye el codigo actual para no rechazar el propio registro.
                    using (SqlCommand existe = new SqlCommand("sp_RegistroExiste_Producto_Nombre", cn))
                    {
                        existe.CommandType = CommandType.StoredProcedure;
                        existe.Parameters.Add("@pro_codigo", SqlDbType.Int).Value = Entero(TxtCodigo.Text);
                        existe.Parameters.Add("@pro_nombre", SqlDbType.VarChar, 50).Value = TxtNombre.Text.Trim();

                        if (Convert.ToInt32(existe.ExecuteScalar()) == 1)
                        {
                            MostrarMensaje("Ya existe otro producto con ese nombre.", "BarraRoja");
                            return;
                        }
                    }

                    using (SqlCommand cmd = new SqlCommand("sp_Update_Producto", cn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        AgregarParametrosProducto(cmd);
                        cmd.ExecuteNonQuery();
                    }
                }

                MostrarMensaje("Registro modificado correctamente.", "BarraVerde");
                ImgBuscar_Click(sender, e);
            }
            catch (Exception ex)
            {
                MostrarMensaje("Error al modificar: " + ex.Message, "BarraRoja");
            }
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            GridViewRow fila = GridView1.SelectedRow;
            if (fila == null) return;

            TxtCodigo.Text = Celda(fila, 1);
            TxtNombre.Text = Celda(fila, 2);
            TxtFechaCompra.Text = Celda(fila, 3);
            TxtPrecioCompraRD.Text = Celda(fila, 4);
            TxtPrecioCompraUS.Text = Celda(fila, 5);
            TxtBodega.Text = Celda(fila, 6);
            TxtUbicacion.Text = Celda(fila, 7);
            TxtStatus.Text = Booleano(Celda(fila, 8)) ? "1" : "0";
            TxtAplicarItbis.Text = Booleano(Celda(fila, 9)) ? "1" : "0";
            TxtFisico.Text = Booleano(Celda(fila, 10)) ? "1" : "0";
            TxtServicio.Text = Booleano(Celda(fila, 11)) ? "1" : "0";
            TxtOcacional.Text = Booleano(Celda(fila, 12)) ? "1" : "0";
            TxtCantidadInicial.Text = Celda(fila, 13);
            TxtCantidadMinima.Text = Celda(fila, 14);
            TxtFechaExpiracion.Text = Celda(fila, 15);
            TxtSuplidor.Text = Celda(fila, 16);
            TxtMarca.Text = Celda(fila, 17);
            TxtModelo.Text = Celda(fila, 18);
            TxtSerie.Text = Celda(fila, 19);
            TxtColor.Text = Celda(fila, 20);
            TxtCategoria.Text = Celda(fila, 21);
            TxtSubcategoria.Text = Celda(fila, 22);
            TxtReferencia.Text = Celda(fila, 23);
            TxtVendepor.Text = Celda(fila, 24);
            TxtContieneVende.Text = Celda(fila, 25);
            TxtComprapor.Text = Celda(fila, 26);
            TxtContieneCompra.Text = Celda(fila, 27);
            TxtNota.Text = Celda(fila, 28);
        }
    }
}

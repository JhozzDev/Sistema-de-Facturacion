using SistemaElectronico.Clases;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;


namespace SistemaElectronico.Mantenimiento
{
    public partial class FormCaja : System.Web.UI.Page
    {
        SqlConnection SqlCon = new SqlConnection();
        protected void Page_Load(object sender, EventArgs e)
        {


            TxtReferencia.Focus();
            try
            {
                if (!IsPostBack)
                {
                    ContarRegistro(sender, e);
                }
            }
            catch
            {

            }

        }

        protected void ContarRegistro(object sender, EventArgs e)
        {

            SqlCon = ConexionDB.getInstancia().CrearConexion();
            SqlCon.Open();
            SqlCommand cmd = new SqlCommand("sp_ContarRegistro_Caja", SqlCon);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            int maxId = Convert.ToInt32(cmd.ExecuteScalar());
            TxtCodigo.Text = maxId.ToString();
            SqlCon.Close();


        }

        private void Reiniciar(object sender, EventArgs e)
        {
            ContarRegistro(sender, e);
            TxtReferencia.Focus();
            ImgAceptar.Enabled = true;
            ImgCancelar.Enabled = true;
            ImgBuscar.Enabled = true;
            ImgNuevo.Enabled = true;
            ImgModificar.Enabled = true;

            TxtDescripcion.Enabled = true;
            TxtReferencia.Enabled = true;

            TxtDescripcion.Text = "";
            TxtReferencia.Text = "";

            ImgBarras.ImageUrl = "/Imagenes/BarraAzul.png";
            LblMensaje.Text = "Mensajes: ";


        }
        protected void ImgAceptar_Click(object sender, EventArgs e)
        {
            // 1️⃣ Validar campos obligatorios
            if (string.IsNullOrWhiteSpace(TxtReferencia.Text) || string.IsNullOrWhiteSpace(TxtDescripcion.Text))
            {
                ImgBarras.ImageUrl = "/Imagenes/BarraRoja.png";
                LblMensaje.Text = "Debe completar todos los campos.";
                Timer1.Enabled = true;
                return;
            }

            try
            {
                using (SqlConnection SqlCon = ConexionDB.getInstancia().CrearConexion())
                {
                    SqlCon.Open();

                    // 2️⃣ Verificar si el registro ya existe
                    using (SqlCommand cmd = new SqlCommand("sp_RegistroExiste_Caja", SqlCon))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@caj_referencia", TxtReferencia.Text);
                        cmd.Parameters.AddWithValue("@caj_descripcion", TxtDescripcion.Text);

                        using (SqlDataReader rd = cmd.ExecuteReader())
                        {
                            if (rd.Read())
                            {
                                // ✅ Ya existe
                                ImgBarras.ImageUrl = "/Imagenes/BarraAmarilla.png";
                                LblMensaje.Text = "El registro ya existe.";
                                Timer1.Enabled = true;
                                return;
                            }
                        }
                    }

                    // 3️⃣ Si no existe, insertar el registro
                    using (SqlCommand cmdInsert = new SqlCommand("sp_Insert_Caja", SqlCon))
                    {
                        cmdInsert.CommandType = CommandType.StoredProcedure;

                        // Parámetros según tu procedimiento almacenado
                        cmdInsert.Parameters.AddWithValue("@caj_referencia", TxtReferencia.Text);
                        cmdInsert.Parameters.AddWithValue("@caj_descripcion", TxtDescripcion.Text);
                        cmdInsert.Parameters.AddWithValue("@caj_codigo", TxtCodigo.Text);

                        cmdInsert.ExecuteNonQuery();
                    }

                    // 4️⃣ Actualizar interfaz tras insertar
                    ImgBarras.ImageUrl = "/Imagenes/BarraVerde.png";
                    LblMensaje.Text = "Registro insertado correctamente.";
                    Timer1.Enabled = true;

                    // Refrescar contador y limpiar campos
                    ContarRegistro(sender, e);
                    TxtReferencia.Text = "";
                    TxtDescripcion.Text = "";
                    TxtReferencia.Focus();

                    // Actualizar el GridView si lo estás usando
                    ImgBuscar_Click(sender, e);
                }
            }
            catch (Exception ex)
            {
                ImgBarras.ImageUrl = "/Imagenes/BarraRoja.png";
                LblMensaje.Text = "Error al guardar: " + ex.Message;
                Timer1.Enabled = true;
            }
        }
        protected void ImgBuscar_Click(object sender, EventArgs e)
        {
            SqlCon = ConexionDB.getInstancia().CrearConexion();
            DataTable dt = new DataTable();
            SqlCon.Open();
            SqlCommand cmd = new SqlCommand("sp_Consulta_GridCaja", SqlCon);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            adapter.Fill(dt);
            GridView1.DataSource = dt;
            GridView1.DataBind();
            SqlCon.Close();


        }

        private void GridView1_SelectedIndex(object sender, EventArgs e)
        {
            TxtCodigo.Text = GridView1.Rows[GridView1.SelectedIndex].Cells[1].Text;
            TxtReferencia.Text = GridView1.Rows[GridView1.SelectedIndex].Cells[2].Text;
            TxtDescripcion.Text = GridView1.Rows[GridView1.SelectedIndex].Cells[3].Text;
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            TxtCodigo.Text = GridView1.Rows[GridView1.SelectedIndex].Cells[1].Text;
            TxtReferencia.Text = GridView1.Rows[GridView1.SelectedIndex].Cells[2].Text;
            TxtDescripcion.Text = GridView1.Rows[GridView1.SelectedIndex].Cells[3].Text;
        }

        protected void ImgModificar_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(TxtReferencia.Text) || string.IsNullOrWhiteSpace(TxtDescripcion.Text))
            {

            }
            else
            {
                SqlCon = ConexionDB.getInstancia().CrearConexion();
                SqlCon.Open();
                SqlCommand cmd = new SqlCommand("sp_RegistroExiste_Caja", SqlCon);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@caja_referencia", TxtReferencia.Text);
                cmd.Parameters.AddWithValue("@caj_descripcion", TxtDescripcion.Text);
                cmd.Connection = SqlCon;
                SqlDataReader rd = cmd.ExecuteReader();



                if (rd.HasRows)
                {

                    ImgBarras.ImageUrl = "/Imagenes/BarraRoja.png";
                    Timer1.Enabled = false;
                    LblMensaje.Text = "Registro Existe";

                }
                else
                {
                    rd.Close();
                    SqlCommand cmd1 = new SqlCommand("sp_Update_Caja", SqlCon);
                    cmd1.CommandType = CommandType.StoredProcedure;

                    cmd1.Parameters.AddWithValue("@caj_codigo", TxtCodigo.Text);
                    cmd1.Parameters.AddWithValue("@caj_referencia", TxtReferencia.Text);
                    cmd1.Parameters.AddWithValue("@caj_descripcion", TxtDescripcion.Text);
                    cmd1.ExecuteNonQuery();
                    SqlCon.Close();

                    ImgBarras.ImageUrl = "/Imagenes/BarraVerde.png";
                    Timer1.Enabled = false;
                    ImgModificar.Enabled = true;



                }
            }
        }
    }
}
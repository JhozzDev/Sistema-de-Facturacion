using SistemaElectronico.Clases;
using System;
using System.Data;
using System.Data.SqlClient;


namespace SistemaElectronico.Mantenimiento
{
    public partial class FormClientes : System.Web.UI.Page
    {
        SqlConnection SqlCon = new SqlConnection();
        protected void Page_Load(object sender, EventArgs e)
        {


            TxtNombre.Focus();
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
            SqlCommand cmd = new SqlCommand("sp_ContarRegistro_Clientes", SqlCon);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            int maxId = Convert.ToInt32(cmd.ExecuteScalar());
            TxtCodigo.Text = maxId.ToString();
            SqlCon.Close();


        }

        private void Reiniciar(object sender, EventArgs e)
        {
            ContarRegistro(sender, e);
            TxtNombre.Focus();
            ImgAceptar.Enabled = true;
            ImgCancelar.Enabled = true;
            ImgBuscar.Enabled = true;
            ImgNuevo.Enabled = true;
            ImgModificar.Enabled = true;

            TxtTipo.Enabled = true;
            TxtNombre.Enabled = true;
            TxtRnc.Enabled = true;
            TxtContacto.Enabled = true;
            TxtCargo.Enabled = true;
            TxtPagina.Enabled = true;
            TxtApellido.Enabled = true;
            TxtCedula.Enabled = true;
            TxtDireccion.Enabled = true;
            TxtTelefono.Enabled = true;
            TxtCelular.Enabled = true;
            TxtCorreo.Enabled = true;
            TxtPais.Enabled = true;
            TxtProvincia.Enabled = true;

            TxtTipo.Text = "";
            TxtNombre.Text = "";
            TxtRnc.Text = "";
            TxtContacto.Text = "";
            TxtCargo.Text = "";
            TxtPagina.Text = "";
            TxtApellido.Text = "";
            TxtCedula.Text = "";
            TxtDireccion.Text = "";
            TxtTelefono.Text = "";
            TxtCelular.Text = "";
            TxtCorreo.Text = "";
            TxtPais.Text = "";
            TxtProvincia.Text = "";

            GridView1.DataBind();
            ImgBarras.ImageUrl = "/Imagenes/BarraAzul.png";
            LblMensaje.Text = "Mensajes: ";


        }
        protected void ImgAceptar_Click(object sender, EventArgs e)
        {
            // 1️⃣ Validar campos obligatorios
            if (string.IsNullOrWhiteSpace(TxtNombre.Text) || string.IsNullOrWhiteSpace(TxtApellido.Text))
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
                    using (SqlCommand cmd = new SqlCommand("sp_RegistroExiste_Clientes", SqlCon))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@cli_nombre", TxtNombre.Text);
                        cmd.Parameters.AddWithValue("@cli_rnc", TxtRnc.Text);

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
                    using (SqlCommand cmdInsert = new SqlCommand("sp_Insert_Clientes", SqlCon))
                    {
                        cmdInsert.CommandType = CommandType.StoredProcedure;

                        // Parámetros según tu procedimiento almacenado
                        cmdInsert.Parameters.AddWithValue("@cli_codigo", TxtCodigo.Text);
                        cmdInsert.Parameters.AddWithValue("@cli_tipo", TxtTipo.Text);
                        cmdInsert.Parameters.AddWithValue("@cli_nombre", TxtNombre.Text);
                        cmdInsert.Parameters.AddWithValue("@cli_rnc", TxtRnc.Text);
                        cmdInsert.Parameters.AddWithValue("@cli_contacto", TxtContacto.Text);
                        cmdInsert.Parameters.AddWithValue("@cli_cargo", TxtCargo.Text);
                        cmdInsert.Parameters.AddWithValue("@cli_pagina", TxtPagina.Text);
                        cmdInsert.Parameters.AddWithValue("@cli_apellido", TxtApellido.Text);
                        cmdInsert.Parameters.AddWithValue("@cli_cedula", TxtCedula.Text);
                        cmdInsert.Parameters.AddWithValue("@cli_direccion", TxtDireccion.Text);
                        cmdInsert.Parameters.AddWithValue("@cli_telefono", TxtTelefono.Text);
                        cmdInsert.Parameters.AddWithValue("@cli_celular", TxtCelular.Text);
                        cmdInsert.Parameters.AddWithValue("@cli_correo", TxtCorreo.Text);
                        cmdInsert.Parameters.AddWithValue("@cli_pais", TxtPais.Text);
                        cmdInsert.Parameters.AddWithValue("@cli_provincia", TxtProvincia.Text);

                        cmdInsert.ExecuteNonQuery();
                    }

                    // 4️⃣ Actualizar interfaz tras insertar
                    ImgBarras.ImageUrl = "/Imagenes/BarraVerde.png";
                    LblMensaje.Text = "Registro insertado correctamente.";
                    Timer1.Enabled = true;

                    // Refrescar contador y limpiar campos
                    ContarRegistro(sender, e);
                    TxtTipo.Text = "";
                    TxtNombre.Text = "";
                    TxtRnc.Text = "";
                    TxtContacto.Text = "";
                    TxtCargo.Text = "";
                    TxtPagina.Text = "";
                    TxtApellido.Text = "";
                    TxtCedula.Text = "";
                    TxtDireccion.Text = "";
                    TxtTelefono.Text = "";
                    TxtCelular.Text = "";
                    TxtCorreo.Text = "";
                    TxtPais.Text = "";
                    TxtProvincia.Text = "";
                    TxtNombre.Focus();

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


        protected void Timer1_Tick(object sender, EventArgs e)
        {

        }

        protected void ImgNuevo_Click(object sender, EventArgs e)
        {

            Reiniciar(sender, e);
        }
        protected void ImgCancelar_Click(object sender, EventArgs e)
        {

            Reiniciar(sender, e);
        }

        protected void ImgBuscar_Click(object sender, EventArgs e)
        {
            SqlCon = ConexionDB.getInstancia().CrearConexion();
            DataTable dt = new DataTable();
            SqlCon.Open();
            SqlCommand cmd = new SqlCommand("sp_Consulta_GridClientes", SqlCon);
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
            TxtTipo.Text = GridView1.Rows[GridView1.SelectedIndex].Cells[2].Text;
            TxtNombre.Text = GridView1.Rows[GridView1.SelectedIndex].Cells[3].Text;
            TxtRnc.Text = GridView1.Rows[GridView1.SelectedIndex].Cells[4].Text;
            TxtContacto.Text = GridView1.Rows[GridView1.SelectedIndex].Cells[5].Text;
            TxtCargo.Text = GridView1.Rows[GridView1.SelectedIndex].Cells[6].Text;
            TxtPagina.Text = GridView1.Rows[GridView1.SelectedIndex].Cells[7].Text;
            TxtApellido.Text = GridView1.Rows[GridView1.SelectedIndex].Cells[8].Text;
            TxtCedula.Text = GridView1.Rows[GridView1.SelectedIndex].Cells[9].Text;
            TxtDireccion.Text = GridView1.Rows[GridView1.SelectedIndex].Cells[10].Text;
            TxtTelefono.Text = GridView1.Rows[GridView1.SelectedIndex].Cells[11].Text;
            TxtCelular.Text = GridView1.Rows[GridView1.SelectedIndex].Cells[12].Text;
            TxtCorreo.Text = GridView1.Rows[GridView1.SelectedIndex].Cells[13].Text;
            TxtPais.Text = GridView1.Rows[GridView1.SelectedIndex].Cells[14].Text;
            TxtProvincia.Text = GridView1.Rows[GridView1.SelectedIndex].Cells[15].Text;
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            TxtCodigo.Text = GridView1.Rows[GridView1.SelectedIndex].Cells[1].Text;
            TxtTipo.Text = GridView1.Rows[GridView1.SelectedIndex].Cells[2].Text;
            TxtNombre.Text = GridView1.Rows[GridView1.SelectedIndex].Cells[3].Text;
            TxtRnc.Text = GridView1.Rows[GridView1.SelectedIndex].Cells[4].Text;
            TxtContacto.Text = GridView1.Rows[GridView1.SelectedIndex].Cells[5].Text;
            TxtCargo.Text = GridView1.Rows[GridView1.SelectedIndex].Cells[6].Text;
            TxtPagina.Text = GridView1.Rows[GridView1.SelectedIndex].Cells[7].Text;
            TxtApellido.Text = GridView1.Rows[GridView1.SelectedIndex].Cells[8].Text;
            TxtCedula.Text = GridView1.Rows[GridView1.SelectedIndex].Cells[9].Text;
            TxtDireccion.Text = GridView1.Rows[GridView1.SelectedIndex].Cells[10].Text;
            TxtTelefono.Text = GridView1.Rows[GridView1.SelectedIndex].Cells[11].Text;
            TxtCelular.Text = GridView1.Rows[GridView1.SelectedIndex].Cells[12].Text;
            TxtCorreo.Text = GridView1.Rows[GridView1.SelectedIndex].Cells[13].Text;
            TxtPais.Text = GridView1.Rows[GridView1.SelectedIndex].Cells[14].Text;
            TxtProvincia.Text = GridView1.Rows[GridView1.SelectedIndex].Cells[15].Text;
        }

        protected void ImgModificar_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(TxtNombre.Text) || string.IsNullOrWhiteSpace(TxtApellido.Text))
            {

            }
            else
            {
                SqlCon = ConexionDB.getInstancia().CrearConexion();
                SqlCon.Open();
                SqlCommand cmd = new SqlCommand("sp_RegistroExiste_Clientes", SqlCon);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@cli_nombre", TxtNombre.Text);
                cmd.Parameters.AddWithValue("@cli_rnc", TxtRnc.Text);
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
                    SqlCommand cmd1 = new SqlCommand("sp_Update_Clientes", SqlCon);
                    cmd1.CommandType = CommandType.StoredProcedure;

                    cmd1.Parameters.AddWithValue("@cli_codigo", TxtCodigo.Text);
                    cmd1.Parameters.AddWithValue("@cli_tipo", TxtTipo.Text);
                    cmd1.Parameters.AddWithValue("@cli_nombre", TxtNombre.Text);
                    cmd1.Parameters.AddWithValue("@cli_rnc", TxtRnc.Text);
                    cmd1.Parameters.AddWithValue("@cli_contacto", TxtContacto.Text);
                    cmd1.Parameters.AddWithValue("@cli_cargo", TxtCargo.Text);
                    cmd1.Parameters.AddWithValue("@cli_pagina", TxtPagina.Text);
                    cmd1.Parameters.AddWithValue("@cli_apellido", TxtApellido.Text);
                    cmd1.Parameters.AddWithValue("@cli_cedula", TxtCedula.Text);
                    cmd1.Parameters.AddWithValue("@cli_direccion", TxtDireccion.Text);
                    cmd1.Parameters.AddWithValue("@cli_telefono", TxtTelefono.Text);
                    cmd1.Parameters.AddWithValue("@cli_celular", TxtCelular.Text);
                    cmd1.Parameters.AddWithValue("@cli_correo", TxtCorreo.Text);
                    cmd1.Parameters.AddWithValue("@cli_pais", TxtPais.Text);
                    cmd1.Parameters.AddWithValue("@cli_provincia", TxtProvincia.Text);
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

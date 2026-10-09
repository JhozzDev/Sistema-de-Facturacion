using SistemaElectronico.Clases;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SistemaElectronico.Mantenimiento
{
    public partial class FormEmpresa : System.Web.UI.Page
    {
        SqlConnection SqlCon = new SqlConnection();
        protected void Page_Load(object sender, EventArgs e)
        {



        }
        protected void ImgAceptar_Click(object sender, EventArgs e){
            SqlCon = ConexionDB.getInstancia().CrearConexion();
            SqlCon.Open();
            SqlCommand cmd = new SqlCommand("sp_ContarRegistro_Emoresa", SqlCon);
            cmd.CommandType = CommandType.StoredProcedure;
            int output = (int)cmd.ExecuteScalar();

            if (output >= 1)
            {
                ImgBarras.ImageUrl = "/Imagenes/BarraRoja.png";
                LblMensaje.Text = "Error, Existe otra empresa";

            }
            else {

                if (string.IsNullOrWhiteSpace(TxtNombre.Text))
                {
                    ImgBarras.ImageUrl = "/Imagenes/BarraRoja.png";
                    LblMensaje.Text = "Debe ingresar todos los parametros";
                }
                else
                {

                    int tamano = fileUpload.PostedFile.ContentLength;
                    byte[] ImagenOriginal = new byte[tamano];

                    fileUpload.PostedFile.InputStream.Read(ImagenOriginal, 0, tamano);
                    Bitmap ImagenOriginalBinaria = new Bitmap(fileUpload.PostedFile.InputStream);
                    string ImagenDataUrl64 = "data:image/jpg;base64," + Convert.ToBase64String(ImagenOriginal);



                    ImgPreview.ImageUrl = ImagenDataUrl64;

                    SqlCommand cmd2 = new SqlCommand("sp_Insert_Empresa", SqlCon);
                    cmd2.CommandType = CommandType.StoredProcedure;

                    cmd2.Parameters.AddWithValue("@Emp_Codigo", 1);
                    cmd2.Parameters.AddWithValue("@Emp_Nombre", TxtNombre.Text);
                    cmd2.Parameters.AddWithValue("@Emp_Direccion", TxtDireccion.Text);
                    cmd2.Parameters.AddWithValue("@Emp_Telefono", TxtTelefono.Text);
                    cmd2.Parameters.AddWithValue("@Emp_RNC", TxtRnc.Text);
                    cmd2.Parameters.AddWithValue("@Emp_Logo", SqlDbType.Image).Value = ImagenOriginal;

                    cmd2.ExecuteScalar();
                    ImgBarras.ImageUrl = "/Imagenes/BarraVerde.png";
                    LblMensaje.Text = "Registro Creado";

                    SqlCon.Close();

                }
            }

        }



        protected void Reiniciar(object sender, EventArgs e)
        {
            TxtDireccion.Text = " ";
            TxtNombre.Text = " ";
            TxtRnc.Text = " ";
            TxtTelefono.Text = " ";
            ImgPreview.ImageUrl = " ";
            fileUpload.Attributes.Clear();
            LblMensaje.Text = "";
            ImgBarras.ImageUrl = "/Imagenes/BarraAzul.png";

        }


        protected void ImgBuscar_Click(object sender, EventArgs e)
        {
            Reiniciar(sender, e);
        }
        protected void ImgCancelar_Click(object sender, EventArgs e)
        {

            Reiniciar(sender, e);

        }

        protected void ImgModificar_Click(object sender, EventArgs e) {    Reiniciar(sender, e);
        }

        protected void ImgNuevo_Click(object sender, EventArgs e)
        {
            Reiniciar(sender, e);
        }



    }
}
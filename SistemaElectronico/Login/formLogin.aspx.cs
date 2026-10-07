using SistemaElectronico.Clases;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics.Eventing.Reader;
using System.Linq;
using System.Linq.Expressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SistemaElectronico.Login
{
    public partial class FormLogin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            TxtUser.Focus();
        }



        protected void BtnAceptar_Click(object sender, EventArgs e)
        {

            SqlConnection SqlCon = new SqlConnection();

            try
            {
                SqlCon = ConexionDB.getInstancia().CrearConexion();
                SqlParameter param = new SqlParameter("@Usuario", TxtUser.Text.Trim());
                SqlParameter param2 = new SqlParameter("@clave", TxtClave.Text.Trim());
                SqlCommand cmd = new SqlCommand("sp_CheclLogin", SqlCon);
                cmd.Parameters.Add(param);
                cmd.Parameters.Add(param2);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                SqlCon.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    Session["Log_Status"] = dr["Log_Status"].ToString();
                    if (dr["Log_Status"].ToString() == "activo")
                    {
           
                        LabelMensaje.Text = "Mensaje: Login Correcto";
                        TxtUser.Enabled = false;
                        TxtClave.Enabled = false;
                        BtnAceptar.Enabled = false;
                        ImageCerradura.ImageUrl = "/Imagenes/CerraduraVerde.png";
                        Response.Redirect("~/Login/Default.aspx");
                        

                    }
                    else
                    {
                        LabelMensaje.Text = "Mensaje: Usuario Inhabilitado";

                    }

                }
                else
                {
                    LabelMensaje.Text = "Mensaje: Login incorrecto";
                }

            }
            catch(Exception ex)
            {
                LabelMensaje.Text = "Mensaje: No hay conexion con la base de datos" + ex.Message; ;

            }
            finally {
            if(SqlCon.State == System.Data.ConnectionState.Open)
                    SqlCon.Close();
                        }



        }
    }
}
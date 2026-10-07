using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using SistemaElectronico.Clases;

namespace SistemaElectronico.Login
{
    public partial class Principal : System.Web.UI.Page
    {
        SqlConnection Sqlcon = new SqlConnection();
        protected void Page_Load(object sender, EventArgs e)
        {

           
            ConsultarImagenes();

        }

        protected void ConsultarImagenes()
        {
            Sqlcon = ConexionDB.getInstancia().CrearConexion();
            Sqlcon.Open();
            SqlCommand cmd = new SqlCommand("sp_ConsultarImagen_Empresa", Sqlcon);
            cmd.CommandType = CommandType.StoredProcedure;
        DataTable imagenesDb = new DataTable();
            imagenesDb.Load(cmd.ExecuteReader());
            Repeater1.DataSource = imagenesDb;
            Repeater1.DataBind();
            Sqlcon.Close();
            LblIdentificacion.Text = (string)Session["Log_Nombre"] + (" ") + (string)Session["Log_Apellido"];
        }

    }
}
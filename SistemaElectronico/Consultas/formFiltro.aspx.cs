using SistemaElectronico.Clases;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace SistemaElectronico.Consultas
{
    public partial class formFiltro : System.Web.UI.Page
    {
        SqlConnection SqlCon = new SqlConnection();

        protected void Page_Load(object sender, EventArgs e)
        {
            txtFiltro.Focus();
        }


        protected void Filtrar(object sender, EventArgs e)
        {
            string tabla = ddlProductos.SelectedValue;
            string columna = "";

            switch (tabla)
            {
                case "Producto":
                    columna = "pro_codigo";
                    break;

                case "Cliente":
                    columna = "cli_codigo";
                    break;

                case "Empresa":
                    columna = "emp_codigo";
                    break;

                case "Bodega":
                    columna = "bod_codigo";
                    break;

                case "Caja":
                    columna = "caj_codigo";
                    break;

                default:
                    return;
            }

            using (SqlConnection conexion =
                ConexionDB.getInstancia().CrearConexion())
            {
                conexion.Open();

                string sql =
                    $"SELECT * FROM [{tabla}] WHERE [{columna}] LIKE @Filtro";

                using (SqlCommand cmd = new SqlCommand(sql, conexion))
                {
                    cmd.Parameters.AddWithValue(
                        "@Filtro",
                        "%" + txtFiltro.Text.Trim() + "%"
                    );

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        GridView1.DataSource = reader;
                        GridView1.DataBind();
                    }
                }
            }
        }
    }
}
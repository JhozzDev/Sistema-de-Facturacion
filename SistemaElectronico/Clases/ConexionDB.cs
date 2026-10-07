using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace SistemaElectronico.Clases
{
    public class ConexionDB
    {

        private string Base;
        private string Servidor;
        private string Usuario;
        private string Clave;
        private bool Seguridad;
        private static ConexionDB Con = null;
        private static ConexionDB Con2 = null;
        private ConexionDB()
        {

            this.Base = "Sistema";
            this.Servidor = @"(localdb)\MSSQLLocalDB"; ;
            this.Usuario = "Sa";
            this.Clave = "12345";
            this.Seguridad = true;

        }

        public SqlConnection CrearConexion()
        {

            SqlConnection cadena = new SqlConnection();
            SqlConnection cadena2 = new SqlConnection();
            try
            {
                cadena.ConnectionString = "Server=" + this.Servidor + ";Database=" + this.Base + ";";
                cadena2.ConnectionString = "Server=localhost\\SQLEXPRESS;Database=Sistema;Trusted_Connection=True;TrustServerCertificate=True;";
                if (this.Seguridad)
                {
                    cadena.ConnectionString = cadena.ConnectionString + "Integrated Security = SSPI";

                }
                else
                {
                    cadena.ConnectionString = cadena.ConnectionString + this.Base + "User Id=" + this.Usuario + "; Password=" + this.Clave;
                }
            }
            catch (Exception ex)
            {
                cadena = null;
                throw ex;
            }
            return cadena2;
        }
        public static ConexionDB getInstancia()
        {
            if(Con2 == null)
            {
                Con2 = new ConexionDB();
            }
            return Con2;
        }

    }
}
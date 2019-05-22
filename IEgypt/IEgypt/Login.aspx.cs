using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Data;
namespace IEgypt
{
    public partial class Login : System.Web.UI.Page
    {
        protected void login_buttonClicked (object sender, EventArgs args)
        {
            string email = email_login.Text;
            string password = password_login.Text;
            int user_id;
            SqlDataReader reader;

            string connectionString = WebConfigurationManager.ConnectionStrings["constr"].ConnectionString;
            SqlConnection cnn = new SqlConnection(connectionString);

            if(string.IsNullOrWhiteSpace(email) || string.IsNullOrWhiteSpace(password))
            {
                popup.Visible = true;
                popup.ForeColor = System.Drawing.Color.Beige;
                return;
            }
            cnn.Open();
            SqlCommand cmd = new SqlCommand("User_login", cnn);

            cmd.CommandType = System.Data.CommandType.StoredProcedure;

            cmd.Parameters.Add(new SqlParameter("@email", email));
            cmd.Parameters.Add(new SqlParameter("@password", password));
            cmd.Parameters.Add("@user_id", System.Data.SqlDbType.Int).Direction = System.Data.ParameterDirection.Output;

            using (reader = cmd.ExecuteReader())
            {
                if (Convert.ToInt32(cmd.Parameters["@user_id"].Value) == -1)
                {
                    cmd.Dispose();
                    reader.Close();
                    cmd = new SqlCommand("SELECT email,password FROM [User]",cnn);
                    reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        if(reader.GetValue(0).ToString().Equals(email) && reader.GetValue(1).ToString().Equals(password))
                        {
                            popup.Visible = true;
                            popup.ForeColor = System.Drawing.Color.Red;
                            popupText.Text = "You Can not login because Your deactivated account has been inactive for over 2 weeks";
                            reader.Close();
                            cmd.Dispose();
                            cnn.Close();
                            return;
                        }
                    }
                    popup.Visible = true;
                    popup.ForeColor = System.Drawing.Color.Red;
                    popupText.Text = "Incorrect Email/Password";
                    reader.Close();
                    cmd.Dispose();
                    cnn.Close();
                    return;
                }
                user_id = Convert.ToInt32(cmd.Parameters["@user_id"].Value);
            }

            Session["ID"] = user_id;
            reader.Close();
            cmd.Dispose();
            cnn.Close();
            Response.Redirect("Profile.aspx");
        }

        protected void okButtonClicked(object sender, EventArgs e)
        {
            popup.Visible = false;
        }
        protected void cancel_buttonClicked(object sender, EventArgs args)
        {
            Response.Redirect("Default.aspx");
        }
        public static object ToDBNull(object value)
        {
            if (value != null)
                return value;
            return DBNull.Value;
        }
    }
}

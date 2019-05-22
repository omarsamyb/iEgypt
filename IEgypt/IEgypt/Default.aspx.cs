using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace IEgypt
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            GetData();
        }

        private void GetData()
        {
            if(Session["ID"] != null)
            {
                login_register.Visible = false;
                profile.Visible = true;
            }
            else
            {
                login_register.Visible = true;
                profile.Visible = false;
            }
        }
        // redirect to register page
        public void button1Clicked(object sender, EventArgs args)
        {
            Response.Redirect("Register.aspx");
        }
        // redirect to login page
        public void button2Clicked(object sender, EventArgs args)
        {
            Response.Redirect("Login.aspx");
        }
        // redirect to profile page
        public void button3Clicked(object sender, EventArgs args)
        {
            Response.Redirect("Profile.aspx?user_id="+Session["ID"]);
        }
        // Search for any original content by its type or its category.
        public void button4Clicked(object sender, EventArgs args)
        {
            if((string.IsNullOrWhiteSpace(typeTB.Text)) && (string.IsNullOrWhiteSpace(categoryTB.Text)))
            {
                popup.Visible = true;
                popup.ForeColor = System.Drawing.Color.Red;
                popupText.Text = "Please enter atleast a type or a category";
                return;
            }
            Response.Redirect("Search.aspx?id=0&type="+typeTB.Text+"&category="+categoryTB.Text);
        }
        //Show the approved original content along with all the information of the contributor who uploaded it.
        public void button5Clicked(object sender, EventArgs args)
        {
            SqlDataReader reader;

            string connectionString = WebConfigurationManager.ConnectionStrings["constr"].ConnectionString;
            SqlConnection cnn = new SqlConnection(connectionString);

            if (!string.IsNullOrWhiteSpace(contributorName.Text))
            {
                cnn.Open();
                SqlCommand cmd = new SqlCommand("checkName", cnn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@name", contributorName.Text));
                cmd.Parameters.Add("@out", System.Data.SqlDbType.Bit).Direction = System.Data.ParameterDirection.Output;
                using (reader = cmd.ExecuteReader())
                {
                    if (Convert.ToInt16(cmd.Parameters["@out"].Value) == 0)
                    {
                        popup.Visible = true;
                        popup.ForeColor = System.Drawing.Color.Red;
                        popupText.Text = "Incorrect name syntax";
                        return;
                    }
                }
                cmd.Dispose();
                cnn.Close();
                reader.Close();
            }
            

            Response.Redirect("Search.aspx?id=1&name="+contributorName.Text);
        }
        //Search for any contributor by his/her name.
        public void button6Clicked(object sender, EventArgs args)
        {
            SqlDataReader reader;

            string connectionString = WebConfigurationManager.ConnectionStrings["constr"].ConnectionString;
            SqlConnection cnn = new SqlConnection(connectionString);

            if (string.IsNullOrWhiteSpace(nameTB.Text))
            {
                popup.Visible = true;
                popup.ForeColor = System.Drawing.Color.Red;
                popupText.Text = "Please enter Contributor Full name separated by spaces";
                return;
            }
            cnn.Open();
            SqlCommand cmd = new SqlCommand("checkName", cnn);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@name", nameTB.Text));
            cmd.Parameters.Add("@out", System.Data.SqlDbType.Bit).Direction = System.Data.ParameterDirection.Output;
            using (reader = cmd.ExecuteReader())
            {
                if (Convert.ToInt16(cmd.Parameters["@out"].Value) == 0)
                {
                    popup.Visible = true;
                    popup.ForeColor = System.Drawing.Color.Red;
                    popupText.Text = "Incorrect name syntax";
                    return;
                }
            }
            cmd.Dispose();
            cnn.Close();
            reader.Close();

            Response.Redirect("Search.aspx?id=2&name="+nameTB.Text);
        }
        // Order contributors
        public void button7Clicked(object sender, EventArgs args)
        {
            Response.Redirect("Search.aspx?id=3");
        }
        protected void okButtonClicked(object sender, EventArgs e)
        {
            popup.Visible = false;
        }
    }
}

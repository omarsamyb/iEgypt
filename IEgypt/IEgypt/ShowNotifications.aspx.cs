using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ShowNotifications : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    /* protected void Button1_Click(object sender, EventArgs e)
     {
         string connectionString;
         SqlConnection cnn;

         connectionString = WebConfigurationManager.ConnectionStrings["constr"].ConnectionString;
         //connectionString = @"Data Source=LAPTOP-A3SPMF01\SQLEXPRESS;Initial Catalog=dd ;";

         cnn = new SqlConnection(connectionString);

         cnn.Open();

         SqlCommand cmd = new SqlCommand("Show_Notification ", cnn);

         cmd.CommandType = System.Data.CommandType.StoredProcedure;

         cmd.Parameters.Add(new SqlParameter("@user_id", (int) Session["ID"]));

     }*/

    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

    protected void button4_Click(object sender, EventArgs e)
    {
        Response.Redirect("Profile.aspx");
    }
}
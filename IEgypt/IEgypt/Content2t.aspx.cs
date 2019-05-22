using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Content2t : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void button2Clicked(object sender, EventArgs e)
    {
        String content;
        content = content_type.Text;

        string connectionString;
        SqlConnection cnn;

        connectionString = WebConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        //connectionString = @"Data Source=LAPTOP-A3SPMF01\SQLEXPRESS;Initial Catalog=dd ;";

        cnn = new SqlConnection(connectionString);

        cnn.Open();

        SqlCommand cmd = new SqlCommand("Staff_Create_Type", cnn);

        cmd.CommandType = System.Data.CommandType.StoredProcedure;

        cmd.Parameters.Add(new SqlParameter("@type_name", content));
        cmd.ExecuteNonQuery();
        cnn.Dispose();

        cnn.Close();

        
    }

    protected void button4_Click(object sender, EventArgs e)
    {
        Response.Redirect("Profile.aspx");
    }
}
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class CategoryAndSubCategory : System.Web.UI.Page
{

    protected void Button3_Click(object sender, EventArgs e)
    {
        String category;
        String subCategory;
        category = subCategory_type.Text;
        subCategory = subCategory_name.Text;

        string connectionString;
        SqlConnection cnn;

        connectionString = WebConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        //connectionString = @"Data Source=LAPTOP-A3SPMF01\SQLEXPRESS;Initial Catalog=dd ;";

        cnn = new SqlConnection(connectionString);

        cnn.Open();

        SqlCommand cmd = new SqlCommand("Staff_Create_Subcategory", cnn);

        cmd.CommandType = System.Data.CommandType.StoredProcedure;

        cmd.Parameters.Add(new SqlParameter("@category_name", category));
        cmd.Parameters.Add(new SqlParameter("@subcategory_name", subCategory));
        cmd.ExecuteNonQuery();
        cnn.Dispose();

        cnn.Close();

    }

    protected void button4_Click(object sender, EventArgs e)
    {
        Response.Redirect("Profile.aspx");
    }
}
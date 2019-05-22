using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class CreateAds : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void button1Clicked(object sender, EventArgs args)
    {
        Response.Redirect("Default.aspx");
    }
    protected void btnClicked(object sender, EventArgs args)
    {
        string desc = box1.Text;
        string loc = box2.Text;
        if (string.IsNullOrWhiteSpace(desc))
            desc = null;
        if (string.IsNullOrWhiteSpace(loc))
            loc = null;

        string connectionString = WebConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        SqlConnection cnn = new SqlConnection(connectionString);
        cnn.Open();
        SqlCommand cmd = new SqlCommand("Create_Ads", cnn);
        cmd.CommandType = System.Data.CommandType.StoredProcedure;
        cmd.Parameters.Add(new SqlParameter("@viewer_id", Convert.ToInt32(Session["ID"])));
        cmd.Parameters.Add(new SqlParameter("@description", ToDBNull(desc)));
        cmd.Parameters.Add(new SqlParameter("@location", ToDBNull(loc)));
        cmd.ExecuteReader();
        cmd.Dispose();
        cnn.Close();
        Response.Redirect("Profile.aspx");
    }
    public static object ToDBNull(object value)
    {
        if (value != null)
            return value;
        return DBNull.Value;
    }
}
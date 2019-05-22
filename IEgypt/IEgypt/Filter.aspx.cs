using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Filter : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    



    protected void lnkSelect1_Click(object sender, EventArgs e)
    {
        SqlConnection cnn = new SqlConnection(WebConfigurationManager.ConnectionStrings["constr"].ConnectionString);
        cnn.Open();

        String[] arg = new string[2];
        arg = Convert.ToString((sender as LinkButton).CommandArgument).Split(';');
        int original_content_id = Convert.ToInt32(arg[0]);
        int reviewer_id = Convert.ToInt32(arg[1]);
        //int original_content_id = Convert.ToInt32(arg[1]);
        // date = Convert.ToString(arg[2]);



        SqlCommand cmd = new SqlCommand("reviewer_filter_content", cnn);
        cmd.CommandType = System.Data.CommandType.StoredProcedure;
        cmd.Parameters.Add(new SqlParameter("@reviewer_id", reviewer_id));
        cmd.Parameters.Add(new SqlParameter("@original_content", original_content_id));
        cmd.Parameters.Add(new SqlParameter("@status", Convert.ToBoolean("True")));
        // cmd.Parameters.Add(new SqlParameter("@original_content_id", original_content_id));
        // cmd.Parameters.Add(new SqlParameter("@written_time", date));
        cmd.ExecuteNonQuery();
        cnn.Dispose();
        cnn.Close();
        Response.Redirect("Filter.aspx");
    }

    protected void lnkSelect2_Click(object sender, EventArgs e)
    {
        SqlConnection cnn = new SqlConnection(WebConfigurationManager.ConnectionStrings["constr"].ConnectionString);
        cnn.Open();

        String[] arg = new string[2];
        arg = Convert.ToString((sender as LinkButton).CommandArgument).Split(';');
        int original_content_id = Convert.ToInt32(arg[0]);
        int Content_Manager_id = Convert.ToInt32(arg[1]);
        //int original_content_id = Convert.ToInt32(arg[1]);
        // date = Convert.ToString(arg[2]);



        SqlCommand cmd = new SqlCommand("content_manager_filter_content ", cnn);
        cmd.CommandType = System.Data.CommandType.StoredProcedure;
        cmd.Parameters.Add(new SqlParameter("@content_manager_id ", Content_Manager_id));
        cmd.Parameters.Add(new SqlParameter("@original_content", original_content_id));
        cmd.Parameters.Add(new SqlParameter("@status", Convert.ToBoolean("True")));
        // cmd.Parameters.Add(new SqlParameter("@original_content_id", original_content_id));
        // cmd.Parameters.Add(new SqlParameter("@written_time", date));
        cmd.ExecuteNonQuery();
        cnn.Dispose();
        cnn.Close();
        Response.Redirect("Filter.aspx");
    }

    protected void button4_Click(object sender, EventArgs e)
    {
        Response.Redirect("Profile.aspx");
    }
}
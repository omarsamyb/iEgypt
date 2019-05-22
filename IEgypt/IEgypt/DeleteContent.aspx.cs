using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class DeleteContent : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {
        /*SqlConnection cnn = new SqlConnection(WebConfigurationManager.ConnectionStrings["constr"].ConnectionString);
        cnn.Open();
        
        String[] arg = new string[1];
        arg = Convert.ToString((sender as LinkButton).CommandArgument).Split(' ');
        int content_id = Convert.ToInt32(arg[0]);
        //int original_content_id = Convert.ToInt32(arg[1]);
       // date = Convert.ToString(arg[2]);

        SqlCommand cmd = new SqlCommand("Delete_Original_Content", cnn);
        cmd.CommandType = System.Data.CommandType.StoredProcedure;
        cmd.Parameters.Add(new SqlParameter("@content_id", content_id));
       // cmd.Parameters.Add(new SqlParameter("@original_content_id", original_content_id));
       // cmd.Parameters.Add(new SqlParameter("@written_time", date));
        cmd.ExecuteNonQuery();
        cnn.Dispose();
        cnn.Close();
        Response.Redirect("DeleteContent.aspx");
        */
    }

    protected void GridView2_SelectedIndexChanged(object sender, EventArgs e)
    {

       /* SqlConnection cnn = new SqlConnection(WebConfigurationManager.ConnectionStrings["constr"].ConnectionString);
        cnn.Open();

        String[] arg = new string[1];
        arg = Convert.ToString((sender as LinkButton).CommandArgument).Split(' ');
        int content_id = Convert.ToInt32(arg[0]);
        //int original_content_id = Convert.ToInt32(arg[1]);
        // date = Convert.ToString(arg[2]);

        SqlCommand cmd = new SqlCommand(" Delete_New_Content", cnn);
        cmd.CommandType = System.Data.CommandType.StoredProcedure;
        cmd.Parameters.Add(new SqlParameter("@content_id", content_id));
        // cmd.Parameters.Add(new SqlParameter("@original_content_id", original_content_id));
        // cmd.Parameters.Add(new SqlParameter("@written_time", date));
        cmd.ExecuteNonQuery();
        cnn.Dispose();
        cnn.Close();
        Response.Redirect("DeleteContent.aspx");
        */
    }

    protected void lnkSelect2_Click(object sender, EventArgs e)
    {
        SqlConnection cnn = new SqlConnection(WebConfigurationManager.ConnectionStrings["constr"].ConnectionString);
        cnn.Open();

        String[] arg = new string[1];
        arg = Convert.ToString((sender as LinkButton).CommandArgument).Split(' ');
        int content_id = Convert.ToInt32(arg[0]);
        //int original_content_id = Convert.ToInt32(arg[1]);
        // date = Convert.ToString(arg[2]);

        SqlCommand cmd = new SqlCommand("Delete_New_Content", cnn);
        cmd.CommandType = System.Data.CommandType.StoredProcedure;
        cmd.Parameters.Add(new SqlParameter("@content_id", content_id));
        // cmd.Parameters.Add(new SqlParameter("@original_content_id", original_content_id));
        // cmd.Parameters.Add(new SqlParameter("@written_time", date));
        cmd.ExecuteNonQuery();
        cnn.Dispose();
        cnn.Close();
        Response.Redirect("DeleteContent.aspx");
    }

    protected void lnkSelect1_Click(object sender, EventArgs e)
    {
        SqlConnection cnn = new SqlConnection(WebConfigurationManager.ConnectionStrings["constr"].ConnectionString);
        cnn.Open();

        String[] arg = new string[1];
        arg = Convert.ToString((sender as LinkButton).CommandArgument).Split(' ');
        int content_id = Convert.ToInt32(arg[0]);
        //int original_content_id = Convert.ToInt32(arg[1]);
        // date = Convert.ToString(arg[2]);

        SqlCommand cmd = new SqlCommand("Delete_Original_Content", cnn);
        cmd.CommandType = System.Data.CommandType.StoredProcedure;
        cmd.Parameters.Add(new SqlParameter("@content_id", content_id));
        // cmd.Parameters.Add(new SqlParameter("@original_content_id", original_content_id));
        // cmd.Parameters.Add(new SqlParameter("@written_time", date));
        cmd.ExecuteNonQuery();
        cnn.Dispose();
        cnn.Close();
        Response.Redirect("DeleteContent.aspx");
    }

    protected void button4_Click(object sender, EventArgs e)
    {
        Response.Redirect("Profile.aspx");
    }
}
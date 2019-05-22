using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class DeleteComent : System.Web.UI.Page
{



    

    protected void Page_Load(object sender, EventArgs e)
    {
        SqlConnection connectionString = new SqlConnection(WebConfigurationManager.ConnectionStrings["constr"].ConnectionString);

       
        using (connectionString)
        {
         connectionString.Open();
        SqlDataAdapter sqlData = new SqlDataAdapter("SELECT * FROM Comment", connectionString);
        DataTable table = new DataTable();
        sqlData.Fill(table);

        }
        

            

    }

    protected void gridview_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        
    }

    protected void link(object sender, EventArgs e)
    {

    }


    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {
    /*    GridViewRow viewRow = GridView1.SelectedRow;

        String date = Convert.ToString(viewRow.Cells[1].Text);
        //String text = Convert.ToString(viewRow.Cells[4].Text);
        //int viewer_id = Convert.ToInt32(viewRow.Cells[1].Text);
        //int original_content_id = Convert.ToInt32(viewRow.Cells[2].Text);

        String connectionString;
        SqlConnection cnn;

        connectionString = WebConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        //connectionString = @"Data Source=LAPTOP-A3SPMF01\SQLEXPRESS;Initial Catalog=dd ;";

        cnn = new SqlConnection(connectionString);
        cnn.Open();

        SqlCommand cmd = new SqlCommand("Delete_Comment ", cnn);
        cmd.CommandType = System.Data.CommandType.StoredProcedure;
        cmd.Parameters.Add(new SqlParameter("@viewer_id", 1));
        cmd.Parameters.Add(new SqlParameter("@original_content_id", 2));
        cmd.Parameters.Add(new SqlParameter("@written_time", date));
        cmd.ExecuteNonQuery();
        cnn.Dispose();
        cnn.Close();
    */
    }

    protected void delete_Click(object sender, EventArgs e)
    {
        SqlConnection cnn = new SqlConnection(WebConfigurationManager.ConnectionStrings["constr"].ConnectionString);
        cnn.Open();
        String date;
        String[] arg = new string[3];
        arg = Convert.ToString((sender as LinkButton).CommandArgument).Split(';');
        int viewer_id = Convert.ToInt32(arg[0]);
        int original_content_id = Convert.ToInt32(arg[1]);
        date = Convert.ToString(arg[2]);

        SqlCommand cmd = new SqlCommand("Delete_Comment", cnn);
        cmd.CommandType = System.Data.CommandType.StoredProcedure;
        cmd.Parameters.Add(new SqlParameter("@viewer_id", viewer_id));
        cmd.Parameters.Add(new SqlParameter("@original_content_id", original_content_id));
        cmd.Parameters.Add(new SqlParameter("@written_time", date));
        cmd.ExecuteNonQuery();
        cnn.Dispose();
        cnn.Close();
        Response.Redirect("DeleteComent.aspx");

    }

    protected void button4_Click(object sender, EventArgs e)
    {
        Response.Redirect("Profile.aspx");
    }
}
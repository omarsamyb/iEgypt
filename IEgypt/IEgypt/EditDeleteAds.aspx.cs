using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IEgypt
{
    public partial class EditDeleteAds : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlDataReader reader;
            string connectionString = WebConfigurationManager.ConnectionStrings["constr"].ConnectionString;
            SqlConnection cnn = new SqlConnection(connectionString);
            cnn.Open();
            SqlCommand cmd = new SqlCommand("SELECT id, [description], [location],viewer_id FROM Advertisement", cnn);
            using (reader = cmd.ExecuteReader())
            {
                TableRow columnNames = new TableRow();
                TableCell edit = new TableCell(); edit.Text = "Edit"; columnNames.Cells.Add(edit);
                TableCell delete = new TableCell(); delete.Text = "Delete"; columnNames.Cells.Add(delete);
                TableCell desc = new TableCell(); desc.Text = "Description"; columnNames.Cells.Add(desc);
                TableCell loc = new TableCell(); loc.Text = "Location"; columnNames.Cells.Add(loc);
                info.Rows.Add(columnNames);
                columnNames.BorderStyle = BorderStyle.Solid;
                columnNames.HorizontalAlign = HorizontalAlign.Center;
                while (reader.Read())
                {
                    if (reader.HasRows)
                    {
                        if (Convert.ToInt32(reader.GetValue(3).ToString()) == Convert.ToInt32(Session["ID"]))
                        {
                            TableRow values = new TableRow();
                            LinkButton editLink = new LinkButton(); editLink.Text = "Edit"; editLink.Click += new EventHandler(editButtonClicked);editLink.CommandArgument = reader.GetValue(0).ToString();
                            LinkButton deleteLink = new LinkButton(); deleteLink.Text = "Delete"; deleteLink.Click += new EventHandler(deleteButtonClicked); deleteLink.CommandArgument = reader.GetValue(0).ToString();
                            TableCell cell1 = new TableCell();cell1.Controls.Add(editLink); values.Cells.Add(cell1);
                            TableCell cell2 = new TableCell();cell2.Controls.Add(deleteLink); values.Cells.Add(cell2);
                            TableCell cell3 = new TableCell(); cell3.Text = reader.GetValue(1).ToString(); values.Cells.Add(cell3);
                            TableCell cell4 = new TableCell(); cell4.Text = reader.GetValue(2).ToString(); values.Cells.Add(cell4);
                            values.ForeColor = System.Drawing.Color.Blue;
                            values.HorizontalAlign = HorizontalAlign.Center;
                            info.Rows.Add(values);
                        }
                    }
                    
                }
            }
        }
        protected void button1Clicked(object sender, EventArgs args)
        {
            Response.Redirect("Default.aspx");
        }
        protected void editButtonClicked(object sender, EventArgs args)
        {
            LinkButton btn = sender as LinkButton;
            int id = Convert.ToInt32(btn.CommandArgument);
            string desc = box1.Text;
            string loc = box2.Text;
            if (string.IsNullOrWhiteSpace(desc))
                desc = null;
            if (string.IsNullOrWhiteSpace(loc))
                loc = null;

            string connectionString = WebConfigurationManager.ConnectionStrings["constr"].ConnectionString;
            SqlConnection cnn = new SqlConnection(connectionString);
            cnn.Open();
            SqlCommand cmd = new SqlCommand("Edit_Ad", cnn);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@ad_id", id));
            cmd.Parameters.Add(new SqlParameter("@description", ToDBNull(desc)));
            cmd.Parameters.Add(new SqlParameter("@location", ToDBNull(loc)));
            cmd.ExecuteReader();
            cmd.Dispose();
            cnn.Close();
            Response.Redirect("Profile.aspx");
        }
        protected void deleteButtonClicked(object sender, EventArgs args)
        {
            LinkButton btn = sender as LinkButton;
            int id = Convert.ToInt32(btn.CommandArgument);
            string connectionString = WebConfigurationManager.ConnectionStrings["constr"].ConnectionString;
            SqlConnection cnn = new SqlConnection(connectionString);
            cnn.Open();
            SqlCommand cmd = new SqlCommand("Delete_Ads", cnn);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@ad_id", id));
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
}

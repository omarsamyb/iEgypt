using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IEgypt
{
    public partial class ShowNewContent : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlDataReader reader;
            string connectionString = WebConfigurationManager.ConnectionStrings["constr"].ConnectionString;
            SqlConnection cnn = new SqlConnection(connectionString);
            cnn.Open();
            SqlCommand cmd = new SqlCommand("SELECT New_Request.viewer_id, Content.contributer_id, Content.link, Content.uploaded_at, Content.category_type, Content.subcategory_name, Content.[type],[User].first_name, [User].middle_name, [User].last_name FROM New_Content INNER JOIN Content ON Content.ID=New_Content.ID INNER JOIN New_Request ON New_Request.id=New_Content.new_request_id INNER JOIN Contributor ON Contributor.ID=Content.contributer_id INNER JOIN [User] ON [User].ID=Contributor.ID", cnn);
            using (reader = cmd.ExecuteReader())
            {
                TableRow columnNames = new TableRow();
                TableCell link = new TableCell(); link.Text = "Link"; columnNames.Cells.Add(link);
                TableCell uploadedAt = new TableCell(); uploadedAt.Text = "Uploaded At"; columnNames.Cells.Add(uploadedAt);
                TableCell categoryName = new TableCell(); categoryName.Text = "Category"; columnNames.Cells.Add(categoryName);
                TableCell subC = new TableCell(); subC.Text = "Sub-Category"; columnNames.Cells.Add(subC);
                TableCell contentType = new TableCell(); contentType.Text = "Type"; columnNames.Cells.Add(contentType);
                TableCell contributor = new TableCell(); contributor.Text = "Contributor Name"; columnNames.Cells.Add(contributor);
                info.Rows.Add(columnNames);
                columnNames.BorderStyle = BorderStyle.Solid;
                columnNames.HorizontalAlign = HorizontalAlign.Center;
                while (reader.Read())
                {
                    if (reader.HasRows)
                    {
                        if (reader.GetValue(0).ToString().Equals(Session["ID"].ToString()))
                        {
                            TableRow values = new TableRow();
                            TableCell cell1 = new TableCell(); cell1.Text = reader.GetValue(2).ToString(); values.Cells.Add(cell1);
                            TableCell cell2 = new TableCell(); cell2.Text = reader.GetValue(3).ToString(); values.Cells.Add(cell2);
                            TableCell cell3 = new TableCell(); cell3.Text = reader.GetValue(4).ToString(); values.Cells.Add(cell3);
                            TableCell cell4 = new TableCell(); cell4.Text = reader.GetValue(5).ToString(); values.Cells.Add(cell4);
                            TableCell cell5 = new TableCell(); cell5.Text = reader.GetValue(6).ToString(); values.Cells.Add(cell5);
                            HyperLink name_redirect = new HyperLink();
                            name_redirect.NavigateUrl = "ShowNewContentProfileRedirect.aspx?id="+reader.GetValue(1).ToString();
                            name_redirect.Text = reader.GetValue(7).ToString() + " " + reader.GetValue(8).ToString() + " " + reader.GetValue(9).ToString();
                            TableCell cell6 = new TableCell();cell6.Controls.Add(name_redirect);values.Cells.Add(cell6);
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
    }
}

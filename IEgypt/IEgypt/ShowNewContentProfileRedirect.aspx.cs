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
    public partial class ShowNewContentProfileRedirect : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int id = Convert.ToInt16(Request.QueryString["id"]);
            SqlDataReader reader;
            string connectionString = WebConfigurationManager.ConnectionStrings["constr"].ConnectionString;
            SqlConnection cnn = new SqlConnection(connectionString);
            cnn.Open();
            SqlCommand cmd = new SqlCommand("Show_Profile", cnn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add(new SqlParameter("@user_id", id));
            cmd.Parameters.Add("@email", SqlDbType.VarChar, 255).Direction = System.Data.ParameterDirection.Output;
            cmd.Parameters.Add("@password", SqlDbType.VarChar, 255).Direction = System.Data.ParameterDirection.Output;
            cmd.Parameters.Add("@firstname", SqlDbType.VarChar, 255).Direction = System.Data.ParameterDirection.Output;
            cmd.Parameters.Add("@middlename", SqlDbType.VarChar, 255).Direction = System.Data.ParameterDirection.Output;
            cmd.Parameters.Add("@lastname", SqlDbType.VarChar, 255).Direction = System.Data.ParameterDirection.Output;
            cmd.Parameters.Add("@birth_date", SqlDbType.DateTime).Direction = System.Data.ParameterDirection.Output;
            cmd.Parameters.Add("@working_place_name", SqlDbType.VarChar, 255).Direction = System.Data.ParameterDirection.Output;
            cmd.Parameters.Add("@working_place_type", SqlDbType.VarChar, 255).Direction = System.Data.ParameterDirection.Output;
            cmd.Parameters.Add("@workring_place_description", SqlDbType.VarChar, 500).Direction = System.Data.ParameterDirection.Output;
            cmd.Parameters.Add("@specilization", SqlDbType.VarChar, 255).Direction = System.Data.ParameterDirection.Output;
            cmd.Parameters.Add("@portofolio_link", SqlDbType.VarChar, 500).Direction = System.Data.ParameterDirection.Output;
            cmd.Parameters.Add("@years_experience", SqlDbType.Int).Direction = System.Data.ParameterDirection.Output;
            cmd.Parameters.Add("@hire_date", SqlDbType.DateTime).Direction = System.Data.ParameterDirection.Output;
            cmd.Parameters.Add("@working_hours", SqlDbType.Int).Direction = System.Data.ParameterDirection.Output;
            cmd.Parameters.Add("@payment_rate", SqlDbType.Decimal).Direction = System.Data.ParameterDirection.Output;

            using (reader = cmd.ExecuteReader())
            {
                TableRow columnNames = new TableRow();
                //TableCell id = new TableCell(); id.Text = "ID"; columnNames.Cells.Add(id);
                TableCell email = new TableCell(); email.Text = "E-Mail"; columnNames.Cells.Add(email);
                //TableCell password = new TableCell(); password.Text = "Password"; columnNames.Cells.Add(password);
                TableCell firstname = new TableCell(); firstname.Text = "First Name"; columnNames.Cells.Add(firstname);
                TableCell middlename = new TableCell(); middlename.Text = "Middle Name"; columnNames.Cells.Add(middlename);
                TableCell lastname = new TableCell(); lastname.Text = "Last Name"; columnNames.Cells.Add(lastname);
                TableCell birthdate = new TableCell(); birthdate.Text = "Birth Date"; columnNames.Cells.Add(birthdate);
                //optional
                TableCell specilization = new TableCell(); specilization.Text = "Specialization"; columnNames.Cells.Add(specilization);
                TableCell portofolio_link = new TableCell(); portofolio_link.Text = "Portofolio Link"; columnNames.Cells.Add(portofolio_link);
                TableCell years_experience = new TableCell(); years_experience.Text = "No. of Experience Years"; columnNames.Cells.Add(years_experience);

                TableRow values = new TableRow();
                //TableCell cell1 = new TableCell(); cell1.Text = Session["ID"].ToString(); values.Cells.Add(cell1);
                TableCell cell2 = new TableCell(); cell2.Text = cmd.Parameters["@email"].Value.ToString(); values.Cells.Add(cell2);
                //TableCell cell3 = new TableCell(); cell3.Text = cmd.Parameters["@password"].Value.ToString(); values.Cells.Add(cell3);
                TableCell cell4 = new TableCell(); cell4.Text = cmd.Parameters["@firstname"].Value.ToString(); values.Cells.Add(cell4);
                TableCell cell5 = new TableCell(); cell5.Text = cmd.Parameters["@middlename"].Value.ToString(); values.Cells.Add(cell5);
                TableCell cell6 = new TableCell(); cell6.Text = cmd.Parameters["@lastname"].Value.ToString(); values.Cells.Add(cell6);
                TableCell cell7 = new TableCell(); cell7.Text = cmd.Parameters["@birth_date"].Value.ToString(); values.Cells.Add(cell7);
                //optional
                TableCell cell8 = new TableCell(); cell8.Text = cmd.Parameters["@specilization"].Value.ToString(); values.Cells.Add(cell8);
                TableCell cell9 = new TableCell(); cell9.Text = cmd.Parameters["@portofolio_link"].Value.ToString(); values.Cells.Add(cell9);
                TableCell cell10 = new TableCell(); cell10.Text = cmd.Parameters["@years_experience"].Value.ToString(); values.Cells.Add(cell10);
                info.Rows.Add(columnNames);
                info.Rows.Add(values);
                values.ForeColor = System.Drawing.Color.Blue;
                columnNames.BorderStyle = BorderStyle.Solid;
            }
        }
        protected void button1Clicked(object sender, EventArgs args)
        {
            Response.Redirect("Default.aspx");
        }
    }
}

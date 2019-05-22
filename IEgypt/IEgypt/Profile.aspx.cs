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
    public partial class _Profile : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlDataReader reader;
            string connectionString = WebConfigurationManager.ConnectionStrings["constr"].ConnectionString;
            SqlConnection cnn = new SqlConnection(connectionString);
            cnn.Open();
            SqlCommand cmd = new SqlCommand("Show_Profile", cnn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add(new SqlParameter("@user_id",Convert.ToInt32(Session["ID"])));
            cmd.Parameters.Add("@email", SqlDbType.VarChar,255).Direction = System.Data.ParameterDirection.Output;
            cmd.Parameters.Add("@password", SqlDbType.VarChar,255).Direction = System.Data.ParameterDirection.Output;
            cmd.Parameters.Add("@firstname", SqlDbType.VarChar,255).Direction = System.Data.ParameterDirection.Output;
            cmd.Parameters.Add("@middlename", SqlDbType.VarChar,255).Direction = System.Data.ParameterDirection.Output;
            cmd.Parameters.Add("@lastname", SqlDbType.VarChar,255).Direction = System.Data.ParameterDirection.Output;
            cmd.Parameters.Add("@birth_date", SqlDbType.DateTime).Direction = System.Data.ParameterDirection.Output;
            cmd.Parameters.Add("@working_place_name", SqlDbType.VarChar,255).Direction = System.Data.ParameterDirection.Output;
            cmd.Parameters.Add("@working_place_type", SqlDbType.VarChar,255).Direction = System.Data.ParameterDirection.Output;
            cmd.Parameters.Add("@workring_place_description", SqlDbType.VarChar,500).Direction = System.Data.ParameterDirection.Output;
            cmd.Parameters.Add("@specilization", SqlDbType.VarChar,255).Direction = System.Data.ParameterDirection.Output;
            cmd.Parameters.Add("@portofolio_link", SqlDbType.VarChar,500).Direction = System.Data.ParameterDirection.Output;
            cmd.Parameters.Add("@years_experience", SqlDbType.Int).Direction = System.Data.ParameterDirection.Output;
            cmd.Parameters.Add("@hire_date", SqlDbType.DateTime).Direction = System.Data.ParameterDirection.Output;
            cmd.Parameters.Add("@working_hours", SqlDbType.Int).Direction = System.Data.ParameterDirection.Output;
            cmd.Parameters.Add("@payment_rate", SqlDbType.Decimal).Direction = System.Data.ParameterDirection.Output;
            
            using (reader = cmd.ExecuteReader())
            {
                // it's a viewer
                if (!(string.IsNullOrWhiteSpace(cmd.Parameters["@working_place_name"].Value.ToString())))
                {
                    TableRow columnNames = new TableRow();
                    //TableCell id = new TableCell(); id.Text = "ID"; columnNames.Cells.Add(id);
                    TableCell email = new TableCell(); email.Text = "E-Mail"; columnNames.Cells.Add(email);
                    TableCell password = new TableCell(); password.Text = "Password"; columnNames.Cells.Add(password);
                    TableCell firstname = new TableCell(); firstname.Text = "First Name"; columnNames.Cells.Add(firstname);
                    TableCell middlename = new TableCell(); middlename.Text = "Middle Name"; columnNames.Cells.Add(middlename);
                    TableCell lastname = new TableCell(); lastname.Text = "Last Name"; columnNames.Cells.Add(lastname);
                    TableCell birthdate = new TableCell(); birthdate.Text = "Birth Date"; columnNames.Cells.Add(birthdate);
                    TableCell wpn = new TableCell(); wpn.Text = "Working Place Name"; columnNames.Cells.Add(wpn);
                    TableCell wpt = new TableCell(); wpt.Text = "Working Place Type"; columnNames.Cells.Add(wpt);
                    //optional
                    TableCell wpd = new TableCell(); wpd.Text = "Working Place Description"; columnNames.Cells.Add(wpd);
                    
                    TableRow values = new TableRow();
                    //TableCell cell1 = new TableCell(); cell1.Text = Session["ID"].ToString(); values.Cells.Add(cell1);
                    TableCell cell2 = new TableCell(); cell2.Text = cmd.Parameters["@email"].Value.ToString(); values.Cells.Add(cell2);
                    TableCell cell3 = new TableCell(); cell3.Text = cmd.Parameters["@password"].Value.ToString(); values.Cells.Add(cell3);
                    TableCell cell4 = new TableCell(); cell4.Text = cmd.Parameters["@firstname"].Value.ToString(); values.Cells.Add(cell4);
                    TableCell cell5 = new TableCell(); cell5.Text = cmd.Parameters["@middlename"].Value.ToString(); values.Cells.Add(cell5);
                    TableCell cell6 = new TableCell(); cell6.Text = cmd.Parameters["@lastname"].Value.ToString(); values.Cells.Add(cell6);
                    TableCell cell7 = new TableCell(); cell7.Text = cmd.Parameters["@birth_date"].Value.ToString(); values.Cells.Add(cell7);
                    TableCell cell8 = new TableCell(); cell8.Text = cmd.Parameters["@working_place_name"].Value.ToString(); values.Cells.Add(cell8);
                    TableCell cell9 = new TableCell(); cell9.Text = cmd.Parameters["@working_place_type"].Value.ToString(); values.Cells.Add(cell9);
                    //optional
                    TableCell cell10 = new TableCell(); cell10.Text = cmd.Parameters["@workring_place_description"].Value.ToString(); values.Cells.Add(cell10);
                    info.Rows.Add(columnNames);
                    info.Rows.Add(values);
                    values.ForeColor = System.Drawing.Color.Blue;
                    columnNames.BorderStyle = BorderStyle.Solid;

                    viewer.Visible = true;
                    contributor.Visible = false;
                    staff.Visible = false;
                }
                // it's a staff
                else if (!(string.IsNullOrWhiteSpace(cmd.Parameters["@payment_rate"].Value.ToString())))
                {
                    TableRow columnNames = new TableRow();
                    //TableCell id = new TableCell(); id.Text = "ID"; columnNames.Cells.Add(id);
                    TableCell email = new TableCell(); email.Text = "E-Mail"; columnNames.Cells.Add(email);
                    TableCell password = new TableCell(); password.Text = "Password"; columnNames.Cells.Add(password);
                    TableCell firstname = new TableCell(); firstname.Text = "First Name"; columnNames.Cells.Add(firstname);
                    TableCell middlename = new TableCell(); middlename.Text = "Middle Name"; columnNames.Cells.Add(middlename);
                    TableCell lastname = new TableCell(); lastname.Text = "Last Name"; columnNames.Cells.Add(lastname);
                    TableCell birthdate = new TableCell(); birthdate.Text = "Birth Date"; columnNames.Cells.Add(birthdate);
                    TableCell hiredate = new TableCell(); hiredate.Text = "Hire Date"; columnNames.Cells.Add(hiredate);
                    TableCell workinghours = new TableCell(); workinghours.Text = "Working Hours"; columnNames.Cells.Add(workinghours);
                    TableCell paymentrate = new TableCell(); paymentrate.Text = "Payment Rate"; columnNames.Cells.Add(paymentrate);
                    

                    TableRow values = new TableRow();
                    //TableCell cell1 = new TableCell(); cell1.Text = Session["ID"].ToString(); values.Cells.Add(cell1);
                    TableCell cell2 = new TableCell(); cell2.Text = cmd.Parameters["@email"].Value.ToString(); values.Cells.Add(cell2);
                    TableCell cell3 = new TableCell(); cell3.Text = cmd.Parameters["@password"].Value.ToString(); values.Cells.Add(cell3);
                    TableCell cell4 = new TableCell(); cell4.Text = cmd.Parameters["@firstname"].Value.ToString(); values.Cells.Add(cell4);
                    TableCell cell5 = new TableCell(); cell5.Text = cmd.Parameters["@middlename"].Value.ToString(); values.Cells.Add(cell5);
                    TableCell cell6 = new TableCell(); cell6.Text = cmd.Parameters["@lastname"].Value.ToString(); values.Cells.Add(cell6);
                    TableCell cell7 = new TableCell(); cell7.Text = cmd.Parameters["@birth_date"].Value.ToString(); values.Cells.Add(cell7);
                    TableCell cell8 = new TableCell(); cell8.Text = cmd.Parameters["@hire_date"].Value.ToString(); values.Cells.Add(cell8);
                    TableCell cell9 = new TableCell(); cell9.Text = cmd.Parameters["@working_hours"].Value.ToString(); values.Cells.Add(cell9);
                    TableCell cell10 = new TableCell(); cell10.Text = cmd.Parameters["@payment_rate"].Value.ToString(); values.Cells.Add(cell10);
                    cmd.Dispose();
                    reader.Close();
                    cmd = new SqlCommand("SELECT * FROM Content_manager", cnn);
                    reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        if (Convert.ToInt32(reader.GetValue(0)) == Convert.ToInt32(Session["ID"]))
                        {
                            TableCell type = new TableCell(); type.Text = "Content Type Speciality"; columnNames.Cells.Add(type);
                            cmd.Dispose();
                            reader.Close();
                            cmd = new SqlCommand("SELECT * FROM Content_manager",cnn);
                            reader = cmd.ExecuteReader();
                            while (reader.Read())
                            {
                                if (Convert.ToInt32(reader.GetValue(0)) == Convert.ToInt32(Session["ID"]))
                                {
                                    TableCell cell11 = new TableCell(); cell11.Text = reader.GetValue(1).ToString(); values.Cells.Add(cell11);
                                    break;
                                }
                            }
                            break;
                        }
                    }

                    info.Rows.Add(columnNames);
                    info.Rows.Add(values);
                    values.ForeColor = System.Drawing.Color.Blue;
                    columnNames.BorderStyle = BorderStyle.Solid;

                    viewer.Visible = false;
                    contributor.Visible = false;
                    staff.Visible = true;
                }
                //it's a contributor
                else
                {
                    TableRow columnNames = new TableRow();
                    //TableCell id = new TableCell(); id.Text = "ID"; columnNames.Cells.Add(id);
                    TableCell email = new TableCell(); email.Text = "E-Mail"; columnNames.Cells.Add(email);
                    TableCell password = new TableCell(); password.Text = "Password"; columnNames.Cells.Add(password);
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
                    TableCell cell3 = new TableCell(); cell3.Text = cmd.Parameters["@password"].Value.ToString(); values.Cells.Add(cell3);
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

                    viewer.Visible = false;
                    contributor.Visible = true;
                    staff.Visible = false;
                }
            }
            reader.Close();
            cmd.Dispose();
            cnn.Close();
        }
        // home
        protected void button1Clicked(object sender, EventArgs args)
        {
            Response.Redirect("Default.aspx");
        }
        // edit profile
        protected void button2Clicked(object sender, EventArgs args)
        {
            Response.Redirect("Edit.aspx");
        }
        // deactivate profile
        protected void button3Clicked(object sender, EventArgs args)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["constr"].ConnectionString;
            SqlConnection cnn = new SqlConnection(connectionString);
            cnn.Open();
            SqlCommand cmd = new SqlCommand("Deactivate_Profile", cnn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add(new SqlParameter("@user_id", Convert.ToInt32(Session["ID"])));
            cmd.ExecuteReader();
            cmd.Dispose();
            cnn.Close();
            Session["ID"] = null;
            Response.Redirect("Default.aspx");
        }
        // sign out
        protected void button4Clicked(object sender, EventArgs args)
        {
            Session["ID"] = null;
            Response.Redirect("Default.aspx");
        }


        // Different components integration
        //viewer
        protected void button5Clicked(object sender, EventArgs e)
        {

        }

        protected void button6Clicked(object sender, EventArgs e)
        {

        }

        protected void button7Clicked(object sender, EventArgs e)
        {

        }

        protected void button8Clicked(object sender, EventArgs e)
        {

        }

        protected void button9Clicked(object sender, EventArgs e)
        {

        }

        protected void button10Clicked(object sender, EventArgs e)
        {

        }

        protected void button11Clicked(object sender, EventArgs e)
        {

        }

        protected void button12Clicked(object sender, EventArgs e)
        {
            Response.Redirect("CreateAds.aspx");
        }

        protected void button13Clicked(object sender, EventArgs e)
        {
            Response.Redirect("EditDeleteAds.aspx");
        }

        protected void button14Clicked(object sender, EventArgs e)
        {
            Response.Redirect("ShowNewContent.aspx");
        }
        //contributor
        protected void button15Clicked(object sender, EventArgs e)
        {
            Response.Redirect("Upload_OriginalContent.aspx");
        }

        protected void button16Clicked(object sender, EventArgs e)
        {
            Response.Redirect("Recieve_Requests.aspx");
        }

        protected void button17Clicked(object sender, EventArgs e)
        {
            Response.Redirect("Respond_Requests.aspx");
        }

        protected void button18Clicked(object sender, EventArgs e)
        {
            Response.Redirect("Message.aspx");
        }

        protected void button19Clicked(object sender, EventArgs e)
        {
            Response.Redirect("Upload_NewContent.aspx");
        }

        protected void button20Clicked(object sender, EventArgs e)
        {
            Response.Redirect("Delete_myContent.aspx");
        }

        protected void button21Clicked(object sender, EventArgs e)
        {
            Response.Redirect("Contributor_Notifications.aspx");
        }

        protected void button22Clicked(object sender, EventArgs e)
        {
            Response.Redirect("Show_Events.aspx");
        }

        protected void button23Clicked(object sender, EventArgs e)
        {
            Response.Redirect("Show_Advertisments.aspx");
        }
        //staff
        protected void button24Clicked(object sender, EventArgs e)
        {
            Response.Redirect("Filter.aspx");
        }

        protected void button25Clicked(object sender, EventArgs e)
        {
            Response.Redirect("CategoryAndSubCategory.aspx");
        }

        protected void button26Clicked(object sender, EventArgs e)
        {
            Response.Redirect("Content2t.aspx");
        }

        protected void button27Clicked(object sender, EventArgs e)
        {
            Response.Redirect("NumberOfExistingRequests.aspx");
        }

        protected void button28Clicked(object sender, EventArgs e)
        {
            Response.Redirect("NumberOfNewAndExisitingReq.aspx");
        }

        protected void button29Clicked(object sender, EventArgs e)
        {
            Response.Redirect("ShowNotifications.aspx");
        }

        protected void button30Clicked(object sender, EventArgs e)
        {
            Response.Redirect("DeleteComent.aspx");
        }

        protected void button31Clicked(object sender, EventArgs e)
        {
            Response.Redirect("DeleteContent.aspx");
        }

        protected void button32Clicked(object sender, EventArgs e)
        {
            Response.Redirect("Order_The_Contributor.aspx");
        }

        protected void button33Clicked(object sender, EventArgs e)
        {
            Response.Redirect("Assign.aspx");
        }
    }
}

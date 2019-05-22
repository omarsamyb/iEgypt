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
    public partial class Search : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["ID"] ==null)
            {
                button2.Visible = false;
            }
            string connectionString = WebConfigurationManager.ConnectionStrings["constr"].ConnectionString;
            SqlConnection cnn = new SqlConnection(connectionString);
            cnn.Open();
            SqlDataReader reader;
            SqlCommand cmd;
            int searchType = Convert.ToInt16(Request.QueryString["id"]);
            // Search for any original content by its type or its category.
            if (searchType == 0)
            {
                string type = Request.QueryString["type"];
                string category = Request.QueryString["category"];
                if (string.IsNullOrWhiteSpace(type))
                {
                    type = null;
                }
                if (string.IsNullOrWhiteSpace(category))
                {
                    category = null;
                }
                cmd = new SqlCommand("Original_Content_Search", cnn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@typename",Search.ToDBNull(type)));
                cmd.Parameters.Add(new SqlParameter("@categoryname",Search.ToDBNull(category)));
                using (reader = cmd.ExecuteReader())
                {
                    TableRow columnNames = new TableRow();
                    //TableCell id = new TableCell(); id.Text = "ID"; columnNames.Cells.Add(id);
                    //TableCell managerID = new TableCell(); managerID.Text = "Manager ID"; columnNames.Cells.Add(managerID);
                    //TableCell reviewerID = new TableCell(); reviewerID.Text = "Reviewer ID"; columnNames.Cells.Add(reviewerID);
                    TableCell reviewStatus = new TableCell(); reviewStatus.Text = "Review Status"; columnNames.Cells.Add(reviewStatus);
                    TableCell filterStatus = new TableCell(); filterStatus.Text = "Filter Status"; columnNames.Cells.Add(filterStatus);
                    TableCell rating = new TableCell(); rating.Text = "Rating"; columnNames.Cells.Add(rating);
                    TableCell link = new TableCell(); link.Text = "Link"; columnNames.Cells.Add(link);
                    TableCell uploadedAt = new TableCell(); uploadedAt.Text = "Uploaded At"; columnNames.Cells.Add(uploadedAt);
                    //TableCell contributor = new TableCell(); contributor.Text = "Contributor ID"; columnNames.Cells.Add(contributor);
                    TableCell categoryName = new TableCell(); categoryName.Text = "Category"; columnNames.Cells.Add(categoryName);
                    TableCell subC = new TableCell(); subC.Text = "Sub-Category"; columnNames.Cells.Add(subC);
                    TableCell contentType = new TableCell(); contentType.Text = "Type"; columnNames.Cells.Add(contentType);
                    table.Rows.Add(columnNames);
                    columnNames.BorderStyle = BorderStyle.Solid;
                    columnNames.HorizontalAlign = HorizontalAlign.Center;
                    while (reader.Read())
                    {
                        TableRow values = new TableRow();
                        //TableCell cell1 = new TableCell(); cell1.Text = reader.GetValue(0).ToString(); values.Cells.Add(cell1);
                        //TableCell cell2 = new TableCell(); cell2.Text = reader.GetValue(1).ToString(); values.Cells.Add(cell2);
                        //TableCell cell3 = new TableCell(); cell3.Text = reader.GetValue(2).ToString(); values.Cells.Add(cell3);
                        TableCell cell4 = new TableCell(); cell4.Text = reader.GetValue(3).ToString(); values.Cells.Add(cell4);
                        TableCell cell5 = new TableCell(); cell5.Text = reader.GetValue(4).ToString(); values.Cells.Add(cell5);
                        TableCell cell6 = new TableCell(); cell6.Text = reader.GetValue(5).ToString(); values.Cells.Add(cell6);
                        TableCell cell7 = new TableCell(); cell7.Text = reader.GetValue(6).ToString(); values.Cells.Add(cell7);
                        //TableCell cell8 = new TableCell(); cell8.Text = reader.GetValue(7).ToString(); values.Cells.Add(cell8);
                        TableCell cell9 = new TableCell(); cell9.Text = reader.GetValue(8).ToString(); values.Cells.Add(cell9);
                        TableCell cell10 = new TableCell(); cell10.Text = reader.GetValue(9).ToString(); values.Cells.Add(cell10);
                        TableCell cell11 = new TableCell(); cell11.Text = reader.GetValue(10).ToString(); values.Cells.Add(cell11);
                        TableCell cell12 = new TableCell(); cell12.Text = reader.GetValue(11).ToString(); values.Cells.Add(cell12);
                        values.ForeColor = System.Drawing.Color.Blue;
                        values.HorizontalAlign = HorizontalAlign.Center;
                        table.Rows.Add(values);
                    }
                    reader.Close();
                    cmd.Dispose();
                    cnn.Close();
                }
            }
            // Search for any contributor by his/her name.
            else if (searchType == 2)
            {
                string name = Request.QueryString["name"];
                cmd = new SqlCommand("Contributor_Search", cnn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@fullname", name));
                using (reader = cmd.ExecuteReader())
                {
                    if (reader.HasRows)
                    {
                        TableRow columnNames = new TableRow();
                        //TableCell id = new TableCell(); id.Text = "ID"; columnNames.Cells.Add(id);
                        TableCell email = new TableCell(); email.Text = "E-Mail"; columnNames.Cells.Add(email);
                        TableCell firstname = new TableCell(); firstname.Text = "First Name"; columnNames.Cells.Add(firstname);
                        TableCell middlename = new TableCell(); middlename.Text = "Middle Name"; columnNames.Cells.Add(middlename);
                        TableCell lastname = new TableCell(); lastname.Text = "Last Name"; columnNames.Cells.Add(lastname);
                        TableCell birthdate = new TableCell(); birthdate.Text = "Birth Date"; columnNames.Cells.Add(birthdate);
                        TableCell age = new TableCell(); age.Text = "Age"; columnNames.Cells.Add(age);
                        TableCell lastlogin = new TableCell(); lastlogin.Text = "Last Login"; columnNames.Cells.Add(lastlogin);
                        TableCell status = new TableCell(); status.Text = "Status"; columnNames.Cells.Add(status);
                        TableCell portofolio_link = new TableCell(); portofolio_link.Text = "Portofolio Link"; columnNames.Cells.Add(portofolio_link);
                        TableCell specilization = new TableCell(); specilization.Text = "Specialization"; columnNames.Cells.Add(specilization);
                        TableCell years_experience = new TableCell(); years_experience.Text = "No. of Experience Years"; columnNames.Cells.Add(years_experience);
                        table.Rows.Add(columnNames);
                        columnNames.BorderStyle = BorderStyle.Solid;
                        while (reader.Read())
                        {
                            TableRow values = new TableRow();
                            //TableCell cell1 = new TableCell(); cell1.Text = reader.GetValue(0).ToString(); values.Cells.Add(cell1);
                            TableCell cell2 = new TableCell(); cell2.Text = reader.GetValue(1).ToString(); values.Cells.Add(cell2);
                            TableCell cell3 = new TableCell(); cell3.Text = reader.GetValue(2).ToString(); values.Cells.Add(cell3);
                            TableCell cell4 = new TableCell(); cell4.Text = reader.GetValue(3).ToString(); values.Cells.Add(cell4);
                            TableCell cell5 = new TableCell(); cell5.Text = reader.GetValue(4).ToString(); values.Cells.Add(cell5);
                            TableCell cell6 = new TableCell(); cell6.Text = reader.GetValue(5).ToString(); values.Cells.Add(cell6);
                            TableCell cell7 = new TableCell(); cell7.Text = reader.GetValue(6).ToString(); values.Cells.Add(cell7);
                            TableCell cell8 = new TableCell(); cell8.Text = reader.GetValue(7).ToString(); values.Cells.Add(cell8);
                            TableCell cell9 = new TableCell(); cell9.Text = reader.GetValue(8).ToString(); values.Cells.Add(cell9);
                            TableCell cell10 = new TableCell(); cell10.Text = reader.GetValue(9).ToString(); values.Cells.Add(cell10);
                            TableCell cell11 = new TableCell(); cell11.Text = reader.GetValue(10).ToString(); values.Cells.Add(cell11);
                            TableCell cell12 = new TableCell(); cell12.Text = reader.GetValue(11).ToString(); values.Cells.Add(cell12);
                            table.Rows.Add(values);
                            values.ForeColor = System.Drawing.Color.Blue;
                        }
                    }
                    else
                    {
                        popup.Visible = true;
                        popup.ForeColor = System.Drawing.Color.Red;
                        popupText.Text = "This Name Doesn't Exist";
                    }
                }
                reader.Close();
                cmd.Dispose();
                cnn.Close();
            }
            //Show the approved original content along with all the information of the contributor who uploaded it.
            else if (searchType == 1)
            {
                string name = Request.QueryString["name"];
                int? idContributor = null;
                if (!string.IsNullOrWhiteSpace(name))
                {
                    cmd = new SqlCommand("Contributor_Search", cnn);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@fullname", name));
                    using (reader = cmd.ExecuteReader())
                    {
                        if (reader.HasRows)
                        {
                            reader.Read();
                            idContributor = Convert.ToInt32(reader.GetValue(0).ToString());
                        }
                        else
                            idContributor = -1;
                    }
                    cmd.Dispose();
                    reader.Close();
                    if (idContributor == -1)
                    {
                        popup.Visible = true;
                        popup.ForeColor = System.Drawing.Color.Red;
                        popupText.Text = "This Name Doesn't Exist";
                        return;
                    }
                    
                }
           
                cmd = new SqlCommand("Show_Original_Content", cnn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@contributor_id", Search.ToDBNull(idContributor)));
                using (reader = cmd.ExecuteReader())
                {
                    if (reader.HasRows)
                    {
                        TableRow columnNames = new TableRow();
                        //TableCell id = new TableCell(); id.Text = "ID"; columnNames.Cells.Add(id);
                        //TableCell managerID = new TableCell(); managerID.Text = "Manager ID"; columnNames.Cells.Add(managerID);
                        //TableCell reviewerID = new TableCell(); reviewerID.Text = "Reviewer ID"; columnNames.Cells.Add(reviewerID);
                        TableCell reviewStatus = new TableCell(); reviewStatus.Text = "Review Status"; columnNames.Cells.Add(reviewStatus);
                        TableCell filterStatus = new TableCell(); filterStatus.Text = "Filter Status"; columnNames.Cells.Add(filterStatus);
                        TableCell rating = new TableCell(); rating.Text = "Rating"; columnNames.Cells.Add(rating);
                        TableCell link = new TableCell(); link.Text = "Link"; columnNames.Cells.Add(link);
                        TableCell uploadedAt = new TableCell(); uploadedAt.Text = "Uploaded At"; columnNames.Cells.Add(uploadedAt);
                        //TableCell contributor = new TableCell(); contributor.Text = "Contributor ID"; columnNames.Cells.Add(contributor);
                        TableCell categoryName = new TableCell(); categoryName.Text = "Category"; columnNames.Cells.Add(categoryName);
                        TableCell subC = new TableCell(); subC.Text = "Sub-Category"; columnNames.Cells.Add(subC);
                        TableCell contentType = new TableCell(); contentType.Text = "Type"; columnNames.Cells.Add(contentType);
                        TableCell email = new TableCell(); email.Text = "E-Mail"; columnNames.Cells.Add(email);
                        TableCell firstname = new TableCell(); firstname.Text = "First Name"; columnNames.Cells.Add(firstname);
                        TableCell middlename = new TableCell(); middlename.Text = "Middle Name"; columnNames.Cells.Add(middlename);
                        TableCell lastname = new TableCell(); lastname.Text = "Last Name"; columnNames.Cells.Add(lastname);
                        TableCell birthdate = new TableCell(); birthdate.Text = "Birth Date"; columnNames.Cells.Add(birthdate);
                        TableCell age = new TableCell(); age.Text = "Age"; columnNames.Cells.Add(age);
                        TableCell lastlogin = new TableCell(); lastlogin.Text = "Last Login"; columnNames.Cells.Add(lastlogin);
                        TableCell status = new TableCell(); status.Text = "Status"; columnNames.Cells.Add(status);
                        TableCell portofolio_link = new TableCell(); portofolio_link.Text = "Portofolio Link"; columnNames.Cells.Add(portofolio_link);
                        TableCell specilization = new TableCell(); specilization.Text = "Specialization"; columnNames.Cells.Add(specilization);
                        TableCell years_experience = new TableCell(); years_experience.Text = "No. of Experience Years"; columnNames.Cells.Add(years_experience);

                        table.Rows.Add(columnNames);
                        columnNames.BorderStyle = BorderStyle.Solid;
                        columnNames.HorizontalAlign = HorizontalAlign.Center;
                        while (reader.Read())
                        {
                            TableRow values = new TableRow();
                            //TableCell cell1 = new TableCell(); cell1.Text = reader.GetValue(0).ToString(); values.Cells.Add(cell1);
                            //TableCell cell2 = new TableCell(); cell2.Text = reader.GetValue(1).ToString(); values.Cells.Add(cell2);
                            //TableCell cell3 = new TableCell(); cell3.Text = reader.GetValue(2).ToString(); values.Cells.Add(cell3);
                            TableCell cell4 = new TableCell(); cell4.Text = reader.GetValue(3).ToString(); values.Cells.Add(cell4);
                            TableCell cell5 = new TableCell(); cell5.Text = reader.GetValue(4).ToString(); values.Cells.Add(cell5);
                            TableCell cell6 = new TableCell(); cell6.Text = reader.GetValue(5).ToString(); values.Cells.Add(cell6);
                            TableCell cell7 = new TableCell(); cell7.Text = reader.GetValue(6).ToString(); values.Cells.Add(cell7);
                            TableCell cell8 = new TableCell(); cell8.Text = reader.GetValue(7).ToString(); values.Cells.Add(cell8);
                            //TableCell cell9 = new TableCell(); cell9.Text = reader.GetValue(8).ToString(); values.Cells.Add(cell9);
                            TableCell cell10 = new TableCell(); cell10.Text = reader.GetValue(9).ToString(); values.Cells.Add(cell10);
                            TableCell cell11 = new TableCell(); cell11.Text = reader.GetValue(10).ToString(); values.Cells.Add(cell11);
                            TableCell cell12 = new TableCell(); cell12.Text = reader.GetValue(11).ToString(); values.Cells.Add(cell12);
                            TableCell cell13 = new TableCell(); cell13.Text = reader.GetValue(12).ToString(); values.Cells.Add(cell13);
                            TableCell cell14 = new TableCell(); cell14.Text = reader.GetValue(13).ToString(); values.Cells.Add(cell14);
                            TableCell cell15 = new TableCell(); cell15.Text = reader.GetValue(14).ToString(); values.Cells.Add(cell15);
                            TableCell cell16 = new TableCell(); cell16.Text = reader.GetValue(15).ToString(); values.Cells.Add(cell16);
                            TableCell cell17 = new TableCell(); cell17.Text = reader.GetValue(16).ToString(); values.Cells.Add(cell17);
                            TableCell cell18 = new TableCell(); cell18.Text = reader.GetValue(17).ToString(); values.Cells.Add(cell18);
                            TableCell cell19 = new TableCell(); cell19.Text = reader.GetValue(18).ToString(); values.Cells.Add(cell19);
                            TableCell cell20 = new TableCell(); cell20.Text = reader.GetValue(19).ToString(); values.Cells.Add(cell20);
                            TableCell cell21 = new TableCell(); cell21.Text = reader.GetValue(20).ToString(); values.Cells.Add(cell21);
                            TableCell cell22 = new TableCell(); cell22.Text = reader.GetValue(21).ToString(); values.Cells.Add(cell22);
                            TableCell cell23 = new TableCell(); cell23.Text = reader.GetValue(22).ToString(); values.Cells.Add(cell23);

                            values.ForeColor = System.Drawing.Color.Blue;
                            values.HorizontalAlign = HorizontalAlign.Center;
                            table.Rows.Add(values);

                        }
                        reader.Close();
                        cmd.Dispose();
                        cnn.Close();
                    }
                    else
                    {
                        popup.Visible = true;
                        popup.ForeColor = System.Drawing.Color.Red;
                        popupText.Text = "No Original Content found for Contributor "+name;
                    }
                }
                reader.Close();
                cmd.Dispose();
                cnn.Close();
            }
            else
            {
                cmd = new SqlCommand("Order_Contributor", cnn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                using (reader = cmd.ExecuteReader())
                {
                    TableRow columnNames = new TableRow();
                    //TableCell id = new TableCell(); id.Text = "ID"; columnNames.Cells.Add(id);
                    TableCell email = new TableCell(); email.Text = "E-Mail"; columnNames.Cells.Add(email);
                    TableCell firstname = new TableCell(); firstname.Text = "First Name"; columnNames.Cells.Add(firstname);
                    TableCell middlename = new TableCell(); middlename.Text = "Middle Name"; columnNames.Cells.Add(middlename);
                    TableCell lastname = new TableCell(); lastname.Text = "Last Name"; columnNames.Cells.Add(lastname);
                    TableCell birthdate = new TableCell(); birthdate.Text = "Birth Date"; columnNames.Cells.Add(birthdate);
                    TableCell age = new TableCell(); age.Text = "Age"; columnNames.Cells.Add(age);
                    TableCell lastlogin = new TableCell(); lastlogin.Text = "Last Login"; columnNames.Cells.Add(lastlogin);
                    TableCell status = new TableCell(); status.Text = "Status"; columnNames.Cells.Add(status);
                    TableCell portofolio_link = new TableCell(); portofolio_link.Text = "Portofolio Link"; columnNames.Cells.Add(portofolio_link);
                    TableCell specilization = new TableCell(); specilization.Text = "Specialization"; columnNames.Cells.Add(specilization);
                    TableCell years_experience = new TableCell(); years_experience.Text = "No. of Experience Years"; columnNames.Cells.Add(years_experience);
                    table.Rows.Add(columnNames);
                    columnNames.BorderStyle = BorderStyle.Solid;
                    columnNames.HorizontalAlign = HorizontalAlign.Center;
                    while (reader.Read())
                    {
                        TableRow values = new TableRow();
                        //TableCell cell1 = new TableCell(); cell1.Text = reader.GetValue(0).ToString(); values.Cells.Add(cell1);
                        TableCell cell2 = new TableCell(); cell2.Text = reader.GetValue(1).ToString(); values.Cells.Add(cell2);
                        TableCell cell3 = new TableCell(); cell3.Text = reader.GetValue(2).ToString(); values.Cells.Add(cell3);
                        TableCell cell4 = new TableCell(); cell4.Text = reader.GetValue(3).ToString(); values.Cells.Add(cell4);
                        TableCell cell5 = new TableCell(); cell5.Text = reader.GetValue(4).ToString(); values.Cells.Add(cell5);
                        TableCell cell6 = new TableCell(); cell6.Text = reader.GetValue(5).ToString(); values.Cells.Add(cell6);
                        TableCell cell7 = new TableCell(); cell7.Text = reader.GetValue(6).ToString(); values.Cells.Add(cell7);
                        TableCell cell8 = new TableCell(); cell8.Text = reader.GetValue(7).ToString(); values.Cells.Add(cell8);
                        TableCell cell9 = new TableCell(); cell9.Text = reader.GetValue(8).ToString(); values.Cells.Add(cell9);
                        TableCell cell10 = new TableCell(); cell10.Text = reader.GetValue(9).ToString(); values.Cells.Add(cell10);
                        TableCell cell11 = new TableCell(); cell11.Text = reader.GetValue(10).ToString(); values.Cells.Add(cell11);
                        TableCell cell12 = new TableCell(); cell12.Text = reader.GetValue(11).ToString(); values.Cells.Add(cell12);
                        values.ForeColor = System.Drawing.Color.Blue;
                        values.HorizontalAlign = HorizontalAlign.Center;
                        table.Rows.Add(values);
                    }
                }
                reader.Close();
                cmd.Dispose();
                cnn.Close();
            }
            
        }
        protected void button1Clicked (object sender, EventArgs args)
        {
            Response.Redirect("Default.aspx");
        }
        protected void button2Clicked(object sender, EventArgs args)
        {
            Response.Redirect("Profile.aspx");
        }
        protected void okButtonClicked(object sender, EventArgs e)
        {
            popup.Visible = false;
            Response.Redirect("Default.aspx");
        }
        public static object ToDBNull(object value)
        {
            if (value != null)
                return value;
            return DBNull.Value;
        }
    }
}
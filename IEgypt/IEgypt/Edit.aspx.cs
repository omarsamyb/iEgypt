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
    public partial class Edit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlDataReader reader;

            string connectionString = WebConfigurationManager.ConnectionStrings["constr"].ConnectionString;
            SqlConnection cnn = new SqlConnection(connectionString);
            cnn.Open();

            SqlCommand cmd = new SqlCommand("SELECT [User].ID,working_place,payment_rate FROM [User] LEFT JOIN Viewer ON Viewer.id=[User].ID LEFT JOIN Staff ON Staff.id=[User].ID",cnn);
            reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                if (Convert.ToInt32(reader.GetValue(0)) == Convert.ToInt32(Session["ID"]))
                {
                    if (!(string.IsNullOrWhiteSpace(reader.GetValue(1).ToString())))
                    {
                        viewer.Visible = true;
                    }
                    else if (!(string.IsNullOrWhiteSpace(reader.GetValue(2).ToString())))
                    {
                        staff.Visible = true;
                        cmd.Dispose();
                        reader.Close();
                        cmd = new SqlCommand("SELECT * FROM Content_manager", cnn);
                        reader = cmd.ExecuteReader();
                        while (reader.Read())
                        {
                            if (Convert.ToInt32(reader.GetValue(0)) == Convert.ToInt32(Session["ID"]))
                            {
                                reader.Close();
                                cmd.Dispose();
                                cmd = new SqlCommand("SELECT * FROM Content_type",cnn);
                                reader = cmd.ExecuteReader();
                                while (reader.Read())
                                {
                                    ListItem x = new ListItem();
                                    x.Text = reader.GetValue(0).ToString();
                                    typeList.Items.Add(x);
                                }
                                manager.Visible = true;
                                break;
                            }
                        }
                    }
                    else
                        contributor.Visible = true;
                }
            }
            reader.Close();
            cmd.Dispose();
            cnn.Close();
        }
        protected void edit_buttonClicked(object sender, EventArgs e)
        {
            string email = emailTB.Text;
            string password = passwordTB.Text;
            string fname = fnTB.Text;
            string mname = mnTB.Text;
            string lname = lnTB.Text;
            string birthdate = birthTB.Text;
            string wpn = wpnTB.Text;
            string wpt = wptTB.Text;
            string wpd = wpdTB.Text;
            string specialization = specializationTB.Text;
            string portofolio = plTB.Text;
            string exp = expTB.Text;
            string hireDate = hdTB.Text;
            string workingHours = whTB.Text;
            string paymentRate = prTB.Text;
            string type = typeList.SelectedItem.Text;
            SqlDataReader reader;

            string connectionString = WebConfigurationManager.ConnectionStrings["constr"].ConnectionString;
            SqlConnection cnn = new SqlConnection(connectionString);

            if(!(string.IsNullOrWhiteSpace(birthdate)) && (!(DateTime.TryParse(birthdate, out DateTime birth))))
            {
                popup.Visible = true;
                popup.ForeColor = System.Drawing.Color.Red;
                popupText.Text = "Incorrect Birth Date Syntax";
                return;
            }
            if (contributor.Visible && exp != "" && !(Int32.TryParse(exp, out int expyears)))
            {
                popup.Visible = true;
                popup.ForeColor = System.Drawing.Color.Red;
                popupText.Text = "Please only put Numbers in Experience Years field";
                return;
            }
            if ((staff.Visible && hireDate != "" && !(DateTime.TryParse(hireDate, out DateTime hdate))) || (staff.Visible && workingHours != "" && !(Int32.TryParse(workingHours, out int wh))) || (staff.Visible && paymentRate !="" && !(Decimal.TryParse(paymentRate, out decimal pr))))
            {
                popup.Visible = true;
                popup.ForeColor = System.Drawing.Color.Red;
                popupText.Text = "Please check Hire Date Syntax or Make sure you entered only numbers in Working hours and Payment rate";
                return;
            }
            if (string.IsNullOrWhiteSpace(email))
                email = null;
            if (string.IsNullOrWhiteSpace(password))
                password = null;
            if (string.IsNullOrWhiteSpace(fname))
                fname = null;
            if (string.IsNullOrWhiteSpace(mname))
                mname = null;
            if (string.IsNullOrWhiteSpace(lname))
                lname = null;
            if (string.IsNullOrWhiteSpace(birthdate))
                birthdate = null;
            if (string.IsNullOrWhiteSpace(wpn))
                wpn = null;
            if (string.IsNullOrWhiteSpace(wpt))
                wpt = null;
            if (string.IsNullOrWhiteSpace(wpd))
                wpd = null;
            if (string.IsNullOrWhiteSpace(specialization))
                specialization = null;
            if (string.IsNullOrWhiteSpace(portofolio))
                portofolio = null;
            if (string.IsNullOrWhiteSpace(exp))
                exp = null;
            if (string.IsNullOrWhiteSpace(hireDate))
                hireDate = null;
            if (string.IsNullOrWhiteSpace(workingHours))
                workingHours = null;
            if (string.IsNullOrWhiteSpace(paymentRate))
                paymentRate = null;

            if (!(string.IsNullOrWhiteSpace(email)))
            {
                cnn.Open();
                SqlCommand checkEmail = new SqlCommand("SELECT email FROM [User]", cnn);

                reader = checkEmail.ExecuteReader();
                while (reader.Read())
                {
                    if (reader.GetValue(0).ToString().Equals(email))
                    {
                        popup.Visible = true;
                        popup.ForeColor = System.Drawing.Color.DarkRed;
                        popupText.Text = "This Email already Exists";
                        reader.Close();
                        checkEmail.Dispose();
                        cnn.Close();
                        return;
                    }
                }
                reader.Close();
                checkEmail.Dispose();
                cnn.Close();
            }
            cnn.Open();
            SqlCommand cmd = new SqlCommand("Edit_Profile", cnn);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;

            cmd.Parameters.Add(new SqlParameter("@user_id", Convert.ToInt16(Session["ID"])));
            cmd.Parameters.Add(new SqlParameter("@email", Edit.ToDBNull(email)));
            cmd.Parameters.Add(new SqlParameter("@password", Edit.ToDBNull(password)));
            cmd.Parameters.Add(new SqlParameter("@firstname", Edit.ToDBNull(fname)));
            cmd.Parameters.Add(new SqlParameter("@middlename", Edit.ToDBNull(mname)));
            cmd.Parameters.Add(new SqlParameter("@lastname", Edit.ToDBNull(lname)));
            cmd.Parameters.Add(new SqlParameter("@birth_date",birthdate==null?Edit.ToDBNull(birthdate) :Convert.ToDateTime(birthdate)));
            cmd.Parameters.Add(new SqlParameter("@working_place_name", Edit.ToDBNull(wpn)));
            cmd.Parameters.Add(new SqlParameter("@working_place_type", Edit.ToDBNull(wpt)));
            cmd.Parameters.Add(new SqlParameter("@workring_place_description", Edit.ToDBNull(wpd)));
            cmd.Parameters.Add(new SqlParameter("@specilization", Edit.ToDBNull(specialization)));
            cmd.Parameters.Add(new SqlParameter("@portofolio_link", Edit.ToDBNull(portofolio)));
            cmd.Parameters.Add(new SqlParameter("@years_experience", exp == null ? Edit.ToDBNull(exp) : Convert.ToInt16(exp)));
            cmd.Parameters.Add(new SqlParameter("@hire_date", hireDate == null ? Edit.ToDBNull(hireDate) : Convert.ToDateTime(hireDate)));
            cmd.Parameters.Add(new SqlParameter("@working_hours", workingHours == null ? Edit.ToDBNull(workingHours) : Convert.ToInt32(workingHours)));
            cmd.Parameters.Add(new SqlParameter("@payment_rate", paymentRate == null ? Edit.ToDBNull(paymentRate) : Convert.ToDecimal(paymentRate)));
            cmd.ExecuteReader();
            cnn.Close();

            if (type != "Unchanged")
            {
                cmd.Dispose();
                cnn.Open();
                cmd = new SqlCommand("Check_Type", cnn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@typename", type));
                cmd.Parameters.Add(new SqlParameter("@content_manager_id", Convert.ToInt16(Session["ID"])));
                cmd.ExecuteReader();
            }
            cmd.Dispose();
            cnn.Close();
            Response.Redirect("Profile.aspx");
        }
        protected void cancel_buttonClicked(object sender, EventArgs e)
        {
            Response.Redirect("Profile.aspx");
        }
        protected void okButtonClicked(object sender, EventArgs e)
        {
            popup.Visible = false;
        }

        public static object ToDBNull(object value)
        {
            if (value != null)
                return value;
            return DBNull.Value;
        }
    }
}

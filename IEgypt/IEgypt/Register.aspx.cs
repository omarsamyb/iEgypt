using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace IEgypt
{

    public partial class Register : System.Web.UI.Page
    {
        protected void register_buttonClicked(object sender, EventArgs args)
        {
            string type = typeList.SelectedValue;
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
            int user_id;
            SqlDataReader reader;

            string connectionString = WebConfigurationManager.ConnectionStrings["constr"].ConnectionString;
            SqlConnection cnn = new SqlConnection(connectionString);

            if ((type == "-1" || string.IsNullOrWhiteSpace(email) || string.IsNullOrWhiteSpace(password) || string.IsNullOrWhiteSpace(fname) || string.IsNullOrWhiteSpace(mname) || string.IsNullOrWhiteSpace(lname) || string.IsNullOrWhiteSpace(birthdate)) || (Convert.ToInt32(type) == 1 && (string.IsNullOrWhiteSpace(wpn) || string.IsNullOrWhiteSpace(wpt))) || (Convert.ToInt32(type) == 3 && (string.IsNullOrWhiteSpace(workingHours) || string.IsNullOrWhiteSpace(paymentRate))))
            {
                popup.Visible = true;
                popup.ForeColor = System.Drawing.Color.Red;
                popupText.Text = "Missing Required Data, Please fill all data with * next to it";
                return;
            }
            if (!(DateTime.TryParse(birthdate, out DateTime birth)))
            {
                popup.Visible = true;
                popup.ForeColor = System.Drawing.Color.SkyBlue;
                popupText.Text = "Incorrect Birth Date Syntax";
                return;
            }
            if (type == "2" && exp != "" && !(Int32.TryParse(exp, out int expyears)))
            {
                popup.Visible = true;
                popup.ForeColor = System.Drawing.Color.Violet;
                popupText.Text = "Please only put Numbers in Experience Years field";
                return;
            }
            if (((type == "3" || type=="4") && hireDate != "" && !(DateTime.TryParse(hireDate, out DateTime hdate))) || ((type == "3" || type == "4") && !(Int32.TryParse(workingHours, out int wh))) || ((type == "3" || type == "4") && !(Decimal.TryParse(paymentRate, out decimal pr))))
            {
                popup.Visible = true;
                popup.ForeColor = System.Drawing.Color.Yellow;
                popupText.Text = "Please check Hire Date Syntax or Make sure you entered only numbers in Working hours and Payment rate";
                return;
            }
            if (type == "1")
            {
                specialization = null;
                portofolio = null;
                exp = null;
                hireDate = null;
                workingHours = null;
                paymentRate = null;
                if (string.IsNullOrWhiteSpace(wpd))
                    wpd = null;
            }
            if (type == "2")
            {
                wpn = null;
                wpt = null;
                wpd = null;
                hireDate = null;
                workingHours = null;
                paymentRate = null;
                if (string.IsNullOrWhiteSpace(specialization))
                    specialization = null;
                if (string.IsNullOrWhiteSpace(portofolio))
                    portofolio = null;
                if (string.IsNullOrWhiteSpace(exp))
                    exp = null;
            }
            if (type == "3" || type=="4")
            {
                wpn = null;
                wpt = null;
                wpd = null;
                specialization = null;
                portofolio = null;
                exp = null;
                if (string.IsNullOrWhiteSpace(hireDate))
                    hireDate = null;
            }

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

            SqlCommand cmd = new SqlCommand("Register_User", cnn);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;

            cmd.Parameters.Add(new SqlParameter("@usertype", Convert.ToInt16(type)));
            cmd.Parameters.Add(new SqlParameter("@email", email));
            cmd.Parameters.Add(new SqlParameter("@password", password));
            cmd.Parameters.Add(new SqlParameter("@firstname", fname));
            cmd.Parameters.Add(new SqlParameter("@middlename", mname));
            cmd.Parameters.Add(new SqlParameter("@lastname", lname));
            cmd.Parameters.Add(new SqlParameter("@birth_date", Convert.ToDateTime(birthdate)));
            cmd.Parameters.Add(new SqlParameter("@working_place_name", Register.ToDBNull(wpn)));
            cmd.Parameters.Add(new SqlParameter("@working_place_type", Register.ToDBNull(wpt)));
            cmd.Parameters.Add(new SqlParameter("@workring_place_description", Register.ToDBNull(wpd)));
            cmd.Parameters.Add(new SqlParameter("@specilization", Register.ToDBNull(specialization)));
            cmd.Parameters.Add(new SqlParameter("@portofolio_link", Register.ToDBNull(portofolio)));
            cmd.Parameters.Add(new SqlParameter("@years_experience", exp == null ? Register.ToDBNull(exp) : Convert.ToInt16(exp)));
            cmd.Parameters.Add(new SqlParameter("@hire_date", hireDate == null ? Register.ToDBNull(hireDate) : Convert.ToDateTime(hireDate)));
            cmd.Parameters.Add(new SqlParameter("@working_hours", workingHours == null ? Register.ToDBNull(workingHours) : Convert.ToInt32(workingHours)));
            cmd.Parameters.Add(new SqlParameter("@payment_rate", paymentRate == null ? Register.ToDBNull(paymentRate) : Convert.ToDecimal(paymentRate)));
            cmd.Parameters.Add("@user_id", System.Data.SqlDbType.Int).Direction = System.Data.ParameterDirection.Output;

            using (reader = cmd.ExecuteReader())
            {
                user_id = Convert.ToInt32(cmd.Parameters["@user_id"].Value);
            }

            reader.Close();
            cmd.Dispose();
            cnn.Close();

            Session["ID"] = user_id;
            Response.Redirect("Profile.aspx");
        }

        protected void typeList_SelectedIndexChanged(object sender, EventArgs e)
        {
            int selected = Convert.ToInt32(typeList.SelectedValue);
            if (selected == 1)
            {
                viewer.Style.Add("display", "inline");
                contributor.Style.Add("display", "none");
                staff.Style.Add("display", "none"); }
            else if (selected == 2)
            {
                viewer.Style.Add("display", "none");
                contributor.Style.Add("display", "inline");
                staff.Style.Add("display", "none");
            }
            else if (selected == 3 || selected == 4)
            {
                viewer.Style.Add("display", "none");
                contributor.Style.Add("display", "none");
                staff.Style.Add("display", "inline");
            }
            else
            {
                viewer.Style.Add("display", "none");
                contributor.Style.Add("display", "none");
                staff.Style.Add("display", "none");
            }
        }
        protected void okButtonClicked(object sender, EventArgs e)
        {
            popup.Visible = false;
        }
        protected void cancel_buttonClicked(object sender, EventArgs args)
        {
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

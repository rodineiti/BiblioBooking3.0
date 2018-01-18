using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BiblioBooking : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["FUNCIONARIO"] == null)
        {
            Session["FUNCIONARIO"] = null;
            Response.Redirect("~/Login.aspx");
        }
    }
}

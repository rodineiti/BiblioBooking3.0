﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ListaTipoLivros : System.Web.UI.Page
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
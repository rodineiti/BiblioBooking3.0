using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Session["FUNCIONARIO"] = null;
    }

    protected void btnLogar_Click(object sender, EventArgs e)
    {
        if (!txtLogin.Text.Equals("") && !txtSenha.Text.Equals(""))
        {
            clsControleFuncionario objFuncionario = new clsControleFuncionario();
            objFuncionario.FunLogin = txtLogin.Text.Trim();
            objFuncionario.FunSenha = txtSenha.Text.Trim();
            DataTable objTableLogin = objFuncionario.ValidarLogin();

            if (objFuncionario.CarregarDadosFuncionario(objTableLogin) == true)
            {
                Session["FUNCIONARIO"] = objFuncionario;

                Response.Redirect("Principal.aspx");
            }
            else
            {
                lblResultado.Text = "dados inválidos";
            }
        }
        else
        {
            lblResultado.Text = "Informe todos os dados!";
        }
    }
}
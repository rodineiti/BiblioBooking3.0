using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using MySql.Data.MySqlClient;
using System.Data;
using System.Text;
using System.Configuration;

public class clsControleFuncionario
{
    private string wStrServer = ConfigurationManager.AppSettings["pStrServer"].ToString();
    private string wStrDataBase = ConfigurationManager.AppSettings["pStrDataBase"].ToString();
    private string wStrUser = ConfigurationManager.AppSettings["pStrUser"].ToString();
    private string wStrpass = ConfigurationManager.AppSettings["pStrpass"].ToString();

    public int FunId { get; set; }
    public string FunNome { get; set; }
    public string FunLogin { get; set; }
    public string FunSenha { get; set; }
    public string FunMaster { get; set; }

    public clsControleFuncionario()
    {
        this.FunId = 0;
        this.FunNome = string.Empty;
        this.FunLogin = string.Empty;
        this.FunSenha = string.Empty;
        this.FunMaster = string.Empty;
    }

    public DataTable ValidarLogin()
    {
        clsBD objBd = new clsBD(wStrServer, wStrDataBase, wStrUser, wStrpass);

        try
        {
            //MySqlCommand cmd = new MySqlCommand("sp_login_administrador");
            MySqlCommand cmd = new MySqlCommand("SELECT funId, funNome, funLogin, funSenha, funMaster FROM tbfuncionario WHERE funLogin = @login AND funSenha = @senha AND funMaster = 'S';");

            cmd.Parameters.AddWithValue("@login", this.FunLogin);
            cmd.Parameters.AddWithValue("@senha", this.FunSenha);

            return objBd.ExecuteDataTable(cmd);
        }
        catch (Exception ex)
        {
            throw new Exception("Erro logar funcionario " + ex.Message);
        }
    }

    public bool CarregarDadosFuncionario(DataTable objDataTable)
    {
        bool booRetono = false;

        if (objDataTable.Rows.Count > 0)
        {
            if (!String.IsNullOrEmpty(objDataTable.Rows[0]["funId"].ToString()))
                this.FunId = Convert.ToInt32(objDataTable.Rows[0]["funId"].ToString());

            if (!String.IsNullOrEmpty(objDataTable.Rows[0]["funNome"].ToString()))
                this.FunNome = objDataTable.Rows[0]["funNome"].ToString();

            if (!String.IsNullOrEmpty(objDataTable.Rows[0]["funLogin"].ToString()))
                this.FunLogin = objDataTable.Rows[0]["funLogin"].ToString();

            if (!String.IsNullOrEmpty(objDataTable.Rows[0]["funSenha"].ToString()))
                this.FunSenha = objDataTable.Rows[0]["funSenha"].ToString();
            
            if (!String.IsNullOrEmpty(objDataTable.Rows[0]["funMaster"].ToString()))
                this.FunMaster = objDataTable.Rows[0]["funMaster"].ToString();

            booRetono = true;
        }
        return booRetono;
    }
}
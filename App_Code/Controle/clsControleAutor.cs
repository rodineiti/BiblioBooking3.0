using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using MySql.Data.MySqlClient;
using System.Data;
using System.Text;
using System.Configuration;

public class clsControleAutor
{
    private string wStrServer = ConfigurationManager.AppSettings["pStrServer"].ToString();
    private string wStrDataBase = ConfigurationManager.AppSettings["pStrDataBase"].ToString();
    private string wStrUser = ConfigurationManager.AppSettings["pStrUser"].ToString();
    private string wStrpass = ConfigurationManager.AppSettings["pStrpass"].ToString();

    public int AutId { get; set; }
    public string AutNome { get; set; }
    public string AutNomeCientifico { get; set; }
	public string AutBibliografia { get; set; }
    
    public clsControleAutor()
    {
        this.AutNome = string.Empty;
		this.AutNomeCientifico = string.Empty;
		this.AutBibliografia = string.Empty;
    }

    public void Cadastrar()
    {
        clsBD objBd = new clsBD(wStrServer, wStrDataBase, wStrUser, wStrpass);

        try
        {
            if (Convert.ToInt32(this.AutId) > 0)
            {
                MySqlCommand cmd = new MySqlCommand("update tbautor set " +
                    "autNome = @autNome, " +
                    "autNomeCientifico = @autNomeCientifico, " +
                    "autBibliografia = @autBibliografia " +
                    "where autId = @autId;");

                cmd.Parameters.AddWithValue("@autId", this.AutId);
                cmd.Parameters.AddWithValue("@autNome", this.AutNome);
                cmd.Parameters.AddWithValue("@autNomeCientifico", this.AutNomeCientifico);
                cmd.Parameters.AddWithValue("@autBibliografia", this.AutBibliografia);

                objBd.ExecuteQuery(cmd);
            }
            else
            {
                MySqlCommand cmd = new MySqlCommand("insert into tbautor (" +
                    "autNome," +
                    "autNomeCientifico," +
                    "autBibliografia" +
                    ") values (" +
                    "@autNome," +
                    "@autNomeCientifico," +
                    "@autBibliografia" +
                    ");");

                cmd.Parameters.AddWithValue("@autNome", this.AutNome);
                cmd.Parameters.AddWithValue("@autNomeCientifico", this.AutNomeCientifico);
                cmd.Parameters.AddWithValue("@autBibliografia", this.AutBibliografia);

                objBd.ExecuteQuery(cmd);
            }
        }
        catch (Exception ex)
        {
            throw new Exception("Erro ao cadastrar autor" + ex.Message);
        }
    }

    public bool Excluir()
    {
        clsBD objBd = new clsBD(wStrServer, wStrDataBase, wStrUser, wStrpass);

        bool res = false;

        try
        {
            if (ifExistsRelation(this.AutId) == 0)
            {
                MySqlCommand cmd = new MySqlCommand("delete from tbautor where autId = @autId;");

                cmd.Parameters.AddWithValue("@autId", this.AutId);

                objBd.ExecuteQuery(cmd);

                res = true;
            }
            else
            {
                res = false;
            }
        }
        catch (Exception ex)
        {
            throw new Exception("Erro ao excluir autor" + ex.Message);
        }

        return res;
    }

    public DataTable Consultar()
    {
        clsBD objBd = new clsBD(wStrServer, wStrDataBase, wStrUser, wStrpass);

        try
        {
            MySqlCommand cmd = new MySqlCommand("select * from tbautor;");

            return objBd.ExecuteDataTable(cmd);
        }
        catch (Exception ex)
        {
            throw new Exception("Erro ao consultar datatable autor" + ex.Message);
        }
    }

    public int ifExistsRelation(Int32 id)
    {
        clsBD objBd = new clsBD(wStrServer, wStrDataBase, wStrUser, wStrpass);

        int count = 0;

        try
        {
            MySqlCommand cmd = new MySqlCommand("select count(livId) from tblivro where autId = @autId;");
            cmd.Parameters.AddWithValue("@autId", id);

            count = Convert.ToInt32(objBd.ExecuteObject(cmd));
        }
        catch (Exception ex)
        {
            throw new Exception("Erro ao consultar livro autor: " + ex.Message);
        }

        return count;
    }
}
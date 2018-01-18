using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using MySql.Data.MySqlClient;
using System.Data;
using System.Text;
using System.Configuration;

public class clsControleEditora
{
    private string wStrServer = ConfigurationManager.AppSettings["pStrServer"].ToString();
    private string wStrDataBase = ConfigurationManager.AppSettings["pStrDataBase"].ToString();
    private string wStrUser = ConfigurationManager.AppSettings["pStrUser"].ToString();
    private string wStrpass = ConfigurationManager.AppSettings["pStrpass"].ToString();

    public int EdiId { get; set; }
    public string EdiNome { get; set; }
	public string EdiEndereco { get; set; }
	public string EdiBairro { get; set; }
	public string EdiCidade { get; set; }
	public string EdiCEP { get; set; }
	public string EdiFone { get; set; }
	public string EdiUF { get; set; }
   
    public clsControleEditora()
    {
        this.EdiNome = string.Empty;
		this.EdiEndereco = string.Empty;
		this.EdiBairro = string.Empty;
		this.EdiCidade = string.Empty;
		this.EdiCEP = string.Empty;
		this.EdiFone = string.Empty;
		this.EdiUF = string.Empty;
    }

    public void Cadastrar()
    {
        clsBD objBd = new clsBD(wStrServer, wStrDataBase, wStrUser, wStrpass);

        try
        {
            if (Convert.ToInt32(this.EdiId) > 0)
            {
                MySqlCommand cmd = new MySqlCommand("update tbeditora set " +
                    "ediNome = @ediNome, " +
                    "ediEndereco = @ediEndereco, " +
                    "ediBairro = @ediBairro, " +
                    "ediCidade = @ediCidade, " +
                    "ediCEP = @ediCEP, " +
                    "ediFone = @ediFone, " +
                    "ediUF = @ediUF " +
                    "where ediId = @ediId;");

                cmd.Parameters.AddWithValue("@ediId", this.EdiId);
                cmd.Parameters.AddWithValue("@ediNome", this.EdiNome);
                cmd.Parameters.AddWithValue("@ediEndereco", this.EdiEndereco);
                cmd.Parameters.AddWithValue("@ediBairro", this.EdiBairro);
                cmd.Parameters.AddWithValue("@ediCidade", this.EdiCidade);
                cmd.Parameters.AddWithValue("@ediCEP", this.EdiCEP);
                cmd.Parameters.AddWithValue("@ediFone", this.EdiFone);
                cmd.Parameters.AddWithValue("@ediUF", this.EdiUF);

                objBd.ExecuteQuery(cmd);
            }
            else
            {
                MySqlCommand cmd = new MySqlCommand("insert into tbeditora (" +
                    "ediNome," +
                    "ediEndereco," +
                    "ediBairro," +
                    "ediCidade," +
                    "ediCEP," +
                    "ediFone," +
                    "ediUF" +
                    ") values (" +
                    "@ediNome," +
                    "@ediEndereco," +
                    "@ediBairro," +
                    "@ediCidade," +
                    "@ediCEP," +
                    "@ediFone," +
                    "@ediUF" +
                    ");");

                cmd.Parameters.AddWithValue("@ediNome", this.EdiNome);
                cmd.Parameters.AddWithValue("@ediEndereco", this.EdiEndereco);
                cmd.Parameters.AddWithValue("@ediBairro", this.EdiBairro);
                cmd.Parameters.AddWithValue("@ediCidade", this.EdiCidade);
                cmd.Parameters.AddWithValue("@ediCEP", this.EdiCEP);
                cmd.Parameters.AddWithValue("@ediFone", this.EdiFone);
                cmd.Parameters.AddWithValue("@ediUF", this.EdiUF);

                objBd.ExecuteQuery(cmd);
            }
        }
        catch (Exception ex)
        {
            throw new Exception("Erro ao cadastrar editora" + ex.Message);
        }
    }

    public bool Excluir()
    {
        clsBD objBd = new clsBD(wStrServer, wStrDataBase, wStrUser, wStrpass);

        bool res = false;

        try
        {
            if (ifExistsRelation(this.EdiId) == 0)
            {
                MySqlCommand cmd = new MySqlCommand("delete from tbeditora where ediId = @ediId;");

                cmd.Parameters.AddWithValue("@ediId", this.EdiId);

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
            throw new Exception("Erro ao excluir editora" + ex.Message);
        }

        return res;
    }

    public DataTable Consultar()
    {
        clsBD objBd = new clsBD(wStrServer, wStrDataBase, wStrUser, wStrpass);

        try
        {
            MySqlCommand cmd = new MySqlCommand("select * from tbeditora;");

            return objBd.ExecuteDataTable(cmd);
        }
        catch (Exception ex)
        {
            throw new Exception("Erro ao consultar datatable editora" + ex.Message);
        }
    }

    public int ifExistsRelation(Int32 id)
    {
        clsBD objBd = new clsBD(wStrServer, wStrDataBase, wStrUser, wStrpass);

        int count = 0;

        try
        {
            MySqlCommand cmd = new MySqlCommand("select count(livId) from tblivro where ediId = @ediId;");
            cmd.Parameters.AddWithValue("@ediId", id);

            count = Convert.ToInt32(objBd.ExecuteObject(cmd));
        }
        catch (Exception ex)
        {
            throw new Exception("Erro ao consultar livro editora: " + ex.Message);
        }

        return count;
    }
}
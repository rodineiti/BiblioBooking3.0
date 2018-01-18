using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using MySql.Data.MySqlClient;
using System.Data;
using System.Text;
using System.Configuration;

public class clsControleTipoLivro
{
    private string wStrServer = ConfigurationManager.AppSettings["pStrServer"].ToString();
    private string wStrDataBase = ConfigurationManager.AppSettings["pStrDataBase"].ToString();
    private string wStrUser = ConfigurationManager.AppSettings["pStrUser"].ToString();
    private string wStrpass = ConfigurationManager.AppSettings["pStrpass"].ToString();

    public int TipId { get; set; }
    public string TipDescricao { get; set; }
   
    public clsControleTipoLivro()
    {
        this.TipDescricao = string.Empty;
    }

    public void Cadastrar()
    {
        clsBD objBd = new clsBD(wStrServer, wStrDataBase, wStrUser, wStrpass);

        try
        {
            if (Convert.ToInt32(this.TipId) > 0)
            {
                MySqlCommand cmd = new MySqlCommand("update tbtipolivro set tipDescricao = @tipDescricao where tipId = @tipId;");

                cmd.Parameters.AddWithValue("@tipDescricao", this.TipDescricao);
                cmd.Parameters.AddWithValue("@tipId", this.TipId);

                objBd.ExecuteQuery(cmd);
            }
            else
            {
                MySqlCommand cmd = new MySqlCommand("insert into tbtipolivro (tipDescricao) values (@tipDescricao)");

                cmd.Parameters.AddWithValue("@tipDescricao", this.TipDescricao);

                objBd.ExecuteQuery(cmd);
            }
        }
        catch (Exception ex)
        {
            throw new Exception("Erro ao cadastrar tipo de livro" + ex.Message);
        }
    }

    public bool Excluir()
    {
        clsBD objBd = new clsBD(wStrServer, wStrDataBase, wStrUser, wStrpass);

        bool res = false;

        try
        {
            if (ifExistsRelation(this.TipId) == 0)
            {
                MySqlCommand cmd = new MySqlCommand("delete from tbtipolivro where tipId = @tipId;");

                cmd.Parameters.AddWithValue("@tipId", this.TipId);

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
            throw new Exception("Erro ao excluir tipo livro" + ex.Message);
        }

        return res;
    }

    public DataTable Consultar()
    {
        clsBD objBd = new clsBD(wStrServer, wStrDataBase, wStrUser, wStrpass);

        try
        {
            MySqlCommand cmd = new MySqlCommand("select * from tbtipolivro;");

            return objBd.ExecuteDataTable(cmd);
        }
        catch (Exception ex)
        {
            throw new Exception("Erro ao consultar datatable tipo de livro" + ex.Message);
        }
    }

    public int ifExistsRelation(Int32 id)
    {
        clsBD objBd = new clsBD(wStrServer, wStrDataBase, wStrUser, wStrpass);

        int count = 0;

        try
        {
            MySqlCommand cmd = new MySqlCommand("select count(livId) from tblivro where tipId = @tipId;");
            cmd.Parameters.AddWithValue("@tipId", id);

            count = Convert.ToInt32(objBd.ExecuteObject(cmd));
        }
        catch (Exception ex)
        {
            throw new Exception("Erro ao consultar livro tipo: " + ex.Message);
        }

        return count;
    }
}
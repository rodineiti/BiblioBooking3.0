using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using MySql.Data.MySqlClient;
using System.Data;
using System.Text;
using System.Configuration;

public class clsControleCategoria
{
    private string wStrServer = ConfigurationManager.AppSettings["pStrServer"].ToString();
    private string wStrDataBase = ConfigurationManager.AppSettings["pStrDataBase"].ToString();
    private string wStrUser = ConfigurationManager.AppSettings["pStrUser"].ToString();
    private string wStrpass = ConfigurationManager.AppSettings["pStrpass"].ToString();

    public int CatId { get; set; }
    public string CatDescricao { get; set; }

    public clsControleCategoria()
    {
        this.CatDescricao = string.Empty;
    }

    public void Cadastrar()
    {
        clsBD objBd = new clsBD(wStrServer, wStrDataBase, wStrUser, wStrpass);

        try
        {
            if (Convert.ToInt32(this.CatId) > 0)
            {
                MySqlCommand cmd = new MySqlCommand("update tbcategoria set catDescricao = @catDescricao where catId = @catId;");

                cmd.Parameters.AddWithValue("@catDescricao", this.CatDescricao);
                cmd.Parameters.AddWithValue("@catId", this.CatId);

                objBd.ExecuteQuery(cmd);
            }
            else
            {
                MySqlCommand cmd = new MySqlCommand("insert into tbcategoria (catDescricao) values (@catDescricao)");

                cmd.Parameters.AddWithValue("@catDescricao", this.CatDescricao);

                objBd.ExecuteQuery(cmd);
            }
        }
        catch (Exception ex)
        {
            throw new Exception("Erro ao cadastrar categoria" + ex.Message);
        }
    }

    public bool Excluir()
    {
        clsBD objBd = new clsBD(wStrServer, wStrDataBase, wStrUser, wStrpass);

        bool res = false;

        try
        {
            if (ifExistsRelation(this.CatId) == 0)
            {
                MySqlCommand cmd = new MySqlCommand("delete from tbcategoria where catId = @catId;");

                cmd.Parameters.AddWithValue("@catId", this.CatId);

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
            throw new Exception("Erro ao excluir Categoria" + ex.Message);
        }

        return res;
    }

    public DataTable Consultar()
    {
        clsBD objBd = new clsBD(wStrServer, wStrDataBase, wStrUser, wStrpass);

        try
        {
            MySqlCommand cmd = new MySqlCommand("select * from tbcategoria;");

            return objBd.ExecuteDataTable(cmd);
        }
        catch (Exception ex)
        {
            throw new Exception("Erro ao consultar datatable categoria" + ex.Message);
        }
    }

    public int ifExistsRelation(Int32 id)
    {
        clsBD objBd = new clsBD(wStrServer, wStrDataBase, wStrUser, wStrpass);

        int count = 0;

        try
        {
            MySqlCommand cmd = new MySqlCommand("select count(livId) from tblivro where catId = @catId;");
            cmd.Parameters.AddWithValue("@catId", id);

            count = Convert.ToInt32(objBd.ExecuteObject(cmd));
        }
        catch (Exception ex)
        {
            throw new Exception("Erro ao consultar livro categoria: " + ex.Message);
        }

        return count;
    }
}
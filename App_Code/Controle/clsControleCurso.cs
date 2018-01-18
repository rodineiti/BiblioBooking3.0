using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using MySql.Data.MySqlClient;
using System.Data;
using System.Text;
using System.Configuration;
using System.Collections;

public class clsControleCurso
{
    private string wStrServer = ConfigurationManager.AppSettings["pStrServer"].ToString();
    private string wStrDataBase = ConfigurationManager.AppSettings["pStrDataBase"].ToString();
    private string wStrUser = ConfigurationManager.AppSettings["pStrUser"].ToString();
    private string wStrpass = ConfigurationManager.AppSettings["pStrpass"].ToString();

    public int CurId { get; set; }
    public string CurDescricao { get; set; }
    
    public clsControleCurso()
    {
        this.CurDescricao = string.Empty;
    }

    public void Cadastrar()
    {
        clsBD objBd = new clsBD(wStrServer, wStrDataBase, wStrUser, wStrpass);

        try
        {
            if (Convert.ToInt32(this.CurId) > 0)
            {
                MySqlCommand cmd = new MySqlCommand("update tbcurso set curDescricao = @curDescricao where curId = @curId;");

                cmd.Parameters.AddWithValue("@curDescricao", this.CurDescricao);
                cmd.Parameters.AddWithValue("@curId", this.CurId);

                objBd.ExecuteQuery(cmd);
            }
            else
            {
                MySqlCommand cmd = new MySqlCommand("insert into tbcurso (curDescricao) values (@curDescricao)");

                cmd.Parameters.AddWithValue("@curDescricao", this.CurDescricao);

                objBd.ExecuteQuery(cmd);
            }            
        }
        catch (Exception ex)
        {
            throw new Exception("Erro ao cadastrar Curso" + ex.Message);
        }
    }

    public bool Excluir()
    {
        clsBD objBd = new clsBD(wStrServer, wStrDataBase, wStrUser, wStrpass);

        bool res = false;

        try
        {
            if (ifExistsRelation(this.CurId) == 0)
            {
                MySqlCommand cmd = new MySqlCommand("delete from tbcurso where curId = @curId;");

                cmd.Parameters.AddWithValue("@curId", this.CurId);

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
            throw new Exception("Erro ao excluir Curso" + ex.Message);
        }

        return res;
    }

    public DataTable Consultar()
    {
        clsBD objBd = new clsBD(wStrServer, wStrDataBase, wStrUser, wStrpass);

        try
        {
            MySqlCommand cmd = new MySqlCommand("SELECT * FROM tbcurso;");

            return objBd.ExecuteDataTable(cmd);
        }
        catch (Exception ex)
        {
            throw new Exception("Erro ao consultar datatable curso" + ex.Message);
        }
    }

    public int ifExistsRelation(Int32 curId)
    {
        clsBD objBd = new clsBD(wStrServer, wStrDataBase, wStrUser, wStrpass);

        int count = 0;

        try
        {
            MySqlCommand cmd = new MySqlCommand("select count(aluId) from tbaluno where curId = @curId;");
            cmd.Parameters.AddWithValue("@curId", curId);

            count = Convert.ToInt32(objBd.ExecuteObject(cmd));
        }
        catch (Exception ex)
        {
            throw new Exception("Erro ao consultar aluno curso: " + ex.Message);
        }

        return count;
    }
}
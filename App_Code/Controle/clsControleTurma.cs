using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using MySql.Data.MySqlClient;
using System.Data;
using System.Text;
using System.Configuration;

public class clsControleTurma
{
    private string wStrServer = ConfigurationManager.AppSettings["pStrServer"].ToString();
    private string wStrDataBase = ConfigurationManager.AppSettings["pStrDataBase"].ToString();
    private string wStrUser = ConfigurationManager.AppSettings["pStrUser"].ToString();
    private string wStrpass = ConfigurationManager.AppSettings["pStrpass"].ToString();

    public int TurId { get; set; }
    public string TurDescricao { get; set; }

    public clsControleTurma()
    {
        this.TurDescricao = string.Empty;
    }

    public void Cadastrar()
    {
        clsBD objBd = new clsBD(wStrServer, wStrDataBase, wStrUser, wStrpass);

        try
        {
            if (Convert.ToInt32(this.TurId) > 0)
            {
                MySqlCommand cmd = new MySqlCommand("update tbturma set turDescricao = @turDescricao where turId = @turId;");

                cmd.Parameters.AddWithValue("@turDescricao", this.TurDescricao);
                cmd.Parameters.AddWithValue("@turId", this.TurId);

                objBd.ExecuteQuery(cmd);
            }
            else
            {
                MySqlCommand cmd = new MySqlCommand("insert into tbturma (turDescricao) values (@turDescricao)");

                cmd.Parameters.AddWithValue("@turDescricao", this.TurDescricao);

                objBd.ExecuteQuery(cmd);
            }
        }
        catch (Exception ex)
        {
            throw new Exception("Erro ao cadastrar turma" + ex.Message);
        }
    }

    public bool Excluir()
    {
        clsBD objBd = new clsBD(wStrServer, wStrDataBase, wStrUser, wStrpass);

        bool res = false;

        try
        {
            if (ifExistsRelation(this.TurId) == 0)
            {
                MySqlCommand cmd = new MySqlCommand("delete from tbturma where turId = @turId;");

                cmd.Parameters.AddWithValue("@turId", this.TurId);

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
            throw new Exception("Erro ao excluir turma" + ex.Message);
        }

        return res;
    }

    public DataTable Consultar()
    {
        clsBD objBd = new clsBD(wStrServer, wStrDataBase, wStrUser, wStrpass);

        try
        {
            MySqlCommand cmd = new MySqlCommand("select * from tbturma;");
            
            return objBd.ExecuteDataTable(cmd);
        }
        catch (Exception ex)
        {
            throw new Exception("Erro ao consultar datatable turma" + ex.Message);
        }
    }

    public int ifExistsRelation(Int32 turId)
    {
        clsBD objBd = new clsBD(wStrServer, wStrDataBase, wStrUser, wStrpass);

        int count = 0;

        try
        {
            MySqlCommand cmd = new MySqlCommand("select count(aluId) from tbaluno where turId = @turId;");
            cmd.Parameters.AddWithValue("@turId", turId);

            count = Convert.ToInt32(objBd.ExecuteObject(cmd));
        }
        catch (Exception ex)
        {
            throw new Exception("Erro ao consultar aluno turma: " + ex.Message);
        }

        return count;
    }
}
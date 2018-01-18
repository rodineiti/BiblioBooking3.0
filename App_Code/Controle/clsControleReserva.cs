using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using MySql.Data.MySqlClient;
using System.Data;
using System.Text;
using System.Configuration;

/// <summary>
/// Summary description for ControleReserva
/// </summary>
public class clsControleReserva
{
	private string wStrServer = ConfigurationManager.AppSettings["pStrServer"].ToString();
    private string wStrDataBase = ConfigurationManager.AppSettings["pStrDataBase"].ToString();
    private string wStrUser = ConfigurationManager.AppSettings["pStrUser"].ToString();
    private string wStrpass = ConfigurationManager.AppSettings["pStrpass"].ToString();

    public int ResId { get; set; }
	public int AluId { get; set; }
    public string AluNome { get; set; }
    public string ResStatus { get; set; }

    public clsControleReserva()
    {
        this.ResId = 0;
        this.AluId = 0;
        this.AluNome = string.Empty;
        this.ResStatus = string.Empty;
    }

    public bool Excluir()
    {
        clsBD objBd = new clsBD(wStrServer, wStrDataBase, wStrUser, wStrpass);

        bool res = false;

        try
        {
            MySqlCommand cmd = new MySqlCommand("delete from tbitemreserva where resId = @resId;");

            cmd.Parameters.AddWithValue("@resId", this.ResId);

            objBd.ExecuteQuery(cmd);

            MySqlCommand cmd2 = new MySqlCommand("delete from tbreserva where resId = @resId;");

            cmd2.Parameters.AddWithValue("@resId", this.ResId);

            objBd.ExecuteQuery(cmd2);

            res = true;
        }
        catch (Exception ex)
        {
            throw new Exception("Erro ao excluir reserva: " + ex.Message);
        }

        return res;
    }

    public DataTable Consultar()
    {
        clsBD objBd = new clsBD(wStrServer, wStrDataBase, wStrUser, wStrpass);

        try
        {
            MySqlCommand cmd = new MySqlCommand("select * from tbreserva r left outer join tbaluno a on (a.aluId = r.aluId) where r.resStatus in ('S');");
            
            return objBd.ExecuteDataTable(cmd);
        }
        catch (Exception ex)
        {
            throw new Exception("Erro ao consultar datatable reserva: " + ex.Message);
        }
    }
}
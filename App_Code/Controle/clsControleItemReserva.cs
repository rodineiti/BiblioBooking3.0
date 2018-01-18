using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using MySql.Data.MySqlClient;
using System.Data;
using System.Text;
using System.Configuration;

/// <summary>
/// Summary description for ControleItemReserva
/// </summary>
public class clsControleItemReserva
{
	private string wStrServer = ConfigurationManager.AppSettings["pStrServer"].ToString();
    private string wStrDataBase = ConfigurationManager.AppSettings["pStrDataBase"].ToString();
    private string wStrUser = ConfigurationManager.AppSettings["pStrUser"].ToString();
    private string wStrpass = ConfigurationManager.AppSettings["pStrpass"].ToString();

    public int IteId { get; set; }
	public int LivId { get; set; }
    public string LivISBN { get; set; }
    public string LivTitulo { get; set; }
    public string LivLocalizacao { get; set; }
    public int ResId { get; set; }

    public clsControleItemReserva()
    {
        this.IteId = 0;
        this.LivId = 0;
        this.LivISBN = string.Empty;
        this.LivTitulo = string.Empty;
        this.LivLocalizacao = string.Empty;
        this.ResId = 0;
    }

    public DataTable Consultar()
    {
        clsBD objBd = new clsBD(wStrServer, wStrDataBase, wStrUser, wStrpass);

        try
        {
            MySqlCommand cmd = new MySqlCommand("select * from tbitemreserva it left outer join tblivro l on (l.livId = it.livId) where it.resId = @resId;");
            
            cmd.Parameters.AddWithValue("@resId", this.ResId);

            return objBd.ExecuteDataTable(cmd);
        }
        catch (Exception ex)
        {
            throw new Exception("Erro ao consultar datatable item reserva: " + ex.Message);
        }
    }
}
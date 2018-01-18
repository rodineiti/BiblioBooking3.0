using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using MySql.Data.MySqlClient;
using System.Data;
using System.Text;
using System.Configuration;

/// <summary>
/// Summary description for clsControleEmprestimo
/// </summary>
public class clsControleEmprestimo
{
    private string wStrServer = ConfigurationManager.AppSettings["pStrServer"].ToString();
    private string wStrDataBase = ConfigurationManager.AppSettings["pStrDataBase"].ToString();
    private string wStrUser = ConfigurationManager.AppSettings["pStrUser"].ToString();
    private string wStrpass = ConfigurationManager.AppSettings["pStrpass"].ToString();

    public int EmpId { get; set; }
    public int ResId { get; set; }
    public string EmpData { get; set; }
    public string AluNome { get; set; }
    public string EmpPrevDevolucao { get; set; }
    public string EmpDataDevolucao { get; set; }
    public string EmpStatus { get; set; }

	public clsControleEmprestimo()
	{
        this.AluNome = string.Empty;
        this.EmpData = string.Empty;
        this.EmpPrevDevolucao = string.Empty;
        this.EmpDataDevolucao = string.Empty;
    }

    public bool InserirEmprestimo()
    {
        clsBD objBd = new clsBD(wStrServer, wStrDataBase, wStrUser, wStrpass);

        bool res = false;

        try
        {
            if (Convert.ToInt32(this.ResId) > 0)
            {
                MySqlCommand cmd = new MySqlCommand("insert into tbemprestimo (resId, empData, empPrevDevolucao) values (@resId, NOW(), DATE_FORMAT(DATE_ADD(NOW(), INTERVAL 7 DAY),'%Y-%m-%d'));");
                cmd.Parameters.AddWithValue("@resId", this.ResId);
                objBd.ExecuteQuery(cmd);

                MySqlCommand cmd2 = new MySqlCommand("update tbreserva set resStatus = 'N' where resId = @resId;");
                cmd2.Parameters.AddWithValue("@resId", this.ResId);
                objBd.ExecuteQuery(cmd2);

                res = true;
            }
            else
            {
                res = false;
            }
        }
        catch (Exception ex)
        {
            throw new Exception("Erro ao inserir empréstimo: " + ex.Message);
        }

        return res;
    }

    public bool DevolverEmprestimo()
    {
        clsBD objBd = new clsBD(wStrServer, wStrDataBase, wStrUser, wStrpass);

        bool res = false;

        try
        {
            if (Convert.ToInt32(this.EmpId) > 0)
            {
                MySqlCommand cmd = new MySqlCommand("update tblivro l " +
                    "inner join tbitemreserva i on (l.livId = i.livId) " +
                    "inner join tbreserva r on (i.resId = r.resId) " +
                    "inner join tbemprestimo e on (r.resId = e.resId) " +
                    "set l.livStatus = 'S'" +
                    "where e.empId = @empId");
                cmd.Parameters.AddWithValue("@empId", this.EmpId);
                objBd.ExecuteQuery(cmd);

                MySqlCommand cmd2 = new MySqlCommand("update tbemprestimo set empStatus = 'N', empDataDevolucao = NOW() where empId = @empId;");
                cmd2.Parameters.AddWithValue("@empId", this.EmpId);
                objBd.ExecuteQuery(cmd2);

                res = true;
            }
            else
            {
                res = false;
            }
        }
        catch (Exception ex)
        {
            throw new Exception("Erro ao inserir empréstimo: " + ex.Message);
        }

        return res;
    }

    public DataTable Consultar()
    {
        clsBD objBd = new clsBD(wStrServer, wStrDataBase, wStrUser, wStrpass);

        try
        {
            MySqlCommand cmd = new MySqlCommand("select e.empId, e.resId, a.aluNome, e.empData, e.empPrevDevolucao, e.empDataDevolucao, e.empStatus " +
                "from tbemprestimo e " + 
                "left outer join tbreserva r on (e.resId = r.resId) " +
                "inner join tbaluno a on (a.aluId = r.aluId) " +
                ";");

            return objBd.ExecuteDataTable(cmd);
        }
        catch (Exception ex)
        {
            throw new Exception("Erro ao consultar datatable emprestimo: " + ex.Message);
        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using MySql.Data.MySqlClient;
using System.Data;
using System.Text;
using System.Configuration;

public class clsControleAluno
{
    private string wStrServer = ConfigurationManager.AppSettings["pStrServer"].ToString();
    private string wStrDataBase = ConfigurationManager.AppSettings["pStrDataBase"].ToString();
    private string wStrUser = ConfigurationManager.AppSettings["pStrUser"].ToString();
    private string wStrpass = ConfigurationManager.AppSettings["pStrpass"].ToString();

    public int AluId { get; set; }
	public int CurId { get; set; }
    public string CurDescricao { get; set; }
	public int TurId { get; set; }
    public string TurDescricao { get; set; }
	public string AluNome { get; set; }
	public string AluEmail { get; set; }
    public string AluCPF { get; set; }
	public string AluSenha { get; set; }
	public string AluEndereco { get; set; }
	public string AluBairro { get; set; }
	public string AluCidade { get; set; }
	public string AluCEP { get; set; }
	public string AluUF { get; set; }
	public string AluFone { get; set; }
	public string AluCelular { get; set; }
	public string AluSituacao { get; set; }
	public string AluObservacao { get; set; }
	public DateTime AluCadastro { get; set; }
	public DateTime AluAlteracao { get; set; }
	public DateTime AluUltAcesso { get; set; }
	
    public clsControleAluno()
    {
        this.AluId = 0;
		this.CurId = 0;
        this.CurDescricao = string.Empty;
        this.TurDescricao = string.Empty;
		this.TurId = 0;
		this.AluNome = string.Empty;
		this.AluEmail = string.Empty;
		this.AluCPF = string.Empty;
		this.AluSenha = string.Empty;
		this.AluEndereco = string.Empty;
		this.AluBairro = string.Empty;
		this.AluCidade = string.Empty;
		this.AluCEP = string.Empty;
		this.AluUF = string.Empty;
		this.AluFone = string.Empty;
		this.AluCelular = string.Empty;
        this.AluSituacao = string.Empty;
		this.AluObservacao = string.Empty;
    }

    public void Cadastrar()
    {
        clsBD objBd = new clsBD(wStrServer, wStrDataBase, wStrUser, wStrpass);

        try
        {
            if (Convert.ToInt32(this.AluId) > 0)
            {
                MySqlCommand cmd = new MySqlCommand("update tbaluno set "+
                    "curId = @curId, " +
                    "turId = @turId, " +
                    "aluNome = @aluNome, " +
                    "aluEmail = @aluEmail, " +
                    "aluCPF = @aluCPF, " +
                    "aluSenha = @aluSenha, " +
                    "aluEndereco = @aluEndereco, " +
                    "aluBairro = @aluBairro, " +
                    "aluCidade = @aluCidade, " +
                    "aluUF = @aluUF, " +
                    "aluCEP = @aluCEP, " +
                    "aluFone = @aluFone, " +
                    "aluCelular = @aluCelular, " +
                    "aluSituacao = @aluSituacao, " +
                    "aluObservacao = @aluObservacao " +
                    "where aluId = @aluId;");

                cmd.Parameters.AddWithValue("@aluId", this.AluId);
                cmd.Parameters.AddWithValue("@curId", this.CurId);
                cmd.Parameters.AddWithValue("@turId", this.TurId);
                cmd.Parameters.AddWithValue("@aluNome", this.AluNome);
                cmd.Parameters.AddWithValue("@aluEmail", this.AluEmail);
                cmd.Parameters.AddWithValue("@aluCPF", this.AluCPF);
                cmd.Parameters.AddWithValue("@aluSenha", this.AluSenha);
                cmd.Parameters.AddWithValue("@aluEndereco", this.AluEndereco);
                cmd.Parameters.AddWithValue("@aluBairro", this.AluBairro);
                cmd.Parameters.AddWithValue("@aluCidade", this.AluCidade);
                cmd.Parameters.AddWithValue("@aluUF", this.AluUF);
                cmd.Parameters.AddWithValue("@aluCEP", this.AluCEP);
                cmd.Parameters.AddWithValue("@aluFone", this.AluFone);
                cmd.Parameters.AddWithValue("@aluCelular", this.AluCelular);
                cmd.Parameters.AddWithValue("@aluSituacao", this.AluSituacao);
                cmd.Parameters.AddWithValue("@aluObservacao", this.AluObservacao);

                objBd.ExecuteQuery(cmd);
            }
            else
            {
                MySqlCommand cmd = new MySqlCommand("insert into tbaluno (" +
                    "curId," +
                    "turId," +
                    "aluNome," +
                    "aluEmail," +
                    "aluCPF," +
                    "aluSenha," +
                    "aluEndereco," +
                    "aluBairro," +
                    "aluCidade," +
                    "aluUF," +
                    "aluCEP," +
                    "aluFone," +
                    "aluCelular," +
                    "aluSituacao," +
                    "aluObservacao" +
                    ") values (" +
                    "@curId," +
                    "@turId," +
                    "@aluNome," +
                    "@aluEmail," +
                    "@aluCPF," +
                    "@aluSenha," +
                    "@aluEndereco," +
                    "@aluBairro," +
                    "@aluCidade," +
                    "@aluUF," +
                    "@aluCEP," +
                    "@aluFone," +
                    "@aluCelular," +
                    "@aluSituacao," +
                    "@aluObservacao" +
                    ");");

                cmd.Parameters.AddWithValue("@curId", this.CurId);
                cmd.Parameters.AddWithValue("@turId", this.TurId);
                cmd.Parameters.AddWithValue("@aluNome", this.AluNome);
                cmd.Parameters.AddWithValue("@aluEmail", this.AluEmail);
                cmd.Parameters.AddWithValue("@aluCPF", this.AluCPF);
                cmd.Parameters.AddWithValue("@aluSenha", this.AluSenha);
                cmd.Parameters.AddWithValue("@aluEndereco", this.AluEndereco);
                cmd.Parameters.AddWithValue("@aluBairro", this.AluBairro);
                cmd.Parameters.AddWithValue("@aluCidade", this.AluCidade);
                cmd.Parameters.AddWithValue("@aluUF", this.AluUF);
                cmd.Parameters.AddWithValue("@aluCEP", this.AluCEP);
                cmd.Parameters.AddWithValue("@aluFone", this.AluFone);
                cmd.Parameters.AddWithValue("@aluCelular", this.AluCelular);
                cmd.Parameters.AddWithValue("@aluSituacao", this.AluSituacao);
                cmd.Parameters.AddWithValue("@aluObservacao", this.AluObservacao);

                objBd.ExecuteQuery(cmd);
            }
            
        }
        catch (Exception ex)
        {
            throw new Exception("Erro ao cadastrar aluno" + ex.Message);
        }
    }

    public bool Excluir()
    {
        clsBD objBd = new clsBD(wStrServer, wStrDataBase, wStrUser, wStrpass);

        bool res = false;

        try
        {
            if (ifExistsRelation(this.AluId) == 0)
            {
                MySqlCommand cmd = new MySqlCommand("delete from tbaluno where aluId = @aluId;");

                cmd.Parameters.AddWithValue("@aluId", this.AluId);

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
            throw new Exception("Erro ao excluir aluno" + ex.Message);
        }

        return res;
    }

    public DataTable Consultar()
    {
        clsBD objBd = new clsBD(wStrServer, wStrDataBase, wStrUser, wStrpass);

        try
        {
            //MySqlCommand cmd = new MySqlCommand("sp_select_aluno");
            MySqlCommand cmd = new MySqlCommand("select * from tbaluno a left outer join tbcurso c on (a.curId = c.curId) left outer join tbturma t on (a.turId = t.turId)");
            //cmd.CommandType = CommandType.StoredProcedure;
			
            return objBd.ExecuteDataTable(cmd);
        }
        catch (Exception ex)
        {
            throw new Exception("Erro ao consultar datatable aluno" + ex.Message);
        }
    }

    public int ifExistsRelation(Int32 aluId)
    {
        clsBD objBd = new clsBD(wStrServer, wStrDataBase, wStrUser, wStrpass);

        int count = 0;

        try
        {
            MySqlCommand cmd = new MySqlCommand("select count(resId) from tbreserva where aluId = @aluId;");
            cmd.Parameters.AddWithValue("@aluId", aluId);

            count = Convert.ToInt32(objBd.ExecuteObject(cmd));
        }
        catch (Exception ex)
        {
            throw new Exception("Erro ao consultar aluno reserva: " + ex.Message);
        }

        return count;
    }
}
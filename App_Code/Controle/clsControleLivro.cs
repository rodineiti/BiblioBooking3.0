using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using MySql.Data.MySqlClient;
using System.Data;
using System.Text;
using System.Configuration;

public class clsControleLivro
{
    private string wStrServer = ConfigurationManager.AppSettings["pStrServer"].ToString();
    private string wStrDataBase = ConfigurationManager.AppSettings["pStrDataBase"].ToString();
    private string wStrUser = ConfigurationManager.AppSettings["pStrUser"].ToString();
    private string wStrpass = ConfigurationManager.AppSettings["pStrpass"].ToString();

    public int LivId { get; set; }
	public int AutId { get; set; }
    public string AutNome { get; set; }
	public int EdiId { get; set; }
    public string EdiNome { get; set; }
	public int CatId { get; set; }
    public string CatDescricao { get; set; }
	public int TipId { get; set; }
    public string TipDescricao { get; set; }
    public string LivISBN { get; set; }
	public string LivTitulo { get; set; }
	public int LivAno { get; set; }
	public string LivEdicao { get; set; }
	public string LivLocalizacao { get; set; }
	public string LivCapa { get; set; }
	public string LivObservacao { get; set; }
	public int LivPaginas { get; set; }
	public DateTime LivDataCadastro { get; set; }
	public string LivStatus { get; set; }
	
    public clsControleLivro()
    {
        this.AutId = 0;
        this.AutNome = string.Empty;
		this.EdiId = 0;
        this.EdiNome = string.Empty;
		this.CatId = 0;
        this.CatDescricao = string.Empty;
		this.TipId = 0;
        this.TipDescricao = string.Empty;
		this.LivISBN = string.Empty;
		this.LivTitulo = string.Empty;
		this.LivAno = 0;
		this.LivEdicao = string.Empty;
		this.LivLocalizacao = string.Empty;
		this.LivCapa = string.Empty;
		this.LivObservacao = string.Empty;
		this.LivPaginas = 0;
        this.LivStatus = string.Empty;
    }

    public void Cadastrar()
    {
        clsBD objBd = new clsBD(wStrServer, wStrDataBase, wStrUser, wStrpass);

        try
        {
            if (Convert.ToInt32(this.LivId) > 0)
            {
                MySqlCommand cmd = new MySqlCommand("update tblivro set " +
                    "autId = @autId, " +
                    "ediId = @ediId, " +
                    "catId = @catId, " +
                    "tipId = @tipId, " +
                    "livISBN = @livISBN, " +
                    "livTitulo = @livTitulo, " +
                    "livAno = @livAno, " +
                    "livEdicao = @livEdicao, " +
                    "livLocalizacao = @livLocalizacao, " +
                    "livPaginas = @livPaginas, " +
                    "livStatus = @livStatus, " +
                    "livObservacao = @livObservacao " +
                    "where livId = @livId;");

                cmd.Parameters.AddWithValue("@livId", this.LivId);
                cmd.Parameters.AddWithValue("@autId", this.AutId);
                cmd.Parameters.AddWithValue("@ediId", this.EdiId);
                cmd.Parameters.AddWithValue("@catId", this.CatId);
                cmd.Parameters.AddWithValue("@tipId", this.TipId);
                cmd.Parameters.AddWithValue("@livISBN", this.LivISBN);
                cmd.Parameters.AddWithValue("@livTitulo", this.LivTitulo);
                cmd.Parameters.AddWithValue("@livAno", this.LivAno);
                cmd.Parameters.AddWithValue("@livEdicao", this.LivEdicao);
                cmd.Parameters.AddWithValue("@livLocalizacao", this.LivLocalizacao);
                cmd.Parameters.AddWithValue("@livPaginas", this.LivPaginas);
                cmd.Parameters.AddWithValue("@livStatus", this.LivStatus);
                cmd.Parameters.AddWithValue("@livObservacao", this.LivObservacao);

                objBd.ExecuteQuery(cmd);
            }
            else
            {
                MySqlCommand cmd = new MySqlCommand("insert into tblivro (" +
                    "autId," +
                    "ediId," +
                    "catId," +
                    "tipId," +
                    "livISBN," +
                    "livTitulo," +
                    "livAno," +
                    "livEdicao," +
                    "livLocalizacao," +
                    "livPaginas," +
                    "livStatus," +
                    "livObservacao" +
                    ") values (" +
                    "@autId," +
                    "@ediId," +
                    "@catId," +
                    "@tipId," +
                    "@livISBN," +
                    "@livTitulo," +
                    "@livAno," +
                    "@livEdicao," +
                    "@livLocalizacao," +
                    "@livPaginas," +
                    "@livStatus," +
                    "@livObservacao" +
                    ");");

                cmd.Parameters.AddWithValue("@autId", this.AutId);
                cmd.Parameters.AddWithValue("@ediId", this.EdiId);
                cmd.Parameters.AddWithValue("@catId", this.CatId);
                cmd.Parameters.AddWithValue("@tipId", this.TipId);
                cmd.Parameters.AddWithValue("@livISBN", this.LivISBN);
                cmd.Parameters.AddWithValue("@livTitulo", this.LivTitulo);
                cmd.Parameters.AddWithValue("@livAno", this.LivAno);
                cmd.Parameters.AddWithValue("@livEdicao", this.LivEdicao);
                cmd.Parameters.AddWithValue("@livLocalizacao", this.LivLocalizacao);
                cmd.Parameters.AddWithValue("@livPaginas", this.LivPaginas);
                cmd.Parameters.AddWithValue("@livStatus", this.LivStatus);
                cmd.Parameters.AddWithValue("@livObservacao", this.LivObservacao);

                objBd.ExecuteQuery(cmd);
            }
        }
        catch (Exception ex)
        {
            throw new Exception("Erro ao cadastrar livro" + ex.Message);
        }
    }

    public bool Excluir()
    {
        clsBD objBd = new clsBD(wStrServer, wStrDataBase, wStrUser, wStrpass);

        bool res = false;

        try
        {
            if (ifExistsRelation(this.LivId) == 0)
            {
                MySqlCommand cmd = new MySqlCommand("delete from tblivro where livId = @livId;");

                cmd.Parameters.AddWithValue("@livId", this.LivId);

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
            throw new Exception("Erro ao excluir livro" + ex.Message);
        }

        return res;
    }

    public DataTable Consultar()
    {
        clsBD objBd = new clsBD(wStrServer, wStrDataBase, wStrUser, wStrpass);

        try
        {
            MySqlCommand cmd = new MySqlCommand("select * from tblivro l left outer join tbautor a on (a.autId = l.autId) left outer join tbeditora e on (e.ediId = l.ediId) left outer join tbcategoria c on (c.catId = l.catId) left outer join tbtipolivro t on (t.tipId = l.tipId);");

            return objBd.ExecuteDataTable(cmd);
        }
        catch (Exception ex)
        {
            throw new Exception("Erro ao consultar datatable livro" + ex.Message);
        }
    }

    public void AtualizaStatusLivro(string livId, string livStatus)
    {
        clsBD objBd = new clsBD(wStrServer, wStrDataBase, wStrUser, wStrpass);

        try
        {
            MySqlCommand cmd = new MySqlCommand("update tblivro set livStatus = @livStatus where livId = @livId;");

            cmd.Parameters.AddWithValue("@livId", Convert.ToInt32(livId));
            cmd.Parameters.AddWithValue("@livStatus", livStatus.ToUpper().Trim());

            objBd.ExecuteQuery(cmd);
        }
        catch (Exception ex)
        {
            throw new Exception("Erro ao atualizar status do livro: " + ex.Message);
        }
    }

    public int ifExistsRelation(Int32 id)
    {
        clsBD objBd = new clsBD(wStrServer, wStrDataBase, wStrUser, wStrpass);

        int count = 0;

        try
        {
            MySqlCommand cmd = new MySqlCommand("select count(*) from tbitemreserva i inner join tbreserva r on (i.resId = r.resId) where i.livId = @livId and r.resStatus in ('S');");

            cmd.Parameters.AddWithValue("@livId", id);

            count = Convert.ToInt32(objBd.ExecuteObject(cmd));
        }
        catch (Exception ex)
        {
            throw new Exception("Erro ao consultar livro reserva: " + ex.Message);
        }

        return count;
    }
}
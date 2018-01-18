<%@ WebHandler Language="C#" CodeBehind="HandlerAluno.ashx.cs" Class="BiblioBooking.HandlerAluno" %>

using System;
using System.Web;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Web.Script.Serialization;
using System.Collections;
using System.Collections.Specialized;

namespace BiblioBooking
{
    public class HandlerAluno : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            if (context.Request.QueryString["strAcao"].ToString() == "L")
            {
                System.Collections.Specialized.NameValueCollection forms = context.Request.Form;
                string strOp = forms.Get("oper");
                string strResponse = string.Empty;
                clsControleAluno objAluno = new clsControleAluno();
                List<clsControleAluno> listaAluno = new List<clsControleAluno>();

                DataTable dt = objAluno.Consultar();

                foreach (DataRow row in dt.Rows)
                {
                    clsControleAluno objAluno2 = new clsControleAluno();
                    objAluno2.AluId = Convert.ToInt32(row["aluId"]);
                    objAluno2.CurDescricao = row["curDescricao"].ToString();
                    objAluno2.TurDescricao = row["turDescricao"].ToString();
                    objAluno2.AluNome = row["aluNome"].ToString();
                    objAluno2.AluEmail = row["aluEmail"].ToString();
                    objAluno2.AluCPF = row["aluCPF"].ToString();
                    objAluno2.AluSenha = row["aluSenha"].ToString();
                    objAluno2.AluEndereco = row["aluEndereco"].ToString();
                    objAluno2.AluBairro = row["aluBairro"].ToString();
                    objAluno2.AluCidade = row["aluCidade"].ToString();
                    objAluno2.AluUF = row["aluUF"].ToString();
                    objAluno2.AluCEP = row["aluCEP"].ToString();
                    objAluno2.AluFone = row["aluFone"].ToString();
                    objAluno2.AluCelular = row["aluCelular"].ToString();
                    objAluno2.AluObservacao = row["aluObservacao"].ToString();
                    objAluno2.AluSituacao = row["aluSituacao"].ToString();
                    listaAluno.Add(objAluno2);
                }

                if (strOp == null)
                {
                    var jsonSer = new JavaScriptSerializer();
                    context.Response.Write(jsonSer.Serialize(listaAluno.AsQueryable<clsControleAluno>().ToList<clsControleAluno>()));
                }
                else if (strOp == "del")
                {
                    clsControleAluno objAlunoDel = new clsControleAluno();
                    objAlunoDel.AluId = Convert.ToInt32(forms.Get("AluId"));
                    if (objAlunoDel.Excluir())
                    {
                        strResponse = "Registro removido com sucesso!";
                    }
                    else
                    {
                        strResponse = "Não foi possível deletar o registro!";    
                    }
                    context.Response.Write(strResponse);
                }
                else
                {
                    string strOut = string.Empty;
                    AddEdit(forms, listaAluno, out strOut);
                    context.Response.Write(strOut);
                }
            }
            else if (context.Request.QueryString["strAcao"].ToString() == "E")
            {
                clsControleAluno objAluno = new clsControleAluno();
                List<object> listaAluno = new List<object>();

                DataTable dt = objAluno.Consultar();

                foreach (DataRow row in dt.Rows)
                {
                    clsControleAluno objAluno2 = new clsControleAluno();
                    objAluno2.AluId = Convert.ToInt32(row["aluId"]);
                    objAluno2.CurDescricao = row["curDescricao"].ToString();
                    objAluno2.TurDescricao = row["turDescricao"].ToString();
                    objAluno2.AluNome = row["aluNome"].ToString();
                    objAluno2.AluEmail = row["aluEmail"].ToString();
                    objAluno2.AluCPF = row["aluCPF"].ToString();
                    objAluno2.AluSenha = row["aluSenha"].ToString();
                    objAluno2.AluEndereco = row["aluEndereco"].ToString();
                    objAluno2.AluBairro = row["aluBairro"].ToString();
                    objAluno2.AluCidade = row["aluCidade"].ToString();
                    objAluno2.AluUF = row["aluUF"].ToString();
                    objAluno2.AluCEP = row["aluCEP"].ToString();
                    objAluno2.AluFone = row["aluFone"].ToString();
                    objAluno2.AluCelular = row["aluCelular"].ToString();
                    objAluno2.AluObservacao = row["aluObservacao"].ToString();
                    objAluno2.AluSituacao = row["aluSituacao"].ToString();
                    listaAluno.Add(objAluno2);
                }

                var jsonSer = new JavaScriptSerializer();
                context.Response.ContentType = "application/json; charset=utf-8";
                context.Response.Write(jsonSer.Serialize(listaAluno.ToList()));
            }
        }

        private void AddEdit(NameValueCollection forms, List<clsControleAluno> listaAluno, out string strResponse)
        {
            string strOperation = forms.Get("oper");
            int intAluId = 0;
            string strRetorno = "";

            if (strOperation == "add")
            {
                intAluId = Convert.ToInt32(forms.Get("AluId"));

                int intCurId = Convert.ToInt32(forms.Get("CurDescricao"));
                int intTurId = Convert.ToInt32(forms.Get("TurDescricao"));
                string strAluNome = forms.Get("AluNome").ToString();
                string strAluEmail = forms.Get("AluEmail").ToString();
                string strAluCPF = forms.Get("AluCPF").ToString();
                string strAluSenha = forms.Get("AluSenha").ToString();
                string strAluEndereco = forms.Get("AluEndereco").ToString();
                string strAluBairro = forms.Get("AluBairro").ToString();
                string strAluCidade = forms.Get("AluCidade").ToString();
                string strAluUF = forms.Get("AluUF").ToString();
                string strAluCEP = forms.Get("AluCEP").ToString();
                string strAluFone = forms.Get("AluFone").ToString();
                string strAluCelular = forms.Get("AluCelular").ToString();
                string strAluObservacao = forms.Get("AluObservacao").ToString();
                string strAluSituacao = forms.Get("AluSituacao").ToString();
                
                clsControleAluno objAlunoInsUpd = new clsControleAluno();
                objAlunoInsUpd.AluId = Convert.ToInt32(intAluId);
                objAlunoInsUpd.CurId = Convert.ToInt32(intCurId);
                objAlunoInsUpd.TurId = Convert.ToInt32(intTurId);
                objAlunoInsUpd.AluNome = strAluNome;
                objAlunoInsUpd.AluEmail = strAluEmail;
                objAlunoInsUpd.AluCPF = strAluCPF;
                objAlunoInsUpd.AluSenha = strAluSenha;
                objAlunoInsUpd.AluEndereco = strAluEndereco;
                objAlunoInsUpd.AluBairro = strAluBairro;
                objAlunoInsUpd.AluCidade = strAluCidade;
                objAlunoInsUpd.AluUF = strAluUF;
                objAlunoInsUpd.AluCEP = strAluCEP;
                objAlunoInsUpd.AluFone = strAluFone;
                objAlunoInsUpd.AluCelular = strAluCelular;
                objAlunoInsUpd.AluObservacao = strAluObservacao;
                objAlunoInsUpd.AluSituacao = strAluSituacao;
                objAlunoInsUpd.Cadastrar();

                strRetorno = "Registro cadastrado com sucesso!";
            }
            else if (strOperation == "edit")
            {
                intAluId = Convert.ToInt32(forms.Get("AluId"));

                int intCurId = Convert.ToInt32(forms.Get("CurDescricao"));
                int intTurId = Convert.ToInt32(forms.Get("TurDescricao"));
                string strAluNome = forms.Get("AluNome").ToString();
                string strAluEmail = forms.Get("AluEmail").ToString();
                string strAluCPF = forms.Get("AluCPF").ToString();
                string strAluSenha = forms.Get("AluSenha").ToString();
                string strAluEndereco = forms.Get("AluEndereco").ToString();
                string strAluBairro = forms.Get("AluBairro").ToString();
                string strAluCidade = forms.Get("AluCidade").ToString();
                string strAluUF = forms.Get("AluUF").ToString();
                string strAluCEP = forms.Get("AluCEP").ToString();
                string strAluFone = forms.Get("AluFone").ToString();
                string strAluCelular = forms.Get("AluCelular").ToString();
                string strAluObservacao = forms.Get("AluObservacao").ToString();
                string strAluSituacao = forms.Get("AluSituacao").ToString();

                clsControleAluno objAlunoInsUpd = new clsControleAluno();
                objAlunoInsUpd.AluId = Convert.ToInt32(intAluId);
                objAlunoInsUpd.CurId = Convert.ToInt32(intCurId);
                objAlunoInsUpd.TurId = Convert.ToInt32(intTurId);
                objAlunoInsUpd.AluNome = strAluNome;
                objAlunoInsUpd.AluEmail = strAluEmail;
                objAlunoInsUpd.AluCPF = strAluCPF;
                objAlunoInsUpd.AluSenha = strAluSenha;
                objAlunoInsUpd.AluEndereco = strAluEndereco;
                objAlunoInsUpd.AluBairro = strAluBairro;
                objAlunoInsUpd.AluCidade = strAluCidade;
                objAlunoInsUpd.AluUF = strAluUF;
                objAlunoInsUpd.AluCEP = strAluCEP;
                objAlunoInsUpd.AluFone = strAluFone;
                objAlunoInsUpd.AluCelular = strAluCelular;
                objAlunoInsUpd.AluObservacao = strAluObservacao;
                objAlunoInsUpd.AluSituacao = strAluSituacao;      
                objAlunoInsUpd.Cadastrar();

                strRetorno = "Registro atualizado com sucesso!";
            }
            else
            {
                strRetorno = "Nenhuma operação informada";
            }

            strResponse = strRetorno;
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}
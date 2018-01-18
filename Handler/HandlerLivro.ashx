<%@ WebHandler Language="C#" CodeBehind="HandlerLivro.ashx.cs" Class="BiblioBooking.HandlerLivro" %>

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
    public class HandlerLivro : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            if (context.Request.QueryString["strAcao"].ToString() == "L")
            {
                System.Collections.Specialized.NameValueCollection forms = context.Request.Form;
                string strOp = forms.Get("oper");
                string strResponse = string.Empty;
                clsControleLivro objLivro = new clsControleLivro();
                List<clsControleLivro> listaLivro = new List<clsControleLivro>();

                DataTable dt = objLivro.Consultar();

                foreach (DataRow row in dt.Rows)
                {
                    clsControleLivro objLivro2 = new clsControleLivro();
                    objLivro2.LivId = Convert.ToInt32(row["livId"]);
                    objLivro2.AutNome = row["autNome"].ToString();
                    objLivro2.EdiNome = row["ediNome"].ToString();
                    objLivro2.CatDescricao = row["catDescricao"].ToString();
                    objLivro2.TipDescricao = row["tipDescricao"].ToString();
                    objLivro2.LivISBN = row["livISBN"].ToString();
                    objLivro2.LivTitulo = row["livTitulo"].ToString();
                    objLivro2.LivAno = Convert.ToInt32(row["livAno"]);
                    objLivro2.LivEdicao = row["livEdicao"].ToString();
                    objLivro2.LivLocalizacao = row["livLocalizacao"].ToString();
                    objLivro2.LivPaginas = Convert.ToInt32(row["livPaginas"]);
                    objLivro2.LivStatus = row["livStatus"].ToString();
                    objLivro2.LivObservacao = row["livObservacao"].ToString();
                    listaLivro.Add(objLivro2);
                }

                if (strOp == null)
                {
                    var jsonSer = new JavaScriptSerializer();
                    context.Response.Write(jsonSer.Serialize(listaLivro.AsQueryable<clsControleLivro>().ToList<clsControleLivro>()));
                }
                else if (strOp == "del")
                {
                    clsControleLivro objLivroDel = new clsControleLivro();
                    objLivroDel.LivId = Convert.ToInt32(forms.Get("LivId"));
                    if (objLivroDel.Excluir())
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
                    AddEdit(forms, listaLivro, out strOut);
                    context.Response.Write(strOut);
                }
            }
            else if (context.Request.QueryString["strAcao"].ToString() == "E")
            {
                clsControleLivro objLivro = new clsControleLivro();
                List<object> listaLivro = new List<object>();

                DataTable dt = objLivro.Consultar();

                foreach (DataRow row in dt.Rows)
                {
                    clsControleLivro objLivro2 = new clsControleLivro();
                    objLivro2.LivId = Convert.ToInt32(row["livId"]);
                    objLivro2.AutNome = row["autNome"].ToString();
                    objLivro2.EdiNome = row["ediNome"].ToString();
                    objLivro2.CatDescricao = row["catDescricao"].ToString();
                    objLivro2.TipDescricao = row["tipDescricao"].ToString();
                    objLivro2.LivISBN = row["livISBN"].ToString();
                    objLivro2.LivTitulo = row["livTitulo"].ToString();
                    objLivro2.LivAno = Convert.ToInt32(row["livAno"]);
                    objLivro2.LivEdicao = row["livEdicao"].ToString();
                    objLivro2.LivLocalizacao = row["livLocalizacao"].ToString();
                    objLivro2.LivPaginas = Convert.ToInt32(row["livPaginas"]);
                    objLivro2.LivStatus = row["livStatus"].ToString();
                    objLivro2.LivObservacao = row["livObservacao"].ToString();
                    listaLivro.Add(objLivro2);
                }

                var jsonSer = new JavaScriptSerializer();
                context.Response.ContentType = "application/json; charset=utf-8";
                context.Response.Write(jsonSer.Serialize(listaLivro.ToList()));
            }
        }

        private void AddEdit(NameValueCollection forms, List<clsControleLivro> listaLivro, out string strResponse)
        {
            string strOperation = forms.Get("oper");
            int intLivId = 0;
            string strRetorno = "";

            if (strOperation == "add")
            {
                intLivId = Convert.ToInt32(forms.Get("LivId"));

                int intAutId = Convert.ToInt32(forms.Get("AutNome"));
                int intEdiId = Convert.ToInt32(forms.Get("EdiNome"));
                int intCatId = Convert.ToInt32(forms.Get("CatDescricao"));
                int intTipId = Convert.ToInt32(forms.Get("TipDescricao"));
                string strLivISBN = forms.Get("LivISBN").ToString();
                string strLivTitulo = forms.Get("LivTitulo").ToString();
                int intLivAno = Convert.ToInt32(forms.Get("LivAno"));
                string strLivEdicao = forms.Get("LivEdicao").ToString();
                string strLivLocalizacao = forms.Get("LivLocalizacao").ToString();
                int intLivPaginas = Convert.ToInt32(forms.Get("LivPaginas"));
                string strLivStatus = forms.Get("LivStatus").ToString();
                string strLivObservacao = forms.Get("LivObservacao").ToString();
                
                clsControleLivro objLivroInsUpd = new clsControleLivro();
                objLivroInsUpd.LivId = Convert.ToInt32(intLivId);
                objLivroInsUpd.AutId = Convert.ToInt32(intAutId);
                objLivroInsUpd.EdiId = Convert.ToInt32(intEdiId);
                objLivroInsUpd.CatId = Convert.ToInt32(intCatId);
                objLivroInsUpd.TipId = Convert.ToInt32(intTipId);
                objLivroInsUpd.LivISBN = strLivISBN;
                objLivroInsUpd.LivTitulo = strLivTitulo;
                objLivroInsUpd.LivAno = intLivAno;
                objLivroInsUpd.LivEdicao = strLivEdicao;
                objLivroInsUpd.LivLocalizacao = strLivLocalizacao;
                objLivroInsUpd.LivPaginas = Convert.ToInt32(intLivPaginas);
                objLivroInsUpd.LivStatus = strLivStatus;
                objLivroInsUpd.LivObservacao = strLivObservacao;
                objLivroInsUpd.Cadastrar();

                strRetorno = "Registro cadastrado com sucesso!";
            }
            else if (strOperation == "edit")
            {
                intLivId = Convert.ToInt32(forms.Get("LivId"));

                int intAutId = Convert.ToInt32(forms.Get("AutNome"));
                int intEdiId = Convert.ToInt32(forms.Get("EdiNome"));
                int intCatId = Convert.ToInt32(forms.Get("CatDescricao"));
                int intTipId = Convert.ToInt32(forms.Get("TipDescricao"));
                string strLivISBN = forms.Get("LivISBN").ToString();
                string strLivTitulo = forms.Get("LivTitulo").ToString();
                int intLivAno = Convert.ToInt32(forms.Get("LivAno"));
                string strLivEdicao = forms.Get("LivEdicao").ToString();
                string strLivLocalizacao = forms.Get("LivLocalizacao").ToString();
                int intLivPaginas = Convert.ToInt32(forms.Get("LivPaginas"));
                string strLivStatus = forms.Get("LivStatus").ToString();
                string strLivObservacao = forms.Get("LivObservacao").ToString();

                clsControleLivro objLivroInsUpd = new clsControleLivro();
                objLivroInsUpd.LivId = Convert.ToInt32(intLivId);
                objLivroInsUpd.AutId = Convert.ToInt32(intAutId);
                objLivroInsUpd.EdiId = Convert.ToInt32(intEdiId);
                objLivroInsUpd.CatId = Convert.ToInt32(intCatId);
                objLivroInsUpd.TipId = Convert.ToInt32(intTipId);
                objLivroInsUpd.LivISBN = strLivISBN;
                objLivroInsUpd.LivTitulo = strLivTitulo;
                objLivroInsUpd.LivAno = intLivAno;
                objLivroInsUpd.LivEdicao = strLivEdicao;
                objLivroInsUpd.LivLocalizacao = strLivLocalizacao;
                objLivroInsUpd.LivPaginas = Convert.ToInt32(intLivPaginas);
                objLivroInsUpd.LivStatus = strLivStatus;
                objLivroInsUpd.LivObservacao = strLivObservacao;
                objLivroInsUpd.Cadastrar();

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
<%@ WebHandler Language="C#" CodeBehind="HandlerEditora.ashx.cs" Class="BiblioBooking.HandlerEditora" %>

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
    public class HandlerEditora : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            if (context.Request.QueryString["strAcao"].ToString() == "L")
            {
                System.Collections.Specialized.NameValueCollection forms = context.Request.Form;
                string strOp = forms.Get("oper");
                string strResponse = string.Empty;
                clsControleEditora objEditora = new clsControleEditora();
                List<clsControleEditora> listaEditora = new List<clsControleEditora>();

                DataTable dt = objEditora.Consultar();

                foreach (DataRow row in dt.Rows)
                {
                    clsControleEditora objEditora2 = new clsControleEditora();
                    objEditora2.EdiId = Convert.ToInt32(row["ediId"]);
                    objEditora2.EdiNome = row["ediNome"].ToString();
                    objEditora2.EdiEndereco = row["ediEndereco"].ToString();
                    objEditora2.EdiBairro = row["ediBairro"].ToString();
                    objEditora2.EdiCidade = row["ediCidade"].ToString();
                    objEditora2.EdiUF = row["ediUF"].ToString();
                    objEditora2.EdiCEP = row["ediCEP"].ToString();
                    objEditora2.EdiFone = row["ediFone"].ToString();
                    listaEditora.Add(objEditora2);
                }

                if (strOp == null)
                {
                    var jsonSer = new JavaScriptSerializer();
                    context.Response.Write(jsonSer.Serialize(listaEditora.AsQueryable<clsControleEditora>().ToList<clsControleEditora>()));
                }
                else if (strOp == "del")
                {
                    clsControleEditora objEditoraDel = new clsControleEditora();
                    objEditoraDel.EdiId = Convert.ToInt32(forms.Get("EdiId"));
                    if (objEditoraDel.Excluir())
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
                    AddEdit(forms, listaEditora, out strOut);
                    context.Response.Write(strOut);
                }
            }
            else if (context.Request.QueryString["strAcao"].ToString() == "E")
            {
                clsControleEditora objEditora = new clsControleEditora();
                List<object> listaEditora = new List<object>();

                DataTable dt = objEditora.Consultar();

                foreach (DataRow row in dt.Rows)
                {
                    clsControleEditora objEditora2 = new clsControleEditora();
                    objEditora2.EdiId = Convert.ToInt32(row["ediId"]);
                    objEditora2.EdiNome = row["ediNome"].ToString();
                    objEditora2.EdiEndereco = row["ediEndereco"].ToString();
                    objEditora2.EdiBairro = row["ediBairro"].ToString();
                    objEditora2.EdiCidade = row["ediCidade"].ToString();
                    objEditora2.EdiUF = row["ediUF"].ToString().ToUpper();
                    objEditora2.EdiCEP = row["ediCEP"].ToString();
                    objEditora2.EdiFone = row["ediFone"].ToString();
                    listaEditora.Add(objEditora2);
                }

                var jsonSer = new JavaScriptSerializer();
                context.Response.ContentType = "application/json; charset=utf-8";
                context.Response.Write(jsonSer.Serialize(listaEditora.ToList()));
            }
        }

        private void AddEdit(NameValueCollection forms, List<clsControleEditora> listaEditora, out string strResponse)
        {
            string strOperation = forms.Get("oper");
            int intEdiId = 0;
            string strRetorno = "";

            if (strOperation == "add")
            {
                intEdiId = Convert.ToInt32(forms.Get("EdiId"));

                string strEdiNome = forms.Get("EdiNome").ToString();
                string strEdiEndereco = forms.Get("EdiEndereco").ToString();
                string strEdiBairro = forms.Get("EdiBairro").ToString();
                string strEdiCidade = forms.Get("EdiCidade").ToString();
                string strEdiUF = forms.Get("EdiUF").ToString().ToUpper();
                string strEdiCEP = forms.Get("EdiCEP").ToString();
                string strEdiFone = forms.Get("EdiFone").ToString();

                clsControleEditora objEditoraInsUpd = new clsControleEditora();
                objEditoraInsUpd.EdiId = Convert.ToInt32(intEdiId);
                objEditoraInsUpd.EdiNome = strEdiNome;
                objEditoraInsUpd.EdiEndereco = strEdiEndereco;
                objEditoraInsUpd.EdiBairro = strEdiBairro;
                objEditoraInsUpd.EdiCidade = strEdiCidade;
                objEditoraInsUpd.EdiUF = strEdiUF;
                objEditoraInsUpd.EdiCEP = strEdiCEP;
                objEditoraInsUpd.EdiFone = strEdiFone;
                objEditoraInsUpd.Cadastrar();

                strRetorno = "Registro cadastrado com sucesso!";
            }
            else if (strOperation == "edit")
            {
                intEdiId = Convert.ToInt32(forms.Get("EdiId"));

                string strEdiNome = forms.Get("EdiNome").ToString();
                string strEdiEndereco = forms.Get("EdiEndereco").ToString();
                string strEdiBairro = forms.Get("EdiBairro").ToString();
                string strEdiCidade = forms.Get("EdiCidade").ToString();
                string strEdiUF = forms.Get("EdiUF").ToString();
                string strEdiCEP = forms.Get("EdiCEP").ToString();
                string strEdiFone = forms.Get("EdiFone").ToString();

                clsControleEditora objEditoraInsUpd = new clsControleEditora();
                objEditoraInsUpd.EdiId = Convert.ToInt32(intEdiId);
                objEditoraInsUpd.EdiNome = strEdiNome;
                objEditoraInsUpd.EdiEndereco = strEdiEndereco;
                objEditoraInsUpd.EdiBairro = strEdiBairro;
                objEditoraInsUpd.EdiCidade = strEdiCidade;
                objEditoraInsUpd.EdiUF = strEdiUF;
                objEditoraInsUpd.EdiCEP = strEdiCEP;
                objEditoraInsUpd.EdiFone = strEdiFone;
                objEditoraInsUpd.Cadastrar();

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
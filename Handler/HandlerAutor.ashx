<%@ WebHandler Language="C#" CodeBehind="HandlerAutor.ashx.cs" Class="BiblioBooking.HandlerAutor" %>

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
    public class HandlerAutor : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            if (context.Request.QueryString["strAcao"].ToString() == "L")
            {
                System.Collections.Specialized.NameValueCollection forms = context.Request.Form;
                string strOp = forms.Get("oper");
                string strResponse = string.Empty;
                clsControleAutor objAutor = new clsControleAutor();
                List<clsControleAutor> listaAutor = new List<clsControleAutor>();

                DataTable dt = objAutor.Consultar();

                foreach (DataRow row in dt.Rows)
                {
                    clsControleAutor objAutor2 = new clsControleAutor();
                    objAutor2.AutId = Convert.ToInt32(row["autId"]);
                    objAutor2.AutNome = row["autNome"].ToString();
                    objAutor2.AutNomeCientifico = row["autNomeCientifico"].ToString();
                    objAutor2.AutBibliografia = row["autBibliografia"].ToString();
                    listaAutor.Add(objAutor2);
                }

                if (strOp == null)
                {
                    var jsonSer = new JavaScriptSerializer();
                    context.Response.Write(jsonSer.Serialize(listaAutor.AsQueryable<clsControleAutor>().ToList<clsControleAutor>()));
                }
                else if (strOp == "del")
                {
                    clsControleAutor objAutorDel = new clsControleAutor();
                    objAutorDel.AutId = Convert.ToInt32(forms.Get("AutId"));
                    if (objAutorDel.Excluir())
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
                    AddEdit(forms, listaAutor, out strOut);
                    context.Response.Write(strOut);
                }
            }
            else if (context.Request.QueryString["strAcao"].ToString() == "E")
            {
                clsControleAutor objAutor = new clsControleAutor();
                List<object> listaAutor = new List<object>();

                DataTable dt = objAutor.Consultar();

                foreach (DataRow row in dt.Rows)
                {
                    clsControleAutor objAutor2 = new clsControleAutor();
                    objAutor2.AutId = Convert.ToInt32(row["autId"]);
                    objAutor2.AutNome = row["autNome"].ToString();
                    objAutor2.AutNomeCientifico = row["autNomeCientifico"].ToString();
                    objAutor2.AutBibliografia = row["autBibliografia"].ToString();
                    listaAutor.Add(objAutor2);
                }

                var jsonSer = new JavaScriptSerializer();
                context.Response.ContentType = "application/json; charset=utf-8";
                context.Response.Write(jsonSer.Serialize(listaAutor.ToList()));
            }
        }

        private void AddEdit(NameValueCollection forms, List<clsControleAutor> listaAutor, out string strResponse)
        {
            string strOperation = forms.Get("oper");
            int intAutId = 0;
            string strRetorno = "";

            if (strOperation == "add")
            {
                intAutId = Convert.ToInt32(forms.Get("AutId"));

                string strAutNome = forms.Get("AutNome").ToString();
                string strAutNomeCientifico = forms.Get("AutNomeCientifico").ToString();
                string strAutBibliografia = forms.Get("AutBibliografia").ToString();

                clsControleAutor objAutorInsUpd = new clsControleAutor();
                objAutorInsUpd.AutId = Convert.ToInt32(intAutId);
                objAutorInsUpd.AutNome = strAutNome;
                objAutorInsUpd.AutNomeCientifico = strAutNomeCientifico;
                objAutorInsUpd.AutBibliografia = strAutBibliografia;
                objAutorInsUpd.Cadastrar();

                strRetorno = "Registro cadastrado com sucesso!";
            }
            else if (strOperation == "edit")
            {
                intAutId = Convert.ToInt32(forms.Get("AutId"));

                string strAutNome = forms.Get("AutNome").ToString();
                string strAutNomeCientifico = forms.Get("AutNomeCientifico").ToString();
                string strAutBibliografia = forms.Get("AutBibliografia").ToString();

                clsControleAutor objAutorInsUpd = new clsControleAutor();
                objAutorInsUpd.AutId = Convert.ToInt32(intAutId);
                objAutorInsUpd.AutNome = strAutNome;
                objAutorInsUpd.AutNomeCientifico = strAutNomeCientifico;
                objAutorInsUpd.AutBibliografia = strAutBibliografia;
                objAutorInsUpd.Cadastrar();

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
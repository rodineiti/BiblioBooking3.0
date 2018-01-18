<%@ WebHandler Language="C#" CodeBehind="HandlerTipoLivro.ashx.cs" Class="BiblioBooking.HandlerTipoLivro" %>

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
    public class HandlerTipoLivro : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {

            if (context.Request.QueryString["strAcao"].ToString() == "L")
            {
                System.Collections.Specialized.NameValueCollection forms = context.Request.Form;
                string strOp = forms.Get("oper");
                string strResponse = string.Empty;
                clsControleTipoLivro objTipo = new clsControleTipoLivro();
                List<clsControleTipoLivro> listaTipo = new List<clsControleTipoLivro>();

                DataTable dt = objTipo.Consultar();

                foreach (DataRow row in dt.Rows)
                {
                    clsControleTipoLivro objTipo2 = new clsControleTipoLivro();
                    objTipo2.TipId = Convert.ToInt32(row["tipId"]);
                    objTipo2.TipDescricao = row["tipDescricao"].ToString();
                    listaTipo.Add(objTipo2);
                }

                if (strOp == null)
                {
                    var jsonSer = new JavaScriptSerializer();
                    context.Response.Write(jsonSer.Serialize(listaTipo.AsQueryable<clsControleTipoLivro>().ToList<clsControleTipoLivro>()));
                }
                else if (strOp == "del")
                {
                    clsControleTipoLivro objTipoDel = new clsControleTipoLivro();
                    objTipoDel.TipId = Convert.ToInt32(forms.Get("TipId"));
                    if (objTipoDel.Excluir())
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
                    AddEdit(forms, listaTipo, out strOut);
                    context.Response.Write(strOut);
                }
            }
            else if (context.Request.QueryString["strAcao"].ToString() == "E")
            {
                clsControleTipoLivro objTipo = new clsControleTipoLivro();
                List<object> listaTipo = new List<object>();

                DataTable dt = objTipo.Consultar();

                foreach (DataRow row in dt.Rows)
                {
                    clsControleTipoLivro objTipo2 = new clsControleTipoLivro();
                    objTipo2.TipId = Convert.ToInt32(row["tipId"]);
                    objTipo2.TipDescricao = row["tipDescricao"].ToString();
                    listaTipo.Add(objTipo2);
                }

                var jsonSer = new JavaScriptSerializer();
                context.Response.ContentType = "application/json; charset=utf-8";
                context.Response.Write(jsonSer.Serialize(listaTipo.ToList()));
            }
        }

        private void AddEdit(NameValueCollection forms, List<clsControleTipoLivro> listaTipo, out string strResponse)
        {
            string strOperation = forms.Get("oper");
            int intTipId = 0;
            string strRetorno = "";

            if (strOperation == "add")
            {
                intTipId = Convert.ToInt32(forms.Get("TipId"));

                string strTipDescricao = forms.Get("TipDescricao").ToString();

                clsControleTipoLivro objTipoInsUpd = new clsControleTipoLivro();
                objTipoInsUpd.TipId = Convert.ToInt32(intTipId);
                objTipoInsUpd.TipDescricao = strTipDescricao;
                objTipoInsUpd.Cadastrar();

                strRetorno = "Registro cadastrado com sucesso!";
            }
            else if (strOperation == "edit")
            {
                intTipId = Convert.ToInt32(forms.Get("TipId"));

                string strTipDescricao = forms.Get("TipDescricao").ToString();

                clsControleTipoLivro objTipoInsUpd = new clsControleTipoLivro();
                objTipoInsUpd.TipId = Convert.ToInt32(intTipId);
                objTipoInsUpd.TipDescricao = strTipDescricao;
                objTipoInsUpd.Cadastrar();

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
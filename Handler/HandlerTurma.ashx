<%@ WebHandler Language="C#" CodeBehind="HandlerTurma.ashx.cs" Class="BiblioBooking.HandlerTurma" %>

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
    public class HandlerTurma : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {

            if (context.Request.QueryString["strAcao"].ToString() == "L")
            {
                System.Collections.Specialized.NameValueCollection forms = context.Request.Form;
                string strOp = forms.Get("oper");
                string strResponse = string.Empty;
                clsControleTurma objTurma = new clsControleTurma();
                List<clsControleTurma> listaTurma = new List<clsControleTurma>();

                DataTable dt = objTurma.Consultar();

                foreach (DataRow row in dt.Rows)
                {
                    clsControleTurma objTurma2 = new clsControleTurma();
                    objTurma2.TurId = Convert.ToInt32(row["turId"]);
                    objTurma2.TurDescricao = row["turDescricao"].ToString();
                    listaTurma.Add(objTurma2);
                }

                if (strOp == null)
                {
                    var jsonSer = new JavaScriptSerializer();
                    context.Response.Write(jsonSer.Serialize(listaTurma.AsQueryable<clsControleTurma>().ToList<clsControleTurma>()));
                }
                else if (strOp == "del")
                {
                    clsControleTurma objTurmaDel = new clsControleTurma();
                    objTurmaDel.TurId = Convert.ToInt32(forms.Get("TurId"));
                    if (objTurmaDel.Excluir())
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
                    AddEdit(forms, listaTurma, out strOut);
                    context.Response.Write(strOut);
                }
            }
            else if (context.Request.QueryString["strAcao"].ToString() == "E")
            {
                clsControleTurma objTurma = new clsControleTurma();
                List<object> listaTurma = new List<object>();

                DataTable dt = objTurma.Consultar();

                foreach (DataRow row in dt.Rows)
                {
                    clsControleTurma objTurma2 = new clsControleTurma();
                    objTurma2.TurId = Convert.ToInt32(row["turId"]);
                    objTurma2.TurDescricao = row["turDescricao"].ToString();
                    listaTurma.Add(objTurma2);
                }

                var jsonSer = new JavaScriptSerializer();
                context.Response.ContentType = "application/json; charset=utf-8";
                context.Response.Write(jsonSer.Serialize(listaTurma.ToList()));
            }
        }

        private void AddEdit(NameValueCollection forms, List<clsControleTurma> listaTurma, out string strResponse)
        {
            string strOperation = forms.Get("oper");
            int intTurId = 0;
            string strRetorno = "";

            if (strOperation == "add")
            {
                intTurId = Convert.ToInt32(forms.Get("TurId"));

                string strTurDescricao = forms.Get("TurDescricao").ToString();

                clsControleTurma objTurmaInsUpd = new clsControleTurma();
                objTurmaInsUpd.TurId = Convert.ToInt32(intTurId);
                objTurmaInsUpd.TurDescricao = strTurDescricao;
                objTurmaInsUpd.Cadastrar();

                strRetorno = "Registro cadastrado com sucesso!";
            }
            else if (strOperation == "edit")
            {
                intTurId = Convert.ToInt32(forms.Get("TurId"));

                string strTurDescricao = forms.Get("TurDescricao").ToString();

                clsControleTurma objTurmaInsUpd = new clsControleTurma();
                objTurmaInsUpd.TurId = Convert.ToInt32(intTurId);
                objTurmaInsUpd.TurDescricao = strTurDescricao;
                objTurmaInsUpd.Cadastrar();

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
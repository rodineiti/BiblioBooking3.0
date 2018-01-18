<%@ WebHandler Language="C#" CodeBehind="HandlerCurso.ashx.cs" Class="BiblioBooking.HandlerCurso" %>

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
    public class HandlerCurso : IHttpHandler
    {
        public void ProcessRequest(HttpContext context)
        {

            if (context.Request.QueryString["strAcao"].ToString() == "L")
            {
                System.Collections.Specialized.NameValueCollection forms = context.Request.Form;
                string strOp = forms.Get("oper");
                string strResponse = string.Empty;
                clsControleCurso objCurso = new clsControleCurso();
                List<clsControleCurso> listaCurso = new List<clsControleCurso>();

                DataTable dt = objCurso.Consultar();

                foreach (DataRow row in dt.Rows)
                {
                    clsControleCurso objCurso2 = new clsControleCurso();
                    objCurso2.CurId = Convert.ToInt32(row["curId"]);
                    objCurso2.CurDescricao = row["curDescricao"].ToString();
                    listaCurso.Add(objCurso2);
                }

                if (strOp == null)
                {
                    var jsonSer = new JavaScriptSerializer();
                    context.Response.Write(jsonSer.Serialize(listaCurso.AsQueryable<clsControleCurso>().ToList<clsControleCurso>()));
                }
                else if (strOp == "del")
                {
                    clsControleCurso objCursoDel = new clsControleCurso();
                    objCursoDel.CurId = Convert.ToInt32(forms.Get("CurId"));
                    if (objCursoDel.Excluir())
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
                    AddEdit(forms, listaCurso, out strOut);
                    context.Response.Write(strOut);
                }
            }
            else if (context.Request.QueryString["strAcao"].ToString() == "E")
            {
                clsControleCurso objCurso = new clsControleCurso();
                List<object> listaCurso = new List<object>();

                DataTable dt = objCurso.Consultar();

                foreach (DataRow row in dt.Rows)
                {
                    clsControleCurso objCurso2 = new clsControleCurso();
                    objCurso2.CurId = Convert.ToInt32(row["curId"]);
                    objCurso2.CurDescricao = row["curDescricao"].ToString();
                    listaCurso.Add(objCurso2);
                }

                var jsonSer = new JavaScriptSerializer();
                context.Response.ContentType = "application/json; charset=utf-8";
                context.Response.Write(jsonSer.Serialize(listaCurso.ToList()));
            }
        }

        private void AddEdit(NameValueCollection forms, List<clsControleCurso> listaCurso, out string strResponse)
        {
            string strOperation = forms.Get("oper");
            int intCurId = 0;
            string strRetorno = "";

            if (strOperation == "add")
            {
                intCurId = Convert.ToInt32(forms.Get("CurId"));

                string strCurDescricao = forms.Get("CurDescricao").ToString();

                clsControleCurso objCursoInsUpd = new clsControleCurso();
                objCursoInsUpd.CurId = Convert.ToInt32(intCurId);
                objCursoInsUpd.CurDescricao = strCurDescricao;
                objCursoInsUpd.Cadastrar();

                strRetorno = "Registro cadastrado com sucesso!";
            }
            else if (strOperation == "edit")
            {
                intCurId = Convert.ToInt32(forms.Get("CurId"));

                string strCurDescricao = forms.Get("CurDescricao").ToString();

                clsControleCurso objCursoInsUpd = new clsControleCurso();
                objCursoInsUpd.CurId = Convert.ToInt32(intCurId);
                objCursoInsUpd.CurDescricao = strCurDescricao;
                objCursoInsUpd.Cadastrar();

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
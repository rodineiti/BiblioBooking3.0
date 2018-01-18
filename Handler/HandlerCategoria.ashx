<%@ WebHandler Language="C#" CodeBehind="HandlerCategoria.ashx.cs" Class="BiblioBooking.HandlerCategoria" %>

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
    public class HandlerCategoria : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {

            if (context.Request.QueryString["strAcao"].ToString() == "L")
            {
                System.Collections.Specialized.NameValueCollection forms = context.Request.Form;
                string strOp = forms.Get("oper");
                string strResponse = string.Empty;
                clsControleCategoria objCategoria = new clsControleCategoria();
                List<clsControleCategoria> listaCategoria = new List<clsControleCategoria>();

                DataTable dt = objCategoria.Consultar();

                foreach (DataRow row in dt.Rows)
                {
                    clsControleCategoria objCategoria2 = new clsControleCategoria();
                    objCategoria2.CatId = Convert.ToInt32(row["catId"]);
                    objCategoria2.CatDescricao = row["catDescricao"].ToString();
                    listaCategoria.Add(objCategoria2);
                }

                if (strOp == null)
                {
                    var jsonSer = new JavaScriptSerializer();
                    context.Response.Write(jsonSer.Serialize(listaCategoria.AsQueryable<clsControleCategoria>().ToList<clsControleCategoria>()));
                }
                else if (strOp == "del")
                {
                    clsControleCategoria objCategoriaDel = new clsControleCategoria();
                    objCategoriaDel.CatId = Convert.ToInt32(forms.Get("CatId"));
                    if (objCategoriaDel.Excluir())
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
                    AddEdit(forms, listaCategoria, out strOut);
                    context.Response.Write(strOut);
                }
            }
            else if (context.Request.QueryString["strAcao"].ToString() == "E")
            {
                clsControleCategoria objCategoria = new clsControleCategoria();
                List<object> listaCategoria = new List<object>();

                DataTable dt = objCategoria.Consultar();

                foreach (DataRow row in dt.Rows)
                {
                    clsControleCategoria objCategoria2 = new clsControleCategoria();
                    objCategoria2.CatId = Convert.ToInt32(row["catId"]);
                    objCategoria2.CatDescricao = row["catDescricao"].ToString();
                    listaCategoria.Add(objCategoria2);
                }

                var jsonSer = new JavaScriptSerializer();
                context.Response.ContentType = "application/json; charset=utf-8";
                context.Response.Write(jsonSer.Serialize(listaCategoria.ToList()));
            }
        }

        private void AddEdit(NameValueCollection forms, List<clsControleCategoria> listaCategoria, out string strResponse)
        {
            string strOperation = forms.Get("oper");
            int intCatId = 0;
            string strRetorno = "";

            if (strOperation == "add")
            {
                intCatId = Convert.ToInt32(forms.Get("CatId"));

                string strCatDescricao = forms.Get("CatDescricao").ToString();

                clsControleCategoria objCategoriaInsUpd = new clsControleCategoria();
                objCategoriaInsUpd.CatId = Convert.ToInt32(intCatId);
                objCategoriaInsUpd.CatDescricao = strCatDescricao;
                objCategoriaInsUpd.Cadastrar();

                strRetorno = "Registro cadastrado com sucesso!";
            }
            else if (strOperation == "edit")
            {
                intCatId = Convert.ToInt32(forms.Get("CatId"));

                string strCatDescricao = forms.Get("CatDescricao").ToString();

                clsControleCategoria objCategoriaInsUpd = new clsControleCategoria();
                objCategoriaInsUpd.CatId = Convert.ToInt32(intCatId);
                objCategoriaInsUpd.CatDescricao = strCatDescricao;
                objCategoriaInsUpd.Cadastrar();

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
<%@ WebHandler Language="C#" CodeBehind="HandlerReserva.ashx.cs" Class="BiblioBooking.HandlerReserva" %>

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
    public class HandlerReserva : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            if (context.Request.QueryString["strAcao"].ToString() == "L")
            {
                System.Collections.Specialized.NameValueCollection forms = context.Request.Form;
                string strOp = forms.Get("oper");
                string strResponse = string.Empty;
                clsControleReserva objReserva = new clsControleReserva();
                List<clsControleReserva> listaReserva = new List<clsControleReserva>();

                DataTable dt = objReserva.Consultar();

                foreach (DataRow row in dt.Rows)
                {
                    clsControleReserva objReserva2 = new clsControleReserva();
                    objReserva2.ResId = Convert.ToInt32(row["resId"]);
                    objReserva2.AluId = Convert.ToInt32(row["aluId"]);
                    objReserva2.AluNome = row["aluNome"].ToString();
                    objReserva2.ResStatus = row["resStatus"].ToString();
                    listaReserva.Add(objReserva2);
                }

                if (strOp == null)
                {
                    var jsonSer = new JavaScriptSerializer();
                    context.Response.Write(jsonSer.Serialize(listaReserva.AsQueryable<clsControleReserva>().ToList<clsControleReserva>()));
                }
                else if (strOp == "del")
                {
                    int intResIdDel = Convert.ToInt32(forms.Get("ResId"));
                    
                    clsControleItemReserva objItemReserva = new clsControleItemReserva();
                    objItemReserva.ResId = intResIdDel;
                    DataTable dtItem = objItemReserva.Consultar();
                    clsControleLivro objLivro;
                    foreach (DataRow row in dtItem.Rows)
                    {
                        objLivro = new clsControleLivro();
                        objLivro.AtualizaStatusLivro(row["livId"].ToString(), "S");
                    }

                    clsControleReserva objReservaDel = new clsControleReserva();
                    objReservaDel.ResId = intResIdDel;
                    if (objReservaDel.Excluir())
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
                    AddEdit(forms, listaReserva, out strOut);
                    context.Response.Write(strOut);
                }
            }
        }

        private void AddEdit(NameValueCollection forms, List<clsControleReserva> listaReserva, out string strResponse)
        {
            string strOperation = forms.Get("oper");
            int intResId = 0;
            string strRetorno = "";

            if (strOperation == "edit")
            {

                intResId = Convert.ToInt32(forms.Get("ResId"));

                clsControleEmprestimo objEmprestimo = new clsControleEmprestimo();
                objEmprestimo.ResId = Convert.ToInt32(intResId);
                if (objEmprestimo.InserirEmprestimo())
                {
                    strResponse = "Empréstimo realizado com sucesso!";
                }
                else
                {
                    strResponse = "Não foi possível realizar o empréstimo, favor verificra!";    
                }
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
<%@ WebHandler Language="C#" CodeBehind="HandlerEmprestimo.ashx.cs" Class="BiblioBooking.HandlerEmprestimo" %>

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
    public class HandlerEmprestimo : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            if (context.Request.QueryString["strAcao"].ToString() == "L")
            {
                System.Collections.Specialized.NameValueCollection forms = context.Request.Form;
                string strOp = forms.Get("oper");
                string strResponse = string.Empty;
                clsControleEmprestimo objEmprestimo = new clsControleEmprestimo();
                List<clsControleEmprestimo> listaEmprestimo = new List<clsControleEmprestimo>();

                DataTable dt = objEmprestimo.Consultar();

                foreach (DataRow row in dt.Rows)
                {
                    clsControleEmprestimo objEmprestimo2 = new clsControleEmprestimo();
                    objEmprestimo2.EmpId = Convert.ToInt32(row["empId"]);
                    objEmprestimo2.ResId = Convert.ToInt32(row["resId"]);
                    objEmprestimo2.AluNome = row["aluNome"].ToString();
                    objEmprestimo2.EmpData = row["empData"].ToString();
                    objEmprestimo2.EmpPrevDevolucao = row["empPrevDevolucao"].ToString();
                    objEmprestimo2.EmpDataDevolucao = row["empDataDevolucao"].ToString();
                    objEmprestimo2.EmpStatus = row["empStatus"].ToString();
                    listaEmprestimo.Add(objEmprestimo2);
                }

                if (strOp == null)
                {
                    var jsonSer = new JavaScriptSerializer();
                    context.Response.Write(jsonSer.Serialize(listaEmprestimo.AsQueryable<clsControleEmprestimo>().ToList<clsControleEmprestimo>()));
                }
                else
                {
                    string strOut = string.Empty;
                    AddEdit(forms, listaEmprestimo, out strOut);
                    context.Response.Write(strOut);
                }
            }
        }

        private void AddEdit(NameValueCollection forms, List<clsControleEmprestimo> listaEmprestimo, out string strResponse)
        {
            string strOperation = forms.Get("oper");
            int intEmpId = 0;
            string strRetorno = "";

            if (strOperation == "edit")
            {
                intEmpId = Convert.ToInt32(forms.Get("EmpId"));

                clsControleEmprestimo objEmprestimo = new clsControleEmprestimo();
                objEmprestimo.EmpId = Convert.ToInt32(intEmpId);                
                if (objEmprestimo.DevolverEmprestimo())
                {
                    strRetorno = "Devolução realizada com sucesso!";
                }
                else
                {
                    strResponse = "Não foi possível realizar a devolução do empréstimo, favor verificra!";    
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
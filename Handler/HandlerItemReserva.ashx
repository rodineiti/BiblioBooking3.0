<%@ WebHandler Language="C#" CodeBehind="HandlerItemReserva.ashx.cs" Class="BiblioBooking.HandlerItemReserva" %>

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
    public class HandlerItemReserva : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {

            if (context.Request.QueryString["strAcao"].ToString() == "L")
            {
                System.Collections.Specialized.NameValueCollection forms = context.Request.Form;
                string strOp = forms.Get("oper");
                string strResponse = string.Empty;
                int intResId = Convert.ToInt32(context.Request.QueryString["id"]);
                //int intResId2 = Convert.ToInt32(forms.Get("rowid"));
                clsControleItemReserva objItemReserva = new clsControleItemReserva();
                List<clsControleItemReserva> listaItemReserva = new List<clsControleItemReserva>();

                objItemReserva.ResId = intResId;
                DataTable dt = objItemReserva.Consultar();

                foreach (DataRow row in dt.Rows)
                {
                    clsControleItemReserva objItemReserva2 = new clsControleItemReserva();
                    objItemReserva2.IteId = Convert.ToInt32(row["iteId"]);
                    objItemReserva2.LivId = Convert.ToInt32(row["livId"]);
                    objItemReserva2.LivISBN = row["livISBN"].ToString();
                    objItemReserva2.LivTitulo = row["livTitulo"].ToString();
                    objItemReserva2.LivLocalizacao = row["livLocalizacao"].ToString();
                    objItemReserva2.ResId = Convert.ToInt32(row["resId"]);
                    listaItemReserva.Add(objItemReserva2);
                }

                if (strOp == null)
                {
                    var jsonSer = new JavaScriptSerializer();
                    context.Response.Write(jsonSer.Serialize(listaItemReserva.AsQueryable<clsControleItemReserva>().ToList<clsControleItemReserva>()));
                }
            }

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
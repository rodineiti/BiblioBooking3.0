using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using MySql.Data.MySqlClient;
using System.Data;

/// <summary>
/// Summary description for clsBD
/// </summary>
public class clsBD
{
    public MySqlConnection wObjConn { get; set; }
    public string wStrServer { get; set; }
    public string wStrDataBase { get; set; }
    public string wStrUser { get; set; }
    public string wStrPass { get; set; }

    public clsBD(string pStrServer, string pStrDataBase, string pStrUser, string pStrPass)
    {
        this.wStrServer = pStrServer;
        this.wStrDataBase = pStrDataBase;
        this.wStrUser = pStrUser;
        this.wStrPass = pStrPass;

        string vStrConnString = String.Format("SERVER={0};DATABASE={1};UID={2};PASSWORD={3};", this.wStrServer, this.wStrDataBase, this.wStrUser, this.wStrPass);
        this.wObjConn = new MySqlConnection(vStrConnString);
    }

    private void OpenConnection()
    {
        if (this.wObjConn.State != System.Data.ConnectionState.Open)
        {
            this.wObjConn.Open();
        }
    }

    private void CloseConnection()
    {
        if (this.wObjConn.State == System.Data.ConnectionState.Open)
        {
            this.wObjConn.Close();
        }
    }

    public string Encode(string pStrValue)
    {
        byte[] toEncodeAsBytes = System.Text.ASCIIEncoding.ASCII.GetBytes(pStrValue);
        string returnValue = System.Convert.ToBase64String(toEncodeAsBytes);
        return returnValue;
    }

    private string Decode(string pStrValue)
    {
        byte[] encodedDataAsBytes = System.Convert.FromBase64String(pStrValue);
        string returnValue = System.Text.ASCIIEncoding.ASCII.GetString(encodedDataAsBytes);
        return returnValue;
    }

    public void ExecuteQuery(MySqlCommand pObjCmd)
    {
        try
        {
            this.OpenConnection();

            pObjCmd.Connection = this.wObjConn;
            pObjCmd.ExecuteNonQuery();
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            this.CloseConnection();
        }
    }

    public DataTable ExecuteDataTable(MySqlCommand pObjCmd)
    {
        DataTable vObjDt = new DataTable();
        MySqlDataAdapter vObjAd = null;

        try
        {
            this.OpenConnection();

            pObjCmd.Connection = this.wObjConn;
            vObjAd = new MySqlDataAdapter(pObjCmd);
            vObjAd.Fill(vObjDt);
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            this.CloseConnection();
        }

        return vObjDt;
    }

    public MySqlDataReader ExecuteDataReader(MySqlCommand pObjCmd)
    {
        MySqlDataReader vObjAd = null;

        try
        {
            this.OpenConnection();

            pObjCmd.Connection = this.wObjConn;
            vObjAd = pObjCmd.ExecuteReader();
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            this.CloseConnection();
        }

        return vObjAd;
    }

    public object ExecuteObject(MySqlCommand pObjCmd)
    {
        object vObject = null;

        try
        {
            this.OpenConnection();

            pObjCmd.Connection = this.wObjConn;
            vObject = pObjCmd.ExecuteScalar();
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            this.CloseConnection();
        }

        return vObject;
    }
}
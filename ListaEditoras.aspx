﻿<%@ Page Title="" Language="C#" MasterPageFile="~/BiblioBooking.master" AutoEventWireup="true" CodeFile="ListaEditoras.aspx.cs" Inherits="ListaEditoras" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<link href="css/jqgrid/jquery-ui-1.9.2.custom.css" rel="stylesheet" type="text/css" />
<link href="css/jqgrid/ui.jqgrid.css" rel="stylesheet" type="text/css" />
<script src="js/jqgrid/grid.locale-pt-br.js" type="text/javascript"></script>
<script src="js/jqgrid/jquery.jqGrid.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<table id="jQGridEditoras"></table>
<div id="jQGridEditorasPager"></div>
<script src="js/jqGridEditora.1.0.js" type="text/javascript"></script>
</asp:Content>


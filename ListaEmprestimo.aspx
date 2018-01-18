<%@ Page Title="" Language="C#" MasterPageFile="~/BiblioBooking.master" AutoEventWireup="true" CodeFile="ListaEmprestimo.aspx.cs" Inherits="ListaEmprestimo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<link href="css/jqgrid/auxiliar2/jquery-ui-1.9.2.custom.css" rel="stylesheet" type="text/css" />
<link href="css/jqgrid/auxiliar2/ui.jqgrid.css" rel="stylesheet" type="text/css" />
<script src="js/jqgrid/auxiliar2/grid.locale-pt-br.js" type="text/javascript"></script>
<script src="js/jqgrid/auxiliar2/jquery.jqGrid.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<table id="jQGridEmprestimos"></table>
<div id="jQGridEmprestimosPager"></div>
<table id="jQGridItemReserva"></table>
<div id="jQGridItemReservaPager"></div>
<script src="js/jqGridEmprestimo.1.0.js" type="text/javascript"></script>
</asp:Content>


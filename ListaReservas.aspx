<%@ Page Title="" Language="C#" MasterPageFile="~/BiblioBooking.master" AutoEventWireup="true" CodeFile="ListaReservas.aspx.cs" Inherits="ListaReservas" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<link href="css/jqgrid/auxiliar/jquery-ui-1.9.2.custom.css" rel="stylesheet" type="text/css" />
<link href="css/jqgrid/auxiliar/ui.jqgrid.css" rel="stylesheet" type="text/css" />
<script src="js/jqgrid/auxiliar/grid.locale-pt-br.js" type="text/javascript"></script>
<script src="js/jqgrid/auxiliar/jquery.jqGrid.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<table id="jQGridReservas"></table>
<div id="jQGridReservasPager"></div>
<table id="jQGridItemReserva"></table>
<div id="jQGridItemReservaPager"></div>
<script src="js/jqGridReserva.1.0.js" type="text/javascript"></script>
</asp:Content>


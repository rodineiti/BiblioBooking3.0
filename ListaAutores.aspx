﻿<%@ Page Title="" Language="C#" MasterPageFile="~/BiblioBooking.master" AutoEventWireup="true" CodeFile="ListaAutores.aspx.cs" Inherits="ListaAutores" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<link href="css/jqgrid/jquery-ui-1.9.2.custom.css" rel="stylesheet" type="text/css" />
<link href="css/jqgrid/ui.jqgrid.css" rel="stylesheet" type="text/css" />
<script src="js/jqgrid/grid.locale-pt-br.js" type="text/javascript"></script>
<script src="js/jqgrid/jquery.jqGrid.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<table id="jQGridAutores"></table>
<div id="jQGridAutoresPager"></div>
<script src="js/jqGridAutor.1.0.js" type="text/javascript"></script>
</asp:Content>


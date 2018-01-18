<%@ Page Title="" Language="C#" MasterPageFile="~/BiblioBooking.master" AutoEventWireup="true" CodeFile="Principal.aspx.cs" Inherits="Principal" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<style>
	.carousel{
		width:500px;
		float:right;
	}
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div id="myCarousel" class="carousel slide">
	<div class="carousel-inner">					
		<div class="item"><a href="A.aspx"><img src="img/book001.png"></a></div>													
		<div class="item active"><a href="B.aspx"><img src="img/book002.png"></a></div>
		<div class="item"><a href="C.aspx"><img src="img/book003.png"></a></div>
        <div class="item"><a href="D.aspx"><img src="img/book004.png"></a></div>
        <div class="item"><a href="E.aspx"><img src="img/book005.png"></a></div>
        <div class="item"><a href="F.aspx"><img src="img/book006.png"></a></div>
        <div class="item"><a href="G.aspx"><img src="img/book007.png"></a></div>
	</div>
</div>
<script src="js/bootstrap/bootstrap.js"></script>
<script src="js/bootstrap/bootstrap-popover.js"></script>
<script src="js/bootstrap/bootstrap-tooltip.js"></script>
<script>
	$(function () {
	    $('.carousel').carousel({
	        interval: 4000
	    });
	    $('#pass').popover();
	});	
</script>
</asp:Content>


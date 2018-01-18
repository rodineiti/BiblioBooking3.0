<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <title>Bibliobooking</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Bootstrap -->
    <link href="css/bootstrap/bootstrap.css" rel="stylesheet" media="screen">
	<link href="css/bootstrap/bootstrap-responsive.min.css" rel="stylesheet" media="screen">
	<link href="css/login.css" rel="stylesheet" type="text/css" />
    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="js/html5shiv.js"></script>
      <script src="js/respond.min.js"></script>
    <![endif]-->
</head>
<body>
    <div class="container">
        <form id="form1" class="form-signin" runat="server">
            <img src="img/logo.fw.png" alt="logo bibliobooking">
            <asp:TextBox ID="txtLogin" runat="server" class="form-control" required="required" placeholder="Login" />
            <asp:TextBox ID="txtSenha" runat="server" class="form-control" required="required" placeholder="Senha" TextMode="Password" />
            <asp:Button ID="btnLogar" runat="server" Text="Logar" class="btn btn-lg btn-primary btn-block" onclick="btnLogar_Click" />
            <asp:Label ID="lblResultado" runat="server" Text=""></asp:Label>
        </form>        
    </div> <!-- /container -->
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="js/jquery.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="js/jquery-1.9.0.min.js" type="text/javascript"></script>
    <script src="js/bootstrap/bootstrap.min.js"></script>
</body>
</html>

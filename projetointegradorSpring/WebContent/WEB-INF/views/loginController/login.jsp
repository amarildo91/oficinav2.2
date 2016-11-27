<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<link href="<c:url value="/bootstrap-dist/css/bootstrap.min.css" />" rel="stylesheet">
<script src="<c:url value="/bootstrap-dist/js/jquery.min.js"/>"></script>
<script src="<c:url value="/bootstrap-dist/js/bootstrap.min.js" />"></script>

<title>Login</title>
</head>
<script type="text/javascript">		
	$( document ).ready(function() {
		if($('.alert-danger').text() != null && !$('.alert-danger').text() == ""){
			$('.alert-danger').show();
		}else if($('.alert-success').text() != null  && !$('.alert-success').text() == ""){
			$('.alert-success').show();
		}
	});
</script>

<body style="background:url(bootstrap-dist/img/bg-login.png); background-size:100%; background-repeat: no-repeat;">
	<div class="container-fluid">
		<div id="loginbox" style="margin-top: 50px;"
			class="mainbox col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">
			<div class="panel panel-default">
				<div class="panel-heading">
					<div class="panel-title">Oficina RC | Login</div>
					<div
						style="float: right; font-size: 80%; position: relative; top: -10px">
						<a href="#">Esqueceu a senha?</a>
					</div>
				</div>
				<div class="alert alert-danger" style="display: none;" role="alert">${erro}</div>
				<div class="alert alert-success" style="display: none;" role="alert">${sucesso}</div>
				<div style="padding-top: 30px" class="panel-body">
					<form id="loginform" method="POST"	action="<c:url value='j_spring_security_check' />"	class="form-horizontal" role="form">
						<div style="margin-bottom: 25px" class="input-group">
							<span class="input-group-addon"> <i
								class="glyphicon glyphicon-user"></i>
							</span> <input id="login-username" type="text" class="form-control"
								name="j_username" value="" placeholder="Usuário">
						</div>
						<div style="margin-bottom: 25px" class="input-group">
							<span class="input-group-addon"> <i
								class="glyphicon glyphicon-lock"></i>
							</span> <input id="login-password" type="password" class="form-control"
								name="j_password" placeholder="Senha">
						</div>
						<div style="margin-top: 10px" class="form-group">
							<!-- Button -->
							<div class="col-sm-12 controls">
								<button id="btn-login" type="submit" class="btn btn-success">Login </a>
								<!--<a id="btn-fblogin" href="#" class="btn btn-primary">Login com Facebook</a>-->
							</div>
						</div>
						
				  </form> 
				</div>
			</div>
		</div>
	</div>
</body>
</html>
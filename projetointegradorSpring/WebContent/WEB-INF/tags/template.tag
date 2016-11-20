<%@tag pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- Atributos --%>
<%@attribute name="tipoInput" type="java.lang.Boolean"%>
<%@attribute name="divBody" fragment="true"%>
<%@attribute name="id"%>
<%@attribute name="name"%>
<%@attribute name="title"%>
<%@attribute name="origem"%>


<%-- Tags condicionais da JSTL --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
 <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
        <meta name="description" content="">
        <meta name="author" content="">
        <link rel="icon" href="../../favicon.ico">

        <title>${title}</title>

        <!-- Bootstrap core CSS -->
        <link href="${pageContext.request.contextPath}/bootstrap-dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/bootstrap-dist/css/ie10-viewport-bug-workaround.css" rel="stylesheet">
        <link href="navbar.css" rel="stylesheet">
        <script src="${pageContext.request.contextPath}/bootstrap-dist/js/ie-emulation-modes-warning.js"></script>
    </head>
       <body>

        
            <!-- Static navbar -->
            <nav class="navbar navbar-inverse">
                <div class="container-fluid">
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbar">
		                    <span class="sr-only">Toggle navigation</span>
		                    <span class="icon-bar"></span>
		                    <span class="icon-bar"></span>
		                    <span class="icon-bar"></span>
		                </button>
                        <a class="navbar-brand" href="${pageContext.request.contextPath}/protect/home"><b>Oficina RC</b></a>
                    </div>
                    <div id="navbar" class="navbar-collapse collapse">
                        <ul class="nav navbar-nav">
                            <li><a href="${pageContext.request.contextPath}/protect/home"><fmt:message key="menu.home"/></a></li>
                             <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><fmt:message key="menu.relatorio"/> <span class="caret"></span></a>
                                <ul class="dropdown-menu">
                                    <li><a href="#"><fmt:message key="menu.relatorio.ordemServico"/></a></li>
                                    <li><a href="#"><fmt:message key="menu.relatorio.notaFiscal"/></a></li>
                                    <li><a href="#"><fmt:message key="menu.relatorio.produto"/></a></li>                                    
                                    <li><a href="#"><fmt:message key="menu.relatorio.cliente"/></a></li>
                                </ul>
                            </li>
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><fmt:message key="menu.ordemServico"/> <span class="caret"></span></a>
                                <ul class="dropdown-menu">
                                    <li><a href="${pageContext.request.contextPath}/protect/ordemServico"><fmt:message key="menu.ordemServico.manutencao"/></a></li>
                                    <li><a href="#"><fmt:message key="menu.ordemServico.categoria"/></a></li>
                                    <li><a href="#"><fmt:message key="menu.ordemServico.inserir"/></a></li>
                                </ul>
                            </li>
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><fmt:message key="menu.notaFiscal"/> <span class="caret"></span></a>
                                <ul class="dropdown-menu">
                                    <li><a href="#"><fmt:message key="menu.notaFiscal.gerar"/></a></li>
                                    <li><a href="#"><fmt:message key="menu.notaFiscal.listagem"/></a></li>
                                </ul>
                            </li>
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><fmt:message key="menu.produto"/> <span class="caret"></span></a>
                                <ul class="dropdown-menu">
                                    <li><a href="${pageContext.request.contextPath}/protect/manutencaoProduto"><fmt:message key="menu.produto.manutencao"/></a></li>
                                    <li><a href="${pageContext.request.contextPath}/protect/produto"><fmt:message key="menu.produto.adicionar"/></a></li>
                                    <li><a href="${pageContext.request.contextPath}/protect/categoria"><fmt:message key="menu.produto.categoria"/></a></li>
                                </ul>
                            </li>
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><fmt:message key="menu.cadastroCliente"/> <span class="caret"></span></a>
                                <ul class="dropdown-menu">
                                    <li><a href="#"><fmt:message key="menu.cadastroCliente.inserir"/></a></li>
                                    <li><a href="${pageContext.request.contextPath}/protect/pessoa"><fmt:message key="menu.cadastroCliente.manutencao"/></a></li>
                                    <li><a href="${pageContext.request.contextPath}/protect/cidade"><fmt:message key="menu.cadastroCliente.cidade"/></a></li>
                                </ul>
                            </li>
                        </ul> 
                        <ul class="nav navbar-nav navbar-right">
                            <li><a href="${pageContext.request.contextPath}/login"><span class="glyphicon glyphicon-log-out"></span> <fmt:message key="menu.logout"/></a></li>
                        </ul>
                    </div><!--/.nav-collapse -->
                </div><!--/.container-fluid -->
            </nav>
            <!-- Main component for a primary marketing message or call to action -->
            <div class="container">
            	<br>
					<jsp:invoke fragment="divBody"/>
				<br>	
				
				
				<!-- modal sucesso insert -->
				<div id="gridSucessoInsertModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="gridModalLabel" aria-hidden="true">
				  <div class="modal-dialog" role="document">
				    <div class="modal-content">
				      <div class="modal-header">
				      	<input type="hidden" id="idCompromissoExclud" name="id">
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				        <h4 class="modal-title" id="gridModalLabel"><fmt:message key="oficina.titulo"/></h4>
				      </div>
				      <div class="modal-body">
				      	<h4 class="modal-title" id="gridModalLabel" align="center"><img src="${pageContext.request.contextPath}/bootstrap-dist/img/check-icon.png" width="50px"><fmt:message key="modal.sucesso.insert"/></h4>
				      </div>
				      <div class="modal-footer">
				      	<button type="button" class="btn btn-primary" data-dismiss="modal"><fmt:message key="modal.button.sair"/></button>
				      </div>
				    </div>
				  </div>
				</div>
				
				<!-- modal erro insert -->
				<div id="gridErrorInsertModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="gridModalLabel" aria-hidden="true">
				  <div class="modal-dialog" role="document">
				    <div class="modal-content">
				      <div class="modal-header">
				      	<input type="hidden" id="idCompromissoExclud" name="id">
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				        <h4 class="modal-title" id="gridModalLabel"><fmt:message key="oficina.titulo"/></h4>
				      </div>
				      <div class="modal-body">
				      	<h4 class="modal-title" id="gridModalLabel" align="center"><img src="${pageContext.request.contextPath}/bootstrap-dist/img/error-icon.png" width="50px"><fmt:message key="modal.erro.insert"/></h4>
				      </div>
				      <div class="modal-footer">
				      	<button type="button" class="btn btn-primary" data-dismiss="modal"><fmt:message key="modal.button.sair"/></button>
				      </div>
				    </div>
				  </div>
				</div>
                
                <!-- modal sucesso remov-->
				<div id="gridSucessoRemovModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="gridModalLabel" aria-hidden="true">
				  <div class="modal-dialog" role="document">
				    <div class="modal-content">
				      <div class="modal-header">
				      	<input type="hidden" id="idCompromissoExclud" name="id">
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				        <h4 class="modal-title" id="gridModalLabel"><fmt:message key="oficina.titulo"/></h4>
				      </div>
				      <div class="modal-body">
				      	<h4 class="modal-title" id="gridModalLabel" align="center"><img src="${pageContext.request.contextPath}/bootstrap-dist/img/check-icon.png" width="50px"><fmt:message key="modal.sucesso.delete"/></h4>
				      </div>
				      <div class="modal-footer">
				      	<button type="button" class="btn btn-primary" data-dismiss="modal"><fmt:message key="modal.button.sair"/></button>
				      </div>
				    </div>
				  </div>
				</div>
				
				<!-- modal erro remov-->
				<div id="gridErrorRemovModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="gridModalLabel" aria-hidden="true">
				  <div class="modal-dialog" role="document">
				    <div class="modal-content">
				      <div class="modal-header">
				      	<input type="hidden" id="idCompromissoExclud" name="id">
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				        <h4 class="modal-title" id="gridModalLabel"><fmt:message key="oficina.titulo"/></h4>
				      </div>
				      <div class="modal-body">
				      	<h4 class="modal-title" id="gridModalLabel" align="center"><img src="${pageContext.request.contextPath}/bootstrap-dist/img/error-icon.png" width="50px"><fmt:message key="modal.erro.delete"/></h4>
				      </div>
				      <div class="modal-footer">
				      	<button type="button" class="btn btn-primary" data-dismiss="modal"><fmt:message key="modal.button.sair"/></button>
				      </div>
				    </div>
				  </div>
				</div>
				
            </div>
        <script src="${pageContext.request.contextPath}/bootstrap-dist/js/jquery.min.js"></script>
        <script src="http://digitalbush.com/wp-content/uploads/2014/10/jquery.maskedinput.js"></script>
        <script>window.jQuery || document.write('<script src="${pageContext.request.contextPath}/bootstrap-dist/js/vendor/jquery.min.js"><\/script>')</script>
        <script src="${pageContext.request.contextPath}/bootstrap-dist/js/bootstrap.min.js"></script>
        <script src="${pageContext.request.contextPath}/bootstrap-dist/js/ie10-viewport-bug-workaround.js"></script>
        
        <script type="text/javascript">
	        $(document).ready(function(){
				if ("${successInsert}"){
					$("html").click(function(){
						window.location.search ="";
					});
					$("html").keyup(function(){
						window.location.search ="";
					});
				}	
			});
        </script>
        
        <c:choose>
        	<c:when test="${removido eq true}">
        		<script>
					$(document).ready(function(){
						$("#gridSucessoRemovModal").modal();
					});
				</script>
        	</c:when>
        	<c:when test="${removido eq false}">
        		<script>
					$(document).ready(function(){
						$("#gridErrorRemovModal").modal();
						if ("${errorMessage}"){
							$("#gridErrorRemovModal .modal-body h4").append("${errorMessage}");
						}
					});
				</script>
        	</c:when>
        </c:choose>
        
        <c:choose>
        	<c:when test="${successUpdate eq true}">
        		<script>
					$(document).ready(function(){
						$("#gridSucessoInsertModal").modal();
					});
				</script>
        	</c:when>
        	<c:when test="${successUpdate eq false}">
        		<script>
					$(document).ready(function(){
						$("#gridErrorInsertModal").modal();
						if ("${errorMessage}"){
							$("#gridErrorInsertModal .modal-body h4").append("${errorMessage}");
						}
					});
				</script>
        	</c:when>
        </c:choose>
        
        <c:choose>
        	<c:when test="${successInsert eq true}">
        		<script>
					$(document).ready(function(){
						$("#gridSucessoInsertModal").modal();
					});
				</script>
        	</c:when>
        	<c:when test="${successInsert eq false}">
        		<script>
					$(document).ready(function(){
						$("#gridErrorInsertModal").modal();
						if ("${errorMessage}"){
							$("#gridErrorInsertModal .modal-body h4").append("${errorMessage}");
						}
					});
				</script>
        	</c:when>
        </c:choose>
        
    </body>
</html>
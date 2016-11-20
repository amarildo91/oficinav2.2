<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<tag:template id="text" name="text" title="Cadastro Categorias">
	<jsp:attribute name="divBody">
		<script>
			function editCategoria(componente){
				$("#idCategoriaEdit").val(componente.getAttribute("data-id"));
				$("#descricaoCategoriaEdit").val(componente.getAttribute("data-nome"));
				$("#gridEditModal").modal();		
			}
			
			function excluiRegistro(id){
				$("#idCategoriaExclud").val(id);
				$("#gridExcluiModal").modal();
			}
		
		</script>
	
		<h1><fmt:message key="categoria.titulo"/></h1>
		<br>
		<table class="table table-striped">
			<tr>
				<td><b><fmt:message key="categoria.id"/></b></td>
				<td><b><fmt:message key="categoria.descricao"/></b></td>
				<td></td><td></td>
			</tr>
				
			<c:if test="${empty categorias}">
				<tr>
					<td><fmt:message key="categoria.nenhum.registro"/></td>
					<td></td><td></td><td></td>
				</tr>	
			</c:if>
			
			<c:forEach items="${categorias}" var="categoria">
				<tr>
					<td>${categoria.id}</td>
					<td>${categoria.descricao}</td>
					<td><a data-id="${categoria.id}" data-nome="${categoria.descricao}"
							href='#' onclick="javascript:editCategoria(this);"><span class="glyphicon glyphicon-pencil"></span></a></td>
						<td><a href="#" onclick="javascript:excluiRegistro(${categoria.id});"><span class="glyphicon glyphicon-remove"></span></a></td>
				</tr>
			</c:forEach>
		</table>
		<br><br>
		<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#gridInsertModal"><fmt:message key="categoria.button"/></button>
		
		<!-- Modal insert -->
		<form:form action="${pageContext.request.contextPath}/protect/cadastrarCategoria" method="post">
			 <div id="gridInsertModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="gridModalLabel" aria-hidden="true">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			        <h4 class="modal-title" id="gridModalLabel"><fmt:message key="categoria.modal.titulo"/></h4>
			      </div>
			      <div class="modal-body">
			        <div class="form-group">
			        	<label for="descricao"><fmt:message key="categoria.modal.descricao"/></label>
			        	<input type="text" name="descricao" class="form-control" id="descricao" required="required"/>
			        </div>
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-default" data-dismiss="modal"><fmt:message key="categoria.modal.button.sair"/></button>
			        <button type="submit" class="btn btn-primary"><fmt:message key="categoria.modal.button.salvar"/></button>
			      </div>
			    </div>
			  </div>
			</div>
		</form:form>
		
		<!-- Modal edit -->
		<form:form action="${pageContext.request.contextPath}/protect/editarCategoria" method="post">
			 <div id="gridEditModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="gridModalLabel" aria-hidden="true">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			        <h4 class="modal-title" id="gridModalLabel"><fmt:message key="categoria.modal.titulo"/></h4>
			      </div>
			      <div class="modal-body">
			      	<input type="hidden" id="idCategoriaEdit" name="id">
			        <div class="form-group">
			        	<label for="descricao"><fmt:message key="categoria.modal.descricao"/></label>
			        	<input type="text" name="descricao" class="form-control" id="descricaoCategoriaEdit" required="required"/>
			        </div>
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-default" data-dismiss="modal"><fmt:message key="categoria.modal.button.sair"/></button>
			        <button type="submit" class="btn btn-primary"><fmt:message key="categoria.modal.button.salvar"/></button>
			      </div>
			    </div>
			  </div>
			</div>
		</form:form>
		
		<!-- Modal excluir -->
		<form:form action="${pageContext.request.contextPath}/protect/categoria/delete" method="post">
			<div id="gridExcluiModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="gridModalLabel" aria-hidden="true">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			      	<input type="hidden" id="idCategoriaExclud" name="id">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			        <h4 class="modal-title" id="gridModalLabel"><fmt:message key="categoria.titulo"/></h4>
			      </div>
			      <div class="modal-body">
				      	<h4 class="modal-title" id="gridModalLabel" align="center"><img src="${pageContext.request.contextPath}/bootstrap-dist/img/warning-icon.png" width="50px"><fmt:message key="categoria.motal.titulo.excluir"/></h4>
				      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-default" data-dismiss="modal"><fmt:message key="categoria.modal.button.nao"/></button>
			        <button type="submit" class="btn btn-primary"><fmt:message key="categoria.modal.button.sim"/></button>
			      </div>
			    </div>
			  </div>
			</div>
		</form:form>
	</jsp:attribute>
</tag:template>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<tag:template id="text" name="text" title="Cadastro Cidade">
	<jsp:attribute name="divBody">
		<script>
			function editCidade(componente){
				$("#idCidadeEdit").val(componente.getAttribute("data-id"));
				$("#nomeCidadeEdit").val(componente.getAttribute("data-nome"));
				$("#ufCidadeEdit").val(componente.getAttribute("data-uf"));
				$("#gridEditModal").modal();		
			}
			
			function excluiRegistro(id){
				$("#idCidadeExclud").val(id);
				$("#gridExcluiModal").modal();
			}
			
			function filter (phrase, _id, cellNr){  
				var suche = phrase.value.toLowerCase(); 
				var table = document.getElementById(_id);
				var ele;  
				for (var r = 1; r < table.rows.length; r++){  	
				   ele = table.rows[r].cells[cellNr].innerHTML.replace(/<[^>]+>/g,"");  
				   if (ele.toLowerCase().indexOf(suche)>=0 )   
				    	 table.rows[r].style.display = '';  	
				   else 
					  	 table.rows[r].style.display = 'none';  
		       	 }	
			 }
			
		</script>
	
		<h1><fmt:message key="cidade.titulo"/></h1>
		<br>
		<table class="table table-striped" id="lista">
			<tr>
				<td>
					<div>
						<b><fmt:message key="cidade.nome"/></b>
						<input type="text" name="filt2" class="form-control" placeholder="Buscar" onKeyUp="filter(this, 'lista', '0')"/>
					</div>	
				</td>
				<td>
					<div>
						<b><fmt:message key="cidade.uf"/></b>
						<input type="text" name="filt2" class="form-control" placeholder="Buscar" onKeyUp="filter(this, 'lista', '1')"/>
					</div>	
				</td>
				<td></td><td></td>
			</tr>
				
			<c:if test="${empty cidades}">
				<tr>
					<td><fmt:message key="cidade.nenhum.registro"/></td>
				</tr>	
			</c:if>
			
			<c:forEach items="${cidades}" var="cidade">
				<tr>
					<td>${cidade.nome}</td>
					<td>${cidade.uf.sigla}</td>
					<td><a data-id="${cidade.id}" data-nome="${cidade.nome}"
							   data-uf="${cidade.uf.id}"	
							href='#' onclick="javascript:editCidade(this);"><span class="glyphicon glyphicon-pencil"></span></a></td>
						<td><a href="#" onclick="javascript:excluiRegistro(${cidade.id});"><span class="glyphicon glyphicon-remove"></span></a></td>
				</tr>
			</c:forEach>
		</table>
		<br><br>
		<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#gridInsertModal"><fmt:message key="cidade.button"/></button>
		
		<!-- Modal insert -->
		<form:form action="${pageContext.request.contextPath}/protect/cadastrarCidade" method="post" modelAttribute="cidade">
			 <div id="gridInsertModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="gridModalLabel" aria-hidden="true">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			        <h4 class="modal-title" id="gridModalLabel"><fmt:message key="cidade.modal.titulo"/></h4>
			      </div>
			      <div class="modal-body">
			        <div class="form-group">
			        	<label for="nome"><fmt:message key="cidade.modal.nome"/></label>
			        	<input type="text" name="nome" class="form-control" id="nome" required="required"/>
			        </div>
			        <div class="form-group">
			        	<label for="uf"><fmt:message key="cidade.modal.uf"/></label>
			        	<select name="idUf" class="form-control">
			        		<option value=""></option>
			        		<c:forEach items="${ufs}" var="uf">
			        			<option value="${uf.id}">${uf.sigla}</option>
			        		</c:forEach>
			        	</select>   
			        </div>
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-default" data-dismiss="modal"><fmt:message key="cidade.modal.button.sair"/></button>
			        <button type="submit" class="btn btn-primary"><fmt:message key="cidade.modal.button.salvar"/></button>
			      </div>
			    </div>
			  </div>
			</div>
		</form:form>
		
		<!-- Modal edit -->
		<form:form action="${pageContext.request.contextPath}/protect/editarCidade" method="post">
			 <div id="gridEditModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="gridModalLabel" aria-hidden="true">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			        <h4 class="modal-title" id="gridModalLabel"><fmt:message key="cidade.modal.titulo"/></h4>
			      </div>
			      <div class="modal-body">
			      	<input type="hidden" id="idCidadeEdit" name="id">
			        <div class="form-group">
			        	<label for="nome"><fmt:message key="cidade.modal.nome"/></label>
			        	<input type="text" name="nome" class="form-control" id="nomeCidadeEdit" required="required"/>
			        </div>
			        <div class="form-group">
			        	<label for="uf"><fmt:message key="cidade.modal.uf"/></label>
			        	<select name="idUf" class="form-control" id="ufCidadeEdit">
			        		<option value=""></option>
			        		<c:forEach items="${ufs}" var="uf">
			        			<option value="${uf.id}">${uf.sigla}</option>
			        		</c:forEach>
			        	</select>   
			        </div>
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-default" data-dismiss="modal"><fmt:message key="cidade.modal.button.sair"/></button>
			        <button type="submit" class="btn btn-primary"><fmt:message key="cidade.modal.button.salvar"/></button>
			      </div>
			    </div>
			  </div>
			</div>
		</form:form>
		
		<!-- Modal excluir -->
		<form:form action="${pageContext.request.contextPath}/protect/cidade/delete" method="post">
			<div id="gridExcluiModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="gridModalLabel" aria-hidden="true">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			      	<input type="hidden" id="idCidadeExclud" name="id">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			        <h4 class="modal-title" id="gridModalLabel"><fmt:message key="cidade.titulo"/></h4>
			      </div>
			      <div class="modal-body">
				      	<h4 class="modal-title" id="gridModalLabel" align="center"><img src="${pageContext.request.contextPath}/bootstrap-dist/img/warning-icon.png" width="50px"><fmt:message key="cidade.motal.titulo.excluir"/></h4>
				      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-default" data-dismiss="modal"><fmt:message key="cidade.modal.button.nao"/></button>
			        <button type="submit" class="btn btn-primary"><fmt:message key="cidade.modal.button.sim"/></button>
			      </div>
			    </div>
			  </div>
			</div>
		</form:form>
	</jsp:attribute>
</tag:template>
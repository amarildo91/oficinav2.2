<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<tag:template id="text" name="text" title="Home">
	<jsp:attribute name="divBody">
		<script>
			function editCompromisso(componente){
				$("#descricaoEdit").val(componente.getAttribute("data-descricao"));
				$("#dtCompromissoEdit").val(componente.getAttribute("data-dt"));
				$("#idCompromissoEdit").val(componente.getAttribute("data-id"));
				$("#dtCompromissoEdit").mask("99/99/9999");
				$("#gridEditModal").modal();
			}

			function excluiRegistro(id){
				$("#idCompromissoExclud").val(id);
				$("#gridExcluiModal").modal();
			}

			function excluir(){
				window.location="${pageContext.request.contextPath}/home/delete?id="+$("#idCompromissoExclud").val();
				$("#idCompromissoExclud").val("");
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
	
		<h1><fmt:message key="home.titulo"/></h1>
		<br>
		<table class="table table-striped" id="lista">
			
			<tr>
				<td><b><fmt:message key="home.data"/></b></td>
				<td>
					<div class="navbar-form navbar-left">
			        	<input type="text" name="filt2" class="form-control" placeholder="Buscar" onKeyUp="filter(this, 'lista', '1')"/>
			    	</div>
				</td>
				<td></td><td></td>
			</tr>
			
			<c:if test="${empty compromissos}">
				<tr>
					<td><fmt:message key="home.nenhum.registro"/></td>
					<td></td>
					<td></td>
				</tr>
			</c:if>
			
			<c:forEach items="${compromissos}" var="compromisso">
				<tr>
					<td><fmt:formatDate pattern="dd/MM/yyyy" value="${compromisso.dtCompromisso}"/></td>
					<td>${compromisso.descricao}</td>
					<td><a data-id="${compromisso.id}" 
						   data-descricao="${compromisso.descricao}"
						   data-dt="<fmt:formatDate pattern="dd/MM/yyyy" value="${compromisso.dtCompromisso}"/>"	
						href='#' onclick="javascript:editCompromisso(this);"><span class="glyphicon glyphicon-pencil"></span></a></td>
					<td><a href="#" onclick="javascript:excluiRegistro(${compromisso.id});"><span class="glyphicon glyphicon-remove"></span></a></td>
				</tr>
			</c:forEach>
		</table>
		<br><br>
		<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#gridSystemModal"><fmt:message key="home.button.agendar"/></button>
		<button type="button" class="btn btn-default" onclick="window.location='${pageContext.request.contextPath}/home/listaTodos'"><fmt:message key="home.button.listarTodos"/></button>
		
		<!-- Modal agendamento de compromissos -->
		<form:form action="${pageContext.request.contextPath}/agendarCompromisso" method="post">
			<div id="gridSystemModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="gridModalLabel" aria-hidden="true">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			        <h4 class="modal-title" id="gridModalLabel"><fmt:message key="home.motal.titulo"/></h4>
			      </div>
			      <div class="modal-body">
			        <div class="form-group">
			        	<label for="dtCompromisso"><fmt:message key="home.modal.dtCompromisso"/></label>
			        	<input type="date" name="data" class="form-control" id="dtCompromisso" required="required"/>
			        </div>
			        <div class="form-group">
			        	<label for="descricao"><fmt:message key="home.modal.descricao"/></label>
			        	<textarea class="form-control" rows="5" id="descricao" name="descricao" required="required"></textarea>
			        </div>
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-default" data-dismiss="modal"><fmt:message key="home.modal.button.sair"/></button>
			        <button type="submit" class="btn btn-primary"><fmt:message key="home.modal.button.salvar"/></button>
			      </div>
			    </div>
			  </div>
			</div>
		</form:form>
		
		<!-- Modal edit -->
		<form:form action="${pageContext.request.contextPath}/editarCompromisso" method="post">
			<div id="gridEditModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="gridModalLabel" aria-hidden="true">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			        <h4 class="modal-title" id="gridModalLabel"><fmt:message key="home.motal.titulo.editar"/></h4>
			      </div>
			      <div class="modal-body">
			      	<input type="hidden" id="idCompromissoEdit" name="id">
			        <div class="form-group">
			        	<label for="dtCompromissoEdit"><fmt:message key="home.modal.dtCompromisso"/></label>
			        	<input type="text" name="data" class="form-control" id="dtCompromissoEdit" required="required"/>
			        </div>
			        <div class="form-group">
			        	<label for="descricaoEdit"><fmt:message key="home.modal.descricao"/></label>
			        	<textarea class="form-control" rows="5" id="descricaoEdit" name="descricao" required="required"></textarea>
			        </div>
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-default" data-dismiss="modal"><fmt:message key="home.modal.button.sair"/></button>
			        <button type="submit" class="btn btn-primary"><fmt:message key="home.modal.button.salvar"/></button>
			      </div>
			    </div>
			  </div>
			</div>
		</form:form>
		
		<!-- Modal excluir -->
		<form:form action="${pageContext.request.contextPath}/home/delete" method="post">
			<div id="gridExcluiModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="gridModalLabel" aria-hidden="true">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			      	<input type="hidden" id="idCompromissoExclud" name="id">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			        <h4 class="modal-title" id="gridModalLabel"><fmt:message key="home.titulo"/></h4>
			      </div>
			      <div class="modal-body">
				      	<h4 class="modal-title" id="gridModalLabel" align="center"><img src="${pageContext.request.contextPath}/bootstrap-dist/img/warning-icon.png" width="50px"><fmt:message key="home.motal.titulo.excluir"/></h4>
				      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-default" data-dismiss="modal"><fmt:message key="home.modal.button.nao"/></button>
			        <button type="submit" class="btn btn-primary"><fmt:message key="home.modal.button.sim"/></button>
			      </div>
			    </div>
			  </div>
			</div>
		</form:form>	
	</jsp:attribute>
</tag:template>
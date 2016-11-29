<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<tag:template id="text" name="text" title="Listagem Pessoas">
	<jsp:attribute name="divBody">	
		<script>
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

			function excluiRegistro(id){
				$("#idPessoaExclud").val(id);
				$("#gridExcluiModal").modal();
			}
		</script>
		
		<h1><fmt:message key="pessoa.title"/></h1>
		<br>
		<table class="table table-striped" id="lista">
			
			<tr>
				<td width="100">
					<div>
						<b><fmt:message key="pessoa.id"/></b>
						<input type="text" name="filt2" class="form-control" placeholder="Buscar" onKeyUp="filter(this, 'lista', '0')"/>
					</div>	
				</td>
				<td>
					<div>
						<b><fmt:message key="pessoa.nome"/></b>
			        	<input type="text" name="filt2" class="form-control" placeholder="Buscar" onKeyUp="filter(this, 'lista', '1')"/>
			    	</div>
				</td>
				<td>
					<div>
						<b><fmt:message key="pessoa.cidade"/></b>
						<input type="text" name="filt2" class="form-control" placeholder="Buscar" onKeyUp="filter(this, 'lista', '2')"/>
					</div>	
				</td>
				<td></td><td></td>
			</tr>
			
			<c:if test="${empty pessoas}">
				<tr>
					<td><fmt:message key="pessoa.nenhum.registro"/></td>
					<td></td>
					<td></td>
				</tr>
			</c:if>
			
			<c:forEach items="${pessoas}" var="pessoa">
				<tr>
					<td>${pessoa.id}</td>
					<td>${pessoa.nome}</td>
					<td>${pessoa.endereco.cidade.nome}</td>
					<td><a href='${pageContext.request.contextPath}/protect/editPessoa?id=${pessoa.id}'><span class="glyphicon glyphicon-pencil"></span></a></td>
					<td><a href="#" onclick="javascript:excluiRegistro(${pessoa.id});"><span class="glyphicon glyphicon-remove"></span></a></td>
				</tr>
			</c:forEach>
		</table>
		<br><br>
		<button type="button" class="btn btn-primary" onclick="javascript:window.location.href='${pageContext.request.contextPath}/protect/formPessoa'"><fmt:message key="pessoa.button.cadastrar"/></button>
		
		<!-- Modal excluir -->
		<form:form action="${pageContext.request.contextPath}/protect/pessoa/delete" method="post">
			<div id="gridExcluiModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="gridModalLabel" aria-hidden="true">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			      	<input type="hidden" id="idPessoaExclud" name="id">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			        <h4 class="modal-title" id="gridModalLabel"><fmt:message key="pessoa.title"/></h4>
			      </div>
			      <div class="modal-body">
				      	<h4 class="modal-title" id="gridModalLabel" align="center"><img src="${pageContext.request.contextPath}/bootstrap-dist/img/warning-icon.png" width="50px"><fmt:message key="produto.motal.titulo.excluir"/></h4>
				      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-default" data-dismiss="modal"><fmt:message key="produto.modal.button.nao"/></button>
			        <button type="submit" class="btn btn-primary"><fmt:message key="produto.modal.button.sim"/></button>
			      </div>
			    </div>
			  </div>
			</div>
		</form:form>	
	</jsp:attribute>
</tag:template>	
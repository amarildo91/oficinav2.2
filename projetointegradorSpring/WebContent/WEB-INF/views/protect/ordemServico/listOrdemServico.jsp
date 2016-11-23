<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<tag:template id="text" name="text" title="Listagem Ordem de Serviço">
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
			
		</script>	
		<h1><fmt:message key="ordemServico.title"/></h1>
		<br>
		<table class="table table-striped" id="lista">
			
			<tr>
				<td><b><fmt:message key="ordemServico.id"/></b></td>
				<td>
					<div>
						<b><fmt:message key="ordemServico.descricao"/></b>
			        	<input type="text" name="filt2" class="form-control" placeholder="Buscar" onKeyUp="filter(this, 'lista', '1')"/>
			    	</div>
				</td>
				<td>
					<div>
						<b><fmt:message key="ordemServico.status"/></b>
			        	<select onchange="filter(this, 'lista', '2')" class="form-control">
			        		<option></option>
			        		<c:forEach items="${status}" var="statusOrdem">
			        			<option value="${statusOrdem}">${statusOrdem}</option>
			        		</c:forEach>
			        	</select>
			    	</div>				
				</td>
				<td>
					<div>
						<b><fmt:message key="ordemServico.cliente"/></b>
			        	<input type="text" name="filt2" class="form-control" placeholder="Buscar" onKeyUp="filter(this, 'lista', '3')"/>
			    	</div>
				</td>
				<td colspan=3><b><fmt:message key="ordemServico.data"/></b></td>
			</tr>
			
			<c:if test="${empty ordemServicos}">
				<tr>
					<td colspan="6"><fmt:message key="ordemServico.nenhum.registro"/></td>
				</tr>
			</c:if>
			
			<c:forEach items="${ordemServicos}" var="ordemServico">
				<tr>
					<td>${ordemServico.idOrdemServico}</td>
					<td>${ordemServico.observacao}</td>
					<td>${ordemServico.status}</td>
					<td>${ordemServico.pessoa.nome}</td>
					<td><fmt:formatDate value="${ordemServico.dtOrdemServico}" pattern="dd/MM/yyyy"/></td>
					<td><a href='${pageContext.request.contextPath}/protect/editOrdemServico?id=${ordemServico.idOrdemServico}'><span class="glyphicon glyphicon-pencil"></span></a></td>
					<td><a href='${pageContext.request.contextPath}/protect/ordemServicoPrint?id=${ordemServico.idOrdemServico}' target="_blank" title="Imprimir"><span class="glyphicon glyphicon-print"></span></a></td>					
				</tr>
			</c:forEach>
		</table>
		<br><br>
		<button type="button" class="btn btn-primary" onclick="javascript:window.location.href='${pageContext.request.contextPath}/protect/formOrdemServico'"><fmt:message key="ordemServico.button.cadastrar"/></button>
		
		<!-- Modal excluir -->
		<form:form action="${pageContext.request.contextPath}/protect/ordemServico/delete" method="post">
			<div id="gridExcluiModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="gridModalLabel" aria-hidden="true">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			      	<input type="hidden" id="idOrdemServicoExclud" name="id">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			        <h4 class="modal-title" id="gridModalLabel"><fmt:message key="ordemServico.title"/></h4>
			      </div>
			      <div class="modal-body">
				      	<h4 class="modal-title" id="gridModalLabel" align="center"><img src="${pageContext.request.contextPath}/bootstrap-dist/img/warning-icon.png" width="50px"><fmt:message key="ordemServico.motal.titulo.excluir"/></h4>
				      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-default" data-dismiss="modal"><fmt:message key="ordemServico.modal.button.nao"/></button>
			        <button type="submit" class="btn btn-primary"><fmt:message key="ordemServico.modal.button.sim"/></button>
			      </div>
			    </div>
			  </div>
			</div>
		</form:form>		
	</jsp:attribute>
</tag:template>	
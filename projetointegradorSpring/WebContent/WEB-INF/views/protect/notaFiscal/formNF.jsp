<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<tag:template id="text" name="text" title="Ordem de Serviço">
	<jsp:attribute name="divBody">
	    <script src="${pageContext.request.contextPath}/bootstrap-dist/js/jquery.min.js"></script>
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
		
		<h1><fmt:message key="ordemServico.form.title"/></h1>
		
		<c:set var="acao" value="${pageContext.request.contextPath}/protect/gerarNotaFiscal"/>
		<c:if test="${notaFiscal.id gt 0}">
			<c:set var="acao" value="${pageContext.request.contextPath}/protect/editNotaFiscal"/>			
		</c:if>
		
		<form:form action="${acao}" method="post" id="formNF">
			<input type="hidden" name="id" value="${notaFiscal.id}"/>
			
			
			<div class="form-group">
			   <label for="nome"><fmt:message key="ordemServico.form.nome"/></label>
			   <div class="input-group">
			     <input type="text" name="nome" class="form-control" id="nome" value="${ordemServico.pessoa.nome}" required="required" disabled="disabled"/>
			     <span class="input-group-btn">
			       <button class="btn btn-default" type="button" onclick='javascript:$("#gridBuscarPessoaModal").modal();'>
			       		<span class="glyphicon glyphicon-search"></span>
			       		<fmt:message key="ordemServico.form.buscar"/>
			       	</button>
			     </span>
			   </div>
			</div>	 
			<div class="form-group">
	        	<label for="nome"><fmt:message key="pessoa.form.nome"/></label>
	        	<input type="text" name="nome" class="form-control" id="nome" value="${pessoa.nome}" required="required"/>
	        </div>
	        <div class="form-group">
	        	<label for="nome"><fmt:message key="pessoa.form.nome"/></label>
	        	<input type="text" name="nome" class="form-control" id="nome" value="${pessoa.nome}" required="required"/>
	        </div>
	        <div class="form-group">
	        	<label for="nome"><fmt:message key="pessoa.form.nome"/></label>
	        	<input type="text" name="nome" class="form-control" id="nome" value="${pessoa.nome}" required="required"/>
	        </div>
	        <div class="form-group">
				<button type="submit" class="btn btn-primary"><fmt:message key="ordemServico.form.salvar"/></button>
				<a class="btn btn-default" href="${pageContext.request.contextPath}/protect/ordemServico"><fmt:message key="ordemServico.form.button.listagem"/></a>
				<c:if test="${nf.id gt 0}">
					<a class="btn btn-default" href="${pageContext.request.contextPath}/protect/notaFiscalPrint?id=${ordemServico.idOrdemServico}"target="_blank" title="Imprimir"><span class="glyphicon glyphicon-print"></span>&nbsp;<fmt:message key="ordemServico.form.button.imprimir"/></a>
				</c:if>					
			</div>
		</form:form>
		
		<!-- Modal buscar OS -->
		<div id="gridBuscarOSModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="gridModalLabel" aria-hidden="true">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		      	<input type="hidden" id="idProdutoExclud" name="id">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h4 class="modal-title" id="gridModalLabel"><fmt:message key="ordemServico.form.pessoa.title"/></h4>
		      </div>
		      <div class="modal-body">
			   	<table class="table table-striped" id="lista">
			   		<thead>
			   			<tr>
			   				<th colspan="5">
			   					<div class="navbar-form navbar-left">
			        				<input type="text" name="filt2" class="form-control" placeholder='<fmt:message key="ordemServico.form.pessoa.placeholder"/>' onKeyUp="filter(this, 'lista', '1')"/>
			    				</div>
			   				</th>
			   			</tr>
			   		</thead>
			   		<tbody>
			   			<c:forEach items="${pessoas}" var="pessoa">
		        			<tr>
		        				<td>${pessoa.id}</td>
		        				<td>${pessoa.nome} - ${pessoa.cpf}</td>
		        				<td><a data-id="${pessoa.id}" data-nome="${pessoa.nome}" href="#" onclick="javascript:selectPessoa(this);"><span class="glyphicon glyphicon-ok"></span></a></td>
		        			</tr>
		        		</c:forEach>
			   		</tbody>
			   	</table>
			  </div>
		      <div class="modal-footer"></div>
		    </div>
		  </div>
		</div>
	</jsp:attribute>
</tag:template>		
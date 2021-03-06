<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<tag:template id="text" name="text" title="Listagem Nota Fiscal">
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
		<h1><fmt:message key="nf.title"/></h1>
		<br>
		<table class="table table-striped" id="lista">
			
			<tr>
				<td width="100">
					<div>
						<b><fmt:message key="nf.id"/></b>
						<input type="text" name="filt2" class="form-control" placeholder="Buscar" onKeyUp="filter(this, 'lista', '0')"/>
					</div>	
				</td>
				<td>
					<div>
						<b><fmt:message key="nf.cliente"/></b>
			        	<input type="text" name="filt2" class="form-control" placeholder="Buscar" onKeyUp="filter(this, 'lista', '1')"/>
			    	</div>
				</td>
				<td width="150">
					<div>
						<b><fmt:message key="nf.dtEmissao"/></b>
			        	<input type="text" name="filt2" class="form-control" placeholder="Buscar data" onKeyUp="filter(this, 'lista', '2')"/>
			    	</div>				
				</td>
				<td>
					<div>
						<b><fmt:message key="nf.valor"/></b>
			        	<input type="text" name="filt2" class="form-control" placeholder="Buscar" onKeyUp="filter(this, 'lista', '3')"/>
			    	</div>
				</td>
				<td colspan=2></td>		
			</tr>
			
			<c:if test="${empty notaFiscal}">
				<tr>
					<td colspan="6"><fmt:message key="nf.nenhum.registro"/></td>
				</tr>
			</c:if>
			
			<c:forEach items="${notaFiscal}" var="nf">
				<tr>
					<td>${nf.id}</td>
					<td>${nf.ordemServico.pessoa.nome}</td>	
					<td><fmt:formatDate value="${nf.dtEmissao}" pattern="dd/MM/yyyy"/></td>
					<td align="right"><fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${nf.vlTotal}"/></td>									
					<td><a href='${pageContext.request.contextPath}/protect/editNotaFiscal?id=${nf.id}'><span class="glyphicon glyphicon-pencil"></span></a></td>
					<td><a href='${pageContext.request.contextPath}/protect/notaFiscalPrint?id=${nf.id}' target="_blank" title="Imprimir"><span class="glyphicon glyphicon-print"></span></a></td>					
				</tr>
			</c:forEach>
		</table>
		
	</jsp:attribute>
</tag:template>			
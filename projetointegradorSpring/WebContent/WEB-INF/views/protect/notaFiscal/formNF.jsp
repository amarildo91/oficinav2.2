<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<tag:template id="text" name="text" title="Nota Fiscal">
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
			/*
			var mask = {
			 money: function() {
			 	var el = this
			 	,exec = function(v) {
			 		v = v.replace(/\D/g,"");
			 		v = new String(Number(v));
			 		var len = v.length;
			 		if (1== len)
			 			v = v.replace(/(\d)/,"0.0$1");
			 		else if (2 == len)
			 			v = v.replace(/(\d)/,"0.$1");
			 		else if (len > 2) {
			 			v = v.replace(/(\d{2})$/,'.$1');
			 		}
			 		return v;
			 	};

			 	setTimeout(function(){
			 	el.value = exec(el.value);
			 	},1);
			 }
			};*/
			
			$(document).ready(function(){
				//$("#valorTotal").bind('keypress',mask.money);
			});
		</script>
  		
		<h1><fmt:message key="nf.title"/></h1>
				
		<form:form action="${pageContext.request.contextPath}/protect/gerarNotaFiscal" method="post" id="formNF">			
 			<div class="form-group">
	        	<label for="id"><fmt:message key="nf.form.idNF"/></label>
	        	<input type="text" name="id" class="form-control" id="id" value="${notaFiscal.id}" disabled="disabled"/>
	        	<input type="hidden" name="id" value="${notaFiscal.id}"/>
	        </div>
			<div class="form-group">
	        	<label for="idOrdemServico"><fmt:message key="nf.form.ordem"/></label>
	        	<input type="text" name="idOrdemServico" class="form-control" id="idOrdemServico" value="${ordemServico.idOrdemServico}" disabled="disabled"/>
	        	<input type="hidden" name="idOrdemServico" value="${ordemServico.idOrdemServico}"/>
	        </div>
   	        <div class="form-group">
	        	<label for="data"><fmt:message key="nf.form.dtEmissao"/></label>
	        	<input type="date" name="data" class="form-control" id="data" value="${notaFiscal.dtEmissao}" disabled="disabled"/>
	        	<input type="hidden" name="data" value="${notaFiscal.dtEmissao}"/>
	        </div>	 
			<div class="form-group">
	        	<label for="nome"><fmt:message key="nf.cliente"/></label>
	        	<input type="text" name="nome" class="form-control" id="nome" value="${ordemServico.pessoa.nome}" disabled="disabled"/>
	        </div>
	        <div class="form-group">
	        	<label for="observacao"><fmt:message key="nf.form.observacao"/></label>
	        	<textarea class="form-control" rows="3" id="observacao" name="observacao" disabled="disabled">${ordemServico.observacao}</textarea>
	        	<input type="hidden" name="observacao" value="${ordemServico.observacao}"/>
	        </div>
	        <div class="form-group">
	        	<label for="valorTotal"><fmt:message key="nf.form.valor"/></label>
	        	<input type="text" name="valorTotal" class="form-control" id="valorTotal" value="<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${ordemServico.valorTotal}"/>" disabled="disabled"/>
	        	<input type="hidden" name="valorTotal" value="${ordemServico.valorTotal}"/>
	        </div>	        
	        	        
	        <table class="table table-striped tableItem">
	        	<thead>
	        		<tr>
	        			<th><fmt:message key="nf.form.items.id"/></th>
	        			<th><fmt:message key="nf.form.items.descricao"/></th>
	        			<th><fmt:message key="nf.form.items.valor"/></th>
	        		</tr>
	        	</thead>
	        	<tbody>
		        	<c:forEach items="${ordemServico.item}" var="item" varStatus="i">
		        		<tr>
		        			<td>${i.count}</td>
		        			<td>${item.descricao}</td>
		        			<td><fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${item.valorItem}"/></td>
		        		</tr>		        
		        	</c:forEach>
	        	</tbody>
	        </table>	
	        
           <div class="form-group">
		        <div class="row">
				  <div class="col-lg-2">
				    <div class="input-group">
			        	<label for="iss"><fmt:message key="nf.form.iss"/></label>
			        	<input type="text" name="iss" class="form-control" id="iss" value="<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${iss}"/>" disabled="disabled"/>
			        </div>
			      </div> 
		          <div class="col-lg-2">
				    <div class="input-group">
			        	<label for="vlIss"><fmt:message key="nf.form.iss.valor"/></label>
			        	<input type="text" name="vlIss" class="form-control" id="vlIss" value="<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${descontoIss}"/>" disabled="disabled"/>
			        </div>	
		          </div>
		        </div>
		    </div>    
		    <input type="hidden" name="vlIss" value="${descontoIss}"/>
		    
		    <c:set var="vlTotalNF" value="${notaFiscal.vlTotal}"/>
		    <c:if test="${notaFiscal.vlTotal eq 0}">
		    	<c:set var="vlTotalNF" value="${ordemServico.valorTotal}"/>
		    </c:if>
		    
	        <div class="form-group">
	        	<label for="vlTotal"><fmt:message key="nf.form.valorTotal"/></label>
	        	<input type="text" name="vlTotal" class="form-control" id="vlTotal" value="<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${vlTotalNF}"/>" disabled="disabled"/>
	        	<input type="hidden" name="vlTotal" value="${vlTotalNF}"/>
	        </div>
	        
	        <c:set var="selcetd" value=""/>
	        <c:if test="${notaFiscal.status}">
	        	<c:set var="selcetd" value="selected"/>
	        </c:if>
	        <div class="form-group">
	        	<label for="status"><fmt:message key="nf.form.status"/></label>
		        <select class="form-control" id="status" name="status">
		        	<option></option>
		        	<option value="${status}" ${selected}>${status}</option>
		        </select>
		    </div>    		
	        
	        <div class="form-group">
				<button type="submit" class="btn btn-primary"><fmt:message key="nf.button.gerar"/></button>
				<a class="btn btn-default" href="${pageContext.request.contextPath}/protect/notaFiscal"><fmt:message key="nf.form.button.listagem"/></a>
				<a class="btn btn-default" href="${pageContext.request.contextPath}/protect/editOrdemServico?id=${ordemServico.idOrdemServico}"><span class="glyphicon glyphicon-pencil"></span>&nbsp;<fmt:message key="nf.form.button.editar"/></a>
				<c:if test="${notaFiscal.id gt 0}">
					<a class="btn btn-default" href="${pageContext.request.contextPath}/protect/notaFiscalPrint?id=${ordemServico.idOrdemServico}"target="_blank" title="Imprimir"><span class="glyphicon glyphicon-print"></span>&nbsp;<fmt:message key="ordemServico.form.button.imprimir"/></a>
				</c:if>					
			</div>
		</form:form>
		
	</jsp:attribute>
</tag:template>	
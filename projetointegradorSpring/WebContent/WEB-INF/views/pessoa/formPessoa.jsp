<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<tag:template id="text" name="text" title="Cliente">
	<jsp:attribute name="divBody">
		<script>
			$(document).ready(function(){
				$("#cpf").mask("999.999.999-99");
				$("#telefone").mask("(99) 9999-9999?9");
				$("#cep").mask("99999-999");
			});
		</script>
		
		<h1><fmt:message key="pessoa.form.title"/></h1>
		
		<c:set var="acao" value="${pageContext.request.contextPath}/cadastrarPessoa"/>
		<c:if test="${pessoa.id gt 0}">
			<c:set var="acao" value="${pageContext.request.contextPath}/editPessoaSubmit"/>
		</c:if>
		
		<form:form action="${acao}" method="post">
			<input type="hidden" name="idPessoa" value="${pessoa.id}"/>
			<input type="hidden" name="idEndereco" value="${endereco.id}"/>
			
			<div class="form-group">
	        	<label for="nome"><fmt:message key="pessoa.form.nome"/></label>
	        	<input type="text" name="nome" class="form-control" id="nome" value="${pessoa.nome}" required="required"/>
	        </div>
	        <div class="form-group">
	        	<label for="cpf"><fmt:message key="pessoa.form.cpf"/></label>
	        	<input type="text" name="cpf" class="form-control" id="cpf" value="${pessoa.cpf}" required="required"/>
	        </div>
	         <div class="form-group">
	        	<label for="rg"><fmt:message key="pessoa.form.rg"/></label>
	        	<input type="text" name="rg" class="form-control" id="rg" value="${pessoa.rg}" required="required" maxlength="10"/>
	        </div>
	        <div class="form-group">
	        	<label for="telefone"><fmt:message key="pessoa.form.telefone"/></label>
	        	<input type="text" name="telefone" class="form-control" id="telefone" value="${pessoa.telefone}" required="required"/>
	        </div>
	        <div class="form-group">
	        	<label for="data"><fmt:message key="pessoa.form.dtNascimento"/></label>
	        	<input type="date" name="data" class="form-control" id="dtNasimento" value="${pessoa.dtNascimento}" required="required"/>
	        </div>
	        
	        <hr>
	        
	        <h3><fmt:message key="pessoa.form.endereco"/></h3>
	        
	        <div class="form-group">
	        	<label for="rua"><fmt:message key="pessoa.form.rua"/></label>
	        	<input type="text" name="rua" class="form-control" id="rua" value="${endereco.rua}" required="required"/>
	        </div>
	        <div class="form-group">
	        	<label for="cep"><fmt:message key="pessoa.form.cep"/></label>
	        	<input type="text" name="cep" class="form-control" id="cep" value="${endereco.cep}" required="required"/>
	        </div>
	        <div class="form-group">
	        	<label for="cidade"><fmt:message key="pessoa.form.cidade"/></label>
	        	<select name="idCidade" class="form-control" id="cidade" required="required">
	        		<option></option>
	        		<c:forEach items="${cidades}" var="cidade">
	        			<c:set var="selected" value=""/>
	        			<c:if test="${cidade.id eq endereco.cidade.id}">
	        				<c:set var="selected" value="selected"/>
	        			</c:if>
	        			<option value="${cidade.id}" ${selected}>${cidade.nome} - ${cidade.uf.sigla}</option>
	        			
	        		</c:forEach>
	        	</select>
	        </div>
				
			<button type="submit" class="btn btn-primary"><fmt:message key="pessoa.form.salvar"/></button>
		</form:form>	
	</jsp:attribute>
</tag:template>	
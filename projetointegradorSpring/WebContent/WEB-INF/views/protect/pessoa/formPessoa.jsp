<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<tag:template id="text" name="text" title="Cliente">
	<jsp:attribute name="divBody">
		<script src="${pageContext.request.contextPath}/bootstrap-dist/js/jquery.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.inputmask/3.3.3/bindings/inputmask.binding.js"></script>
		<script>		
			$(document).ready(function(){
				
		        $('#cpfCnpj').on('keyup', function (e) {
		            var query = $('#cpfCnpj').val().replace(/[^a-zA-Z 0-9]+/g,'');
		            if (query.length == 11) {
		                $("#cpfCnpj").mask("999.999.999-99?99999");
		            }
		            if (query.length == 14) {
		                $("#cpfCnpj").mask("99.999.999/9999-99");
		            }
		        });

				$("#telefone").mask("(99) 9999-9999?9");
				$("#cep").mask("99999-999");
			});
		</script>
		
		<h1><fmt:message key="pessoa.form.title"/></h1>
		
		<c:set var="acao" value="${pageContext.request.contextPath}/protect/cadastrarPessoa"/>
		<c:if test="${pessoa.id gt 0}">
			<c:set var="acao" value="${pageContext.request.contextPath}/protect/editPessoaSubmit"/>
		</c:if>
		
		<form:form action="${acao}" method="post">
			<input type="hidden" name="idPessoa" value="${pessoa.id}"/>
			<input type="hidden" name="idEndereco" value="${endereco.id}"/>
			
			<div class="form-group">
	        	<label for="nome"><fmt:message key="pessoa.form.nome"/></label>
	        	<input type="text" name="nome" class="form-control" id="nome" value="${pessoa.nome}" required="required"/>
	        </div>
	        <div class="form-group">
	        	<label for="cpfCnpj"><fmt:message key="pessoa.form.cpf"/></label>
	        	<input type="text" name="cpfCnpj" class="form-control" id="cpfCnpj" value="${pessoa.cpfCnpj}" required="required"/>
	        </div>
	        <div class="form-group">
	        	<label for="telefone"><fmt:message key="pessoa.form.telefone"/></label>
	        	<input type="text" name="telefone" class="form-control" id="telefone" value="${pessoa.telefone}" required="required"/>
	        </div>
	        <div class="form-group">
	        	<label for="email"><fmt:message key="pessoa.form.email"/></label>
	        	<input type="email" name="email" class="form-control" id="email" value="${pessoa.email}" required="required"/>
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
	        	<label for="bairro"><fmt:message key="pessoa.form.bairro"/></label>
	        	<input type="text" name="bairro" class="form-control" id="bairro" value="${endereco.bairro}" required="required"/>
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
			<a class="btn btn-default" href="${pageContext.request.contextPath}/protect/pessoa"><fmt:message key="pessoa.listagem"/></a>
		</form:form>	
	</jsp:attribute>
</tag:template>	
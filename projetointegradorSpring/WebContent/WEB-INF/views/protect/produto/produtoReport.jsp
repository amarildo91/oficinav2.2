<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<tag:template id="text" name="text" title="Cliente">
	<jsp:attribute name="divBody">
	
	<h1><fmt:message key="produto.report.title"/></h1>
	
	<form:form action="${pageContext.request.contextPath}/protect/produtoSaidaReport" target="_blank">		
		<div class="form-group">
        	<label for="produto"><fmt:message key="produto.report.nome"/></label>
        	<select class="form-control" name="produto">
        		<option></option>
        		<c:forEach items="${produtos}" var="produto">
        			<option value="${produto.id}">${produto.descricao}</option>
        		</c:forEach>
        	</select>
        </div>
        <div class="form-group">
        	<label for="dtInicio"><fmt:message key="produto.report.dtInicio"/></label>
        	<input type="date" name="dtInicio" class="form-control" id="dtInicio"/>
        </div>
        <div class="form-group">
        	<label for="dtFim"><fmt:message key="produto.report.dtFim"/></label>
        	<input type="date" name="dtFim" class="form-control" id="dtFim"/>
        </div>
		<button type="submit" class="btn btn-primary"><fmt:message key="produto.report.gerar"/></button>	
	</form:form>
	
	</jsp:attribute>
</tag:template>	
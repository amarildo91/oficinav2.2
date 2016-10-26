<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<tag:template id="text" name="text" title="Cadastro Itens Ordem Serviço">
	<jsp:attribute name="divBody">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
		<script>
			var cont = 0;
			function selectProduto(){
				var valorAproximado = $("#quantidade").val() * $("#produtoSelected option:selected").data("valor");
				$(".table tbody").append("<tr>"+
											"<td>"+$("#produtoSelected").val()+"</td>"+
											"<td>"+$("#produtoSelected option:selected").text()+"</td>"+
											"<td>"+$("#quantidade").val()+"</td>"+
											"<td>"+valorAproximado+"</td>"+
										"</tr>");
				$("#formItem").append("<input type='hidden' name='produto["+cont+"].id' value='"+$("#produtoSelected").val()+"'/>");
				$("#formItem").append("<input type='hidden' name='produto["+cont+"].descricao' value='"+$("#produtoSelected option:selected").text()+"'/>");
				$("#formItem").append("<input type='hidden' name='produto["+cont+"].valor' value='"+valorAproximado+"'/>");
				$("#formItem").append("<input type='hidden' name='produto["+cont+"].quantidade' value='"+$("#quantidade").val()+"'/>");
				cont++;
			}
		
			$(document).ready(function(){
				$("#idCategoria").change(function(){
					$.ajax({
						url:"buscarProduto",
						data: {id : $("#idCategoria").val()},
						method: "POST",
						dataType: "text",
						success: function(produto){
							$(".selectProd option").remove();
							$(".selectProd").append(produto);
						}
					});
				});
			});
		</script>
		<ul class="nav nav-tabs">
  			<li class="nav-item">
    			<a class="nav-link" href="${pageContext.request.contextPath}/editOrdemServico?id=${idOrdemServico}"><fmt:message key="ordemServico.form.title"/></a>
  			</li>
  			<li class="nav-item active">
    			<a class="nav-link" href="${pageContext.request.contextPath}/item?id=${idOrdemServico}"><fmt:message key="item.form.title"/></a>
  			</li>
  		</ul>	
  		
  		<h1><fmt:message key="item.form.title"/></h1>
		
		<form:form action="${pageContext.request.contextPath}/salvarItem" method="post" id="formItem" modelAttribute="item">
			<input type="hidden" name="idItem" id="idItem" value="${item.idItem}"/> 
			<input type="hidden" name="idOrdemServico" id="idOrdemServico" value="${idOrdemServico}"/>
			<div class="form-group">
	        	<label for="valorItem"><fmt:message key="item.form.valor"/></label>
	        	<input type="text" name="valorItem" class="form-control" id="valorItem" value="${ordemServico.valorTotal}"/>
	        </div>
	        <div class="form-group">
	        	<label for="idCategoria"><fmt:message key="item.form.categoria"/></label>
	        	<select name="idCategoria" id="idCategoria" class="form-control">
	        		<option></option>
	        		<c:forEach items="${categorias}" var="categoria">
	        			<option value="${categoria.id}">${categoria.descricao}</option>
	        		</c:forEach>
	        	</select>
	        </div>
	        <table class="table table-striped">
	        	<thead>
	        		<tr>
	        			<th><fmt:message key="item.form.produto"/></th>
	        			<th><a href="#" onclick="javascript:$('#gridProdutoModal').modal();"><span class="glyphicon glyphicon-plus"></span></a></th>
	        		</tr>
	        	</thead>
	        	<tbody>
	        		
	        		
	        	</tbody>
	        </table>
	        <br><br>
			<button type="submit" class="btn btn-primary" data-toggle="modal" data-target="#gridInsertModal"><fmt:message key="produto.button"/></button>
		</form:form>
		
		<!-- Modal inserção de produtos -->
		<div id="gridProdutoModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="gridModalLabel" aria-hidden="true">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		      	<input type="hidden" id="idProdutoExclud" name="id">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h4 class="modal-title" id="gridModalLabel"><fmt:message key="ordemServico.form.pessoa.title"/></h4>
		      </div>
		      <div class="modal-body">
		      
		      	<select class="form-control selectProd" id="produtoSelected">
		      		<option></option>
		        </select>
		        <div class="form-group">
	        		<label for="quantidade"><fmt:message key="item.form.valor"/></label>
	        		<input type="text" name="quantidade" class="form-control" id="quantidade"/>
	        	</div>		
			  </div>
		      <div class="modal-footer">
		      	<button type="button" class="btn btn-default" data-dismiss="modal" onclick="javascript:selectProduto();"><fmt:message key="produto.modal.button.nao"/></button>
		      </div>
		    </div>
		  </div>
		</div>
	</jsp:attribute>
</tag:template>	
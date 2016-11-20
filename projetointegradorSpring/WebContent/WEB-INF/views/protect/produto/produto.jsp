<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<tag:template id="text" name="text" title="Cadastro Produtos">
	<jsp:attribute name="divBody">
	    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
		<script>
			function editProduto(componente){
				$("#idProdutoEdit").val(componente.getAttribute("data-id"));
				$("#descricaoEdit").val(componente.getAttribute("data-nome"));
				$("#quantidadeEdit").val(componente.getAttribute("data-qt"));
				$("#valorEdit").val(componente.getAttribute("data-valor"));
				$("#idCategoriaEdit").val(componente.getAttribute("data-categoria"));
				$("#gridEditModal").modal();		
			}
			
			function excluiRegistro(id){
				$("#idProdutoExclud").val(id);
				$("#gridExcluiModal").modal();
			}

			var mask = {
			 money: function() {
			 	var el = this
			 	,exec = function(v) {
			 		v = v.replace(/\D/g,"");
			 		v = new String(Number(v));
			 		var len = v.length;
			 		if (1== len)
			 			v = v.replace(/(\d)/,"0.$1");
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

			};

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

			$(function(){
				 $('#valor').bind('keypress',mask.money);
				 $('#valorEdit').bind('keypress',mask.money);
			});
		
		</script>
	
		<h1><fmt:message key="produto.titulo"/></h1>
		<br>
		<table class="table table-striped" id="lista">
			<tr>
				<td><b><fmt:message key="produto.id"/></b></td>
				<td>
					<div>
						<b><fmt:message key="produto.descricao"/></b>
			        	<input type="text" name="filt2" class="form-control" placeholder="Buscar" onKeyUp="filter(this, 'lista', '1')"/>
			    	</div></td>
				<td><b><fmt:message key="produto.valor"/></b></td>
				<td><b><fmt:message key="produto.quantidade"/></b></td>
				<td></td><td></td>
			</tr>
				
			<c:if test="${empty produtos}">
				<tr>
					<td><fmt:message key="produto.nenhum.registro"/></td>
					<td></td><td></td><td></td><td></td><td></td>
				</tr>	
			</c:if>
			
			<c:forEach items="${produtos}" var="produto">
				<tr>
					<td>${produto.id}</td>
					<td>${produto.descricao}</td>
					<td>${produto.valor}</td>
					<td>${produto.quantidade}</td>
					<td><a data-id="${produto.id}" data-nome="${produto.descricao}" data-valor="${produto.valor}" data-qt="${produto.quantidade}"
							data-categoria="${produto.categoria.id}"
							href='#' onclick="javascript:editProduto(this);"><span class="glyphicon glyphicon-pencil"></span></a></td>
						<td><a href="#" onclick="javascript:excluiRegistro(${produto.id});"><span class="glyphicon glyphicon-remove"></span></a></td>
				</tr>
			</c:forEach>
		</table>
		<br><br>
		<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#gridInsertModal"><fmt:message key="produto.button"/></button>
		
		<!-- Modal insert -->
		<form:form action="${pageContext.request.contextPath}/protect/cadastrarProduto" method="post">
			 <div id="gridInsertModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="gridModalLabel" aria-hidden="true">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			        <h4 class="modal-title" id="gridModalLabel"><fmt:message key="produto.modal.titulo"/></h4>
			      </div>
			      <div class="modal-body">
			        <div class="form-group">
			        	<label for="descricao"><fmt:message key="produto.modal.descricao"/></label>
			        	<input type="text" name="descricao" class="form-control" id="descricao" required="required"/>
			        </div>
			        <div class="form-group">
			        	<label for="valor"><fmt:message key="produto.modal.valor"/></label>
			        	<input type="text" name="valor" class="form-control" id="valor" required="required"/>
			        </div>
			        
			        <div class="form-group">
			        	<label for="quantidade"><fmt:message key="produto.modal.quantidade"/></label>
			        	<input type="number" name="quantidade" class="form-control" id="quantidade" required="required"/>
			        </div>
			        
			        <div class="form-group">
					    <label for="idCategoriaOrdem"><fmt:message key="produto.modal.categorias"/></label>
					      <select name="idCategoriaOrdem" class="form-control" required="required">
					      	<option></option>
					      	<c:forEach items="${categorias}" var="categoria">
					      		<option value="${categoria.id}">${categoria.descricao}</option>
					      	</c:forEach>       
					      </select>
					</div>
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-default" data-dismiss="modal"><fmt:message key="produto.modal.button.sair"/></button>
			        <button type="submit" class="btn btn-primary"><fmt:message key="produto.modal.button.salvar"/></button>
			      </div>
			    </div>
			  </div>
			</div>
		</form:form>
		
		<!-- Modal edit -->
		<form:form action="${pageContext.request.contextPath}/protect/editProduto" method="post">
			 <div id="gridEditModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="gridModalLabel" aria-hidden="true">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			        <h4 class="modal-title" id="gridModalLabel"><fmt:message key="produto.modal.titulo"/></h4>
			      </div>
			      <div class="modal-body">
			      	<input type="hidden" id="idProdutoEdit" name="id">
			        <div class="form-group">
			        	<label for="descricao"><fmt:message key="produto.modal.descricao"/></label>
			        	<input type="text" name="descricao" class="form-control" id="descricaoEdit" required="required"/>
			        </div>
			        <div class="form-group">
			        	<label for="valor"><fmt:message key="produto.modal.valor"/></label>
			        	<input type="text" name="valor" class="form-control" id="valorEdit" required="required"/>
			        </div>
			        
			        <div class="form-group">
			        	<label for="quantidade"><fmt:message key="produto.modal.quantidade"/></label>
			        	<input type="number" name="quantidade" class="form-control" id="quantidadeEdit" required="required"/>
			        </div>
			        
			        <div class="form-group">
					    <label for="idCategoriaOrdem"><fmt:message key="produto.modal.categorias"/></label>
					      <select name="idCategoriaOrdem" class="form-control" required="required" id="idCategoriaEdit">
					      	<option></option>
					      	<c:forEach items="${categorias}" var="categoria">
					      		<option value="${categoria.id}">${categoria.descricao}</option>
					      	</c:forEach>       
					      </select>
					</div>
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-default" data-dismiss="modal"><fmt:message key="produto.modal.button.sair"/></button>
			        <button type="submit" class="btn btn-primary"><fmt:message key="produto.modal.button.salvar"/></button>
			      </div>
			    </div>
			  </div>
			</div>
		</form:form>
		
		<!-- Modal excluir -->
		<form:form action="${pageContext.request.contextPath}/protect/produto/delete" method="post">
			<div id="gridExcluiModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="gridModalLabel" aria-hidden="true">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			      	<input type="hidden" id="idProdutoExclud" name="id">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			        <h4 class="modal-title" id="gridModalLabel"><fmt:message key="produto.titulo"/></h4>
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
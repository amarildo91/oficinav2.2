<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<tag:template id="text" name="text" title="Manutenção Produtos">
	<jsp:attribute name="divBody">
	    <script src="${pageContext.request.contextPath}/bootstrap-dist/js/jquery.min.js"></script>
		<script>
			function editProduto(componente){
				$(".tableProduto tbody tr").remove();
				$("#idProdutoEdit").val(componente.getAttribute("data-id"));
				$("#descricaoEdit").val(componente.getAttribute("data-nome"));
				$("#quantidadeEdit").val(componente.getAttribute("data-qt"));
				$("#valorEdit").val(componente.getAttribute("data-valor"));
				$("#idCategoriaEdit").val(componente.getAttribute("data-categoria"));
				$("#gridEditModal").modal();		
				$(".tableProduto tbody").append("<tr>"
											+"<td>"+$("#idProdutoEdit").val()+"</td>"
											+"<td>"+$("#descricaoEdit").val()+"</td>"
											+"<td>"+$("#valorEdit").val().replace(".", ",")+"</td>"
											+"<td>"+$("#quantidadeEdit").val().replace(".", ",")+"</td>"
									    +"</tr>");
				
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

			$(document).ready(function(){
				 $('#valor').bind('keypress',mask.money);
				 $('#valorEdit').bind('keypress',mask.money);
				 $('#quantidadeEditPrd').bind('keypress',mask.money);
			});
		
		</script>
	
		<h1><fmt:message key="produto.manutencao.titulo"/></h1>
		<br>
		<table class="table table-striped" id="lista">
			<tr>
				<td><b><fmt:message key="produto.id"/></b></td>
				<td>
					<div>
						<b><fmt:message key="produto.descricao"/></b>
			        	<input type="text" name="filt2" class="form-control" placeholder="Buscar" onKeyUp="filter(this, 'lista', '1')"/>
			    	</div></td>
				<td>
					<div>
						<b><fmt:message key="produto.categorias"/></b>
						<select onchange="filter(this, 'lista', '2')" class="form-control">
							<option></option>
							<c:forEach items="${categorias}" var="categoria">
					      		<option value="${categoria.descricao}">${categoria.descricao}</option>
					      	</c:forEach>
						</select>	
					</div>
				</td>
				<td><b><fmt:message key="produto.quantidade"/></b></td>
				<td></td>
			</tr>
				
			<c:if test="${empty produtos}">
				<tr>
					<td><fmt:message key="produto.nenhum.registro"/></td>
					<td></td><td></td><td></td><td></td>
				</tr>	
			</c:if>
			
			<c:forEach items="${produtos}" var="produto">
				<tr>
					<td>${produto.id}</td>
					<td>${produto.descricao}</td>
					<td>${produto.categoria.descricao}</td>
					<td><fmt:formatNumber type="number" maxIntegerDigits="3" value="${produto.quantidade}"/></td>
					<td><a data-id="${produto.id}" data-nome="${produto.descricao}" data-valor="${produto.valor}" data-qt="${produto.quantidade}"
							data-categoria="${produto.categoria.id}"
							href='#' onclick="javascript:editProduto(this);"><span class="glyphicon glyphicon-plus"></span></a></td>
				</tr>
			</c:forEach>
		</table>
		
		<!-- Modal edit -->
		<form:form action="${pageContext.request.contextPath}/editProdutoManutencao" method="post">
			 <div id="gridEditModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="gridModalLabel" aria-hidden="true">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			        <h4 class="modal-title" id="gridModalLabel"><fmt:message key="produto.manutencao.titulo"/></h4>
			      </div>
			      <div class="modal-body">
			      	<input type="hidden" id="idProdutoEdit" name="id">
			        <input type="hidden" name="descricao" id="descricaoEdit"/>
			        <input type="hidden" name="idCategoriaOrdem"id="idCategoriaEdit"/>
			        <input type="hidden" id="quantidadeEdit"/>
			        
			        <table class="table table-striped tableProduto">
			        	<thead>
							<tr>
								<th><fmt:message key="produto.id"/></th>
								<th><fmt:message key="produto.descricao"/></th>
								<th><fmt:message key="produto.valor"/></th>
								<th><fmt:message key="produto.quantidade"/></th>
							</tr>
						</thead>
						<tbody>							
						</tbody>	
					</table>	
			        
			        <div class="form-group">
			        	<label for="valor"><fmt:message key="produto.modal.valor"/></label>
			        	<input type="number" name="valor" class="form-control" id="valorEdit" required="required" step="any"/>
			        </div>
			        
			        <div class="form-group">
			        	<label for="quantidade"><fmt:message key="produto.modal.quantidade"/></label>
			        	<input type="number" name="quantidade" class="form-control" id="quantidadeEditPrd" required="required" step="any"/>
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
		
	</jsp:attribute>
</tag:template>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<tag:template id="text" name="text" title="Ordem de Serviço">
	<jsp:attribute name="divBody">
	    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
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
			
			function selectPessoa(componente){
				$("#idPessoa").val(componente.getAttribute("data-id"));
				$("#nome").val(componente.getAttribute("data-nome"));
				$("#gridBuscarPessoaModal").modal('hide');
			}
			
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

			};
			
			var cont = 0;
			function selectProduto(){
				var valorAproximado = $("#quantidade").val() * $("#produtoSelected option:selected").data("valor");
				var a = parseFloat($("#valorItem").val());
				var b =  parseFloat(valorAproximado);
				alert(a+" - "+b);
				$("#valorItem").val(a + b);
				
				$("#selectProd tbody").append("<tr>"+
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
			
			var contItem = 0;
			function selectItem(){
				$("#rowZero").remove();
				$(".tableItem tbody").append("<tr>"+
												"<td>"+contItem+"</td>"+
												"<td>Teste</td>"+
												"<td>10</td>"+
											"</tr>");
				
				/*$("#formItem").append("<input type='hidden' name='produto["+contItem+"].id' value='"+$("#produtoSelected").val()+"'/>");*/
				/*$("#formItem").append("<input type='hidden' name='item["+contItem+"].quantidade' value='"+$("#quantidade").val()+"'/>");*/
				$("#formItem").append("<input type='hidden' name='item["+contItem+"].idCategoria' value='"+$("#idCategoria").val()+"'/>");
				contItem++;
			}
			
			$(document).ready(function(){
				$(".modal-body").css("max-height", "400px");
				$(".modal-body").css("overflow-y", "auto");
				$('#valorTotal').bind('keypress',mask.money);
				
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
		
		
		<h1><fmt:message key="ordemServico.form.title"/></h1>
		
		<c:set var="acao" value="${pageContext.request.contextPath}/cadastrarOrdemServico"/>
		<c:if test="${ordemServico.idOrdemServico gt 0}">
			<c:set var="acao" value="${pageContext.request.contextPath}/editOrdemServicoSubmit"/>
		</c:if>
		
		<form:form action="${acao}" method="post" id="formItem">
			<input type="hidden" name="idOrdemServico" value="${ordemServico.idOrdemServico}"/>
			<input type="hidden" name="idPessoa" id="idPessoa" value="${ordemServico.pessoa.id}"/>
			
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
	        	<label for="data"><fmt:message key="ordemServico.form.dtOrdemServico"/></label>
	        	<input type="date" name="data" class="form-control" id="dtOrdemServico" value="${ordemServico.dtOrdemServico}" required="required"/>
	        </div>
	        <div class="form-group">
	        	<label for="valorTotal"><fmt:message key="ordemServico.form.valorTotal"/></label>
	        	<input type="text" name="valorTotal" class="form-control" id="valorTotal" value="${ordemServico.valorTotal}"/>
	        </div>
	        <div class="form-group">
	        	<label for="observacao"><fmt:message key="ordemServico.form.observacao"/></label>
	        	<textarea class="form-control" rows="5" id="observacao" name="observacao" required="required">${ordemServico.observacao}</textarea>
	        </div>
	        
	        <hr>
	        
	        <h3><fmt:message key="ordemServico.form.items"/></h3>
	        <table class="table table-striped tableItem">
	        	<thead>
	        		<tr>
	        			<th><fmt:message key="ordemServico.form.items.id"/></th>
	        			<th><fmt:message key="ordemServico.form.items.descricao"/></th>
	        			<th><fmt:message key="ordemServico.form.items.valor"/></th>
	        			<th><button type="button" onclick='javascript:$("#gridItemModal").modal();' class="btn btn-default">Adicionar Item</button></th>
	        		</tr>
	        	</thead>
	        	<tbody>
	        		<c:if test="${empty ordemServico.item}">
	        			<tr id="rowZero"><td colspan="4"><fmt:message key="ordemServico.form.items.nenhumCadastro"/></td></tr>
	        		</c:if>
	        		<c:forEach items="${ordemServico.item}" var="item">
	        			<tr>
	        				<td>${item.idItem}</td>
	        				<td>${item.categoria.descricao}</td>
	        				<td>${item.valor}</td>
	        			</tr>
	        		</c:forEach>
	        	</tbody>
	        </table>	        
			
			<div class="form-group">
				<button type="submit" class="btn btn-primary"><fmt:message key="ordemServico.form.salvar"/></button>
				<a class="btn btn-default" href="${pageContext.request.contextPath}/ordemServico"><fmt:message key="ordemServico.form.button.listagem"/></a>
			</div>
		</form:form>	
		
		<!-- Modal buscar pessoa -->
		<div id="gridBuscarPessoaModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="gridModalLabel" aria-hidden="true">
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
		
		<!-- Modal inserção de produtos -->
		<div id="gridItemModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="gridModalLabel" aria-hidden="true">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		      	<input type="hidden" id="idProdutoExclud" name="id">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h4 class="modal-title" id="gridModalLabel"><fmt:message key="ordemServico.form.pessoa.title"/></h4>
		      </div>
		      <div class="modal-body">
		      	<div class="form-group">
		      		<label for="descricao"><fmt:message key="ordemServico.form.descricao"/></label>
		      		<textarea class="form-control" rows="3" name="descricao" id="descricao"></textarea>
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
		        <div class="row">
					<div class="col-lg-7">
				   		<div class="input-group">
				   			<div class="form-group">
				   				<label for="idCategoria"><fmt:message key="item.form.valor"/></label>
				      			<select class="form-control selectProd" id="produtoSelected" name="idCategoria">
				      				<option></option>
				        		</select>
				        	</div>	
				   		</div>
				 	</div>
  					<div class="col-lg-5">
    					<div class="form-group">
    						<label for="quantidade"><fmt:message key="item.form.valor"/></label>    
		        			<div class="input-group">
	        					<input type="text" name="quantidade" class="form-control" id="quantidade"/>
	        					<span class="input-group-btn">
							        <button class="btn btn-primary" type="button" onclick="javascript:selectProduto();">Adicionar</button>
							      </span>
	        				</div>
	        			</div>
	        		</div>			
	        	</div>
	        	<hr>
	        	<table class="table table-striped" id="selectProd">
				  	<thead>
				  		<tr>
				  			<td><b>#</b></td>
				  			<td><b>Produto</b></td>
				  			<td><b>Quantidade</b></td>
				  			<td><b>Valor</b></td>
				  		</tr>
				  	</thead>
				  	<tbody>
				  	</tbody>
				  </table>		
				  <div class="form-group">
				  	<label for="valorItem"><fmt:message key="ordemServico.form.valorItem"/></label>
				  	<input class="form-control" type="number" name="valorItem" id="valorItem"/>
				  </div>			
			  </div>
		      <div class="modal-footer">
		      	<button type="button" class="btn btn-default" data-dismiss="modal" onclick="javascript:selectItem();"><fmt:message key="produto.modal.button.nao"/></button>
		      </div>
		    </div>
		  </div>
		</div>
	</jsp:attribute>
</tag:template>	
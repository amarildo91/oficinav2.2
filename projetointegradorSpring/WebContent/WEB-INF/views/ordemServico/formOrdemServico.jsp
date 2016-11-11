<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<tag:template id="text" name="text" title="Ordem de Servi�o">
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
			var contItem = 0;
			var produtoItem = "";
			var qtProdutoEstoque = [];
			var edit = false;
			function selectProduto(){
				if (qtProdutoEstoque.indexOf($("#produtoSelected").val()) < 0){										
					if ($("#quantidade").val() <=  $("#produtoSelected option:selected").data("quantidade")){
						
						if (edit){
							cont = contEditItemProd; 
						}
						
						qtProdutoEstoque.push($("#produtoSelected").val());
						var valorAproximado = $("#quantidade").val() * $("#produtoSelected option:selected").data("valor");
						var a = parseFloat($("#valorItem").val());
						var b =  parseFloat(valorAproximado);
						$("#valorItem").val(a + b);
						$("#spanProd .help-block").css("display", "none");
						$("#spanEstoque .help-block").css("display", "none");
						$("#selectProd tbody").append("<tr id='produto"+cont+"' data-produto="+$("#produtoSelected").val()+" data-descricao='"+$("#produtoSelected option:selected").text()+"' data-quantidade="+$("#quantidade").val()+" data-valor="+valorAproximado+" data-categoria="+$("#idCategoria").val()+">"+
													"<td>"+$("#produtoSelected").val()+"</td>"+
													"<td>"+$("#produtoSelected option:selected").text()+"</td>"+
													"<td>"+$("#quantidade").val()+"</td>"+
													"<td>"+valorAproximado+"</td>"+
													"<td><a href='javascript:removeProduto($(\"#produto"+cont+"\"));' data-cont="+cont+" data-contItem="+contItem+"><span class='glyphicon glyphicon-remove'></span></a></td>"+
												"</tr>");
						$("#idCategoria").val("");
						$("#produtoSelected").val("");
						$("#quantidade").val("");
						cont++;
					} else {
						$("#spanEstoque .help-block").css("display", "block");
						$("#produtoSelected").val("");
						$("#quantidade").val("");
					}	
				}else{
					$("#spanExists .help-block").css("display", "block");
				}
			}
			
			function removeProduto(componente){
				valor = $("#valorItem").val() - componente.data("valor");
				$("#valorItem").val(valor);
				qtProdutoEstoque.splice(qtProdutoEstoque.indexOf('"+componente.data("produto");+"'));
				componente.remove();
			}
			
			/*
			* fun��o para selecionar itens, atribui novos e itens editados
			*/
			function selectItem(){
				var validaItem = true;
				if ($.trim($("#descricao").val()) == ""){
					$("#descricaoForm").addClass("has-error");
					$("#descricaoForm .help-block").css("display", "block");
					validaItem = false;
				} 
				if($.trim($("#valorItem").val()) == ""){
					$("#valorItemForm").addClass("has-error");
					$("#valorItemForm .help-block").css("display", "block");
					validaItem = false;
				} 
				if ($("#selectProd tbody tr").length == 0){
					$("#spanProd .help-block").css("display", "block");
					validaItem = false;
				} 
				if (validaItem){
					if (!edit){
						contId = contItem + 1;
						tableItem = "";
						$("#rowZero").remove();
						tableItem += "<tr>"+
											"<td>"+contId+"</td>"+
											"<td>"+$("#descricao").val()+"</td>"+
											"<td>"+$("#valorItem").val()+"</td>"+
											"<td><a href=\"javascript:editItem($('#item"+contItem+"'));\" id='item"+contItem+"' data-contitem='"+contItem+"' data-contproduto='"+cont+"'><span class='glyphicon glyphicon-pencil'></span></a></td>"+
											"<td><span class='glyphicon glyphicon-remove'></span></td>"+
										"</tr>";
						$(".tableItem tbody").html(tableProduto);
						for (i=0;i<cont;i++){
							if ($("#produto"+i).length > 0){
								produtoItem += 
							           "<input type='hidden' name='item["+contItem+"].listProduto["+i+"].produto.id' value='"+$("#produto"+i).data("produto")+"' id='item"+contItem+"_produtoId"+i+"'/>"
									  +"<input type='hidden' name='item["+contItem+"].listProduto["+i+"].produto.descricao' value='"+$("#produto"+i).data("descricao")+"' id='item"+contItem+"_descricao"+i+"'/>"
									  +"<input type='hidden' name='item["+contItem+"].listProduto["+i+"].produto.valor' value='"+$("#produto"+i).data("valor")+"' id='item"+contItem+"_valor"+i+"'/>"
									  +"<input type='hidden' name='item["+contItem+"].listProduto["+i+"].quantidadeProduto' value='"+$("#produto"+i).data("quantidade")+"' id='item"+contItem+"_quantidade"+i+"'/>"
									  +"<input type='hidden' name='item["+contItem+"].listProduto["+i+"].produto.idCategoria' value='"+$("#produto"+i).data("categoria")+"' id='item"+contItem+"_idCategoria"+i+"'/>";
							}		  
						}
						
						$("#formItem").append("<input type='hidden' name='item["+contItem+"].valorItem' value='"+$("#valorItem").val()+"' id='valorItem"+contItem+"'/>");
						$("#formItem").append("<input type='hidden' name='item["+contItem+"].descricao' value='"+$("#descricao").val()+"' id='descricao"+contItem+"'/>");
						$("#formItem").append("<input type='hidden' name='item["+contItem+"].idItem' value='0' id='idItem"+contItem+"'/>");
						$("#formItem").append(produtoItem);
						produtoItem = "";
						$("#descricao").val("");
						$("#valorItem").val(0);
						$("#selectProd tbody tr").remove();
						$("#gridItemModal").modal('hide');
						cont=0;
						qtProdutoEstoque = [];
						contItem++;
					} else {						
						$("#valorItem"+contEditItem).val($("#valorItem").val());
						$("#descricao"+contEditItem).val($("#descricao").val());
						$("#item0").data("contproduto", cont);
						tableItem = "<td>"+$("#itemProduto"+contEditItem).data("id")+"</td>"+
									"<td>"+$("#descricao").val()+"</td>"+
									"<td>"+$("#valorItem").val()+"</td>"+
									"<td><a href=\"javascript:editItem($('#item"+contEditItem+"'));\" id='item"+contEditItem+"' data-contitem='"+contEditItem+"' data-contproduto='"+cont+"'><span class='glyphicon glyphicon-pencil'></span></a></td>"+
									"<td><span class='glyphicon glyphicon-remove'></span></td>";
						$("#itemProduto"+contEditItem).html(tableItem);
						for (i=0;i<cont;i++){
						    if ($("#item"+contEditItem+"_produtoId"+i).length > 0){
								$("#item"+contEditItem+"_produtoId"+i).val($("#produto"+i).data("produto"));
								$("#item"+contEditItem+"_descricao"+i).val($("#produto"+i).data("descricao"));
								$("#item"+contEditItem+"_valor"+i).val($("#produto"+i).data("valor"));
								$("#item"+contEditItem+"_quantidade"+i).val($("#produto"+i).data("quantidade"));
								$("#item"+contEditItem+"_idCategoria"+i).val($("#produto"+i).data("categoria"));
						    } else {
						    	produtoItem += 
							           "<input type='hidden' name='item["+contEditItem+"].listProduto["+i+"].produto.id' value='"+$("#produto"+i).data("produto")+"' id='item"+contEditItem+"_produtoId"+i+"'/>"
									  +"<input type='hidden' name='item["+contEditItem+"].listProduto["+i+"].produto.descricao' value='"+$("#produto"+i).data("descricao")+"' id='item"+contEditItem+"_descricao"+i+"'/>"
									  +"<input type='hidden' name='item["+contEditItem+"].listProduto["+i+"].produto.valor' value='"+$("#produto"+i).data("valor")+"' id='item"+contEditItem+"_valor"+i+"'/>"
									  +"<input type='hidden' name='item["+contEditItem+"].listProduto["+i+"].quantidadeProduto' value='"+$("#produto"+i).data("quantidade")+"' id='item"+contEditItem+"_quantidade"+i+"'/>"
									  +"<input type='hidden' name='item["+contEditItem+"].listProduto["+i+"].produto.idCategoria' value='"+$("#produto"+i).data("categoria")+"' id='item"+contEditItem+"_idCategoria"+i+"'/>";
						    }	
						}
						$("#formItem").append(produtoItem);
						$("#descricao").val("");
						$("#valorItem").val(0);
						$("#selectProd tbody tr").remove();
						$("#gridItemModal").modal('hide');
						produtoItem = "";
						cont++;
						qtProdutoEstoque = [];
						edit = false;
					}
				} 
			}
			
			/*
			* fun��o para edi��o de itens, possui contadores globais
			*/
			var contEditItem = 0;
			var contEditItemProd = 0;
			function editItem(componente){
				edit = true;
				itemCont = componente.data("contitem");
				prodCont = componente.data("contproduto");
				contEditItem = itemCont;
				contEditItemProd = prodCont;
				cont =  prodCont;
				$("#descricao").val($("#descricao"+itemCont).val());
				$("#valorItem").val($("#valorItem"+itemCont).val());
				tableProduto = '';
				
				for (i=0;i<prodCont;i++){
					qtProdutoEstoque.push($("#item"+itemCont+"_produtoId"+i).val());
					    tableProduto +=
					    "<tr id='produto"+i+"' data-produto="+$("#item"+itemCont+"_produtoId"+i).val()+" data-descricao='"+$("#item"+itemCont+"_descricao"+i).val()+"' data-quantidade="+$("#item"+itemCont+"_quantidade"+i).val()+" data-valor="+$("#item"+itemCont+"_valor"+i).val()+" data-categoria="+$("#item"+itemCont+"_idCategoria"+i).val()+">"+
							"<td>"+$("#item"+itemCont+"_produtoId"+i).val()+"</td>"+
							"<td>"+$("#item"+itemCont+"_descricao"+i).val()+"</td>"+
							"<td>"+$("#item"+itemCont+"_quantidade"+i).val()+"</td>"+
							"<td>"+$("#item"+itemCont+"_valor"+i).val()+"</td>"+
							"<td><a href='javascript:removeProduto($(\"#produto"+i+"\"));' data-cont="+prodCont+" data-contItem="+itemCont+"><span class='glyphicon glyphicon-remove'></span></a></td>"+
						"</tr>";
						$("#selectProd tbody").html(tableProduto);	
				}
				$("#gridItemModal").modal();
			}
			
			function addItem(){
				$("#descricao").val("");
				$("#valorItem").val(0);
				$("#selectProd tbody tr").remove();
				$("#gridItemModal").modal();
				produtoItem = "";
				cont=0;
				qtProdutoEstoque = [];
				edit = false;
			}
			
			$(document).ready(function(){
				$(".modal-body").css("max-height", "500px");
				$(".modal-body").css("overflow-y", "auto");
				$('#valorTotal').bind('keypress',mask.money);
				
				$("#descricao").click(function(){
					$("#descricaoForm").removeClass("has-error");
					$("#descricaoForm .help-block").css("display", "none");
				});
				
				$("#valorItem").click(function(){
					$("#valorItemForm").removeClass("has-error");
					$("#valorItemForm .help-block").css("display", "none");
				});
				
				$("#produtoSelected").click(function() {
					$("#spanExists .help-block").css("display", "none");
				});
				
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
	        <div class="form-group">
	        	<label for="status"><fmt:message key="ordemServico.form.status"/></label>
	        	<select class="form-control" id="status" name="status" required="required">
	        		<option></option>
			        <c:forEach items="${status}" var="st">
			        	<c:set var="selected" value=""/>
	        			<c:if test="${st eq ordemServico.status}">
	        				<c:set var="selected" value="selected"/>
	        			</c:if>
			        	<option value="${st}" ${selected}>${st}</option>
			        </c:forEach>
	        	</select>
	        </div>
	        
	        <hr>
	        
	        <h3><fmt:message key="ordemServico.form.items"/></h3>
	        <table class="table table-striped tableItem">
	        	<thead>
	        		<tr>
	        			<th><fmt:message key="ordemServico.form.items.id"/></th>
	        			<th><fmt:message key="ordemServico.form.items.descricao"/></th>
	        			<th><fmt:message key="ordemServico.form.items.valor"/></th>
	        			<th colspan="2"><button type="button" onclick='javascript:addItem();' class="btn btn-default"><span class="glyphicon glyphicon-plus"></span>&nbsp;Adicionar Item</button></th>
	        		</tr>
	        	</thead>
	        	<tbody>
	        		<c:if test="${empty ordemServico.item}">
	        			<tr id="rowZero"><td colspan="5"><fmt:message key="ordemServico.form.items.nenhumCadastro"/></td></tr>
	        		</c:if>
	        		<c:forEach items="${ordemServico.item}" var="item" varStatus="contItem">
	        			<script>
	        				if (contItem == 0){
	        					contItem = ${contItem.count};
	        				}	
	        			</script>
	        			<tr id='itemProduto${contItem.index}' data-id="${item.idItem}">
	        				<td>${item.idItem}</td>
	        				<td>${item.descricao}</td>
	        				<td>${item.valorItem}</td>
	        				<td><a href="javascript:editItem($('#item${contItem.index}'));" id='item${contItem.index}' data-contitem='${contItem.index}' data-contproduto='${contadorProduto}'><span class='glyphicon glyphicon-pencil'></span></a></td>
	        			</tr>
	        			<input type='hidden' name='item[${contItem.index}].valorItem' value="${item.valorItem}" id='valorItem${contItem.index}'/>
	        			<input type='hidden' name='item[${contItem.index}].descricao' value="${item.descricao}" id='descricao${contItem.index}'/>
	        			<input type='hidden' name='item[${contItem.index}].idItem' value='${item.idItem}' id='idItem${contItem.index}'/>
	        			
	        			<c:forEach items="${item.listProduto}" var="produto" varStatus="contProduto">
	        				<input type='hidden' name='item[${contItem.index}].listProduto[${contProduto.index}].idProdutoItem' value='${produto.idProdutoItem}' id='item${contItem.index}_produtoIdItem${contProduto.index}'/>
		        			<input type='hidden' name='item[${contItem.index}].listProduto[${contProduto.index}].produto.id' value='${produto.produto.id}' id='item${contItem.index}_produtoId${contProduto.index}'/>
						 	<input type='hidden' name='item[${contItem.index}].listProduto[${contProduto.index}].produto.descricao' value='${produto.produto.descricao}' id='item${contItem.index}_descricao${contProduto.index}'/>
							<input type='hidden' name='item[${contItem.index}].listProduto[${contProduto.index}].produto.valor' value='${produto.produto.valor}' id='item${contItem.index}_valor${contProduto.index}'/>
							<input type='hidden' name='item[${contItem.index}].listProduto[${contProduto.index}].quantidadeProduto' value='${produto.quantidadeProduto}' id='item${contItem.index}_quantidade${contProduto.index}'/>
							<input type='hidden' name='item[${contItem.index}].listProduto[${contProduto.index}].produto.idCategoria' value='${produto.produto.categoria.id}' id='item${contItem.index}_idCategoria${contProduto.index}'/> 
						</c:forEach>
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
		
		<!-- Modal inser��o de produtos -->
		<div id="gridItemModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="gridModalLabel" aria-hidden="true">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		      	<input type="hidden" id="idProdutoExclud" name="id">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h4 class="modal-title" id="gridModalLabel"><fmt:message key="ordemServico.form.pessoa.title"/></h4>
		      </div>
		      <div class="modal-body">
		      	<div class="form-group" id="descricaoForm">
		      		<label for="descricao" class="control-label"><fmt:message key="ordemServico.form.descricao"/></label>
		      		<textarea class="form-control" rows="3" name="descricao" id="descricao"></textarea>
		      		<span id='helpBlock' class='help-block' style="display:none">Preencha o campo</span>
		      	</div>		
				<div class="form-group" id="valorItemForm">
				  	<label for="valorItem" class="control-label"><fmt:message key="ordemServico.form.valorItem"/></label>
				  	<input class="form-control" type="number" name="valorItem" id="valorItem" disabled="disabled" value="0"/>
				  	<span id='helpBlock' class='help-block' style="display:none">Preencha o campo</span>
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
				      			<select class="form-control selectProd" id="produtoSelected" name="produtoSelected">
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
							        <button class="btn btn-primary" type="button" onclick="javascript:selectProduto();"><span class="glyphicon glyphicon-plus"></span>&nbsp;Adicionar</button>
							      </span>
	        				</div>
	        			</div>
	        		</div>			
	        	</div>
	        	<div class="has-error" id="spanExists"><span id="helpBlock" class="help-block" style="display:none"><b>Produto j� foi selecionado.</b></span></div>
	        	<div class="has-error" id="spanEstoque"><span id="helpBlock" class="help-block" style="display:none">N�o h� a quantidade solicitada em estoque.</span></div>
	        	<hr>
	        	<div class="has-error" id="spanProd"><span id="helpBlock" class="help-block" style="display:none">Insira produtos na tabela</span></div>
	        	<table class="table table-striped table-bordered" id="selectProd">
				  	<thead>
				  		<tr>
				  			<td><b>#</b></td>
				  			<td><b>Produto</b></td>
				  			<td><b>Quantidade</b></td>
				  			<td><b>Valor</b></td>
				  			<td></td>
				  		</tr>
				  	</thead>
				  	<tbody>
				  	</tbody>
				  </table>			
			  </div>
		      <div class="modal-footer">
		      	<button type="button" class="btn btn-primary" onclick="javascript:selectItem();"><fmt:message key="produto.modal.button.nao"/></button>
		      </div>
		    </div>
		  </div>
		</div>
		
		<!-- Modal Estoque insuficiente -->
		<div id="gridEstoqueModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="gridModalLabel" aria-hidden="true">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		      	<input type="hidden" id="idCompromissoExclud" name="id">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h4 class="modal-title" id="gridModalLabel"><fmt:message key="home.titulo"/></h4>
		      </div>
		      <div class="modal-body">
			      	<h4 class="modal-title" id="gridModalLabel" align="center"><img src="${pageContext.request.contextPath}/bootstrap-dist/img/warning-icon.png" width="50px"><fmt:message key="home.motal.titulo.excluir"/></h4>
			      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal"><fmt:message key="home.modal.button.nao"/></button>
		        <button type="submit" class="btn btn-primary"><fmt:message key="home.modal.button.sim"/></button>
		      </div>
		    </div>
		  </div>
		</div>
	</jsp:attribute>
</tag:template>	
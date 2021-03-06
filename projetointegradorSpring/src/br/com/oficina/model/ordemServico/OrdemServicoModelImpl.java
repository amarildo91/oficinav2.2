package br.com.oficina.model.ordemservico;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;

import br.com.oficina.beans.CategoriaOrdemServico;
import br.com.oficina.beans.ItemOrdemServico;
import br.com.oficina.beans.OrdemServico;
import br.com.oficina.beans.Pessoa;
import br.com.oficina.beans.Produto;
import br.com.oficina.beans.ProdutoItem;
import br.com.oficina.dao.GenericoDao;
import br.com.oficina.utils.FabricaConexao;

public class OrdemServicoModelImpl {

	static EntityManager em = FabricaConexao.getEntityManager();
	static GenericoDao<OrdemServico> daoOrdem = new GenericoDao<OrdemServico>(OrdemServico.class);
	static GenericoDao<ItemOrdemServico> daoItem = new GenericoDao<ItemOrdemServico>(ItemOrdemServico.class);
	
	@SuppressWarnings("unchecked")
	public List<OrdemServico> listAllOrdemServico(){
		System.out.println("listAllOrdemServico() - enter");
		List<OrdemServico> listOS = new ArrayList<OrdemServico>();
		try {
			listOS = em.createQuery("from OrdemServico order by id desc").getResultList();
		} catch (Exception e) {
			System.out.println("listAllOrdemServico() - ERRO: " + e.getMessage());
		}
		return listOS;
	}
	
	@SuppressWarnings("unchecked")
	public List<Pessoa> listAllPessoa(){
		System.out.println("listAllPessoa() - enter");
		List<Pessoa> listPessoa = new ArrayList<Pessoa>();
		try {
			listPessoa = em.createQuery("from Pessoa").getResultList();
		} catch (Exception e) {
			System.out.println("listAllPessoa() - ERRO: " + e.getMessage());
		}
		return listPessoa;
	}
	
	public CategoriaOrdemServico getCategoriaById(Long id){
		System.out.println("getCategoriaById(Long id) - enter");
		CategoriaOrdemServico categoria = new CategoriaOrdemServico();
		try {
			categoria = em.find(CategoriaOrdemServico.class, id);
		} catch (Exception e) {
			System.out.println("getCategoriaById(Long id) - ERRO: " + e.getMessage());
		}
		return categoria;
	}
	
	public Pessoa getPessoaById(Long id){
		System.out.println("getPessoaById(Long id) - enter");
		Pessoa pessoa = new Pessoa();
		try {
			pessoa = em.find(Pessoa.class, id);
		} catch (Exception e) {
			System.out.println("getPessoaById(Long id) - ERRO: " + e.getMessage());
		}
		return pessoa;
	}
	
	/*
	 * calcula quantidade de produtos existentes em cada item
	 */
	public Map<Long, Integer> getIndiceProduto(List<ItemOrdemServico> item){
		System.out.println("getIndiceProduto(List<ItemOrdemServico> item) - enter");
		Map<Long, Integer> indiceProduto = new HashMap<Long, Integer>();
		for (int i=0; i < item.size(); i++){
			int indice = 0;
			for (int j=0; j < item.get(i).getListProduto().size(); j++){
				indice++;
				indiceProduto.put(item.get(i).getIdItem(), indice);
			}
		}
		return indiceProduto;
	}
	
	public boolean persistOrdemServico(OrdemServico ordemServico){
		System.out.println("persitOrdemServico(OrdemServico ordemServico) - enter");
		boolean persist = false;
		GenericoDao<ProdutoItem> daoPrdItem = new GenericoDao<ProdutoItem>(ProdutoItem.class);
		try {
			DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			Date date = (Date)formatter.parse(ordemServico.getData());
			ordemServico.setDtOrdemServico(date);
			/*
			 * valida itens de ordem de servico, os mesmos ser�o salvos separadamente
			 */
			for (int i=0;i<ordemServico.getItem().size();i++){
				if (!ordemServico.getItem().get(i).getDescricao().isEmpty()){
					for (int j=0;j<ordemServico.getItem().get(i).getListProduto().size();j++){
						if (ordemServico.getItem().get(i).getListProduto().get(j).getProduto().getId() == 0){
							ordemServico.getItem().get(i).getListProduto().remove(j);
						}
						// atualiza estoque
						Long idProduto = ordemServico.getItem().get(i).getListProduto().get(j).getProduto().getId();
						this.updateQtProduto(idProduto, (ProdutoItem)ordemServico.getItem().get(i).getListProduto().get(j), false);
						
						if (ordemServico.getItem().get(i).getListProduto().get(j).getIdProdutoItem() == 0) {
							daoPrdItem.persist(ordemServico.getItem().get(i).getListProduto().get(j));
						} else {
							daoPrdItem.merge(ordemServico.getItem().get(i).getListProduto().get(j));
						}
					}
				}
				if (ordemServico.getItem().get(i).getIdItem() == 0){
					daoItem.persist(ordemServico.getItem().get(i));
				} else {
					daoItem.merge(ordemServico.getItem().get(i));
				}
			}
			daoOrdem.merge(ordemServico);
			persist = true;
		} catch (Exception e) {
			System.out.println("persitOrdemServico(OrdemServico ordemServico) - ERRO: " + e.getMessage());
		}
		return persist;
	}
	/*
	 * Atualiza estoque de produto
	 */
	public void updateQtProduto(Long idProduto, ProdutoItem prdItem, boolean remove) throws Exception {
		System.out.println("updateQtProduto(Produto produto) - enter");
		GenericoDao<Produto> daoProd = new GenericoDao<Produto>(Produto.class);
		try {
			Produto produtoEstoque = em.find(Produto.class, idProduto);
			double prdItemQt = em.find(ProdutoItem.class, prdItem.getIdProdutoItem()) != null ? em.find(ProdutoItem.class, prdItem.getIdProdutoItem()).getQuantidadeProduto() : 0;
			double qt = 0;
			
			// valida se produto foi alterado
			if (prdItemQt >= 0 && prdItemQt != prdItem.getQuantidadeProduto()){
				if (!remove){
					qt = prdItem.getQuantidadeProduto() - prdItemQt;
					qt = produtoEstoque.getQuantidade() - qt;
				} else {
					qt = produtoEstoque.getQuantidade() + prdItem.getQuantidadeProduto();
				}
				produtoEstoque.setQuantidade(qt);
				daoProd.merge(produtoEstoque);		
			}			
		} catch (Exception e) {
			System.out.println("updateQtProduto(Produto produto) - ERRO: " + e.getMessage());
			throw e;
		}
	}
	
	public OrdemServico getOrdemServicoById(Long id){
		System.out.println("getOrdemServicoById(Long id) - enter");
		
		OrdemServico ordem = new OrdemServico();
		try {
			ordem = em.find(OrdemServico.class, id);
		} catch (Exception e) {
			System.out.println("getOrdemServicoById(Long id) - ERRO: " + e.getMessage());
		}
		return ordem;
	}
	
	@SuppressWarnings("unchecked")
	public List<Produto> listAllProduto(){
		System.out.println("listAllProduto() - enter");
		
		List<Produto> listProduto = new ArrayList<Produto>();
		try {
			listProduto = em.createQuery("from Produto").getResultList();
		} catch (Exception e) {
			System.out.println("listAllProduto() - ERRO: " + e.getMessage());
		}
		return listProduto;
	}
	
	@SuppressWarnings("unchecked")
	public List<CategoriaOrdemServico> listAllCategoria(){
		System.out.println("listAllCategoria() - enter");
		
		List<CategoriaOrdemServico> listCAtegoria = new ArrayList<CategoriaOrdemServico>();
		try {
			listCAtegoria = em.createQuery("from CategoriaOrdemServico").getResultList();
		} catch (Exception e) {
			System.out.println("listAllCategoria() - enter");
		}
		return listCAtegoria;
	}
	
	@SuppressWarnings("unchecked")
	public String buscarProduto(Long id){
		List<Produto> listProduto = new ArrayList<Produto>();
		String option = "<option></option>";
		try {
			listProduto = em.createQuery("from Produto where categoria.id = "+ id).getResultList();
			for (Produto produto : listProduto){
				option += "<option value=\""+produto.getId()+"\" data-valor=\""+produto.getValor()+"\" data-quantidade=\""+produto.getQuantidade()+"\">"+produto.getDescricao()+"</option>";
			}
		} catch (Exception e) {
			System.out.println("buscarProduto(Long id) - ERRO: " +e.getMessage());
		}
		return option;
	}
	
	/*
	 * m�todo exclui produtoItem em chamada ajax
	 */
	public String excluirProdutoItem(Long id, Long idItem){
		Long idProdutoItem = em.find(ProdutoItem.class, id) != null ? em.find(ProdutoItem.class, id).getIdProdutoItem() : 0;
		GenericoDao<ProdutoItem> daoProd = new GenericoDao<ProdutoItem>(ProdutoItem.class);
		int success = 0;
		int exists = 0;
		try{
			if (idProdutoItem > 0){
				exists = 1;
				ItemOrdemServico item = em.find(ItemOrdemServico.class, idItem);
				for (int i=0; i < item.getListProduto().size(); i++){
					if (item.getListProduto().get(i).getIdProdutoItem() == id){
						item.getListProduto().remove(i);
						daoItem.merge(item);
					}
				}
				daoProd.removeById(idProdutoItem);
				success = 1;
			}
		} catch (Exception e){
			System.out.println("excluirProduto(Long id) - ERRO: " + e.getMessage());
		}
		return "success="+success+";exists="+exists;
	}
	
	public boolean mergeItem(ItemOrdemServico item){
		System.out.println("mergeItem(ItemOrdemServico item) - enter");
		
		boolean merge = false;
		try {
			daoItem.merge(item);
			merge = true;
		} catch (Exception e) {
			System.out.println("mergeItem(ItemOrdemServico item) - ERRO: " + e.getMessage());
		}
		return merge;
	}
	/*
	 * delete itens ordem de servi�o
	 */
	public boolean deleteItem(OrdemServico ordemServico, Long idItem){
		System.out.println("deleteItem(OrdemServico ordem) - enter");
		
		boolean delete = false;
		GenericoDao<ProdutoItem> daoPrdItem = new GenericoDao<ProdutoItem>(ProdutoItem.class);
		try {
			for (int i=0; i<ordemServico.getItem().size(); i++){
				if (ordemServico.getItem().get(i).getIdItem() == idItem){
					for (int j=0; j<ordemServico.getItem().get(i).getListProduto().size(); j++){
						/*
						 * intancia ProdutoItem para atualiza��o de estoque
						 * remove ProdutoItem de item e atualiza a base de dados
						 */
						ProdutoItem produtoItem = ordemServico.getItem().get(i).getListProduto().get(j);
						Produto produtoRemove = ordemServico.getItem().get(i).getListProduto().get(j).getProduto();
						ordemServico.getItem().get(i).getListProduto().remove(j);
						daoItem.merge(ordemServico.getItem().get(i));
						
						// remove ProdutoItem
						daoPrdItem.remove(produtoItem);
						// atualiza estoque
						this.updateQtProduto(produtoRemove.getId(), produtoItem, true);
					}
					// exclui item
					ItemOrdemServico item = ordemServico.getItem().get(i);
					ordemServico.getItem().remove(i);
					ordemServico.setValorTotal(ordemServico.getValorTotal() - item.getValorItem());
					daoOrdem.merge(ordemServico);
					daoItem.removeById(item.getIdItem());
				}
			}
			delete = true;
		} catch (Exception e) {
			System.out.println("deleteItem(OrdemServico ordem) - ERRO: "+ e.getMessage());
		}
		return delete;
	}
}

package br.com.oficina.model.produto;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;

import br.com.oficina.beans.CategoriaOrdemServico;
import br.com.oficina.beans.OrdemServico;
import br.com.oficina.beans.Produto;
import br.com.oficina.dao.GenericoDao;
import br.com.oficina.utils.FabricaConexao;

public class ProdutoModelImpl {
	
	@SuppressWarnings("unchecked")
	public List<CategoriaOrdemServico> listAllCategorias(){
		System.out.println("listAllCategorias() - enter");
		
		EntityManager em = FabricaConexao.getEntityManager();
		List<CategoriaOrdemServico> listCategoria = new ArrayList<CategoriaOrdemServico>();
		try {
			listCategoria = em.createQuery("from CategoriaOrdemServico").getResultList();
		} catch (Exception e) {
			System.out.println("listAllCategoria() - ERRO: " + e.getMessage());
		}
		return listCategoria;
	}
	
	@SuppressWarnings("unchecked")
	public List<Produto> listAllProdutos(){
		System.out.println("listAllProdutos() - enter");
		
		EntityManager em = FabricaConexao.getEntityManager();
		List<Produto> listProduto = new ArrayList<Produto>();
		try {
			listProduto = em.createQuery("from Produto order by id").getResultList();
		} catch (Exception e) {
			System.out.println("listAllProdutos() - ERRO: " + e.getMessage());
		}
		return listProduto;
	}
	
	public boolean persistProduto(Produto produto){
		System.out.println("persistProduto(Produto produto) - enter");
		
		boolean persist = false;
		GenericoDao<Produto> dao = new GenericoDao<Produto>(Produto.class);
		EntityManager em = FabricaConexao.getEntityManager();
		try {
			CategoriaOrdemServico categoria = em.find(CategoriaOrdemServico.class, produto.getIdCategoriaOrdem());		
			produto.setCategoria(categoria);
			dao.persist(produto);
			persist = true;
			
		} catch (Exception e) {
			System.out.println("persistProduto(Produto produto) - ERRO: " + e.getMessage());
		}
		return persist;
	}
	
	public boolean editProduto(Produto produto){
		System.out.println("editProduto(Produto produto) - enter");
		
		boolean merge = false;
		GenericoDao<Produto> dao = new GenericoDao<Produto>(Produto.class);
		EntityManager em = FabricaConexao.getEntityManager();
		CategoriaOrdemServico categoria = em.find(CategoriaOrdemServico.class, produto.getIdCategoriaOrdem());
		try {
			produto.setCategoria(categoria);
			dao.merge(produto);
			merge = true;			
		} catch (Exception e) {
			System.out.println("editProduto(Produto produto) - ERRO: " + e.getMessage());
		}
		return merge;
	}
	
	public boolean removeProdutoById(Long id){
		System.out.println("removeProdutoById(Long id) - enter");
		
		boolean remove = false;
		GenericoDao<Produto> dao = new GenericoDao<Produto>(Produto.class);
		try {
			dao.removeById(id);
			remove = true;			
		} catch (Exception e) {
			System.out.println("removeProdutoById(Long id) - ERRO: " + e.getMessage());
		}
		return remove;
	}
	
	public double getQuantidadeEstoque(Long id, double qtAdicaoProduto){
		System.out.println("getQuantidadeEstoque(Long id, double qtAdicaoProduto) - enter");
		
		EntityManager em = FabricaConexao.getEntityManager();
		double quantidade = 0.0;
		try {
			Produto produto = em.find(Produto.class, id);
			if (produto != null){
				quantidade = produto.getQuantidade();
			}
			quantidade += qtAdicaoProduto;
		} catch (Exception e) {
			System.out.println("getQuantidadeEstoque(Long id, double qtAdicaoProduto) - ERRO: " +e.getMessage());
		}
		return quantidade;
	}
	
	public List<OrdemServico> reportOrdemServicoProdutos(Long idProduto, String dtInicio, String dtFim){
		System.out.println("reportOrdemServicoProdutos(Long idProduto, Long idCategoria, String dtInicio, String dtFim) - enter");
		
		EntityManager em = FabricaConexao.getEntityManager();
		List<OrdemServico> listResult = new ArrayList<>();
		try {
			DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");					
			
			String osReport = "select os from OrdemServico os "
					       	 + " join os.item it "
					         + " join it.listProduto lp"
						    + " where os.status != 3 ";
			//valida datas
			if (!dtInicio.isEmpty()){
				osReport += "and os.dtOrdemServico >= :dateInicio";
			}
			if (!dtFim.isEmpty()){
				osReport += "and os.dtOrdemServico <= :dateFim";
			}
			osReport += " order by lp.produto.id";
						
			List<OrdemServico> listOrdem = new ArrayList<>();
			TypedQuery<OrdemServico> lQuery = em.createQuery(osReport, OrdemServico.class);
			
			// filtra datas
			if (!dtInicio.isEmpty()){
				Date dateInicio = ((Date)formatter.parse(dtInicio));
				lQuery.setParameter("dateInicio", dateInicio); 
			}	
			if (!dtFim.isEmpty()){
				Date dateFim = (Date)formatter.parse(dtFim);
				lQuery.setParameter("dateFim", dateFim);
			}
			
			listOrdem = lQuery.getResultList();
			
			// filtro por produto
			if (idProduto != null){
				
				//lista de filtro
				List<OrdemServico> listFilter = new ArrayList<>();
				for (OrdemServico ordem : listOrdem){
					for (int i=0; i < ordem.getItem().size(); i++){
						for (int j=0; j < ordem.getItem().get(i).getListProduto().size(); j++){
							if (ordem.getItem().get(i).getListProduto().get(j).getProduto().getId() != idProduto){
								ordem.getItem().get(i).getListProduto().remove(j);
							} else if (ordem.getItem().get(i).getListProduto().get(j).getProduto().getId() == idProduto){								
								listFilter.add(ordem);								
							}
						}
					}
				}
				listOrdem = listFilter;
			} 			
			// elimina duplicação de list
			listOrdem = new ArrayList<OrdemServico>(new HashSet<>(listOrdem));
			listResult = listOrdem;
		} catch (Exception e) {
			System.out.println("reportOrdemServicoProdutos(Long idProduto, String dtInicio, String dtFim) - ERRO: "+e.getMessage());
		}
		return listResult;
	}

}

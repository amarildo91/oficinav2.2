package br.com.oficina.model.produto;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;

import br.com.oficina.beans.CategoriaOrdemServico;
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
			listProduto = em.createQuery("from Produto").getResultList();
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

}

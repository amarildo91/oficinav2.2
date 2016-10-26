package br.com.oficina.model.categoria;

import java.util.List;

import javax.persistence.EntityManager;

import br.com.oficina.beans.CategoriaOrdemServico;
import br.com.oficina.dao.GenericoDao;
import br.com.oficina.utils.FabricaConexao;

public class CategoriaModelImpl {
	
	@SuppressWarnings("unchecked")
	public List<CategoriaOrdemServico> listAllCategorias(){
		System.out.println("listAllCategorias() - enter");
		EntityManager em = FabricaConexao.getEntityManager();
		
		List<CategoriaOrdemServico> categoriaList = em.createQuery("from CategoriaOrdemServico order by descricao").getResultList();
		
		return categoriaList;
	}
	
	public boolean persistCategoria(CategoriaOrdemServico categoria){
		System.out.println("persistCategoria(CategoriaOrdemServico categoria) - enter");
		
		boolean persist = false;
		GenericoDao<CategoriaOrdemServico> dao = new GenericoDao<CategoriaOrdemServico>(CategoriaOrdemServico.class);
		try {
			dao.persist(categoria);
			persist = true;
		} catch (Exception e) {
			System.out.println("persistCategoria(CategoriaOrdemServico categoria) - ERRO: " + e.getMessage());
		}
		return persist;
	}
	
	public boolean editCategoria(CategoriaOrdemServico categoria){
		System.out.println("editCategoria(CategoriaOrdemServico categoria) - enter");
		
		boolean merge = false;
		GenericoDao<CategoriaOrdemServico> dao = new GenericoDao<CategoriaOrdemServico>(CategoriaOrdemServico.class);
		try {
			dao.merge(categoria);
			merge = true;
		} catch (Exception e) {
			System.out.println("editCategoria(CategoriaOrdemServico categoria) - ERRO: " + e.getMessage());
		}
		return merge;
	}
	
	public boolean removeCategoriaById(Long id){
		System.out.println("removeCategoriaById(Long id) - enter");
		
		boolean remove = false;
		GenericoDao<CategoriaOrdemServico> dao = new GenericoDao<CategoriaOrdemServico>(CategoriaOrdemServico.class);
		try {
			dao.removeById(id);
			remove = true;
		} catch (Exception e) {
			System.out.println("removeCategoriaById(Long id) - ERRO: " + e.getMessage());
		}
		return remove;
	}

}

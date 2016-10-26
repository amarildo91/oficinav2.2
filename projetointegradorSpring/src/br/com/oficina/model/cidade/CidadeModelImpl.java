package br.com.oficina.model.cidade;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.Query;

import br.com.oficina.beans.Cidade;
import br.com.oficina.beans.Uf;
import br.com.oficina.dao.GenericoDao;
import br.com.oficina.utils.FabricaConexao;

public class CidadeModelImpl {

	
	@SuppressWarnings("unchecked")
	public List<Uf> getAllUf(){
		
		List<Uf> ufList = new ArrayList<Uf>();
		EntityManager em = FabricaConexao.getEntityManager();
		try {
			Query query = em.createQuery("from Uf");
			ufList = query.getResultList();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ufList;
	}
	
	@SuppressWarnings("unchecked")
	public List<Cidade> getAllCidade(){
		
		List<Cidade> cidadeList = new ArrayList<Cidade>();
		EntityManager em = FabricaConexao.getEntityManager();
		try {
			Query query = em.createQuery("from Cidade order by nome");
			cidadeList = query.getResultList();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cidadeList;
	}
	
	public boolean persistCidade(Cidade cidade){
		System.out.println("persistCidade(Cidade cidade) - enter");
		
		boolean persist = false;
		EntityManager em = FabricaConexao.getEntityManager();
		Uf uf = new Uf();
		uf = em.find(Uf.class, cidade.getIdUf());
		
		GenericoDao<Cidade> dao = new GenericoDao<Cidade>(Cidade.class);
		try {
			cidade.setUf(uf);
			dao.persist(cidade);
			persist = true;
		} catch (Exception e) {
			System.out.println("persistCidade(Cidade cidade) - ERRO:" + e.getMessage());
		}
		return persist;
	}
	
	public boolean editCidade(Cidade cidade){
		System.out.println("editCidade(Cidade cidade) - enter");
		
		boolean merge = false;
		EntityManager em = FabricaConexao.getEntityManager();
		Uf uf = em.find(Uf.class, cidade.getIdUf());
		
		GenericoDao<Cidade> dao = new GenericoDao<Cidade>(Cidade.class);
		try {
			cidade.setUf(uf);
			dao.merge(cidade);
			merge = true;
		} catch (Exception e) {
			System.out.println("editCidade(Cidade cidade) -ERRO:" + e.getMessage());
		}
		return merge;
	}
	
	public boolean removeCidadeById(Long  id){
		System.out.println("removeCidadeById(Long  id) - enter");
		
		boolean removido = false;
		GenericoDao<Cidade> dao = new GenericoDao<Cidade>(Cidade.class);
		try {
			dao.removeById(id);
			removido = true;
		} catch (Exception e) {
			System.out.println("removeCidadeById(Long  id) - ERRO:" + e.getMessage());
		}
		return removido;
	}
}
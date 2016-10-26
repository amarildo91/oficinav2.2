package br.com.oficina.model.ordemServico;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;

import br.com.oficina.beans.CategoriaOrdemServico;
import br.com.oficina.beans.ItemOrdemServico;
import br.com.oficina.beans.OrdemServico;
import br.com.oficina.beans.Pessoa;
import br.com.oficina.beans.Produto;
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
			listOS = em.createQuery("from OrdemServico").getResultList();
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
	
	public boolean persitOrdemServico(OrdemServico ordemServico){
		System.out.println("persitOrdemServico(OrdemServico ordemServico) - enter");
		boolean persist = false;
		try {
			DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			Date date = (Date)formatter.parse(ordemServico.getData());
			ordemServico.setDtOrdemServico(date);
			
			daoOrdem.persist(ordemServico);
			persist = true;
		} catch (Exception e) {
			System.out.println("persitOrdemServico(OrdemServico ordemServico) - ERRO: " + e.getMessage());
		}
		return persist;
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
	
	public boolean mergeOrdemServico(OrdemServico ordemServico){
		System.out.println("mergeOrdemServico(OrdemServico ordemServico) - enter");
		
		boolean merge = false;
		try {
			DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			Date date = (Date)formatter.parse(ordemServico.getData());
			ordemServico.setDtOrdemServico(date);
			
			daoOrdem.merge(ordemServico);
			merge = true;
		} catch (Exception e) {
			System.out.println("mergeOrdemServico(OrdemServico ordemServico) - ERRO: " + e.getMessage());
		}		
		return merge;
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
				option += "<option value=\""+produto.getId()+"\" data-valor=\""+produto.getValor()+"\">"+produto.getDescricao()+"</option>";
			}
		} catch (Exception e) {
			System.out.println("buscarProduto(Long id) - ERRO: " +e.getMessage());
		}
		return option;
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
}

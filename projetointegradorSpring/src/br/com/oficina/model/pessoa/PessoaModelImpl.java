package br.com.oficina.model.pessoa;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;

import br.com.oficina.beans.Cidade;
import br.com.oficina.beans.Endereco;
import br.com.oficina.beans.Pessoa;
import br.com.oficina.dao.GenericoDao;
import br.com.oficina.utils.FabricaConexao;

public class PessoaModelImpl {

	@SuppressWarnings("unchecked")
	public List<Pessoa> listAllPessoas(){
		System.out.println("listAllPessoas() - enter");
		
		EntityManager em = FabricaConexao.getEntityManager();
		List<Pessoa> listPessoa = new ArrayList<Pessoa>();
		try {
			listPessoa = em.createQuery("from Pessoa").getResultList();
			
		} catch (Exception e) {
			System.out.println("listAllPessoas() - ERRO: "+e.getMessage());
		}
		return listPessoa;
	}
	
	@SuppressWarnings("unchecked")
	public List<Cidade> listCidade(){
		System.out.println("listCidade() - enter");
		
		EntityManager em = FabricaConexao.getEntityManager();
		List<Cidade> cidadeList = new ArrayList<Cidade>();
		try {
			cidadeList = em.createQuery("from Cidade").getResultList();
		} catch (Exception e) {
			System.out.println("listCidade() - ERRO: " + e.getMessage());
		}
		return cidadeList;
	}
	
	public boolean persistPessoa(Pessoa pessoa, Endereco endereco){
		System.out.println("persistPessoa(Pessoa pessoa, Endereco endereco) - enter");
		
		boolean persist = false;
		GenericoDao<Pessoa> dao = new GenericoDao<Pessoa>(Pessoa.class);
		GenericoDao<Endereco> daoEnd = new GenericoDao<Endereco>(Endereco.class);
		EntityManager em = FabricaConexao.getEntityManager();
		try {
			DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			Date date = (Date)formatter.parse(pessoa.getData());
			pessoa.setDtNascimento(date);
			
			Cidade cidade = em.find(Cidade.class, endereco.getIdCidade());
			endereco.setCidade(cidade);
			daoEnd.persist(endereco);
			pessoa.setEndereco(endereco);
			
			dao.persist(pessoa);
			persist = true;
		} catch (Exception e) {
			System.out.println("persistPessoa(Pessoa pessoa) - ERRO: " +e.getMessage());
		}
		return persist;
	}
	
	public Pessoa getPessoaById(Long id){
		System.out.println("getPessoaById(Long id) - enter");
		
		Pessoa pessoa = new Pessoa();
		EntityManager em = FabricaConexao.getEntityManager();
		try {
			pessoa = em.find(Pessoa.class, id);
			pessoa.setData(pessoa.getDtNascimento().toString());
		} catch (Exception e) {
			System.out.println("getPessoaById(Long id) - enter");
		}
		return pessoa;
	}
	
	public boolean removePessoaById(Long id){
		System.out.println("removePessoaById(Long id) - enter");
		
		boolean remove = false;
		GenericoDao<Pessoa> dao = new GenericoDao<Pessoa>(Pessoa.class);
		GenericoDao<Endereco> daoEnd = new GenericoDao<Endereco>(Endereco.class);
		EntityManager em = FabricaConexao.getEntityManager();
		try {
			Pessoa pessoa = em.find(Pessoa.class, id);
			Endereco endereco = pessoa.getEndereco();
			dao.removeById(id);
			if (endereco.getId() > 0){
				daoEnd.removeById(endereco.getId());
			}	
			remove = true;
		} catch (Exception e) {
			System.out.println("removePessoaById(Long id) - ERRO: " + e.getMessage());
		}
		return remove;
	}
	
	public boolean editPessoa(Pessoa pessoa, Endereco endereco){
		System.out.println("editPessoa(Pessoa pessoa, Endereco endereco) - enter");
		
		boolean merge = false;
		GenericoDao<Pessoa> dao = new GenericoDao<Pessoa>(Pessoa.class);
		GenericoDao<Endereco> daoEnd = new GenericoDao<Endereco>(Endereco.class);
		EntityManager em = FabricaConexao.getEntityManager();
		try {
			DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			Date date = (Date)formatter.parse(pessoa.getData());
			pessoa.setDtNascimento(date);
			
			Cidade cidade = em.find(Cidade.class, endereco.getIdCidade());
			endereco.setCidade(cidade);
			
			dao.merge(pessoa);
			daoEnd.merge(endereco);
			merge = true;
		} catch (Exception e) {
			System.out.println("editPessoa(Pessoa pessoa, Endereco endereco) - ERRO: " + e.getMessage() );
		}
		return merge;
	}
}

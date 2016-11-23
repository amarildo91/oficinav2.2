package br.com.oficina.model.notafiscal;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;

import br.com.oficina.beans.NotaFiscal;
import br.com.oficina.dao.GenericoDao;
import br.com.oficina.utils.FabricaConexao;

public class NotaFiscalModelImpl {

	static EntityManager em = FabricaConexao.getEntityManager();
	static GenericoDao<NotaFiscal> nfDao = new GenericoDao<NotaFiscal>(NotaFiscal.class);
	
	@SuppressWarnings("unchecked")
	public List<NotaFiscal> listAllNotaFiscal(){
		System.out.println("listAllNotaFiscal() - enter");
		List<NotaFiscal> listNF = new ArrayList<NotaFiscal>();
		try {
			listNF = em.createQuery("from NotaFiscal order by id").getResultList();
		} catch (Exception e) {
			System.out.println("listAllNotaFiscal() - ERRO: "+e.getMessage());
		}		
		return listNF;
	}
	
	
}

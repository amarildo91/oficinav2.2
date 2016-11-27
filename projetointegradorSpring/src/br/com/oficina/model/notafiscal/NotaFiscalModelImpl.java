package br.com.oficina.model.notafiscal;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.Query;

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
			listNF = em.createQuery("from NotaFiscal where status = null order by id desc").getResultList();
		} catch (Exception e) {
			System.out.println("listAllNotaFiscal() - ERRO: "+e.getMessage());
		}		
		return listNF;
	}
	
	public NotaFiscal getNotaFiscalById(Long id){
		System.out.println("getNotaFiscalById(Long id) - enter");
		NotaFiscal nf = new NotaFiscal();
		try {
			nf = em.find(NotaFiscal.class, id);
		} catch (Exception e) {
			System.out.println("getNotaFiscalById(Long id) - ERRO: " + e.getMessage());
		}
		return nf;
	}
	
	public NotaFiscal getNotaFIscalByIdOrdemServico(Long idOrdemServico){
		System.out.println("NotaFiscal getNotaFIscalByIdOrdemServico(Long idOrdemServico) - enter");
		
		NotaFiscal nf = null;
		try {
			Query query = em.createQuery("from NotaFiscal where ordemServico.idOrdemServico = '"+idOrdemServico+"' and status = null");
			if (query.getFirstResult() >= 0){
				nf = (NotaFiscal)query.getSingleResult();
			}
		} catch (Exception e) {
			System.out.println("NotaFiscal getNotaFIscalByIdOrdemServico(Long idOrdemServico) - ERRO: " + e.getMessage());
		}
		return nf;
	}
	
	public boolean persistNF(NotaFiscal notaFiscal){
		System.out.println("persistNF(NotaFiscal notaFiscal) - enter");
		boolean persist = false;
		try {
			Date date = new Date();
			notaFiscal.setDtEmissao(date);
			nfDao.merge(notaFiscal);
			persist = true;
		} catch (Exception e) {
			System.out.println("persistNF(NotaFiscal notaFiscal) - ERRO: "+e.getMessage());
		}
		return persist;
	}
}

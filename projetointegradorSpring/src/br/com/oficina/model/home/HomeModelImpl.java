package br.com.oficina.model.home;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.Query;

import br.com.oficina.beans.Compromisso;
import br.com.oficina.dao.GenericoDao;
import br.com.oficina.utils.FabricaConexao;

public class HomeModelImpl {

	
	@SuppressWarnings({ "unchecked"})
	public List<Compromisso> getAllCompromissoList(){
		System.out.println("getAllCompromissoList() - enter");
		
		EntityManager em = FabricaConexao.getEntityManager();
		List<Compromisso> listCompromissoAtivo = new ArrayList<Compromisso>();
		try {
			Query query = em.createQuery("from Compromisso order by dtCompromisso");
			List<Compromisso> list = query.getResultList();
			Calendar data = DateToCalendar(new Date(), true);
			
			for (Compromisso compromisso : list){
				Calendar dtCompromisso = DateToCalendar(compromisso.getDtCompromisso(), true);
				if (dtCompromisso != null && data.compareTo(dtCompromisso) <= 0){
					listCompromissoAtivo.add(compromisso);
				}
			}
		} catch (Exception e) {
			System.out.println("getAllCompromissoList() - ERRO:"+e.getMessage());
		}
		return listCompromissoAtivo;
	}
	
	public static Calendar DateToCalendar(Date date, boolean setTimeToZero){ 
	    Calendar calendario = Calendar.getInstance();
	    calendario.setTime(date);
	    if(setTimeToZero){
	        calendario.set(Calendar.HOUR_OF_DAY, 0);
	        calendario.set(Calendar.MINUTE, 0);
	        calendario.set(Calendar.SECOND, 0);
	        calendario.set(Calendar.MILLISECOND, 0);
	    }
	    return calendario;
	}  
	
	public boolean persistCompromisso(Compromisso compromisso){
		System.out.println("persistCompromisso(Compromisso compromisso) - enter");
		
		boolean insere = false;
		GenericoDao<Compromisso> dao = new GenericoDao<Compromisso>(Compromisso.class);
		try {
			DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			Date date = (Date)formatter.parse(compromisso.getData());
			compromisso.setDtCompromisso(date);
			dao.persist(compromisso);
			insere = true;
		} catch (Exception e) {
			System.out.println("persistCompromisso(Compromisso compromisso) - ERRO:" + e.getMessage());
		}
		return insere;
	}
	
	public boolean removeById(Long id){
		System.out.println("removeById(Long id) - enter");
		
		GenericoDao<Compromisso> dao = new GenericoDao<Compromisso>(Compromisso.class);
		boolean removido = false;
		try {
			dao.removeById(id);
			removido = true;
		} catch (Exception e) {
			System.out.println("removeById(Long id) - ERRO:" + e.getMessage());
			removido = false;
		}
		return removido;
	}
	
	public boolean editCompromisso(Compromisso compromisso){
		System.out.println("editCompromisso(Compromisso compromisso) - enter");
		
		GenericoDao<Compromisso> dao = new GenericoDao<Compromisso>(Compromisso.class);
		boolean edit = false;
		try {
			DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
			Date date = (Date)formatter.parse(compromisso.getData());
			compromisso.setDtCompromisso(date);
			dao.merge(compromisso);
			edit = true;
		} catch (Exception e) {
			System.out.println("editCompromisso(Compromisso compromisso) - ERRO:" + e.getMessage());
			edit = false;
		}
		return edit;
	}
	
	@SuppressWarnings({"unchecked" })
	public List<Compromisso> getAllCompromisso(){
		System.out.println("getAllCompromisso() - enter");
		
		EntityManager em = FabricaConexao.getEntityManager();
		List<Compromisso> list = new ArrayList<Compromisso>();
		try {
			Query query = em.createQuery("from Compromisso order by dtCompromisso");
			list = query.getResultList();
		} catch (Exception e) {
			System.out.println("getAllCompromisso() - ERRO:"+e.getMessage());
		}
		return list;
	}
}

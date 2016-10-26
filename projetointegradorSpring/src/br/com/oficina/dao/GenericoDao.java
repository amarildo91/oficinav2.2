package br.com.oficina.dao;

import java.util.List;

import javax.persistence.EntityManager;

import br.com.oficina.utils.FabricaConexao;

public class GenericoDao<T> implements InterfaceDAO<T> {

	private Class classe;
		
	public GenericoDao(Class classe) {
		super();
		this.classe = classe;
	}

	@Override
	public void persist(T instancia) throws Exception {
		EntityManager em = FabricaConexao.getEntityManager();
		try {
			em.getTransaction().begin();
			em.persist(instancia);
			em.getTransaction().commit();
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		} finally {
			em.close();
		}
	}

	@Override
	public T merge(T instancia) throws Exception {
		EntityManager em = FabricaConexao.getEntityManager();
		try {
			em.getTransaction().begin();
			instancia = em.merge(instancia);
			em.getTransaction().commit();
			return instancia;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		} finally {
			em.close();
		}
	}

	@Override
	public void remove(T instancia) throws Exception {
		EntityManager em = FabricaConexao.getEntityManager();
		try {
			em.getTransaction().begin();
			instancia = em.merge(instancia);
			em.remove(instancia);
			em.getTransaction().commit();
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		} finally {
			em.close();
		}
	}

	@Override
	public void removeById(Long id) throws Exception {
		EntityManager em = FabricaConexao.getEntityManager();
		try {
			em.getTransaction().begin();
			T instancia = (T) em.find(classe, id);
			em.remove(instancia);
			em.getTransaction().commit();
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		} finally {
			em.close();
		}
	}

	@Override
	public T getInstancia(Long id) throws Exception {
		EntityManager em = FabricaConexao.getEntityManager();
		try {
			T instancia = (T) em.find(classe, id);
			return instancia;			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		} finally {
			em.close();
		}
	}

	@Override
	public List<T> getInstanciasList() throws Exception {
		EntityManager em = FabricaConexao.getEntityManager();
		try {
			String hql = "from "+classe.getSimpleName();
			List<T> retorno = em.createQuery(hql).getResultList();
			return retorno;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		} finally{
			em.close();
		}

	}

	@Override
	public List<T> getInstanciasList(String atributoOrdem)
			throws Exception {
		EntityManager em = FabricaConexao.getEntityManager();
		try {
			String hql = "from "+classe.getSimpleName();
			// fazer ordenação
			if ((atributoOrdem!=null) && 
				(atributoOrdem.trim().length() > 0))
			   hql += " order by "+atributoOrdem;
			List<T> retorno = em.createQuery(hql).getResultList();
			return retorno;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		} finally{
			em.close();
		}

	}

	@Override
	public List<T> getInstanciasList(String atributoOrdem,
			String atributoFiltro, String valorFiltro) throws Exception {

		EntityManager em = FabricaConexao.getEntityManager();
		try {
			String hql = "from "+classe.getSimpleName();
			// fazer filtro
			if ((atributoFiltro != null) && 
			    (atributoFiltro.trim().length() > 0) &&
			    (valorFiltro != null) &&
			    (valorFiltro.trim().length() > 0)){
				hql += " where upper(cast("+atributoFiltro+" as string)) "
					+  " like '%"+valorFiltro.toUpperCase()+"%' ";
			}
			// fazer ordenação
			if ((atributoOrdem!=null) && 
				(atributoOrdem.trim().length() > 0))
			   hql += " order by "+atributoOrdem;
			List<T> retorno = em.createQuery(hql).getResultList();
			return retorno;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		} finally{
			em.close();
		}

	}

	@Override
	public List<T> getInstanciasList(String atributoOrdem,
			String atributoFiltro, String valorFiltro, Integer quantidade,
			Integer posicaoInicial) throws Exception {
		
		EntityManager em = FabricaConexao.getEntityManager();
		try {
			String hql = "from "+classe.getSimpleName();
			// fazer filtro
			if ((atributoFiltro != null) && 
			    (atributoFiltro.trim().length() > 0) &&
			    (valorFiltro != null) &&
			    (valorFiltro.trim().length() > 0)){
				hql += " where upper(cast("+atributoFiltro+" as string)) "
					+  " like '%"+valorFiltro.toUpperCase()+"%' ";
			}
			// fazer ordenação
			if ((atributoOrdem!=null) && 
				(atributoOrdem.trim().length() > 0))
			   hql += " order by "+atributoOrdem;
			// fazer paginação
			List<T> retorno = em.createQuery(hql).
					setMaxResults(quantidade).
					setFirstResult(posicaoInicial).
					getResultList();
			return retorno;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		} finally{
			em.close();
		}
		
	}

}

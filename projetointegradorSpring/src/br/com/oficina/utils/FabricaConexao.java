package br.com.oficina.utils;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

public class FabricaConexao {

private static EntityManagerFactory fabrica;
	
	public static EntityManager getEntityManager() {

		if(fabrica == null) {
			fabrica = Persistence.createEntityManagerFactory("projetointegradorJPA");
		}
		
		return fabrica.createEntityManager();
		
	}
}

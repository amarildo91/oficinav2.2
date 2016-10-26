package br.com.oficina.utils;

import javax.persistence.EntityManager;

public class CriaBanco {
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		@SuppressWarnings("unused")
		EntityManager em = FabricaConexao.getEntityManager();
	}
}

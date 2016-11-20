package br.com.oficina.utils;

public enum LoginEnum {
	ERRO_LOGIN("erro"),
	ERRO_LOGIN_MSG("login inv�lido"),
	SUCESSO_LOGIN("sucesso"),
	SUCESSO_LOGIN_MSG("Cadastrado Com Sucesso"),
	ERRO_CADASTRO_MSG("Cadastro Inv�lido, favor realizar novamente!");
	
	public final String value;
	
	private LoginEnum(String value) {
		this.value = value;
	}
}

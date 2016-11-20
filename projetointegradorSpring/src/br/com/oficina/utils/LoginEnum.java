package br.com.oficina.utils;

public enum LoginEnum {
	ERRO_LOGIN("erro"),
	ERRO_LOGIN_MSG("login inválido"),
	SUCESSO_LOGIN("sucesso"),
	SUCESSO_LOGIN_MSG("Cadastrado Com Sucesso"),
	ERRO_CADASTRO_MSG("Cadastro Inválido, favor realizar novamente!");
	
	public final String value;
	
	private LoginEnum(String value) {
		this.value = value;
	}
}

package br.com.oficina.utils;

public enum TaxasEnum {

	TAXA_ISS(0.0);
	
	public final double value;
	
	private TaxasEnum(double value) {
		this.value = value;
	}
}

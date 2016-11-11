package br.com.oficina.beans;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name="produto_item")
public class ProdutoItem {

	@Id
	@GeneratedValue
	private long idProdutoItem;
	@OneToOne
	private Produto produto;
	
	private double quantidadeProduto;

	public long getIdProdutoItem() {
		return idProdutoItem;
	}

	public void setIdProdutoItem(long idProdutoItem) {
		this.idProdutoItem = idProdutoItem;
	}

	public Produto getProduto() {
		return produto;
	}

	public void setProduto(Produto produto) {
		this.produto = produto;
	}

	public double getQuantidadeProduto() {
		return quantidadeProduto;
	}

	public void setQuantidadeProduto(double quantidadeProduto) {
		this.quantidadeProduto = quantidadeProduto;
	}
}

package br.com.oficina.beans;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

@Entity
@Table(name="item_ordem_servico")
public class ItemOrdemServico {

	@Id
	@Column(name="id")
	@SequenceGenerator(name="seq_item", sequenceName="account_item_id_seq", allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="seq_item")
	private long idItem;
	@ManyToMany(targetEntity=ProdutoItem.class)
	@JoinColumn(name="produto_item_id")
	private List<ProdutoItem> listProduto;
	private double valorItem;
	private String descricao;
	
	public String getDescricao() {
		return descricao;
	}
	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}
	public List<ProdutoItem> getListProduto() {
		return listProduto;
	}
	public void setListProduto(List<ProdutoItem> listProduto) {
		this.listProduto = listProduto;
	}
	public long getIdItem() {
		return idItem;
	}
	public void setIdItem(long idItem) {
		this.idItem = idItem;
	}	
	public double getValorItem() {
		return valorItem;
	}
	public void setValorItem(double valorItem) {
		this.valorItem = valorItem;
	}
}

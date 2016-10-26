package br.com.oficina.beans;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name="item_ordem_servico")
public class ItemOrdemServico {

	@Id
	@Column(name="id")
	@SequenceGenerator(name="seq_item", sequenceName="account_item_id_seq", allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="seq_item")
	private long idItem;
	@OneToOne
	private CategoriaOrdemServico categoria;
	@ManyToMany(targetEntity=Produto.class)
	@JoinColumn(name="produto_id",nullable=false)
	private List<Produto> listProduto;
	private double valorItem;
	private String descricao;
	
	@Transient
	private long idCategoria;
	
	public String getDescricao() {
		return descricao;
	}
	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}
	public List<Produto> getListProduto() {
		return listProduto;
	}
	public void setListProduto(List<Produto> listProduto) {
		this.listProduto = listProduto;
	}
	public long getIdCategoria() {
		return idCategoria;
	}
	public void setIdCategoria(long idCategoria) {
		this.idCategoria = idCategoria;
	}
	public long getIdItem() {
		return idItem;
	}
	public void setIdItem(long idItem) {
		this.idItem = idItem;
	}
	public CategoriaOrdemServico getCategoria() {
		return categoria;
	}
	public void setCategoria(CategoriaOrdemServico categoria) {
		this.categoria = categoria;
	}
	public double getValorItem() {
		return valorItem;
	}
	public void setValorItem(double valorItem) {
		this.valorItem = valorItem;
	}
}

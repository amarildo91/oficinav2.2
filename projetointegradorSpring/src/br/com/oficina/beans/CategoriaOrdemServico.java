package br.com.oficina.beans;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name="categoria_ordem_servico")
public class CategoriaOrdemServico {

	@Id
	/*@Column(name="id")
	@SequenceGenerator(name="seq_categoria", sequenceName="account_categoria_id_seq", allocationSize=1)*/
	@GeneratedValue/*(strategy=GenerationType.SEQUENCE, generator="seq_categoria")*/
	private long id;
	private String descricao;
	@OneToMany
	private List<Produto> produto;
	
	@Transient
	private long idProduto;
	
	public long getIdProduto() {
		return idProduto;
	}
	public List<Produto> getProduto() {
		return produto;
	}
	public void setProduto(List<Produto> produto) {
		this.produto = produto;
	}
	public void setIdProduto(long idProduto) {
		this.idProduto = idProduto;
	}
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getDescricao() {
		return descricao;
	}
	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}
}

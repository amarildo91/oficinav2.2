package br.com.oficina.beans;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name="produto")
public class Produto {

	@Id
	@Column(name="id")
	@SequenceGenerator(name="seq_produto", sequenceName="account_produto_id_seq", allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="seq_produto")
	private long id;
	private String descricao;
	private double valor;
	private int quantidade;
	@ManyToOne
	@JoinColumn(name="categoria_id",nullable=false)
	private CategoriaOrdemServico categoria;
	@Transient
	private long idCategoriaOrdem;
	
	public long getIdCategoriaOrdem() {
		return idCategoriaOrdem;
	}
	public void setIdCategoriaOrdem(long idCategoriaOrdem) {
		this.idCategoriaOrdem = idCategoriaOrdem;
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
	public double getValor() {
		return valor;
	}
	public void setValor(double valor) {
		this.valor = valor;
	}
	public int getQuantidade() {
		return quantidade;
	}
	public void setQuantidade(int quantidade) {
		this.quantidade = quantidade;
	}
	public CategoriaOrdemServico getCategoria() {
		return categoria;
	}
	public void setCategoria(CategoriaOrdemServico categoria) {
		this.categoria = categoria;
	}
}

package br.com.oficina.beans;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name="endereco")
public class Endereco {
	
	@Id
	@Column(name="id")
	@SequenceGenerator(name="seq_endereco", sequenceName="account_endereco_id_seq", allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="seq_endereco")
	private long id;
	private String rua;
	private String cep;
	@OneToOne
	private Cidade cidade;
	
	@Transient
	private long idCidade;
	
	public long getIdCidade() {
		return idCidade;
	}
	public void setIdCidade(long idCidade) {
		this.idCidade = idCidade;
	}
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getRua() {
		return rua;
	}
	public void setRua(String rua) {
		this.rua = rua;
	}
	public String getCep() {
		return cep;
	}
	public void setCep(String cep) {
		this.cep = cep;
	}
	public Cidade getCidade() {
		return cidade;
	}
	public void setCidade(Cidade cidade) {
		this.cidade = cidade;
	}
}

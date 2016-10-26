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
@Table(name="cidade")
public class Cidade {

	@Id
	@Column(name="id")
	@SequenceGenerator(name="seq_cidade", sequenceName="account_cidade_id_seq", allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="seq_cidade")
	private long id;
	private String nome;
	@OneToOne
	private Uf uf;
	
	@Transient
	private long idUf;
	
	public long getIdUf() {
		return idUf;
	}
	public void setIdUf(long idUf) {
		this.idUf = idUf;
	}
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	public Uf getUf() {
		return uf;
	}
	public void setUf(Uf uf) {
		this.uf = uf;
	}
}

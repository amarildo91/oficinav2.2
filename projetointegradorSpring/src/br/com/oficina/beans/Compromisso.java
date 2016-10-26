package br.com.oficina.beans;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

@Entity
@Table(name="Compromisso")
public class Compromisso {
	
	@Id
	@Column(name="id")
	@SequenceGenerator(name="seq_compromisso", sequenceName="account_compromisso_id_seq", allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="seq_compromisso")
	private long id;
	private String descricao;
	
	@Column(name="dt_compromisso")
	@Temporal(TemporalType.DATE)
	private Date dtCompromisso;
	
	@Transient
	private String data;
	
	public String getData() {
		return data;
	}
	public void setData(String data) {
		this.data = data;
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
	public Date getDtCompromisso() {
		return dtCompromisso;
	}
	public void setDtCompromisso(Date dtCompromisso) {
		this.dtCompromisso = dtCompromisso;
	}
}

package br.com.oficina.beans;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

@Entity
@Table(name="nota_fiscal")
public class NotaFiscal {

	@Id
	@Column(name="id")
	@SequenceGenerator(name="seq_nf", sequenceName="account_nf_id_seq", allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="seq_nf")
	private long id;
	@OneToOne
	private OrdemServico ordemServico;
	@OneToOne
	private Pessoa pessoa;
	private double vlTotal;
	
	@Column(name="dt_emissao")
	@Temporal(TemporalType.DATE)
	private Date dtEmissao;
	
	@Transient
	private String data;
	@Transient
	private long idPessoa;
	@Transient
	private long idOrdemServico;
	
	public long getIdPessoa() {
		return idPessoa;
	}
	public void setIdPessoa(long idPessoa) {
		this.idPessoa = idPessoa;
	}
	public long getIdOrdemServico() {
		return idOrdemServico;
	}
	public void setIdOrdemServico(long idOrdemServico) {
		this.idOrdemServico = idOrdemServico;
	}
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
	public OrdemServico getOrdemServico() {
		return ordemServico;
	}
	public void setOrdemServico(OrdemServico ordemServico) {
		this.ordemServico = ordemServico;
	}
	public Pessoa getPessoa() {
		return pessoa;
	}
	public void setPessoa(Pessoa pessoa) {
		this.pessoa = pessoa;
	}
	public double getVlTotal() {
		return vlTotal;
	}
	public void setVlTotal(double vlTotal) {
		this.vlTotal = vlTotal;
	}
	public Date getDtEmissao() {
		return dtEmissao;
	}
	public void setDtEmissao(Date dtEmissao) {
		this.dtEmissao = dtEmissao;
	}
}	
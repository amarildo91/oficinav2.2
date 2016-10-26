package br.com.oficina.beans;

import java.util.Date;
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
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

@Entity
@Table(name="ordem_servico")
public class OrdemServico {
	
	@Id
	@Column(name="id")
	@SequenceGenerator(name="seq_ordem", sequenceName="account_ordem_id_seq", allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="seq_ordem")
	private long idOrdemServico;
	private String observacao;
	private double valorTotal;
	
	@Column(name="dt_ordem_servico")
	@Temporal(TemporalType.DATE)
	private Date dtOrdemServico;
	
	@OneToOne
	private Pessoa pessoa;
	@ManyToMany(targetEntity=ItemOrdemServico.class)
	@JoinColumn(name="item_id",nullable=false)
	private List<ItemOrdemServico> item;
	private Status status;
	
	@Transient
    private String data;
	@Transient
	private long idItem;
	
	public long getIdItem() {
		return idItem;
	}
	public void setIdItem(long idItem) {
		this.idItem = idItem;
	}
	public String getData() {
		return data;
	}
	public void setData(String data) {
		this.data = data;
	}
	public long getIdOrdemServico() {
		return idOrdemServico;
	}
	public void setIdOrdemServico(long idOrdemServico) {
		this.idOrdemServico = idOrdemServico;
	}
	public String getObservacao() {
		return observacao;
	}
	public void setObservacao(String observacao) {
		this.observacao = observacao;
	}
	public double getValorTotal() {
		return valorTotal;
	}
	public void setValorTotal(double valorTotal) {
		this.valorTotal = valorTotal;
	}
	public Date getDtOrdemServico() {
		return dtOrdemServico;
	}
	public void setDtOrdemServico(Date dtOrdemServico) {
		this.dtOrdemServico = dtOrdemServico;
	}
	public Pessoa getPessoa() {
		return pessoa;
	}
	public void setPessoa(Pessoa pessoa) {
		this.pessoa = pessoa;
	}
	public List<ItemOrdemServico> getItem() {
		return item;
	}
	public void setItem(List<ItemOrdemServico> item) {
		this.item = item;
	}
	public Status getStatus() {
		return status;
	}
	public void setStatus(Status status) {
		this.status = status;
	}

}

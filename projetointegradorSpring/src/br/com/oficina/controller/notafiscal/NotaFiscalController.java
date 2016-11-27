package br.com.oficina.controller.notafiscal;

import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import br.com.oficina.beans.NotaFiscal;
import br.com.oficina.beans.OrdemServico;
import br.com.oficina.model.notafiscal.NotaFiscalModelImpl;
import br.com.oficina.model.ordemservico.OrdemServicoModelImpl;
import br.com.oficina.utils.Constantes;
import br.com.oficina.utils.NFStatusEnum;
import br.com.oficina.utils.TaxasEnum;

@Controller
public class NotaFiscalController {
	
	static NotaFiscalModelImpl nfModel = new NotaFiscalModelImpl();
	static OrdemServicoModelImpl ordemModel = new OrdemServicoModelImpl();
	
	@RequestMapping("/protect/notaFiscal")
	public ModelAndView begin(@RequestParam(required=false) boolean successMessage, @RequestParam(required=false) boolean insert){
		System.out.println("NotaFiscal begin(boolean successMessage, boolean insert) - enter");
		
		ModelAndView model = new ModelAndView("protect/notaFiscal/listNF");
		model.addObject("notaFiscal", nfModel.listAllNotaFiscal());		
		if (insert){
			model.addObject(Constantes.SUCCESS_INSERT , successMessage);
		}
		return model;
	}
	
	@RequestMapping(value="/protect/formNotaFiscal", method=RequestMethod.GET)
	public ModelAndView formNotaFiscal(@RequestParam("id") Long id){
		System.out.println("formNotaFiscal() - enter");
		
		ModelAndView model = new ModelAndView("protect/notaFiscal/formNF", "notaFiscal", new NotaFiscal());
		OrdemServico ordem = ordemModel.getOrdemServicoById(id);
		double descImpostoIss = (ordem.getValorTotal() * TaxasEnum.TAXA_ISS.value)/100;
		NotaFiscal nf = nfModel.getNotaFIscalByIdOrdemServico(id);
		if (nf != null){
			model.addObject("notaFiscal", nf);
		}				
		model.addObject("ordemServico", ordem);
		model.addObject("iss", TaxasEnum.TAXA_ISS.value);
		model.addObject("descontoIss", descImpostoIss);	
		model.addObject("status", NFStatusEnum.CANCELADO);
		return model;
	}
	
	@RequestMapping(value="/protect/editNotaFiscal", method=RequestMethod.GET)
	public ModelAndView editNotaFiscal(@RequestParam("id") Long id){
		System.out.println("editNotaFiscal(Long id) - enter");
		
		ModelAndView model = new ModelAndView("protect/notaFiscal/formNF");
		NotaFiscal nf = nfModel.getNotaFiscalById(id);
		OrdemServico ordem = nf.getOrdemServico();
		model.addObject("ordemServico", ordem);
		model.addObject("notaFiscal", nf);
		model.addObject("iss", TaxasEnum.TAXA_ISS.value);
		model.addObject("descontoIss", nf.getVlIss());
		model.addObject("status", NFStatusEnum.CANCELADO);
		return model;
	}
	
	@RequestMapping("/protect/gerarNotaFiscal")
	public String gerarNotaFiscal(@RequestParam(value="idOrdemServico") Long idOrdemServico, @Valid NotaFiscal notaFiscal){
		System.out.println("gerarNotaFiscal(Long idOrdemServico, NotaFiscal notaFiscal) - enter");
		
		OrdemServico ordem = ordemModel.getOrdemServicoById(idOrdemServico);
		notaFiscal.setOrdemServico(ordem);
		boolean insert = nfModel.persistNF(notaFiscal);
		return "redirect:/protect/notaFiscal?successMessage=true&insert="+insert;
	}
	
	@RequestMapping(value="/protect/notaFiscalPrint", method=RequestMethod.GET)
	public ModelAndView notaFiscalPrint(@RequestParam(value="id") Long id){
		System.out.println("notaFiscalPrint(Long id) - enter");
		
		NotaFiscal nf = nfModel.getNotaFiscalById(id);
		return new ModelAndView("pdfViewNF", "notaFiscal", nf);
	}

}

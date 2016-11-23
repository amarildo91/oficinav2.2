package br.com.oficina.controller.notafiscal;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import br.com.oficina.model.notafiscal.NotaFiscalModelImpl;
import br.com.oficina.model.ordemservico.OrdemServicoModelImpl;
import br.com.oficina.utils.Constantes;

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
	
	@RequestMapping("/protect/formNotaFiscal")
	public ModelAndView formNotaFiscal(){
		System.out.println("formNotaFiscal() - enter");
		
		ModelAndView model = new ModelAndView("protect/notaFiscal/formNF");
		model.addObject("ordemServico", ordemModel.listAllOrdemServico());
		return model;
	}

}

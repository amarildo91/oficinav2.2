package br.com.oficina.controller.cidade;

import java.util.List;

import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import br.com.oficina.beans.Cidade;
import br.com.oficina.beans.Uf;
import br.com.oficina.model.cidade.CidadeModelImpl;
import br.com.oficina.utils.Constantes;

@Controller
public class CidadeController {
	
	static CidadeModelImpl cidadeModel = new CidadeModelImpl();
	
	@RequestMapping("/cidade")
	public ModelAndView begin(@RequestParam(required=false) boolean successMessage, @RequestParam(required=false) boolean insert){
		System.out.println("begin(@RequestParam(required=false) boolean successMessage, @RequestParam(required=false) boolean insert) - enter");
		
		ModelAndView model = new ModelAndView("cidade/cidade");
		List<Uf> ufList = cidadeModel.getAllUf();
		List<Cidade> cidadeList = cidadeModel.getAllCidade();
		model.addObject("ufs", ufList);
		model.addObject("cidades", cidadeList);
		if (insert){
			model.addObject(Constantes.SUCCESS_INSERT , successMessage);
		}
		
		return model;
	}
	
	@RequestMapping(value="/cadastrarCidade", method=RequestMethod.POST)	
	public String cadastrarCidade(@ModelAttribute Cidade cidade){
		System.out.println("cadastrarCidade(Cidade cidade) - enter");
		
		boolean persist;
		persist = cidadeModel.persistCidade(cidade);
		return "redirect:cidade?insert=true&successMessage="+persist;
	}
	
	@RequestMapping(value="/editarCidade", method=RequestMethod.POST)
	public ModelAndView	editarCidade(@Valid Cidade cidade){
		System.out.println("editarCidade(Cidade cidade) - enter");
		
		ModelAndView model = new ModelAndView("cidade/cidade");
		boolean result = cidadeModel.editCidade(cidade);
		List<Uf> ufList = cidadeModel.getAllUf();
		List<Cidade> cidadeList = cidadeModel.getAllCidade();
		model.addObject("ufs", ufList);
		model.addObject("cidades", cidadeList);
		model.addObject(Constantes.SUCCESS_UPDATE, result);
		return model;
	}
	
	@RequestMapping(value="/cidade/delete", method=RequestMethod.POST)
	public ModelAndView delete(@RequestParam("id") String id){
		System.out.println("delete(String id) - enter");
		
		ModelAndView model = new ModelAndView("cidade/cidade");
		boolean removido = false;
		if (id != null){
			removido = cidadeModel.removeCidadeById(Long.parseLong(id));
		}
		
		List<Uf> ufList = cidadeModel.getAllUf();
		List<Cidade> cidadeList = cidadeModel.getAllCidade();
		model.addObject("ufs", ufList);
		model.addObject("cidades", cidadeList);
		model.addObject(Constantes.REMOVIDO, removido);
		
		return model;
		
	}	
}
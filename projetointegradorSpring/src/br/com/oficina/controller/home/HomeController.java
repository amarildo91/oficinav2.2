package br.com.oficina.controller.home;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import br.com.oficina.beans.Compromisso;
import br.com.oficina.model.home.HomeModelImpl;
import br.com.oficina.utils.Constantes;

import javax.validation.Valid;

@Controller
public class HomeController {

	static HomeModelImpl homeModel = new HomeModelImpl();	
	
	@RequestMapping("/home")
	public ModelAndView begin(@RequestParam(required=false) boolean successMessage, @RequestParam(required=false) boolean insert){
		System.out.println("begin(@RequestParam(required=false) boolean successMessage, @RequestParam(required=false) boolean insert) - enter");
		
		ModelAndView model = new ModelAndView("home");
		List<Compromisso> comp = homeModel.getAllCompromissoList();
		model.addObject("compromissos", comp);
		if (insert){
			model.addObject(Constantes.SUCCESS_INSERT , successMessage);
		}
		return model;
	}
	
	@RequestMapping(value="/agendarCompromisso", method=RequestMethod.POST)
	public String	agendarCompromisso(@Valid Compromisso compromisso){
		System.out.println("agendarCompromisso(Compromisso compromisso) - enter");
		
		boolean insert = false;
		insert = homeModel.persistCompromisso(compromisso);
		return "redirect:home?insert=true&successMessage="+insert;
	}
	
	@RequestMapping(value="/home/delete", method=RequestMethod.POST)
	public ModelAndView delete(@RequestParam("id") String id){
		System.out.println("delete(String id) - enter");
		
		boolean removido = false;
		ModelAndView model = new ModelAndView("/home");
		if (id != null){
			removido = homeModel.removeById(Long.parseLong(id));
		}		
		List<Compromisso> comp = homeModel.getAllCompromissoList();
		model.addObject("compromissos", comp);
		model.addObject(Constantes.REMOVIDO, removido);
		
		return model;
	}
	
	@RequestMapping(value="/editarCompromisso", method=RequestMethod.POST)
	public ModelAndView	editarCompromisso(@Valid Compromisso compromisso){
		System.out.println("editarCompromisso(Compromisso compromisso) - enter");
		
		ModelAndView model = new ModelAndView("home");
		boolean result = homeModel.editCompromisso(compromisso);
		List<Compromisso> comp = homeModel.getAllCompromissoList();
		model.addObject("compromissos", comp);
		model.addObject(Constantes.SUCCESS_UPDATE, result);
		return model;
	}
	
	@RequestMapping("/home/listaTodos")
	public ModelAndView listaTodos(){
		System.out.println("listaTodos() - enter");
		
		ModelAndView model = new ModelAndView("home");
		List<Compromisso> comp = homeModel.getAllCompromisso();
		model.addObject("compromissos", comp);
		return model;
	}
}

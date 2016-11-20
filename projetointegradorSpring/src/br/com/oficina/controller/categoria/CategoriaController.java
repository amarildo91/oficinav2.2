package br.com.oficina.controller.categoria;

import java.util.List;

import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import br.com.oficina.beans.CategoriaOrdemServico;
import br.com.oficina.model.categoria.CategoriaModelImpl;
import br.com.oficina.utils.Constantes;

@Controller
public class CategoriaController {

	static CategoriaModelImpl categoriaModel = new CategoriaModelImpl();
	
	@RequestMapping("/protect/categoria")
	public ModelAndView begin(@RequestParam(required=false) boolean successMessage, @RequestParam(required=false) boolean insert){
		System.out.println("categoria begin(@RequestParam(required=false) boolean successMessage, @RequestParam(required=false) boolean insert) - enter");
		
		ModelAndView model = new ModelAndView("protect/categoria/categoria");
		List<CategoriaOrdemServico> categorias = categoriaModel.listAllCategorias();
		model.addObject("categorias", categorias);
		if (insert){
			model.addObject(Constantes.SUCCESS_INSERT , successMessage);
		}
		return model;
	}
	
	@RequestMapping(value="/protect/cadastrarCategoria", method=RequestMethod.POST)
	public String cadastrarCategoria(@Valid CategoriaOrdemServico categoria){
		System.out.println("cadastrarCategoria(CategoriaOrdemServico categoria) - enter");
		
		boolean result = false;
	    result = categoriaModel.persistCategoria(categoria);
		return "redirect:protect/categoria?insert=true&successMessage="+result;
	}
	
	@RequestMapping(value="/protect/editarCategoria", method=RequestMethod.POST)
	public ModelAndView editarCategoria(@Valid CategoriaOrdemServico categoria){
		System.out.println("editarCategoria(CategoriaOrdemServico categoria) - enter");
		
		ModelAndView model = new ModelAndView("protect/categoria/categoria");
		boolean result = false;
	    result = categoriaModel.editCategoria(categoria);
		List<CategoriaOrdemServico> categorias = categoriaModel.listAllCategorias();
		model.addObject("categorias", categorias);
		model.addObject(Constantes.SUCCESS_UPDATE, result);
		
		return model;
	}
	
	@RequestMapping(value="/protect/categoria/delete", method=RequestMethod.POST)
	public ModelAndView delete(@RequestParam("id") String id){
		System.out.println("categoria delete(String id) - enter");
		
		ModelAndView model = new ModelAndView("protect/categoria/categoria");
		boolean result = false;
		if (!id.isEmpty()){
			result = categoriaModel.removeCategoriaById(Long.parseLong(id));
		}	
	    if (!result){
	    	model.addObject(Constantes.ERROR_MESSAGE, "Verifique se não existe outros registros associados a esta categoria.");
	    }
	    
		List<CategoriaOrdemServico> categorias = categoriaModel.listAllCategorias();
		model.addObject("categorias", categorias);
		model.addObject(Constantes.REMOVIDO, result);
		
		return model;
	}	
}

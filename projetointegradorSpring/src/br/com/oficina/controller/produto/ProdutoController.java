package br.com.oficina.controller.produto;

import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import br.com.oficina.beans.Produto;
import br.com.oficina.model.produto.ProdutoModelImpl;
import br.com.oficina.utils.Constantes;

@Controller
public class ProdutoController {
	
	static ProdutoModelImpl produtoModel = new ProdutoModelImpl(); 
	
	@RequestMapping("/produto")
	public ModelAndView begin(@RequestParam(required=false) boolean successMessage, @RequestParam(required=false) boolean insert){
		System.out.println("produto begin(@RequestParam(required=false) boolean successMessage, @RequestParam(required=false) boolean insert) - enter");
		
		ModelAndView model = new ModelAndView("produto/produto");
		model.addObject("categorias", produtoModel.listAllCategorias());
		model.addObject("produtos", produtoModel.listAllProdutos());
		if (insert){
			model.addObject(Constantes.SUCCESS_INSERT , successMessage);
		}
		return model;
	}
	
	@RequestMapping(value="/cadastrarProduto", method=RequestMethod.POST)
	public String cadastrarProduto(@Valid Produto produto){
		System.out.println("cadastrarProduto(Produto produto) - enter");
		
		boolean insert;
		insert =  produtoModel.persistProduto(produto);
		return "redirect:produto?insert=true&successMessage="+insert;
	}
	
	@RequestMapping(value="/editProduto", method=RequestMethod.POST)
	public ModelAndView editProduto(@Valid Produto produto){
		System.out.println("editProduto(Produto produto) - enter");
		
		ModelAndView model = new ModelAndView("produto/produto");
		model.addObject(Constantes.SUCCESS_UPDATE, produtoModel.editProduto(produto));
		model.addObject("categorias", produtoModel.listAllCategorias());
		model.addObject("produtos", produtoModel.listAllProdutos());
		return model;
	}
	
	@RequestMapping(value="/produto/delete", method=RequestMethod.POST)
	public ModelAndView deleteProduto(@RequestParam("id") String id){
		System.out.println("deleteProduto(String id) - enter");
		
		ModelAndView model = new ModelAndView("produto/produto");
		boolean result = false;
		if (!id.isEmpty()){
			result = produtoModel.removeProdutoById(Long.parseLong(id));
		}
		if (!result){
			model.addObject(Constantes.ERROR_MESSAGE, "Verifique se não existe outros registros associados a este produto.");
		}
		model.addObject(Constantes.REMOVIDO, result);
		model.addObject("categorias", produtoModel.listAllCategorias());
		model.addObject("produtos", produtoModel.listAllProdutos());
		return model;
	}

}

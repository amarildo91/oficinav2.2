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
	
	@RequestMapping("/protect/produto")
	public ModelAndView begin(@RequestParam(required=false) boolean successMessage, @RequestParam(required=false) boolean insert){
		System.out.println("produto begin(@RequestParam(required=false) boolean successMessage, @RequestParam(required=false) boolean insert) - enter");
		
		ModelAndView model = new ModelAndView("protect/produto/produto");
		model.addObject("categorias", produtoModel.listAllCategorias());
		model.addObject("produtos", produtoModel.listAllProdutos());
		if (insert){
			model.addObject(Constantes.SUCCESS_INSERT , successMessage);
		}
		return model;
	}
	
	@RequestMapping(value="/protect/cadastrarProduto", method=RequestMethod.POST)
	public String cadastrarProduto(@Valid Produto produto){
		System.out.println("cadastrarProduto(Produto produto) - enter");
		
		boolean insert;
		insert =  produtoModel.persistProduto(produto);
		return "redirect:/protect/produto?insert=true&successMessage="+insert;
	}
	
	@RequestMapping(value="/protect/editProduto", method=RequestMethod.POST)
	public ModelAndView editProduto(@Valid Produto produto){
		System.out.println("editProduto(Produto produto) - enter");
		
		ModelAndView model = new ModelAndView("protect/produto/produto");
		model.addObject(Constantes.SUCCESS_UPDATE, produtoModel.editProduto(produto));
		model.addObject("categorias", produtoModel.listAllCategorias());
		model.addObject("produtos", produtoModel.listAllProdutos());
		return model;
	}
	
	@RequestMapping(value="/protect/produto/delete", method=RequestMethod.POST)
	public ModelAndView deleteProduto(@RequestParam("id") String id){
		System.out.println("deleteProduto(String id) - enter");
		
		ModelAndView model = new ModelAndView("protect/produto/produto");
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
	
	@RequestMapping("/protect/manutencaoProduto")
	public ModelAndView manutencaoProduto(@RequestParam(required=false) boolean successMessage, @RequestParam(required=false) boolean insert){
		System.out.println("produto manutencaoProduto(@RequestParam(required=false) boolean successMessage, @RequestParam(required=false) boolean insert) - enter");
		
		ModelAndView model = new ModelAndView("protect/produto/manutencao");
		model.addObject("categorias", produtoModel.listAllCategorias());
		model.addObject("produtos", produtoModel.listAllProdutos());
		if (insert){
			model.addObject(Constantes.SUCCESS_INSERT , successMessage);
		}
		return model;
	}
	
	@RequestMapping(value="/protect/editProdutoManutencao", method=RequestMethod.POST)
	public String editProdutoManutencao(@Valid Produto produto){
		System.out.println("editProdutoManutencao(Produto produto) - enter");
		
		double quantidade = produtoModel.getQuantidadeEstoque(produto.getId(), produto.getQuantidade());
		produto.setQuantidade(quantidade);
		boolean update = produtoModel.editProduto(produto);
		return "redirect:/protect/manutencaoProduto?insert=true&successMessage="+update;
	}

}

package br.com.oficina.controller.ordemServico;

import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import br.com.oficina.beans.ItemListView;
import br.com.oficina.beans.ItemOrdemServico;
import br.com.oficina.beans.OrdemServico;
import br.com.oficina.beans.Pessoa;
import br.com.oficina.beans.Produto;
import br.com.oficina.beans.ProdutoListView;
import br.com.oficina.model.ordemServico.OrdemServicoModelImpl;
import br.com.oficina.utils.Constantes;

@Controller
public class OrdemServicoController {

	static OrdemServicoModelImpl ordemModel = new OrdemServicoModelImpl();
	
	@RequestMapping("/ordemServico")
	public ModelAndView begin(@RequestParam(required=false) boolean successMessage, @RequestParam(required=false) boolean insert){
		System.out.println("OrdemServico begin(boolean successMessage, boolean insert) - enter");
		
		ModelAndView model = new ModelAndView("ordemServico/listOrdemServico");
		model.addObject("ordemServicos", ordemModel.listAllOrdemServico());
		if (insert){
			model.addObject(Constantes.SUCCESS_INSERT , successMessage);
		}
		return model;
	}	
	
	@RequestMapping("/formOrdemServico")
	public ModelAndView formOrdemServico(){
		System.out.println("formOrdemServico() - enter");
		
		ModelAndView model = new ModelAndView("ordemServico/formOrdemServico", "ordemServico", new OrdemServico());
		model.addObject("pessoas", ordemModel.listAllPessoa());
		model.addObject("categorias", ordemModel.listAllCategoria());
		return model;
	}
	
	@RequestMapping("/cadastrarOrdemServico")
	public String cadastrarOrdemServico(@Valid OrdemServico ordemServico, @RequestParam("idPessoa") String idPessoa, @Valid ProdutoListView produto, @Valid ItemListView item){
		System.out.println("cadastrarOrdemServico(OrdemServico ordemServico, String idPessoa) - enter");
		
		boolean insert = false;
		if(!idPessoa.isEmpty()){
			Pessoa pessoa = ordemModel.getPessoaById(Long.parseLong(idPessoa));
			ordemServico.setPessoa(pessoa);
			insert = ordemModel.persitOrdemServico(ordemServico);
		}
		return "redirect:ordemServico?insert=true&successMessage="+insert;
	}
	
	@RequestMapping(value="editOrdemServico", method=RequestMethod.GET)
	public ModelAndView editOrdemServico(@RequestParam("id") String id){
		System.out.println("editOrdemServico(String id) - enter");
		
		ModelAndView model = new ModelAndView("ordemServico/formOrdemServico");
		model.addObject("ordemServico", ordemModel.getOrdemServicoById(Long.parseLong(id)));
		model.addObject("pessoas", ordemModel.listAllPessoa());
		model.addObject("categorias", ordemModel.listAllCategoria());
		return model;
	}
	
	@RequestMapping("editOrdemServicoSubmit")
	public ModelAndView editOrdemServicoSubmit(@Valid OrdemServico ordemServico, @RequestParam("idPessoa") String idPessoa, @RequestParam("idOrdemServico") String idOrdemServico){
		System.out.println("editOrdemServicoSubmit(OrdemServico ordemServico, String idPessoa, String idOrdemServico) - enter");
		
		ModelAndView model = new ModelAndView("ordemServico/formOrdemServico");
		boolean update = false;
		if (!idOrdemServico.isEmpty()){
			if(!idPessoa.isEmpty()){
				Pessoa pessoa = ordemModel.getPessoaById(Long.parseLong(idPessoa));
				ordemServico.setPessoa(pessoa);
				ordemServico.setIdOrdemServico(Long.parseLong(idOrdemServico));
				update = ordemModel.mergeOrdemServico(ordemServico);
			}
		}
		model.addObject(Constantes.SUCCESS_UPDATE, update);
		return model;
	}
	
	@RequestMapping(value="item", method=RequestMethod.GET)
	public ModelAndView item(@RequestParam("id") String id){
		System.out.println("item(String id) - enter");
		
		ModelAndView model = new ModelAndView("ordemServico/item", "item", new ItemOrdemServico());
		model.addObject("categorias", ordemModel.listAllCategoria());
		model.addObject("produtos", ordemModel.listAllProduto());
		model.addObject("idOrdemServico", id);
		return model;
	}
	
	@RequestMapping(value="/salvarItem", method=RequestMethod.POST)
	public String saveItem(@Valid ProdutoListView produto, @Valid ItemOrdemServico item, @RequestParam("idOrdemServico") String idOrdemServico){
		System.out.println("saveItem(Produto produto, ItemOrdemServico item, String idOrdemServico) - enter");
		
		OrdemServico ordem = ordemModel.getOrdemServicoById(Long.parseLong(idOrdemServico));
		for (Produto prod : produto.getProduto()){
			item.getListProduto().add(prod);
		}
		ordem.getItem().add(item);
		
		System.out.println(ordem);
		
		return "ordemServico/item";
	}
	
	@ResponseBody
	@RequestMapping("/buscarProduto")
	public String  buscarProduto(@RequestBody String id){		
		System.out.println("buscarProduto(String id) - enter");
			
		String[] ajaxRequest = id.split("=");
		Long idCategoria = Long.parseLong(ajaxRequest[1]);
		String produtos = ordemModel.buscarProduto(idCategoria);
		return produtos;
	}
}

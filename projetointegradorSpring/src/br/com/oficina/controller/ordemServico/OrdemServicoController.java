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
import br.com.oficina.beans.Status;
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
		model.addObject("status", Status.values());
		return model;
	}
	
	@RequestMapping("/cadastrarOrdemServico")
	public String cadastrarOrdemServico(@Valid OrdemServico ordemServico, @RequestParam("idPessoa") String idPessoa, @Valid ItemListView item){
		System.out.println("cadastrarOrdemServico(OrdemServico ordemServico, String idPessoa) - enter");
		
		boolean insert = false;
		if(!idPessoa.isEmpty()){
			Pessoa pessoa = ordemModel.getPessoaById(Long.parseLong(idPessoa));
			ordemServico.setPessoa(pessoa);			
			ordemServico.setItem(item.getItem());
			insert = ordemModel.persistOrdemServico(ordemServico);
		}
		return "redirect:ordemServico?insert=true&successMessage="+insert;
	}
	
	@SuppressWarnings("static-access")
	@RequestMapping(value="editOrdemServico", method=RequestMethod.GET)
	public ModelAndView editOrdemServico(@RequestParam("id") String id){
		System.out.println("editOrdemServico(String id) - enter");
		
		ModelAndView model = new ModelAndView("ordemServico/formOrdemServico");
		OrdemServico ordem = ordemModel.getOrdemServicoById(Long.parseLong(id));
		model.addObject("ordemServico", ordem);
		model.addObject("pessoas", ordemModel.listAllPessoa());
		model.addObject("categorias", ordemModel.listAllCategoria());
		model.addObject("contadorProduto", ordemModel.getIndiceProduto(ordem.getItem()));
		model.addObject("status", ordem.getStatus().values());		
		return model;
	}
	
	@RequestMapping("editOrdemServicoSubmit")
	public String editOrdemServicoSubmit(@Valid OrdemServico ordemServico, @RequestParam("idPessoa") String idPessoa, @RequestParam("idOrdemServico") String idOrdemServico, @Valid ItemListView item){
		System.out.println("editOrdemServicoSubmit(OrdemServico ordemServico, String idPessoa, String idOrdemServico) - enter");
		
		boolean update = false;
		if (!idOrdemServico.isEmpty()){
			if(!idPessoa.isEmpty()){
				Pessoa pessoa = ordemModel.getPessoaById(Long.parseLong(idPessoa));
				ordemServico.setPessoa(pessoa);
				ordemServico.setIdOrdemServico(Long.parseLong(idOrdemServico));
				ordemServico.setItem(item.getItem());
				update = ordemModel.persistOrdemServico(ordemServico);
			}
		}
		return "redirect:ordemServico?insert=true&successMessage="+update;
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
	
	@RequestMapping("/deletarItem")
	public String deleteItem(@RequestParam("idItem") String idItem, @RequestParam("idOrdemServico") String idOrdemServico){
		System.out.println("deleteItem(String idItem, String idOrdemServico) - enter");
		
		boolean delete = false;
		if (!idItem.isEmpty() && !idOrdemServico.isEmpty()){
			OrdemServico ordemServico = ordemModel.getOrdemServicoById(Long.parseLong(idOrdemServico));
			delete = ordemModel.deleteItem(ordemServico, Long.parseLong(idItem));
		}
		return "redirect:ordemServico?insert=true&successMessage="+delete;
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

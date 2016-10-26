package br.com.oficina.controller.pessoa;

import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import br.com.oficina.beans.Endereco;
import br.com.oficina.beans.Pessoa;
import br.com.oficina.model.pessoa.PessoaModelImpl;
import br.com.oficina.utils.Constantes;

@Controller
public class PessoaController {

	static PessoaModelImpl pessoaModel = new PessoaModelImpl();
	
	@RequestMapping("/pessoa")
	public ModelAndView begin(@RequestParam(required=false) boolean successMessage, @RequestParam(required=false) boolean insert){
		System.out.println("pessoa begin(@RequestParam(required=false) boolean successMessage, @RequestParam(required=false) boolean insert) - enter");
		
		ModelAndView model = new ModelAndView("pessoa/listPessoa");
		model.addObject("pessoas", pessoaModel.listAllPessoas());
		if (insert){
			model.addObject(Constantes.SUCCESS_INSERT , successMessage);
		}
		return model;
	}
	
	@RequestMapping("/formPessoa")
	public ModelAndView formPessoa(){
		System.out.println("formPessoa() - enter");
		
		ModelAndView model = new ModelAndView("pessoa/formPessoa", "pessoa", new Pessoa());
		model.addObject("cidades", pessoaModel.listCidade());
		return model;
	}
	
	@RequestMapping(value="/cadastrarPessoa", method=RequestMethod.POST)
	public String cadastrarPessoa(@Valid Pessoa pessoa, @Valid Endereco endereco){
		System.out.println("cadastrarPessoa(Pessoa pessoa, Endereco endereco) - enter");
		
		boolean success =  pessoaModel.persistPessoa(pessoa, endereco);
		return "redirect:pessoa?insert=true&successMessage="+success;
	}
	
	@RequestMapping(value="/editPessoa", method=RequestMethod.GET)
	public ModelAndView editPessoa(@RequestParam("id") String id){
		System.out.println("editPessoa(String id) - enter");
		
		ModelAndView model = new ModelAndView("pessoa/formPessoa");
		Pessoa pessoa = pessoaModel.getPessoaById(Long.parseLong(id));
		Endereco endereco = pessoa.getEndereco();
		model.addObject("cidades", pessoaModel.listCidade());
		model.addObject("pessoa", pessoa);
		model.addObject("endereco", endereco);
		return model;
	}
	
	@RequestMapping(value="/editPessoaSubmit", method=RequestMethod.POST)
	public String editPessoaSubmit(@Valid Pessoa pessoa, @Valid Endereco endereco, @RequestParam("idPessoa") String idPessoa,@RequestParam("idEndereco") String idEndereco){
		System.out.println("editPessoaSubmit(@Valid Pessoa pessoa, @Valid Endereco endereco, String idPessoa, String idEndereco) - enter");
		
		if(!idEndereco.isEmpty()){
			endereco.setId(Long.parseLong(idEndereco));
		}	
		pessoa.setId(Long.parseLong(idPessoa));
		pessoa.setEndereco(endereco);
		boolean update = pessoaModel.editPessoa(pessoa, endereco);
		return "redirect:pessoa?insert=true&successMessage="+update;
	}	
	
	@RequestMapping(value="/pessoa/delete", method=RequestMethod.POST)
	public ModelAndView deletePessoa(@RequestParam("id") String id){
		System.out.println("deletePessoa(String id) - enter");
		
		ModelAndView model = new ModelAndView("pessoa/listPessoa");
		boolean result = false;
		if (!id.isEmpty()){
			result = pessoaModel.removePessoaById(Long.parseLong(id));
		}
		if (!result){
			model.addObject(Constantes.ERROR_MESSAGE, "Verifique se não existe outros registros associados a esta pessoa.");
		}
		model.addObject(Constantes.REMOVIDO, result);
		model.addObject("pessoas", pessoaModel.listAllPessoas());
		return model;
	}
}

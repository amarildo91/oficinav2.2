package br.com.oficina.controller.login;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import br.com.oficina.utils.LoginEnum;

@Controller
public class LoginController {
	@RequestMapping("/login")
	public ModelAndView execute(@RequestParam(value = "error", required = false) String error) {
		ModelAndView model =  new ModelAndView("loginController/login");
		if (error != null) {
			model.addObject(LoginEnum.ERRO_LOGIN.value, LoginEnum.ERRO_LOGIN_MSG.value);
		}
		return model;
	}

	@RequestMapping(value = "/errorGeral", method = RequestMethod.GET)
	public ModelAndView erroGeral() {
		ModelAndView model = new ModelAndView("loginController/erro");
		return model;
	}
}

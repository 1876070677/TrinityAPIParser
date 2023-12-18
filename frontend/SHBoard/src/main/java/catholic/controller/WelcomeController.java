package catholic.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import javax.servlet.http.HttpServletRequest;
import java.net.URI;

@Controller
public class WelcomeController {

    @Autowired
    public WelcomeController(){}

    @RequestMapping(value="/test")
    public String test(Model model) {
        model.addAttribute("text", "Welcome Page");
        return "test";
    }

//    @RequestMapping(value="/")
//    public String index(Model model) {
//        System.out.println("Welcome");
//        model.addAttribute("text", "Welcome Page");
//        return "index";
//    }

    @RequestMapping(value="/")
    public String cuk(Model model) {
        model.addAttribute("text", "Trinity Helper");
        return "cuk";
    }
}

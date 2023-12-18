package catholic.controller;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URI;

@Controller
public class TrinityController {

    @Autowired
    public TrinityController(){}

    private final ObjectMapper objectMapper = new ObjectMapper();

    @RequestMapping(value = "/search")
    public String search(Model model, HttpServletRequest req) {
        try {
            req.setCharacterEncoding("utf-8");
        } catch(UnsupportedEncodingException e) {
            e.printStackTrace();
        }

        if (req.getParameter("subjNo") == null || req.getParameter("no") == null || req.getParameter("userId") == null || req.getParameter("userPw") == null || req.getParameter("year") == null || req.getParameter("semester") == null) {
            return "redirect:/cuk";
        }

        URI uri = UriComponentsBuilder
                .fromUriString("https://trinity.shbox.kr") //http://localhost에 호출
                .path("/search")
                .build()
                .toUri();

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        RestTemplate restTemplate = new RestTemplate();

        JSONObject subjJsonObject = new JSONObject();
        subjJsonObject.put("subjNo", req.getParameter("subjNo"));
        subjJsonObject.put("no", req.getParameter("no"));
        subjJsonObject.put("userId", req.getParameter("userId"));
        subjJsonObject.put("userPw", req.getParameter("userPw"));
        subjJsonObject.put("year", req.getParameter("year"));
        subjJsonObject.put("semester", req.getParameter("semester"));

        System.out.println(req.getParameter("userId") + " : " + req.getParameter("userPw"));

        HttpEntity<String> request = new HttpEntity<String>(subjJsonObject.toString(), headers);
        String trinityResult = restTemplate.postForObject(uri, request, String.class);

        try {
            JsonNode root = objectMapper.readTree(trinityResult);
            JsonNode body = objectMapper.readTree(root.path("body").asText());
            model.addAttribute("totalNum", body.path("totalNum").asText());
            model.addAttribute("nowNum", body.path("nowNum").asText());
            model.addAttribute("className", body.path("className"));
        } catch (IOException e) {
            e.printStackTrace();
        }

        return "cuk";
    }
}

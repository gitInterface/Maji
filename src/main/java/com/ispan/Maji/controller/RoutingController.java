package com.ispan.Maji.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class RoutingController {
    @GetMapping(path = {"/", "/index"})
	public String method1() {
		return "/index";
	}
	@GetMapping(value = {"/secure/productinsert"})
	public String method3() {
		return "/secure/productinsert";
	}
	@GetMapping(value = {"/secure/productview"})
	public String method4() {
		return "/secure/productview";
	}
	@GetMapping(value = {"/secure/productupdate"})
	public String method5() {
		return "/secure/productupdate";
	}
	@GetMapping(value = {"/portal/register"})
	public String method6() {
		return "/portal/register";
	}
	@GetMapping(value = {"/portal/login"})
	public String method7() {
		return "/portal/login";
	}
	@GetMapping(value = {"/user/userview"})
	public String method8() {
		return "/user/userview";
	}
	@GetMapping(value = {"/user/userupdate"})
	public String method9() {
		return "/user/userupdate";
	}
	@GetMapping(value = {"/pages/aboutbrand"})
	public String method10() {
		return "/pages/aboutbrand";
	}
	@GetMapping(value = {"/pages/location"})
	public String method11() {
		return "/pages/location";
	}
	@GetMapping(value = {"/pages/restaurant"})
	public String method12() {
		return "/pages/restaurant";
	}
	@GetMapping(value = {"/pages/feedback"})
	public String method13() {
		return "/pages/feedback";
	}
	@GetMapping(value = {"/portal/forgotpassword"})
	public String method14() {
		return "/portal/forgotpassword";
	}
	@GetMapping(value = {"/portal/resetpassword"})
	public String method15() {
		return "/portal/resetpassword";
	}
	@GetMapping(value = {"/pages/onlineshopping"})
	public String method16() {
		return "/pages/onlineshopping";
	}
	@GetMapping(value = {"/pages/termsofuse"})
	public String method17() {
		return "/pages/termsofuse";
	}
	@GetMapping(value = {"/pages/privacypolicy"})
	public String method18() {
		return "/pages/privacypolicy";
	}
	@GetMapping(value = {"/pages/productdetail"})
	public String method19() {
		return "/pages/productdetail";
	}
	@GetMapping(value = {"/pages/shoppingcart"})
	public String method20() {
		return "/pages/shoppingcart";
	}
	@GetMapping(value = {"/pages/checkout"})
	public String method21() {
		return "/pages/checkout";
	}
}



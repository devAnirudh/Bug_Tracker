<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.io.File"%>
<%@page import="nl.captcha.servlet.CaptchaServletUtil"%>
<%@page import="java.awt.Color"%>
<%@page import="nl.captcha.Captcha"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    
    <%
    Captcha captcha = captcha = new Captcha.Builder(200, 50).addText().addBackground().addNoise().gimp().addBorder().build();
    
    CaptchaServletUtil.writeImage(response, captcha.getImage());
    
    File file = new File("tempCaptcha.jpg");
    ImageIO.write(captcha.getImage(), "jpg", file);
    
    %>	
    

 
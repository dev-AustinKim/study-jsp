package com.example.app;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Oper
 */
//@WebServlet("/Oper")
public class MyOper extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MyOper() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	      response.setContentType("text/html; charset=UTF-8");
	      PrintWriter out = response.getWriter();
	      String arr[] = new String[3];
	      arr = request.getParameter("calc").split(" ");
	      int num1 = Integer.parseInt(arr[0]);
	      int num2 = Integer.parseInt(arr[2]);
	      MyCalc calc = new MyCalc();

	      try {
	    	  switch(arr[1]) {
		      	case "+" :
		      		out.print("<div style='text-align: center'> 덧셈 결과 : " + calc.sum(num1,num2) + "<div>");
		      		break;
		      	case "-" :
		      		out.print("<div style='text-align: center'> 뺄셈 결과 : " + calc.sub(num1,num2) + "<div>");
		      		break;
		      	case "*" :
		      		out.print("<div style='text-align: center'> 곱셈 결과 : " + calc.multiply(num1,num2) + "<div>");
		      		break;
		      	case "/" :
		      		out.print("<div style='text-align: center'> 나눗셈 결과 : " + calc.divide(num1,num2) + "<div>");
		      		break;
		      	default :
		      		out.print("<div>사칙연산이 아닙니다.<div>");
		      		break;
		      }
		} catch(ArithmeticException e) {
			e.printStackTrace();
			out.print("0으로 나눌 수 없습니다.");
		}
	      
	     
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

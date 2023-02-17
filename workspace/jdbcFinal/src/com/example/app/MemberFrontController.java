package com.example.app;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.example.app.member.MemberJoinActionController;
import com.example.app.member.MemberLoginActionController;
import com.example.app.member.MemberMyPageActionController;

public class MemberFrontController extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String uri = req.getRequestURI();
		String target = uri.replaceAll(req.getContextPath() + "/", "").split("\\.")[0];
		Result result = null;
		
//		페이지 이동만 할 때는 그냥 쓴다. (Ex : join)
		if(target.equals("join")) {
			result = new Result();
			result.setPath("/join.jsp");
//			result.setRedirect(false); 이걸 해주는 이유는 /join.jsp 이게 안보였으면 좋겠어서이다.
			result.setRedirect(false);
			
//		DB 조회할 때 Action을 붙인다. (Ex : joinAction)
		}else if(target.equals("checkIdAction")) {
			new MemberCheckIdActionController().execute(req, resp);
			
		}else if(target.equals("joinAction")) {
			result = new MemberJoinActionController().execute(req, resp);
			
		}else if(target.equals("login")) {
			result = new Result();
			result.setPath(req.getContextPath() + "/login.jsp");
			result.setRedirect(true);
			
		}else if(target.equals("loginAction")) {
			result = new MemberLoginActionController().execute(req, resp);
		}else if(target.equals("myPageAction")) {
			result = new MemberMyPageActionController().execute(req, resp);
		}else {
			
		}
		
		if(result != null) {
//			isRedirect는 보내는 방식을 정하는 것이다.
			if(result.isRedirect()) {
				resp.sendRedirect(result.getPath());
			}else {
				req.getRequestDispatcher(result.getPath()).forward(req, resp);
			}
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
	
}






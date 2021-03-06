package HoH.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import HoH.model.FollowDAO;
import HoH.model.MemberDAO;
import HoH.model.MemberVO;

public class follwerAddController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//MemberVO memberVO = (MemberVO)session.getAttribute("memberVO");
		String myId = request.getParameter("id");//세션아이디를 보냈음
		String nickName = request.getParameter("nickname");//게시물의 닉네임을 전송
		FollowDAO.getInstance().follwerAdd(myId, nickName);
		String id=MemberDAO.getInstance().findIdbyNickName(nickName);
		MemberDAO.getInstance().UpdatePlusPoint(id, MemberVO.followPoint);
		
		HttpSession session = request.getSession();
		int point = MemberDAO.getInstance().getPoint(id);
		MemberVO vo=(MemberVO)session.getAttribute("memberVO");
		vo.setPoint(point);			
				
		String result= "fail";
		request.setAttribute("responsebody", result);
		return "AjaxView";
	}

}

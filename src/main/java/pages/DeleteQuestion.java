package pages;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import db.Database;

@WebServlet("/DeleteQuestion")
public class DeleteQuestion extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public DeleteQuestion() {
		super();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		if (session.getAttribute("username") != null) {
			String questionid = request.getParameter("id");
			Database.deleteQuestion(questionid);
		}

		String referer = request.getHeader("referer");
		int index = referer.indexOf("quiz.jsp");
		response.sendRedirect(referer.substring(index));
	}

}

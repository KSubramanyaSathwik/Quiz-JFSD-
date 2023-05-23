package pages;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import db.Database;

@WebServlet("/CreateQuiz")
public class CreateQuiz extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public CreateQuiz() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		String quizname = request.getParameter("quizname");
		Integer quizid = Database.getNumericId(session.getAttribute("username").toString(), quizname);
		response.sendRedirect("quiz.jsp?id=" + quizid + "&name=" + quizname);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}

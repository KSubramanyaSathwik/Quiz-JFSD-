package pages;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import db.Database;
import models.questions.MCQ;

@WebServlet("/UpdateQuestion")
public class UpdateQuestion extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public UpdateQuestion() {
		super();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		if (session.getAttribute("username") != null) {
			String questionid = request.getParameter("id");
			String question = request.getParameter("update_qname");
			String[] answers = { request.getParameter("a"), request.getParameter("b"), request.getParameter("c"),
					request.getParameter("d") };
			MCQ q = new MCQ(question, answers, request.getParameter("ca"));
			Database.updateQuestion(questionid, q);
		}

		String referer = request.getHeader("referer");
		int index = referer.indexOf("quiz.jsp");
		response.sendRedirect(referer.substring(index));
	}

}

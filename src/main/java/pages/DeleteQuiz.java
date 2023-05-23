package pages;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import db.Database;

@WebServlet("/DeleteQuiz")
public class DeleteQuiz extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public DeleteQuiz() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		if(session.getAttribute("username") != null) {
			String id = request.getParameter("id");
			Database.deleteQuiz(id);
		}
		
		response.sendRedirect("dashboard.jsp");
	}
}

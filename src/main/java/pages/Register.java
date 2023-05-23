package pages;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import db.Database;

@WebServlet({ "/Register", "/Register/" })
public class Register extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter pw = response.getWriter();
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String repassword = request.getParameter("repassword");

		if (!password.equals(repassword)) {
			pw.println("Passwords do not match!");
			return;
		}

		String name = request.getParameter("name");
		String email = request.getParameter("email");

		if (Database.addUser(username, password, name, email, pw)) {
			pw.println("<script>alert('Your Registration was successful! Login on the next page.');</script>");
			response.sendRedirect("index.jsp");
		} else {
			pw.println("<script>alert('Some error occured! Please try again.');</script>");
			response.sendRedirect("register.jsp");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}

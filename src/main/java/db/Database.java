package db;

import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import models.Score;
import models.User;
import models.questions.MCQ;
import models.questions.Question;
import util.Util;

public class Database {
	static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
	// static final String DB_URL = "jdbc:mysql://bxdckaiotjos6uxqsxij-mysql.services.clever-cloud.com:3306/bxdckaiotjos6uxqsxij";
	static final String DB_URL = "jdbc:mysql://localhost:3306/Quiz";
	// static final String USER = "u1bl3chv4wysc2pd";
	static final String USER = "root";
	// static final String PASS = "fFWLbfvEvE8CYje7Cv3o";
	static final String PASS = "StudyHard1234";

	public static void submitFeedback(String quizid, String username, int rating) {
		try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
				Statement stmt = conn.createStatement()) {
			stmt.executeUpdate("insert into feedback values('" + quizid + "','" + username + "','" + rating + "')");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static void submitAnswer(String qid, String username, String selected, int isCorrect) {
		try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
				Statement stmt = conn.createStatement()) {
			stmt.executeUpdate("INSERT INTO scoreboard (questionid, username, selected, isCorrect) VALUES('" + qid
					+ "', '" + username + "', '" + selected + "', '" + isCorrect + "')");
		} catch (Exception e) {
			System.out.println("DATABASE ERROR");
			e.printStackTrace();
		}
	}

	public static Question getQuestion(String questionid) {
		Question q = null;
		try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
				Statement stmt = conn.createStatement()) {
			ResultSet rs = stmt.executeQuery("SELECT * FROM questions WHERE questionid='" + questionid + "'");
			if (rs.next()) {
				String qname = rs.getString("question");
				String a = rs.getString("option1");
				String b = rs.getString("option2");
				String c = rs.getString("option3");
				String d = rs.getString("option4");
				String ca = rs.getString("correctanswer");

				q = new MCQ(qname, new String[] { a, b, c, d }, ca);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return q;
	}

	public static boolean quizExists(String quizid) {
		int count = 0;
		try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
				Statement stmt = conn.createStatement()) {
			ResultSet rs = stmt.executeQuery("SELECT COUNT(quizid) as count FROM quiz WHERE quizid='" + quizid + "'");
			if (rs.next()) {
				count = rs.getInt("count");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return count > 0;
	}

	public static int[] getPerQuestionResult(String quesid) {
		int[] score = new int[2];
		try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
				Statement stmt = conn.createStatement()) {
			ResultSet rs = stmt.executeQuery(
					"SELECT COUNT(CASE WHEN isCorrect = 0 then isCorrect end) as wrong, COUNT(CASE WHEN isCorrect = 1 then isCorrect end) as correct from scoreboard where questionid = '"
							+ quesid + "'");
			while (rs.next()) {
				score[0] = rs.getInt("correct");
				score[1] = rs.getInt("wrong");
			}
			System.out.println(score[0]);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return score;
	}

	public static String getCorrectAnswer(String qid) {
		try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
				Statement stmt = conn.createStatement()) {
			ResultSet rs = stmt.executeQuery("SELECT correctanswer FROM questions WHERE questionid='" + qid + "'");
			if (rs.next())
				return rs.getString("correctanswer");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public static List<Score> getScoreboard(String quizid) {
		List<Score> scores = new ArrayList<>();
		try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
				Statement stmt = conn.createStatement()) {
			String sql = "SELECT s.username, SUM(s.isCorrect) AS score, (SELECT COUNT(questionid) from questions where quizid='"
					+ quizid + "') as total FROM quiz qu, scoreboard s WHERE qu.quizid='" + quizid
					+ "' and s.questionid IN(SELECT questionid FROM questions WHERE quizid='" + quizid
					+ "') GROUP BY username ORDER BY score DESC;";
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				String username = rs.getString("username");
				int score = rs.getInt("score");
				int total = rs.getInt("total");
				scores.add(new Score(username, score, total));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return scores;
	}

	public static void updateQuestion(String qid, Question q) {
		MCQ question = (MCQ) q;

		try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
				Statement stmt = conn.createStatement()) {
			String[] answers = question.getAnswers();
			stmt.executeUpdate("UPDATE questions SET question='" + question.getQuestion() + "', option1='" + answers[0]
					+ "', option2='" + answers[1] + "', option3='" + answers[2] + "', option4='" + answers[3]
					+ "', correctanswer='" + question.getCorrectAnswer() + "' WHERE questionid='" + qid + "'");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static void deleteQuiz(String qid) {
		try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
				Statement stmt = conn.createStatement()) {
			stmt.executeUpdate("DELETE FROM quiz WHERE quizid='" + qid + "'");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static void deleteQuestion(String qid) {
		try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
				Statement stmt = conn.createStatement()) {
			stmt.executeUpdate("DELETE FROM questions WHERE questionid='" + qid + "'");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static void addQuestion(Question q, Integer quizid, int qno) {
		MCQ question = (MCQ) q;
		try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
				Statement stmt = conn.createStatement()) {
			String[] answers = question.getAnswers();
			stmt.executeUpdate(
					"INSERT INTO questions (questionid, question, quizid, option1, option2, option3, option4, correctanswer, type, correctPoints, minusPoints, timestamp, qno) VALUES('"
							+ Util.getUniqueID(6) + "', '" + question.getQuestion() + "', '" + quizid + "', '"
							+ answers[0] + "', '" + answers[1] + "', '" + answers[2] + "', '" + answers[3] + "', '"
							+ question.getCorrectAnswer() + "', 'MCQ', '1', '0', '" + java.time.LocalDateTime.now()
							+ "', '" + qno + "')");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static Integer getNumericId(String username, String quizname) {
		boolean unique = false;
		Integer quizid = Util.getNumericID(6);

		while (!unique) {
			quizid = Util.getNumericID(6);
			try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
					Statement stmt = conn.createStatement()) {
				ResultSet rs = stmt
						.executeQuery("SELECT COUNT(quizid) AS count FROM quiz WHERE quizid='" + quizid + "'");
				if (rs.next()) {
					int count = rs.getInt("count");
					if (count > 0)
						continue;
					else {
						unique = true;
					}
				}
				unique = true;
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
				Statement stmt = conn.createStatement()) {
			// int result =
			stmt.executeUpdate("INSERT INTO quiz (quizid, quizname, username, timestamp) VALUES(" + quizid + ", '"
					+ quizname + "', '" + username + "', '" + java.time.LocalDateTime.now() + "')");
		} catch (Exception e) {
			e.printStackTrace();
		}

		return quizid;
	}

	public static User fetchUser(String username, String password, PrintWriter pw, HttpSession session) {
		String sql = "SELECT * FROM users WHERE username=\'" + username + "\' AND password=\'" + password + "\'";
		try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
				Statement stmt = conn.createStatement()) {
			Class.forName(JDBC_DRIVER);
			ResultSet rs = stmt.executeQuery(sql);
			if (rs.next()) {
				String uname = rs.getString("username");
				String name = rs.getString("name");
				String email = rs.getString("email");
				String passwd = rs.getString("password");

				if (username.equals(uname) && password.equals(passwd)) {

					session.setAttribute("username", uname);
					session.setAttribute("date", java.time.LocalDate.now());
					session.setAttribute("time", java.time.LocalTime.now());

					return new User(uname, name, email);
				}
				return null;
			}
			rs.close();
			return null;
		} catch (Exception e) {
			pw.println(e.getMessage());
			return null;
		}
	}

	public static boolean addUser(String username, String password, String name, String email, PrintWriter pw) {
		String sql = "INSERT INTO users (username, password, name, email) VALUES('" + username + "','" + password
				+ "', '" + name + "', '" + email + "')";
		int res = 0;
		try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
				Statement stmt = conn.createStatement()) {
			Class.forName(JDBC_DRIVER);
			res = stmt.executeUpdate(sql);
		} catch (Exception e) {
			pw.println(e.getMessage());
		}

		return res >= 0;
	}
}

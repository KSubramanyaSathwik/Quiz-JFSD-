package util;

import java.io.IOException;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

@ServerEndpoint("/GetScores")
public class GetScores {
	private static Set<Session> userSessions = Collections.newSetFromMap(new ConcurrentHashMap<Session, Boolean>());

	@OnOpen
	public void onOpen(Session curSession) {
		userSessions.add(curSession);
	}

	@OnClose
	public void onClose(Session curSession) {
		userSessions.remove(curSession);
	}

	@OnMessage
	public void onMessage(String message, Session userSession) {
		String response = "";
		String quizid = message.substring(3);
		List<models.Score> scores = db.Database.getScoreboard(quizid);
		for (models.Score s : scores) {
			response += s + ",";
		}
		response = response.substring(0, response.length() - 1);

		for (Session ses : userSessions) {
			if (ses.isOpen()) {
				try {
					ses.getBasicRemote().sendText(response);
				} catch (IOException e) {
					System.out.println("Error on GetScores: " + e.getMessage());
					e.printStackTrace();
				}
			} else {
				System.out.println("--Closed Session on Scores--");
			}
		}
	}
}
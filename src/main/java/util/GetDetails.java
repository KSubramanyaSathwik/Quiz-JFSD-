package util;

import java.io.IOException;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

@ServerEndpoint("/GetDetails")
public class GetDetails {
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

		int[] result = db.Database.getPerQuestionResult(message);
		response = result[0] + "," + result[1];

		for (Session ses : userSessions) {
			if (ses.isOpen()) {
				try {
					ses.getBasicRemote().sendText(response);
				} catch (IOException e) {
					System.out.println("Error on GetDetails: " + e.getMessage());
					e.printStackTrace();
				}
			} else {
				System.out.println("--Closed Session Details--");
			}
		}
	}
}
package util;

import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

@ServerEndpoint("/SubmitAnswer")
public class SubmitAnswer {
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
		String[] msg = message.split(",");
		System.out.println(message);
		db.Database.submitAnswer(msg[0], msg[1], msg[2], Integer.parseInt(msg[3]));
	}
}
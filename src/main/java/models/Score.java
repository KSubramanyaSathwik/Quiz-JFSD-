package models;

public class Score {
	public final String username;
	public final int score;
	public final int total;

	public Score(String username, int score, int total) {
		this.username = username;
		this.score = score;
		this.total = total;
	}

	@Override
	public String toString() {
		return username + ":" + score + ":" + total;
	}
}

package models;

public class User {
	public final String username;
	public final String name;
	public final String email;

	public User(String username, String name, String email) {
		this.username = username;
		this.name = name;
		this.email = email;
	}

	@Override
	public String toString() {
		return this.username;
	}
}

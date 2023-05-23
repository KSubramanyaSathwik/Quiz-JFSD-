package models.questions;

public abstract class Question {
	protected String question;
	protected QuestionType type;
	protected int qno;

	public Question(String question, QuestionType type) {
		this.question = question;
		this.type = type;
	}

	public abstract String getQuestion();

	public QuestionType getType() {
		return this.type;
	}
	
	@Override
	public String toString() {
		return this.question;
	}
}

package models.questions;

public class OpenQuestion extends Question {

	public OpenQuestion(String question) {
		super(question, QuestionType.Open);
	}

	@Override
	public String getQuestion() {
		return this.question;
	}
}
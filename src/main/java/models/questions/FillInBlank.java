package models.questions;

public class FillInBlank extends Question {
	private String correctAnswer;

	public FillInBlank(String question, String correctAnswer) {
		super(question, QuestionType.FillInBlank);
		this.correctAnswer = correctAnswer;
	}

	@Override
	public String getQuestion() {
		return question;
	}
	
	public String getCorrectAnswer() {
		return this.correctAnswer;
	}
}

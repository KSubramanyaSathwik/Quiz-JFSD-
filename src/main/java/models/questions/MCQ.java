package models.questions;

import java.util.Arrays;

public class MCQ extends Question {
	private String[] answers;
	private String correctAnswer;

	public MCQ(String question, String[] answers, String correctAnswer) {
		super(question, QuestionType.MCQ);
		this.answers = answers;
		this.correctAnswer = correctAnswer;
	}

	@Override
	public String getQuestion() {
		return this.question;
	}

	public String[] getAnswers() {
		return Arrays.copyOf(answers, 4);
	}
	
	public String getCorrectAnswer() {
		return correctAnswer;
	}
}

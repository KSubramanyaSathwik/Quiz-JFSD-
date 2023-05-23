package models.questions;

import java.util.Arrays;

public class Scale extends Question {
	private ScaleStatement[] statements;

	public Scale(String question, String[] stmt) {
		super(question, QuestionType.Scale);

		stmt = Arrays.copyOf(stmt, 4);
		statements = new ScaleStatement[4];
		for (int i = 0; i < 4; i++) {
			statements[i] = new ScaleStatement(stmt[i]);
		}
	}

	@Override
	public String getQuestion() {
		return this.question;
	}

	public String getResponse(int statementIndex, int value) {
		return statements[statementIndex].getResponse(value);
	}

	public ScaleStatement[] getStatements() {
		return Arrays.copyOf(statements, 4);
	}
}
package models.questions;

public class ScaleStatement {
	public final String statement;
	public final static int min = 1;
	public final static int max = 5;
	public final static String[] responses = { "Strongly Disagree", "Disagree", "Neither Agree not Disagree", "Agree",
			"Strongly Agree" };

	public ScaleStatement(String statement) {
		this.statement = statement;
	}

	public String getResponse(int value) {
		return responses[value - 1];
	}
}

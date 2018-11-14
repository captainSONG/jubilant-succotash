package kr.or.ddit.web.calculate;

public enum Operator {
	// 사칙연산에는 +,-,*,/ 4개가 있으므로 4개를 정의해준다.
	// 요청데이터는 String 타입으로 전송되기 때문에 String으로 받아서 연산결과를 처리해준다. 
	ADD("+",new RealOperator() {

		@Override
		public int operate(int leftOp, int rightOp) {
			return leftOp+rightOp;
		}
		
	}), 
	MINUS("-", (leftOp, rightOp) -> {return leftOp-rightOp;}),
	MULTIPLY("*", (a, b) -> {return a*b;}),
	DIVIED("/", (c, d) -> {return c/d;});
	private String sign;
	private RealOperator realOperator;
	Operator(String sign, RealOperator realOperator){
		this.sign = sign;
		this.realOperator = realOperator;
	}
	public String getsign() {
		return this. sign;
	}
	public int operate(int leftOp, int rightOp) {
		return realOperator.operate(leftOp, rightOp);
	}
}

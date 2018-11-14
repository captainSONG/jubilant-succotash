package kr.or.ddit.web.calculate;

@FunctionalInterface
interface RealOperator{
	public int operate(int leftOp, int rightOp);
}
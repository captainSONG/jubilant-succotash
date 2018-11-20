package kr.or.ddit.member.dao;

import kr.or.ddit.vo.MemberVO;

public interface IMemberDAO {
	/**
	 * 회원정보 상세 조회
	 * @param mem_id 조회할 회원의 아이디
	 * @return 존재하지 않는다면, null 반환
	 */
	public MemberVO selectMember(String mem_id);
}

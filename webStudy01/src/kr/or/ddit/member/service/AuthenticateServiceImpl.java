package kr.or.ddit.member.service;

import kr.or.ddit.member.dao.IMemberDAO;
import kr.or.ddit.member.dao.MemberDAOImpl;
import kr.or.ddit.member.dao.MemberDAOImpl_Simple;
import kr.or.ddit.vo.MemberVO;

public class AuthenticateServiceImpl implements IAuthenticateService {
	IMemberDAO memberDAO = new MemberDAOImpl();
	public static enum ServiceResult{ PKNOTFOUND, INVALIDPASSWORD }
	@Override
	public Object authenticate(MemberVO member) {
		Object result = null;
		MemberVO savedMember = memberDAO.selectMember(member.getMem_id());
		if(savedMember != null) {
			if(savedMember.getMem_pass().equals(member.getMem_pass())) {
				result = savedMember;
			}else {
				result = ServiceResult.INVALIDPASSWORD;
			}
		} else {
			result = ServiceResult.PKNOTFOUND;
		}
		return result;
	}
}
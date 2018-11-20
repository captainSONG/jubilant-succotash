package kr.or.ddit.member.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import kr.or.ddit.db.ConnectionFactory;
import kr.or.ddit.vo.MemberVO;

public class MemberDAOImpl_Simple implements IMemberDAO{

	@Override
	public MemberVO selectMember(String mem_id) {
		MemberVO member = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT                                              ");
	    sql.append(" MEM_ID,    MEM_PASS,    MEM_NAME,    MEM_REGNO1,    ");
	    sql.append(" MEM_REGNO2,    TO_CHAR(MEM_BIR,'YYYY-MM-DD') MEM_BIR,    MEM_ZIP,    MEM_ADD1,    ");
	    sql.append(" MEM_ADD2,    MEM_HOMETEL,    MEM_COMTEL,    MEM_HP, ");
	    sql.append(" MEM_MAIL,    MEM_JOB,    MEM_LIKE,    MEM_MEMORIAL, ");
	    sql.append(" TO_CHAR(MEM_MEMORIALDAY,'YYYY-MM-DD') MEM_MEMORIALDAY,    MEM_MILEAGE,    MEM_DELETE      ");
		sql.append(" FROM MEMBER                                         ");
		sql.append(" WHERE MEM_ID = ?                                    ");
		try (Connection conn = ConnectionFactory.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql.toString());) {
			pstmt.setString(1, mem_id);			
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				member = new MemberVO();
				// 조회된 결과(ResultSet)를 Java Object로 변환
				member.setMem_id(rs.getString("MEM_ID"));
				member.setMem_pass(rs.getString("MEM_PASS"));
				member.setMem_name(rs.getString("MEM_NAME"));
				member.setMem_regno1(rs.getString("MEM_REGNO1"));
				member.setMem_regno2(rs.getString("MEM_REGNO2"));
				member.setMem_bir(rs.getString("MEM_BIR"));
				member.setMem_zip(rs.getString("MEM_ZIP"));
				member.setMem_add1(rs.getString("MEM_ADD1"));
				member.setMem_add2(rs.getString("MEM_ADD2"));
				member.setMem_hometel(rs.getString("MEM_HOMETEL"));
				member.setMem_comtel(rs.getString("MEM_COMTEL"));
				member.setMem_hp(rs.getString("MEM_HP"));
				member.setMem_mail(rs.getString("MEM_MAIL"));
				member.setMem_job(rs.getString("MEM_JOB"));
				member.setMem_like(rs.getString("MEM_LIKE"));
				member.setMem_memorial(rs.getString("MEM_MEMORIAL"));
				member.setMem_memorialday(rs.getString("MEM_MEMORIALDAY"));
				//member.setMem_mileage(rs.getString("MEM_MILEAGE"));
				member.setMem_delete(rs.getString("MEM_DELETE"));
				
			}
			return member;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		
	}

}

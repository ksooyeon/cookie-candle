package coocan.com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import coocan.com.dto.QuestionDTO;
import coocan.com.dto.ReviewDTO;

public class QuestionDAO extends JdbcDAO {
	private static QuestionDAO _dao;

	private QuestionDAO() {
		// TODO Auto-generated constructor stub
	}

	static {
		_dao = new QuestionDAO();
	}

	public static QuestionDAO getDAO() {
		return _dao;
	}
	//문의 글 쓰는 메소드
	public int insertQuestion(QuestionDTO question) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;
		try {
			con = getConnection();

			String sql = "insert into question values(q_no_seq.nextval,?,?,sysdate,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, question.getqTitle());
			pstmt.setString(2, question.getqContent());
			pstmt.setInt(3, question.getqStatus());
			pstmt.setInt(4, question.getRef());
			pstmt.setInt(5, question.getRestep());
			pstmt.setString(6, question.getqUid());

			rows = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]insertQuestion 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}

	public List<QuestionDTO> selectAllQuestionList(int startRow, int endRow, String search, String keyword) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<QuestionDTO> questionList = new ArrayList<QuestionDTO>();

		try {
			con = getConnection();

			if(keyword.equals("")) {//검색 기능을 사용하지 않은 경우
				String sql="select * from (select rownum rn, temp.* from "
						+ "(select q_no, q_title, q_content, q_date, q_status, ref, re_step, q_uid, case when ref != 0 then ref else q_no end as q_ord from question order by q_ord desc, q_no)temp) "
						+ "where rn between ? and ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, endRow);
			} else {//검색 기능을 사용한 경우
				String sql="select * from (select rownum rn, temp.* from "
						+ "(select q_no, q_title, q_content, q_date, q_status, ref, re_step, q_uid, case when ref != 0 then ref else q_no end as q_ord from question  where "+search
						+" like '%'||?||'%' order by q_ord desc, q_no) temp) "
						+ "where rn between ? and ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, keyword);
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, endRow);
			}
			rs=pstmt.executeQuery();
			while(rs.next()) {
				QuestionDTO question = new QuestionDTO();
				question.setqNo(rs.getInt("q_no"));
				question.setqTitle(rs.getString("q_title"));
				question.setqContent(rs.getString("q_content"));
				question.setqDate(rs.getString("q_date"));
				question.setqStatus(rs.getInt("q_status"));
				question.setRef(rs.getInt("ref"));
				question.setRestep(rs.getInt("re_step"));
				question.setqUid(rs.getString("q_uid"));
				questionList.add(question);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectAllReviewList 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}	
		return questionList;
	}

	public int selectQuestionCount(String search, String keyword) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;
		try {
			con = getConnection();

			if (keyword.equals("")) {// 검색 기능을 사용하지 않은 경우
				String sql = "select count(*) from question";
				pstmt = con.prepareStatement(sql);
			} else {// 검색 기능을 사용한 경우
				String sql = "select count(*) from question where " + search + " like '%'||?||'%'";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, keyword);
			}
			rs = pstmt.executeQuery();

			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectQuestionCount 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return count;
	}
	
	public int selectNextNum() {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int nextNum=0;
		try {
			con=getConnection();
			
			String sql="select q_no_seq.nextval from dual";
			pstmt=con.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				nextNum=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectNextNum 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return nextNum;
	}
	
	public int updateReStep(int ref, int reStep) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update question set re_step=re_step+1 where ref=? and re_step=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, ref);
			pstmt.setInt(2, reStep);
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updateReStep 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//글 번호 전달 받아 review 테이블에 저장된 게시글 검색하여 반환하는 메소드
		public QuestionDTO selectQuestionView(int num) {
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			QuestionDTO questionView = new QuestionDTO();
			
			try {
				con=getConnection();
				
				String sql = "select * from question where q_no=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, num);
				
				rs=pstmt.executeQuery();
				while(rs.next()) {
					questionView.setqNo(rs.getInt("q_no"));
					questionView.setqTitle(rs.getString("q_title"));
					questionView.setqContent(rs.getString("q_content"));
					questionView.setqDate(rs.getString("q_date"));
					questionView.setqStatus(rs.getInt("q_status"));
					questionView.setRef(rs.getInt("ref"));
					questionView.setRestep(rs.getInt("re_step"));
					questionView.setqUid(rs.getString("q_uid"));
				}
			} catch (SQLException e) {
				System.out.println("[에러]selectNoticeView 메소드의 SQL 오류 = "+e.getMessage());
			} finally {
				close(con, pstmt, rs);
			}
			
			return questionView;
		}
		//문의글 수정 메소드
		public int updateQuestion(QuestionDTO question) {
			Connection con=null;
			PreparedStatement pstmt=null;
			int rows=0;
			try {
				con=getConnection();
				
				String sql="update question set q_title=?,q_content=? where q_no=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, question.getqTitle());
				pstmt.setString(2, question.getqContent());
				pstmt.setInt(3, question.getqNo());
				rows=pstmt.executeUpdate()
						;
			} catch (SQLException e) {
				System.out.println("[에러]updateQuestion 메소드의 SQL 오류 = "+e.getMessage());
			} finally {
				close(con, pstmt);
			}
			return rows;		
		}
		//문의글 삭제 메소드
		public int deleteQuestion(int num) {
			Connection con = null;
			PreparedStatement pstmt = null;
			int rows = 0;
			try {
				con = getConnection();
				
				String sql = "delete from question where q_no = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				
				rows = pstmt.executeUpdate();
			} catch(SQLException e) {
				System.out.println("[에러]deleteQuestion 메소드의 SQL 오류 = "+e.getMessage());
			} finally {
				close(con, pstmt);
			}
			return rows;
			}
}

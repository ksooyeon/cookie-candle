package coocan.com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import coocan.com.dto.ReviewDTO;

public class ReviewDAO extends JdbcDAO{
	private static ReviewDAO _dao;
	
	private ReviewDAO() {
		// TODO Auto-generated constructor stub
	}
	
	static {
		_dao=new ReviewDAO();
	}
	
	public static ReviewDAO getDAO() {
		return _dao;
	}
	//review_write 글 쓰는 메소드
	public int insertReview(ReviewDTO review) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con = getConnection();
			
			String sql="insert into review values(r_no_seq.nextval,?,?,sysdate,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, review.getrTitle());
			pstmt.setString(2, review.getrContent());
			pstmt.setInt(3, review.getpNum());
			pstmt.setString(4, review.getrUid());
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]insertReview 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	//시작행 번호와 종료행 번호 사이에 저장된 게시글을 검색하여 반환하는 메소드
	public List<ReviewDTO> selectAllReviewList(int startRow, int endRow, String search, String keyword) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<ReviewDTO> reviewList=new ArrayList<ReviewDTO>();
		
		try {
			con=getConnection();
			
			if(keyword.equals("")) {//검색 기능을 사용하지 않은 경우
				String sql="select * from (select rownum rn, temp.* from "
						+ "(select * from review order by r_date desc)temp) "
						+ "where rn between ? and ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, endRow);
			} else {//검색 기능을 사용한 경우
				String sql="select * from (select rownum rn, temp.* from "
						+ "(select * from review where "+search
						+" like '%'||?||'%' order by r_date desc) temp) "
						+ "where rn between ? and ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, keyword);
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, endRow);
			}
			rs=pstmt.executeQuery();
			while(rs.next()) {
				ReviewDTO review = new ReviewDTO();
				review.setrNo(rs.getInt("r_no"));
				review.setrTitle(rs.getString("r_title"));
				review.setrContent(rs.getString("r_content"));
				review.setrDate(rs.getString("r_date"));
				review.setpNum(rs.getInt("p_num"));
				review.setrUid(rs.getString("r_uid"));
				reviewList.add(review);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectAllReviewList 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}	
		return reviewList;
	}
	//글 번호 전달 받아 review 테이블에 저장된 게시글 검색하여 반환하는 메소드
	public ReviewDTO selectReviewView(int num) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		ReviewDTO reviewView = new ReviewDTO();
		
		try {
			con=getConnection();
			
			String sql = "select * from review where r_no=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rs=pstmt.executeQuery();
			while(rs.next()) {
				reviewView.setrNo(rs.getInt("r_no"));
				reviewView.setrTitle(rs.getString("r_title"));
				reviewView.setrContent(rs.getString("r_content"));
				reviewView.setrDate(rs.getString("r_date"));
				reviewView.setpNum(rs.getInt("p_num"));
				reviewView.setrUid(rs.getString("r_uid"));
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectNoticeView 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		
		return reviewView;
	}
	
	public int updateReview(ReviewDTO review) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update review set r_title=?,r_content=?,p_num=? where r_no=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, review.getrTitle());
			pstmt.setString(2, review.getrContent());
			pstmt.setInt(3, review.getpNum());
			pstmt.setInt(4, review.getrNo());
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updateReview 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;		
	}
	
	public int deleteReview(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;
		try {
			con = getConnection();
			
			String sql = "delete from review where r_no = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rows = pstmt.executeUpdate();
		} catch(SQLException e) {
			System.out.println("[에러]deleteReview 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	//검색어 전달 받아서 review 테이블에 저장된 전체 게시글 중 검색어가 포함된 게시글의 갯수 검색하는 메소드
	public int selectReviewCount(String search, String keyword) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count=0;
		try {
			con=getConnection();
			
			if(keyword.equals("")) {//검색 기능을 사용하지 않은 경우
				String sql="select count(*) from review";
				pstmt=con.prepareStatement(sql);
			} else {//검색 기능을 사용한 경우
				String sql="select count(*) from review where "+search+" like '%'||?||'%'";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, keyword);
			}
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectReviewCount 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return count;
	}
	
	// 상품번호로 리뷰 받아오기 
	public List<ReviewDTO> selectReviewProductList(int num) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<ReviewDTO> reviewList=new ArrayList<ReviewDTO>();
		
		try {
			con=getConnection();
			
				String sql="select * from review where p_num=? order by r_date desc";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, num);
			
			rs=pstmt.executeQuery();
			while(rs.next()) {
				ReviewDTO review = new ReviewDTO();
				review.setrNo(rs.getInt("r_no"));
				review.setrTitle(rs.getString("r_title"));
				review.setrContent(rs.getString("r_content"));
				review.setrDate(rs.getString("r_date"));
				review.setpNum(rs.getInt("p_num"));
				review.setrUid(rs.getString("r_uid"));
				reviewList.add(review);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectReviewProductList 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}	
		return reviewList;
	}
}
	

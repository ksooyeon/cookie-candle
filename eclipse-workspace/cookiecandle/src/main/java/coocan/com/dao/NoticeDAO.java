package coocan.com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import coocan.com.dto.NoticeDTO;


public class NoticeDAO extends JdbcDAO {
	private static NoticeDAO _dao;
	
	private NoticeDAO() {
		// TODO Auto-generated constructor stub
	}
	
	static {
		_dao=new NoticeDAO();
	}
	
	public static NoticeDAO getDAO() {
		return _dao;
	}
	
	public int insertNotice(NoticeDTO notice) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con = getConnection();
			
			String sql="insert into notice values(n_no_seq.nextval,?,?,0,sysdate)";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, notice.getnTitle());
			pstmt.setString(2, notice.getnContent());
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]insertNotice 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	//시작행 번호와 종료행 번호 사이에 저장된 게시글을 검색하여 반환하는 메소드
	public List<NoticeDTO> selectAllNoticeList(int startRow, int endRow, String search, String keyword) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<NoticeDTO> noticeList=new ArrayList<NoticeDTO>();
		
		try {
			con=getConnection();
			
			if(keyword.equals("")) {//검색 기능을 사용하지 않은 경우
				String sql="select * from (select rownum rn, temp.* from "
						+ "(select * from notice order by n_date desc)temp) "
						+ "where rn between ? and ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, endRow);
			} else {//검색 기능을 사용한 경우
				String sql="select * from (select rownum rn, temp.* from "
						+ "(select * from notice where "+search
						+" like '%'||?||'%' order by n_date desc) temp) "
						+ "where rn between ? and ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, keyword);
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, endRow);
			}
			
			rs=pstmt.executeQuery();
			while(rs.next()) {
				NoticeDTO notice = new NoticeDTO();
				notice.setnNo(rs.getInt("n_no"));
				notice.setnTitle(rs.getString("n_title"));
				notice.setnContent(rs.getString("n_content"));
				notice.setnView(rs.getInt("n_view"));
				notice.setnDate(rs.getString("n_date"));
				noticeList.add(notice);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectAllNoticeList 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}	
		return noticeList;
	}
	//글 번호 전달 받아 notice 테이블에 저장된 게시글 검색하여 반환하는 메소드
	public NoticeDTO selectNoticeView(int num) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		NoticeDTO noticeView = new NoticeDTO();
		
		try {
			con=getConnection();
			
			String sql = "select * from notice where n_no=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rs=pstmt.executeQuery();
			while(rs.next()) {
				noticeView.setnNo(rs.getInt("n_no"));
				noticeView.setnTitle(rs.getString("n_title"));
				noticeView.setnContent(rs.getString("n_content"));
				noticeView.setnView(rs.getInt("n_view"));
				noticeView.setnDate(rs.getString("n_date"));
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectNoticeView 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		
		return noticeView;
	}
	//조회수 변경
	public int updateView(int num) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		
		try {
			con=getConnection();
			
			String sql="update notice set n_view = n_view+1 where n_no = ?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rows=pstmt.executeUpdate();
		}catch (SQLException e) {
			System.out.println("[에러]selectNoticeView 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		
		return rows;
	}
	//검색어 전달 받아서 notice 테이블에 저장된 전체 게시글 중 검색어가 포함된 게시글의 갯수 검색하는 메소드
	public int selectNoticeCount(String search, String keyword) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count=0;
		try {
			con=getConnection();
			
			if(keyword.equals("")) {//검색 기능을 사용하지 않은 경우
				String sql="select count(*) from notice";
				pstmt=con.prepareStatement(sql);
			}else {//검색 기능을 사용한 경우
				String sql="select count(*) from notice where "+search+" like '%'||?||'%'";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, keyword);
			}
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt(1);
			}
		}catch(SQLException e) {
			System.out.println("[에러]selectNoticeCount 메소드의 SQL 오류 = "+e.getMessage());
		}finally {
			close(con, pstmt, rs);
		}
		return count;
	}
}








package coocan.com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import coocan.com.dto.BoardDTO;
import coocan.com.dto.NoticeDTO;
import coocan.com.dto.QuestionDTO;
import coocan.com.dto.ReviewDTO;
import coocan.com.dto.UserDTO;

public class BoardDAO extends JdbcDAO{
	private static BoardDAO _dao;
	
	private BoardDAO() {
		// TODO Auto-generated constructor stub
	}
	
	static {
		_dao=new BoardDAO();
	}
	
	public static BoardDAO getDAO() {
		return _dao;
	}
	
	public List<BoardDTO> selectBoardList(String b_category, String b_writer, String s_word, String[] r_status, String s_date, String e_date) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<BoardDTO> boardList=new ArrayList<BoardDTO>();
		
		try {
				con=getConnection();
				
				String sql="select * from " + b_category;
				
				if(!b_writer.equals("") || !s_date.equals("") || !e_date.equals(""))
					sql += " where ";
				
				String f = b_category.substring(0, 1);
				List<String> list = new ArrayList<String>();
				
				if(!b_writer.equals("")) {
					if(b_writer.equals("title")) 
						sql += f + "_title like '%'||?||'%' ";
					
					else if(b_writer.equals("content")) 
						sql += f + "_content like '%'||?||'%' ";
					
					else if(b_writer.equals("writer_id")) {
						if(!f.equals("n"))
							sql += f + "_uid like '%'||?||'%' ";
					}
					
					list.add(s_word);
				}
					
				if(!s_date.equals("") && !e_date.equals("")) {
					sql += "and " + f + "_date between to_date(?, 'yyyy-mm-dd') and to_date(?, 'yyyy-mm-dd')+0.99999 ";
					list.add(s_date);
					list.add(e_date);
				}
					
				// 검색하려는 게시글의 카테고리가 문의일 경우, 답변 상태에 따라 검색
				if(f.equals("q")) {
					if(b_writer.equals("") && s_date.equals("") && e_date.equals(""))
						sql += " where (";
					else
						sql += "and (";
					for(int i=0;i<r_status.length;i++) {
						sql += "q_status = ? ";
						if(i < r_status.length-1)
							sql += "or ";
					}
					sql += ")";
				}
				
				pstmt=con.prepareStatement(sql);
				int i=0;
				for(i=1;i<=list.size();i++) {
					pstmt.setString(i, list.get(i-1));
				}
				if(f.equals("q")) {
					for(int j=i;j<=i+r_status.length-1;j++) {
						pstmt.setInt(j, Integer.parseInt(r_status[j-i]));
						
					}
				}
				
				rs=pstmt.executeQuery();
				while(rs.next()) {
					BoardDTO board = new BoardDTO();
					if(f.equals("n"))
						board.setId("관리자");
					else
						board.setId(rs.getString(f+"_uid"));
					board.setCategory(b_category);
					board.setTitle(rs.getString(f+"_title"));
					if(f.equals("n"))
						board.setName("관리자");
					board.setDate(rs.getString(f+"_date"));
					if(f.equals("q"))
						board.setStatus(Integer.toString(rs.getInt(f+"_status")));
					else
						board.setStatus("-");
					boardList.add(board);
				}
			
		} catch (SQLException e) {
			System.out.println("[에러]selectBoardList 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}	
		return boardList;
	}
	
	public int deleteBoard(String id, String category) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		
		String f = category.substring(0, 1);
		try {
			con=getConnection();
			
			String sql="delete from ? where " + f + "_no = ?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, category);
			pstmt.setInt(2, Integer.parseInt(id));
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]deleteProduct 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		} 
		return rows;
	}
	
	@SuppressWarnings("resource")
	public int[] countBoard() {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int[] count = new int[4];
		
		try {
			con=getConnection();
			
			// 공지사항 갯수 조회
			String sql1 = "select count(n_no) from notice";
			pstmt=con.prepareStatement(sql1);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				count[0] = rs.getInt(1);
			}
			
			// 리뷰 갯수 조회
			String sql2 = "select count(r_no) from review";
			pstmt=con.prepareStatement(sql2);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				count[1] = rs.getInt(1);
			} 
			
			// 문의사항 갯수 조회
			String sql3 = "select count(q_no) from question";
			pstmt=con.prepareStatement(sql3);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				count[2] = rs.getInt(1);
			}
			
			// 답변완료 갯수 조회
			String sql4 = "select count(q_no) from question where q_status = 1";
			pstmt=con.prepareStatement(sql4);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				count[3] = rs.getInt(1);
			}
			
		} catch (SQLException e) {
			System.out.println("[에러]countBoard 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		
		return count;
	}
}

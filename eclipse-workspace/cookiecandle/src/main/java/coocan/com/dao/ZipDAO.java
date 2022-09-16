package coocan.com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import coocan.com.dto.ZipDTO;



public class ZipDAO extends JdbcDAO {
	private static ZipDAO _dao;
	
	private ZipDAO() {
		// TODO Auto-generated constructor stub
	}
	
	static {
		_dao=new ZipDAO();		
	}
	
	public static ZipDAO getDAO() {
		return _dao;
	}
	
	//동이름으로 우편번호 검색
	public List<ZipDTO> selectZipList(String dong) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<ZipDTO> zipList=new ArrayList<ZipDTO>();
		try {
			con=getConnection();
			
			String sql="select * from zip where dong like ?||'%' order by zipcode";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, dong);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				ZipDTO zip=new ZipDTO();
				zip.setZipcode(rs.getString("zipcode"));
				zip.setDong(rs.getString("dong"));
				zip.setAddress(rs.getString("address"));
				zipList.add(zip);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectZipList 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return zipList;
	}
}











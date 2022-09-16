package coocan.com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import coocan.com.dto.UserDTO;
public class UserDAO extends JdbcDAO {
	private static UserDAO _dao;

	private UserDAO() {
		// TODO Auto-generated constructor stub
	}

	static {
		_dao = new UserDAO();
	}

	public static UserDAO getDAO() {
		return _dao;
	}

	public int insertUser(UserDTO user) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;
		try {
			con = getConnection();

			String sql = "insert into users values(?,?,?,?,?,?,?,?,0)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, user.getUid());
			pstmt.setString(2, user.getPasswd());
			pstmt.setString(3, user.getName());
			pstmt.setString(4, user.getAdd1());
			pstmt.setString(5, user.getAdd2());
			pstmt.setString(6, user.getZipcode());
			pstmt.setString(7, user.getPhone());
			pstmt.setString(8, user.getEmail());

			rows = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]insertUser 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}

	// 아이디 검색해서 유저 회원정보 테이블 검색
	public UserDTO selectUser(String uid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		UserDTO user = null;

		try {
			con = getConnection();
			String sql = "select * from users where u_id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, uid);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				user = new UserDTO();
				user.setUid(rs.getString("u_id"));
				user.setPasswd(rs.getString("u_pw"));
				user.setName(rs.getString("u_name"));
				user.setAdd1(rs.getString("u_add1"));
				user.setAdd2(rs.getString("u_add2"));
				user.setZipcode(rs.getString("u_zipcode"));
				user.setPhone(rs.getString("u_phone"));
				user.setEmail(rs.getString("u_email"));
				user.setStatus(rs.getInt("u_status"));
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectUser 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return user;
	}
	// 아이디찾기
	public UserDTO id_search(String name, String email,String phone,String choice) { 
		Connection con = null;
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		UserDTO user = null;
		try {
			con = getConnection();
			if(choice.equals("email"))
			{
				String sql = "select u_id from users where u_name=? and u_email=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, name);
				pstmt.setString(2, email);
			}else {
				String sql = "select u_id from users where u_name=? and u_phone=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, name);
				pstmt.setString(2, phone);
			
			}
			rs = pstmt.executeQuery();
			while (rs.next()) {
				user = new UserDTO();
				user.setUid(rs.getString("u_id"));
			}

		} catch (Exception e) {
			System.out.println("[에러]id_searchEmail 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs); // 디비연결 종료
		}
		
		return user;
	}
	
	
	// 비밀번호 찾기
	public UserDTO pwd_search(String uid, String name,String email,String phone,String choice) { 
		Connection con = null;
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		UserDTO user = null;
		try {
			con = getConnection();
			if(choice.equals("email"))
			{
				String sql = "select u_pw from users where u_id=? and u_name=? and u_email=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, uid);
				pstmt.setString(2, name);
				pstmt.setString(3, email);
			}else {
				String sql = "select u_pw from users where u_id=? and u_name=? and u_phone=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, uid);
				pstmt.setString(2, name);
				pstmt.setString(3, phone);
			}
			rs = pstmt.executeQuery();
			while (rs.next()) {
				user = new UserDTO();
				user.setPasswd(rs.getString("u_pw"));

			}

		} catch (Exception e) {
			System.out.println("[에러]pwd_searchPhone 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs); 
		}
		return user;
	}
	public int updatePwd(String pwd,String uid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows=0;
	

		try {
			con = getConnection();
			String sql = "update users set u_pw=? where u_id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, pwd);
			pstmt.setString(2, uid);

			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updatePwd 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	public int updateUser(UserDTO user) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;

		try {
			con = getConnection();
			String sql = "update users set u_pw=?, u_name=?, u_add1=?, u_add2=?, u_zipcode=?, u_phone=?, u_email=? where u_id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, user.getPasswd());
			pstmt.setString(2, user.getName());
			pstmt.setString(3, user.getAdd1());
			pstmt.setString(4, user.getAdd2());
			pstmt.setString(5, user.getZipcode());
			pstmt.setString(6, user.getPhone());
			pstmt.setString(7, user.getEmail());
			pstmt.setString(8, user.getUid());

			rows = pstmt.executeUpdate();

		} catch (SQLException e) {
			System.out.println("[에러]updateUser 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}

	// 회원 상태 변경 관리자:9 휴면:8 일반:0
	// 아이디와 상태값 받아와서 변경
	public int updateStatus(String uid, int status) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;

		try {
			con = getConnection();
			String sql = "update users set u_status=? where u_id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, status);
			pstmt.setString(2, uid);

			rows = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updateStatus 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}

	public List<UserDTO> selectAllUserList() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<UserDTO> userList = new ArrayList<UserDTO>();

		try {
			con = getConnection();

			String sql = "select * from users where u_status != 9";
			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();
			while (rs.next()) {
				UserDTO user = new UserDTO();
				user.setUid(rs.getString("u_id"));
				user.setPasswd(rs.getString("u_pw"));
				user.setName(rs.getString("u_name"));
				user.setAdd1(rs.getString("u_add1"));
				user.setAdd2(rs.getString("u_add2"));
				user.setZipcode(rs.getString("u_zipcode"));
				user.setPhone(rs.getString("u_phone"));
				user.setEmail(rs.getString("u_email"));
				userList.add(user);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectAllUserList 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return userList;
	}
	
	// made by 김수연
	
		public List<UserDTO> selectUserList (String search_id, String search_name, String user_category) {
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			List<UserDTO> userList=new ArrayList<UserDTO>();
			try {
				con=getConnection();
				
				String sql="select u_id, u_name, u_phone, u_email, u_status from users where ";
				
				List<String> list = new ArrayList<String>();
				
				if(!user_category.equals("")) {
					sql += "u_status = ? ";
				}
				else {
					sql += "(u_status = 0 or u_status = 8) ";
				}
				
				if(!search_name.equals("")) {
					sql += "and u_name = ? ";
					list.add(search_name);
				}
				
				if(!search_id.equals("")) {
					sql += "and u_id = ? ";
					list.add(search_id);
				}
				
				int i = 1;
				// 쿼리문 조건들 순서대로 삽입
				pstmt=con.prepareStatement(sql);
				if(!user_category.equals(""))
					pstmt.setInt(i++, Integer.parseInt(user_category));
				
				for(i=i;i<=list.size();i++) {
					pstmt.setString(i, list.get(i-1));
				}
				
				rs=pstmt.executeQuery();
				while(rs.next()) {
					UserDTO user = new UserDTO();
					user.setUid(rs.getString("u_id"));
					user.setName(rs.getString("u_name"));
					user.setPhone(rs.getString("u_phone"));
					user.setEmail(rs.getString("u_email"));
					user.setStatus(rs.getInt("u_status"));
					userList.add(user);
				}
			} catch (SQLException e) {
				System.out.println("[에러]selectProductList 메소드의 SQL 오류 = "+e.getMessage());
			} finally {
				close(con, pstmt, rs);
			}	
			return userList;
		}
		
		@SuppressWarnings("resource")
		public int[] countUsers() {
			
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			int[] count = new int[3];
			
			try {
				con=getConnection();
				
				// 관리자 제외 전체 회원수 조회
				String sql1 = "select count(u_id) from users where u_status != 9";
				pstmt=con.prepareStatement(sql1);
				rs=pstmt.executeQuery();
				while(rs.next()) {
					count[0] = rs.getInt(1);
				}
				
				// 일반 회원수 조회
				String sql2 = "select count(u_id) from users where u_status = 0";
				pstmt=con.prepareStatement(sql2);
				rs=pstmt.executeQuery();
				while(rs.next()) {
					count[1] = rs.getInt(1);
				} 
				
				// 휴면 회원수 조회
				String sql3 = "select count(u_id) from users where u_status = 8";
				pstmt=con.prepareStatement(sql3);
				rs=pstmt.executeQuery();
				while(rs.next()) {
					count[2] = rs.getInt(1);
				} 
			} catch (SQLException e) {
				System.out.println("[에러]countAllOrders 메소드의 SQL 오류 = "+e.getMessage());
			} finally {
				close(con, pstmt, rs);
			}
			
			return count;
		}
		
		// made by 김수연
}

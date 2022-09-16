package coocan.com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import coocan.com.dto.CartDTO;
import coocan.com.dto.NoticeDTO;

public class CartDAO extends JdbcDAO {
	private static CartDAO _dao;
	
	private CartDAO() {
		// TODO Auto-generated constructor stub
	}
	
	static {
		_dao=new CartDAO();
	}
	
	public static CartDAO getDAO() {
		return _dao;
	}
	
	public int insertCart (CartDTO cart) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con = getConnection();
			
			String sql="insert into cart values(c_no_seq.nextval,?,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, cart.getUid());
			pstmt.setInt(2, cart.getPid());
			pstmt.setInt(3, cart.getQuantity());
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]insertCart 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	public List<CartDTO> selectAllCartList() {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<CartDTO> cartList=new ArrayList<CartDTO>();
		
		try {
			con=getConnection();
			
			String sql="select * from cart";
			pstmt=con.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			while(rs.next()) {
				CartDTO cart = new CartDTO();
				cart.setCno(rs.getInt("c_no"));
				cart.setUid(rs.getString("c_uid"));
				cart.setPid(rs.getInt("c_pid"));
				cart.setQuantity(rs.getInt("c_quantity"));
				cartList.add(cart);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectAllCartList 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}	
		return cartList;
	}
	
	public int deleteCart(int pid , String uid ) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="delete from cart where c_pid=? and c_uid=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, pid);
			pstmt.setString(2, uid);
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]deleteMember 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		} 
		return rows;
	}

	public List<CartDTO> selectUserCartList(String uid) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<CartDTO> cartList=new ArrayList<CartDTO>();
		
		try {
			con=getConnection();
			
			String sql="select * from cart where c_uid = ?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, uid);

			rs=pstmt.executeQuery();
			while(rs.next()) {
				if(rs.getInt("c_pid") == 0) continue;
				CartDTO cart = new CartDTO();
				cart.setCno(rs.getInt("c_no"));
				cart.setUid(rs.getString("c_uid"));
				cart.setPid(rs.getInt("c_pid"));
				cart.setQuantity(rs.getInt("c_quantity"));
				cartList.add(cart);
				
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectUserCartList 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}	
		return cartList;
	}
	

}

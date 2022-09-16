package coocan.com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import coocan.com.dto.OrderDTO;
import coocan.com.dto.OrderListDTO;
import coocan.com.dto.UserDTO;

public class OrderDAO extends JdbcDAO {
	private static OrderDAO _dao;
	
	private OrderDAO() {
		// TODO Auto-generated constructor stub
	}
	
	static {
		_dao=new OrderDAO();
	}
	
	public static OrderDAO getDAO() {
		return _dao;
	}
	
	public int insertOrder (OrderDTO order) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con = getConnection();
			
			String sql="insert into orders values(o_no_seq.nextval,?,?,?,?,?,sysdate, 0)";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, order.getUid());
			pstmt.setString(2, order.getAdd1());
			pstmt.setString(3, order.getAdd2());
			pstmt.setString(4, order.getZipcode());
			pstmt.setString(5, order.getPayment());
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]insertOrder 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	public List<OrderDTO> selectOrderList(String uid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<OrderDTO> orderList=new ArrayList<OrderDTO>();

		try {
			con = getConnection();
			String sql="select * from orders where o_uid=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, uid);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				OrderDTO order = new OrderDTO();
				order.setOno(rs.getInt("o_no"));
				order.setUid(rs.getString("o_uid"));
				order.setAdd1(rs.getString("o_add1"));
				order.setAdd2(rs.getString("o_add2"));
				order.setZipcode(rs.getString("o_zipcode"));
				order.setPayment(rs.getString("o_payment"));
				order.setDate(rs.getString("o_date"));
				orderList.add(order);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectOrderList 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return orderList;
	}
	
	
	public List<OrderDTO> selectAllOrderList() {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<OrderDTO> orderList=new ArrayList<OrderDTO>();
		
		try {
			con=getConnection();
			
			String sql="select * from orders";
			pstmt=con.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			while(rs.next()) {
				OrderDTO order = new OrderDTO();
				order.setOno(rs.getInt("o_no"));
				order.setUid(rs.getString("o_uid"));
				order.setAdd1(rs.getString("o_add1"));
				order.setAdd2(rs.getString("o_add2"));
				order.setZipcode(rs.getString("o_zipcode"));
				order.setPayment(rs.getString("o_payment"));
				order.setDate(rs.getString("o_date"));
				orderList.add(order);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectAllOrderList 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}	
		return orderList;
	}
	
	// made by 김수연
	public List<OrderListDTO> selectOrderListNoCondition() {
		
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<OrderListDTO> orderList=new ArrayList<OrderListDTO>();
		
		try {
			con=getConnection();
			String sql = "select distinct o.o_date 주문일자, o.o_no 주문번호, u.u_name 주문자명, sum(p.p_price * c.c_quantity) 주문금액, o.o_payment 결제수단, o.o_stat 주문상태 from orders o, users u, cart c, product p where (o.o_uid = c.c_uid and c.c_uid = u.u_id) and c.c_pid = p.p_no group by o.o_no, o.o_date, u.u_name, o.o_payment, o.o_stat order by o.o_no";
			//String sql = "select * from orders";
			pstmt=con.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			while(rs.next()) {
				OrderListDTO orderlist = new OrderListDTO();
				orderlist.setDate(rs.getString("주문일자"));
				orderlist.setOrderNum(rs.getInt("주문번호"));
				orderlist.setuName(rs.getString("주문자명"));
				orderlist.setAllPrice(rs.getInt("주문금액"));
				orderlist.setPayment(rs.getString("결제수단"));
				orderlist.setStatus(rs.getInt("주문상태"));
				
				orderList.add(orderlist);
			}
			
		} catch (SQLException e) {
			System.out.println("[에러]selectOrderListNoCondition 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}	
		return orderList;
	}
	
	public List<OrderListDTO> selectOrderList (String o_num, String u_id, String pro_name, String[] o_status, String s_date, String e_date) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<OrderListDTO> orderList=new ArrayList<OrderListDTO>();
		
		try {
			con=getConnection();
			
			String sql="select distinct o.o_date 주문일자, o.o_no 주문번호, u.u_name 주문자명, sum(p.p_price * c.c_quantity) 주문금액, o.o_payment 결제수단, o.o_stat 주문상태 "
						+ "from orders o, users u, cart c, product p "
						+ "where (o.o_uid = c.c_uid and c.c_uid = u.u_id) and c.c_pid = p.p_no ";
			List<String> list = new ArrayList<String>();
			
			if(!s_date.equals("") && !e_date.equals("")) {
				sql += "and o.o_date between to_date(?, 'yyyy-mm-dd') and to_date(?, 'yyyy-mm-dd')+0.99999 ";
				list.add(s_date);
				list.add(e_date);
			}
			
			if(!pro_name.equals("")) {
				sql += "and p.p_name like '%'||?||'%' ";
				list.add(pro_name);
			}
			
			if(!u_id.equals("")) {
				sql += "and u.u_id like '%'||?||'%' ";
				list.add(u_id);
			}
			
			if(!o_num.equals("")) {
				sql += "and o.o_no = ? ";
			}
			
			sql += "and (";
			for(int i=0;i<o_status.length;i++) {
				sql += "o.o_stat = ? ";
				if(i < o_status.length-1)
					sql += "or ";
			}
			
			sql += ") group by o.o_no, o.o_date, u.u_name, o.o_payment, o.o_stat "
					+ "order by o.o_no";
			
			pstmt=con.prepareStatement(sql);
			int i=0;
			for(i=1;i<=list.size();i++) {
				pstmt.setString(i, list.get(i-1));
			}
			if(!o_num.equals("")) {
				pstmt.setInt(i, Integer.parseInt(o_num));
				i += 1;
			}
			
			int j=0;
			for(j=i;j<i+o_status.length;j++) {
				pstmt.setInt(j, Integer.parseInt(o_status[j-i]));
			}
			
			rs=pstmt.executeQuery();
			while(rs.next()) {
				OrderListDTO orderlist = new OrderListDTO();
				orderlist.setDate(rs.getString("주문일자"));
				orderlist.setOrderNum(rs.getInt("주문번호"));
				orderlist.setuName(rs.getString("주문자명"));
				orderlist.setAllPrice(rs.getInt("주문금액"));
				orderlist.setPayment(rs.getString("결제수단"));
				orderlist.setStatus(rs.getInt("주문상태"));
				orderList.add(orderlist);
			}
			
		} catch (SQLException e) {
			System.out.println("[에러]selectOrderList 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}	
		return orderList;
	}
	
	public List<OrderListDTO> selectOrderNumberList(int o_num) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<OrderListDTO> orderList=new ArrayList<OrderListDTO>();
		
		try {
			con=getConnection();
			
			String sql = "select distinct p.p_name 상품명, sum(p.p_price * c.c_quantity) 상품금액, o.o_payment 결제수단, o.o_stat 주문상태, o.o_date 주문일자 "
						+ "from orders o, users u, cart c, product p "
						+ "where (o.o_uid = c.c_uid and c.c_uid = u.u_id) and c.c_pid = p.p_no and o.o_no = ? "
						+ "group by p.p_name, u.u_name, o.o_payment, o.o_stat, o.o_date, p.p_price * c.c_quantity";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, o_num);
			
			rs=pstmt.executeQuery();
			while(rs.next()) {
				OrderListDTO orderlist = new OrderListDTO();
				orderlist.setPnames(rs.getString("상품명"));
				orderlist.setAllPrice(rs.getInt("상품금액"));
				orderlist.setPayment(rs.getString("결제수단"));
				orderlist.setStatus(rs.getInt("주문상태"));
				orderlist.setDate(rs.getString("주문일자"));
				orderList.add(orderlist);
			}
			
		} catch (SQLException e) {
			System.out.println("[에러]selectOrderList 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}	
		return orderList;
	}
	
	public int countAllOrders() {
		
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count = 0;
		
		try {
			con=getConnection();
			
			String sql="select count(o_no) 주문수 from orders";
			pstmt=con.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			while(rs.next()) {
				count = rs.getInt(1);
			}  
		} catch (SQLException e) {
			System.out.println("[에러]countAllOrders 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		
		return count;
	}
	
	public int[] countPayment() {
		
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int[] count = new int[2];
		
		try {
			con=getConnection();
			
			String sql="select count(o.o_uid) 주문수, sum(p.p_price * c.c_quantity) 실결제액 "
					+ "from orders o, cart c, product p "
					+ "where o.o_uid = c.c_uid and c.c_pid = p.p_no and o.o_stat != 0";
			pstmt=con.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			while(rs.next()) {
				count[0] = rs.getInt("주문수");
				count[1] = rs.getInt("실결제액");
			}  
		} catch (SQLException e) {
			System.out.println("[에러]countPayment 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		
		return count;
	}
	
	public int countStatus(int status) {
		
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count = 0;
		
		try {
			con=getConnection();
			
			String sql="select count(o_no) 주문수 from orders where o_stat = ? ";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, status);
			
			rs=pstmt.executeQuery();
			while(rs.next()) {
				count = rs.getInt(1);
			}  
		} catch (SQLException e) {
			System.out.println("[에러]countStatus 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		
		return count;
	}
	
	public int sumAllPrice() {
		
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count = 0;
		
		try {
			con=getConnection();
			
			String sql="select sum(p.p_price * c.c_quantity) 총액 "
					  + "from orders o, cart c, product p "
					  + "where o.o_uid = c.c_uid and c.c_pid = p.p_no";
			pstmt=con.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			while(rs.next()) {
				count = rs.getInt("총액");
			}  
		} catch (SQLException e) {
			System.out.println("[에러]sumAllPrice 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		
		return count;
		
	}
	
	// made by 김수연
}

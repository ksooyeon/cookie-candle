package coocan.com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import coocan.com.dto.ProductDTO;

public class ProductDAO extends JdbcDAO {
	private static ProductDAO _dao;

	private ProductDAO() {
		// TODO Auto-generated constructor stub
	}

	static {
		_dao=new ProductDAO();
	}

	public static ProductDAO getDAO() {
		return _dao;
	}

	// PRODUCT 테이블에 상품 데이터 삽입
	public int insertProduct(ProductDTO product) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();

			String sql="insert into product values(p_name_seq.nextval,?,?,?,?,?,sysdate,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, product.getPname());
			pstmt.setString(2, product.getImg1());
			pstmt.setString(3, product.getImg2());
			pstmt.setInt(4, product.getPrice());
			pstmt.setString(5, product.getKinds());
			pstmt.setInt(6, product.getStock());

			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]insertProduct 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}

	// PRODUCT 테이블 모든 데이터 반환
	public List<ProductDTO> selectAllProductList() {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<ProductDTO> productList=new ArrayList<ProductDTO>();

		try {
			con=getConnection();

			String sql="select * from product order by p_date desc";
			pstmt=con.prepareStatement(sql);

			rs=pstmt.executeQuery();
			while(rs.next()) {
				ProductDTO product=new ProductDTO();
				product.setPno(rs.getInt("p_no"));
				product.setPname(rs.getString("p_name"));
				product.setPrice(rs.getInt("p_price"));
				product.setKinds(rs.getString("p_kinds"));
				product.setDate(rs.getString("p_date"));
				productList.add(product);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectProductList 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}	
		return productList;
	}
	// 메인화면에 9개까지만 출력되게끔
	public List<ProductDTO> selectNineProductList() {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<ProductDTO> productList=new ArrayList<ProductDTO>();

		try {
			con=getConnection();

			String sql="select * from product where rownum <= 9";
			pstmt=con.prepareStatement(sql);

			rs=pstmt.executeQuery();
			while(rs.next()) {
				ProductDTO product=new ProductDTO();
				product.setPno(rs.getInt("p_no"));
				product.setPname(rs.getString("p_name"));
				product.setImg1(rs.getString("p_img1"));
				product.setImg2(rs.getString("p_img2"));
				product.setPrice(rs.getInt("p_price"));
				product.setKinds(rs.getString("p_kinds"));
				product.setDate(rs.getString("p_date"));
				product.setStock(rs.getInt("p_stock"));
				productList.add(product);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectProductList 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}	
		return productList;
	}

	//제품번호를 전달받아 PRODUCT 테이블에 저장된 제품정보를 검색하여 반환하는 메소드
	public ProductDTO selectProduct(int pno) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		ProductDTO product=null;
		try {
			con=getConnection();

			String sql="select * from product where p_no=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, pno);

			rs=pstmt.executeQuery();

			if(rs.next()) {
				product=new ProductDTO();
				product.setPno(rs.getInt("p_no"));
				product.setPname(rs.getString("p_name"));
				product.setImg1(rs.getString("p_img1"));
				product.setImg2(rs.getString("p_img2"));
				product.setPrice(rs.getInt("p_price"));
				product.setKinds(rs.getString("p_kinds"));
				product.setDate(rs.getString("p_date"));
				product.setStock(rs.getInt("p_stock"));
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectProduct 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}	
		return product;
	}

	//카테고리를 전달받아 PRODUCT 테이블에 저장된 해당 카테고리의 제품목록을 검색하여 반환하는 메소드
	// => PRODUCT 테이블에 저장된 모든 제품정보를 검색하여 반환
	public List<ProductDTO> selectProductList(String kinds) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<ProductDTO> productList=new ArrayList<ProductDTO>();
		try {
			con=getConnection();

			//동적 SQL 기능을 이용하여 매개변수에 전달된 값에 따라 다른 SQL 명령이 실행되도록 설정
			if(kinds.equals("ALL")) {
				String sql="select * from product order by p_kinds, p_name";
				pstmt=con.prepareStatement(sql);
			} else {
				String sql="select * from product where p_kinds=? order by p_kinds, p_name";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, kinds);
			}

			rs=pstmt.executeQuery();

			while(rs.next()) {
				ProductDTO product=new ProductDTO();
				product.setPno(rs.getInt("p_no"));
				product.setPname(rs.getString("p_name"));
				product.setImg1(rs.getString("p_img1"));
				product.setImg2(rs.getString("p_img2"));
				product.setPrice(rs.getInt("p_price"));
				product.setKinds(rs.getString("p_kinds"));
				product.setDate(rs.getString("p_date"));
				product.setStock(rs.getInt("p_stock"));
				productList.add(product);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectProductList 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}	
		return productList;
	}

	// 이름을 전달받아 이름이 포함된 상품리스트를 출력하는 메소드
	public List<ProductDTO> selectProductSearch(String pname) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<ProductDTO> productList=new ArrayList<ProductDTO>();

		try {
			con=getConnection();

			//검색 기능을 사용한 경우
			//검색대상은 값이 아니므로 ?(InParameter)로 표현 불가능 - 문자열 결합
			String sql="select * from product where p_name like '%'||?||'%'";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, pname);

			rs=pstmt.executeQuery();

			while(rs.next()) {
				ProductDTO product=new ProductDTO();
				product.setPno(rs.getInt("p_no"));
				product.setPname(rs.getString("p_name"));
				product.setImg1(rs.getString("p_img1"));
				product.setImg2(rs.getString("p_img2"));
				product.setPrice(rs.getInt("p_price"));
				product.setKinds(rs.getString("p_kinds"));
				product.setDate(rs.getString("p_date"));
				product.setStock(rs.getInt("p_stock"));
				productList.add(product);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectProductSearch 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return productList;
	}
	
	// made by 김수연
	// 조건별 PRODUCT 테이블의 데이터 조회
	public List<ProductDTO> selectProductList(String pname, String[] category, String sdate, String edate) throws ParseException {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<ProductDTO> productList=new ArrayList<ProductDTO>();
		try {
			con=getConnection();
			
			String sql="select p_no, p_name, p_price, p_kinds, p_date from product where (";
			
			// 체크된 카테고리 갯수만큼 쿼리문에 추가
			for(int i=0;i<category.length;i++) {
				sql += "p_kinds = ? ";
				if(i < category.length-1)
					sql += "or ";
			}
			sql += ") ";
			
			// 쿼리문에 삽입될 조건들 list에 삽입
			List<String> queryList = new ArrayList<String>();
			for(int i=0;i<category.length;i++)
				queryList.add(category[i]);

			if(!sdate.equals("") && !edate.equals("")) {
				sql += "and p_date between to_date(?, 'yyyy-mm-dd') and to_date(?, 'yyyy-mm-dd')+0.99999 ";

				queryList.add(sdate);
				queryList.add(edate);
			}
			
			// 상품명 입력받은 경우 리스트에 추가, 쿼리문에 추가
			if(!pname.equals("")) {
				queryList.add(pname);
				sql += "and p_name like '%'||?||'%' ";
			}
			
			sql += "order by p_date desc";
			
			// 쿼리문 조건들 순서대로 삽입
			pstmt=con.prepareStatement(sql);
			for(int i=1;i<=queryList.size();i++) {
				pstmt.setString(i, queryList.get(i-1));
			}
			
			rs=pstmt.executeQuery();
			while(rs.next()) {
				ProductDTO product=new ProductDTO();
				product.setPno(rs.getInt("p_no"));
				product.setPname(rs.getString("p_name"));
				product.setPrice(rs.getInt("p_price"));
				product.setKinds(rs.getString("p_kinds"));
				product.setDate(rs.getString("p_date"));
				productList.add(product);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectProductList 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}	
		return productList;
	}
		
	// 체크된 상품 삭제
	public int deleteProduct(String pid) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		System.out.println(pid);
		try {
			con=getConnection();
			
			String sql="delete from product where p_no=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, pid);
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]deleteProduct 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		} 
		return rows;
	}
	
	// 체크된 상품 카테고리 수정
	public int updateProductCategory(String category, String pid) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update product set p_kinds = ? where p_no = ?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, category);
			pstmt.setString(2, pid);
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updateProduct 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	// 체크된 상품 가격 변경
	public int updateProductPrice(int price, String pid) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update product set p_price = ? where p_no = ?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, price);
			pstmt.setString(2, pid);
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updateProduct 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
		
	// made by 김수연
	
	
	public ProductDTO selectProductId(int pid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ProductDTO product = new ProductDTO();

		try {
			con=getConnection();

			String sql="select * from product where p_no = ?";
			pstmt=con.prepareStatement(sql);
            pstmt.setInt(1, pid);

			rs = pstmt.executeQuery();
			while(rs.next()) {
			product.setPno(rs.getInt("p_no"));
			product.setPname(rs.getString("p_name"));
			product.setPrice(rs.getInt("p_price"));
			product.setKinds(rs.getString("p_kinds"));
			product.setDate(rs.getString("p_date"));
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectProduct 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return product;
	}

 
}

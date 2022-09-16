package coocan.com.dto;

public class OrderListDTO {
	private String date;
	private int orderNum;
	private String uName;
	private int allPrice;
	private String payment;
	private int status;
	private String pnames;
	
	public OrderListDTO() {
		// TODO Auto-generated constructor stub
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public int getOrderNum() {
		return orderNum;
	}

	public void setOrderNum(int orderNum) {
		this.orderNum = orderNum;
	}

	public String getuName() {
		return uName;
	}

	public void setuName(String uName) {
		this.uName = uName;
	}

	public int getAllPrice() {
		return allPrice;
	}

	public void setAllPrice(int allPrice) {
		this.allPrice = allPrice;
	}

	public String getPayment() {
		return payment;
	}

	public void setPayment(String payment) {
		this.payment = payment;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getPnames() {
		return pnames;
	}

	public void setPnames(String pnames) {
		this.pnames = pnames;
	}
	
	
	
}

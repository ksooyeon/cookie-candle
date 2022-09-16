package coocan.com.dto;

public class ReviewDTO {
	private int rNo;
	private String rTitle;
	private String rContent;
	private String rDate;
	private int pNum;
	private String rUid;
	
	public ReviewDTO() {
		// TODO Auto-generated constructor stub
	}

	public int getrNo() {
		return rNo;
	}

	public void setrNo(int rNo) {
		this.rNo = rNo;
	}

	public String getrTitle() {
		return rTitle;
	}

	public void setrTitle(String rTitle) {
		this.rTitle = rTitle;
	}

	public String getrContent() {
		return rContent;
	}

	public void setrContent(String rContent) {
		this.rContent = rContent;
	}

	public String getrDate() {
		return rDate;
	}

	public void setrDate(String rDate) {
		this.rDate = rDate;
	}

	public int getpNum() {
		return pNum;
	}

	public void setpNum(int pNum) {
		this.pNum = pNum;
	}

	public String getrUid() {
		return rUid;
	}

	public void setrUid(String rUid) {
		this.rUid = rUid;
	}
}

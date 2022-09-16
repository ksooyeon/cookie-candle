package coocan.com.dto;

public class QuestionDTO {
	private int qNo;
	private String qTitle;
	private String qContent;
	private String qDate;
	private int qStatus;//0-답변대기, 1-답변완료
	private int ref;
	private int restep;
	private String qUid;
	
	public QuestionDTO() {
		// TODO Auto-generated constructor stub
	}

	public int getqNo() {
		return qNo;
	}

	public void setqNo(int qNo) {
		this.qNo = qNo;
	}

	public String getqTitle() {
		return qTitle;
	}

	public void setqTitle(String qTitle) {
		this.qTitle = qTitle;
	}

	public String getqContent() {
		return qContent;
	}

	public void setqContent(String qContent) {
		this.qContent = qContent;
	}

	public String getqDate() {
		return qDate;
	}

	public void setqDate(String qDate) {
		this.qDate = qDate;
	}

	public int getqStatus() {
		return qStatus;
	}

	public void setqStatus(int qStatus) {
		this.qStatus = qStatus;
	}

	public int getRef() {
		return ref;
	}

	public void setRef(int ref) {
		this.ref = ref;
	}

	public int getRestep() {
		return restep;
	}

	public void setRestep(int restep) {
		this.restep = restep;
	}

	public String getqUid() {
		return qUid;
	}

	public void setqUid(String qUid) {
		this.qUid = qUid;
	}
}

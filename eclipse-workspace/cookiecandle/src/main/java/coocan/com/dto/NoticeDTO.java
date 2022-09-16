package coocan.com.dto;

public class NoticeDTO {
	private int nNo;
	private String nTitle;
	private String nContent;
	private int nView;
	private String nDate;
	
	public NoticeDTO() {
	}
	
	public int getnNo() {
		return nNo;
	}
	public void setnNo(int nNo) {
		this.nNo = nNo;
	}
	public String getnTitle() {
		return nTitle;
	}
	public void setnTitle(String nTitle) {
		this.nTitle = nTitle;
	}
	public String getnContent() {
		return nContent;
	}
	public void setnContent(String nContent) {
		this.nContent = nContent;
	}
	public int getnView() {
		return nView;
	}
	public void setnView(int nView) {
		this.nView = nView;
	}
	public String getnDate() {
		return nDate;
	}
	public void setnDate(String nDate) {
		this.nDate = nDate;
	}

	
}
package coocan.com.dto;


public class ZipDTO {
	public String zipcode; //우편번호
	public String dong;	//동
	public String address; //주소
	
	public ZipDTO() {
		// TODO Auto-generated constructor stub
	}

	public String getZipcode() {
		return zipcode;
	}

	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}

	public String getDong() {
		return dong;
	}

	public void setDong(String dong) {
		this.dong = dong;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}
}

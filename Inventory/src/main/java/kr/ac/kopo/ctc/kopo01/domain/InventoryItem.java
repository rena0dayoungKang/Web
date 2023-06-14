package kr.ac.kopo.ctc.kopo01.domain;

public class InventoryItem {
	
	private long id;  			//상품 번호
	private String name; 		//상품 명
	private int stock;			//재고 현황
	private String regiDate;	//상품등록일
	private String regiDateQ;	//재고등록일
	private String context;		//상품설명
	private String link;		//상품 사진
	private String userId;		//등록
	
	
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getStock() {
		return stock;
	}
	public void setStock(int stock) {
		this.stock = stock;
	}
	public String getRegiDate() {
		return regiDate;
	}
	public void setRegiDate(String regiDate) {
		this.regiDate = regiDate;
	}
	public String getRegiDateQ() {
		return regiDateQ;
	}
	public void setRegiDateQ(String regiDateQ) {
		this.regiDateQ = regiDateQ;
	}
	public String getContext() {
		return context;
	}
	public void setContext(String context) {
		this.context = context;
	}
	public String getLink() {
		return link;
	}
	public void setLink(String link) {
		this.link = link;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	
	
}

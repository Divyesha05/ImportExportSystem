package Pojo;

import java.util.Date;

public class ReportPojo {
	private int reportId;
	private int productId;
	private int consumerPortId;
	private String productName;
	private String issueType;
	private Date reportDate;
	private String solution;

	public int getReportId() {
		return reportId;
	}

	public void setReportId(int reportId) {
		this.reportId = reportId;
	}

	public int getProductId() {
		return productId;
	}

	public void setProductId(int productId) {
		this.productId = productId;
	}

	public int getConsumerPortId() {
		return consumerPortId;
	}

	public void setConsumerPortId(int consumerPortId) {
		this.consumerPortId = consumerPortId;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getIssueType() {
		return issueType;
	}

	public void setIssueType(String issueType) {
		this.issueType = issueType;
	}

	public Date getReportDate() {
		return reportDate;
	}

	public void setReportDate(Date reportDate) {
		this.reportDate = reportDate;
	}

	public String getSolution() {
		return solution;
	}

	public void setSolution(String solution) {
		this.solution = solution;
	}
}
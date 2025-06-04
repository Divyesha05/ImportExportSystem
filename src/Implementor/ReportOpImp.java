package Implementor;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import Db.GetConnection;
import Interface.ReportOp;
import Pojo.ReportPojo;

public class ReportOpImp implements ReportOp {

	@Override
	public void reportProduct(ReportPojo pojo) {
		String sql = "INSERT INTO reported_products (product_id, consumer_port_id, issue_type, solution) VALUES (?, ?, ?, ?)";

		try (Connection con = GetConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setInt(1, pojo.getProductId());
			ps.setInt(2, pojo.getConsumerPortId());
			ps.setString(3, pojo.getIssueType());
			ps.setString(4, "pending"); // Default solution is 'pending'

			int rowsAffected = ps.executeUpdate();
			System.out.println(rowsAffected > 0 ? "Report inserted successfully." : "Failed to insert report.");

		} catch (SQLException e) {
			System.err.println("SQL Error: " + e.getMessage());
		}
	}

	@Override
	public void updateReportStatus(int reportId, String newStatus) {
		String sql = "{CALL UpdateReportedProductStatus(?, ?)}"; // Call the stored procedure

		try (Connection con = GetConnection.getConnection(); CallableStatement cs = con.prepareCall(sql)) {

			// Set the input parameters for the stored procedure
			cs.setInt(1, reportId); // reportID
			cs.setString(2, newStatus); // newStatus

			// Execute the stored procedure
			cs.executeUpdate();
			System.out.println("Report status updated successfully using stored procedure.");

		} catch (SQLException e) {
			System.err.println("SQL Error: " + e.getMessage());
		}
	}

	@Override
	public List<ReportPojo> viewReportedIssues(int consumerId) {
		List<ReportPojo> reports = new ArrayList<>();

		try (Connection con = GetConnection.getConnection();
				PreparedStatement ps = con.prepareStatement("CALL ViewReportedIssues(?, 'Consumer')")) {

			ps.setInt(1, consumerId);

			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					ReportPojo report = new ReportPojo();
					report.setReportId(rs.getInt("report_id"));
					report.setProductName(rs.getString("product_name"));
					report.setIssueType(rs.getString("issue_type"));
					report.setReportDate(rs.getDate("report_date"));
					report.setSolution(rs.getString("solution")); // Use 'solution' column
					reports.add(report);
				}
			}

		} catch (SQLException e) {
			System.err.println("SQL Error: " + e.getMessage());
		}

		return reports;
	}

	@Override
	public List<ReportPojo> getReportedIssuesForSeller(int sellerId) {
		List<ReportPojo> reports = new ArrayList<>();
		String sql = "SELECT rp.report_id, p.product_name, rp.issue_type, rp.report_date, rp.solution "
				+ "FROM reported_products rp " + "JOIN products p ON rp.product_id = p.product_id "
				+ "WHERE p.seller_id = ?";

		try (Connection con = GetConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setInt(1, sellerId);
			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					ReportPojo report = new ReportPojo();
					report.setReportId(rs.getInt("report_id"));
					report.setProductName(rs.getString("product_name"));
					report.setIssueType(rs.getString("issue_type"));
					report.setReportDate(rs.getDate("report_date"));
					report.setSolution(rs.getString("solution"));
					reports.add(report);
				}
			}

		} catch (SQLException e) {
			System.err.println("SQL Error: " + e.getMessage());
		}

		return reports;
	}
}
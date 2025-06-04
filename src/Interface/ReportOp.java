package Interface;

import java.util.List;
import Pojo.ReportPojo;

public interface ReportOp {
    void reportProduct(ReportPojo pojo); 

    void updateReportStatus(int reportId, String newStatus);

    List<ReportPojo> viewReportedIssues(int consumerId); 

    List<ReportPojo> getReportedIssuesForSeller(int sellerId); 
}
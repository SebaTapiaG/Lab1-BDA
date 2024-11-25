package proyecto.entities;

public class QueriesReportEntity {

    private String userName;

    private String queryType;

    private String queryStatement;

    private Integer queryCount;

    public QueriesReportEntity(String userName, String queryType, String queryStatement, Integer queryCount) {
        this.userName = userName;
        this.queryType = queryType;
        this.queryStatement = queryStatement;
        this.queryCount = queryCount;
    }

    // Getters y Setters
    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getQueryType() {
        return queryType;
    }

    public void setQueryType(String queryType) {
        this.queryType = queryType;
    }

    public String getQueryStatement() {
        return queryStatement;
    }

    public void setQueryStatement(String queryStatement) {
        this.queryStatement = queryStatement;
    }

    public Integer getQueryCount() {
        return queryCount;
    }

    public void setQueryCount(Integer queryCount) {
        this.queryCount = queryCount;
    }
}

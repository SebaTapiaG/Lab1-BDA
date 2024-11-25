package proyecto.entities;

public class QueriesReportEntity {

    private String user_name;

    private String query_type;

    private String query_statement;

    private Integer query_count;

    public QueriesReportEntity(String user_name, String query_type, String query_statement, Integer query_count) {
        this.user_name = user_name;
        this.query_type = query_type;
        this.query_statement = query_statement;
        this.query_count = query_count;
    }

    // Getters y Setters
    public String getUserName() {
        return user_name;
    }

    public void setUserName(String userName) {
        this.user_name = userName;
    }

    public String getQueryType() {
        return query_type;
    }

    public void setQueryType(String queryType) {
        this.query_type = queryType;
    }

    public String getQueryStatement() {
        return query_statement;
    }

    public void setQueryStatement(String queryStatement) {
        this.query_statement = queryStatement;
    }

    public Integer getQueryCount() {
        return query_count;
    }

    public void setQueryCount(Integer queryCount) {
        this.query_count = queryCount;
    }
}

package proyecto.repositories;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Repository;
import org.sql2o.Connection;
import org.sql2o.Sql2o;
import proyecto.entities.QueriesReportEntity;

import java.util.ArrayList;
import java.util.List;

@Repository
public class QueriesReportRepositoryImp implements QueriesReportRepository {

    @Autowired
    private Sql2o sql2o;

    @Override
    public ResponseEntity<List<QueriesReportEntity>> getQueriesReport() {
        try (Connection conn = sql2o.open()) {
            List<QueriesReportEntity> queriesReports = conn.createQuery("SELECT * FROM get_queries_report()")
                    .executeAndFetch(QueriesReportEntity.class);

            return ResponseEntity.ok(queriesReports);

        } catch (Exception e) {
            return ResponseEntity.status(500).body(null);
        }
    }
}

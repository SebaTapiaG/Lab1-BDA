package proyecto.repositories;

import org.springframework.http.ResponseEntity;
import proyecto.entities.QueriesReportEntity;

import java.util.List;

public interface QueriesReportRepository {

    public ResponseEntity<List<QueriesReportEntity>> getQueriesReport();
}

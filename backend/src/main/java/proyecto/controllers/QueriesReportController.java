package proyecto.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import proyecto.entities.QueriesReportEntity;
import proyecto.repositories.QueriesReportRepository;
import proyecto.repositories.QueriesReportRepositoryImp;
import proyecto.service.ProductoService;

import java.util.List;

@RestController
@CrossOrigin("*")
@RequestMapping("/api/queries-report")
public class QueriesReportController {

    private final QueriesReportRepository queriesReportRepository;

    public QueriesReportController(QueriesReportRepository queriesReportRepository){
        this.queriesReportRepository = queriesReportRepository;
    }

    @GetMapping("")
    public ResponseEntity<List<QueriesReportEntity>> findAll(){
        return queriesReportRepository.getQueriesReport();
    }

}

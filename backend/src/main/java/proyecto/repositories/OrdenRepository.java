package proyecto.repositories;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Repository;
import proyecto.entities.OrdenEntity;

import java.util.List;

@Repository
public interface OrdenRepository {
    ResponseEntity<List<Object>> findAll();

    ResponseEntity findById(int id_orden);

    ResponseEntity<List<Object>> findByCliente(int id_cliente);

    ResponseEntity create(OrdenEntity orden);

    ResponseEntity update(OrdenEntity orden);

    ResponseEntity delete(int id_orden);
}

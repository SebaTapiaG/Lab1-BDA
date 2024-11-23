package proyecto.controllers;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import proyecto.entities.ClienteEntity;
import proyecto.service.ClienteService;

import java.util.List;


@RestController
@CrossOrigin("*")
@RequestMapping("/api/cliente")
public class ClienteController {

    private final ClienteService clienteService;

    public ClienteController(ClienteService clienteService) {
        this.clienteService = clienteService;
    }

    @GetMapping("")
    public ResponseEntity<List<Object>> findAll(){
        return clienteService.findAll();
    }

    @GetMapping("/cliente/{id_cliente}")
    public ResponseEntity<Object> findById(@PathVariable int id_cliente) {
        return clienteService.findById(id_cliente);
    }

    @GetMapping("/cliente/email/{email}")
    public ResponseEntity<Object> findByEmail(@PathVariable String email) {
        return clienteService.findByEmail(email);
    }

    @GetMapping("/cliente/login")
    public ResponseEntity<Object> loginUser(@RequestBody ClienteEntity user) {
        return clienteService.loginUser(user.getEmail(), user.getContrasena());
    }

    @PostMapping("/cliente/register")
    public ResponseEntity<Object> createUser(@RequestBody ClienteEntity user) {
        return clienteService.createUser(user);
    }


    @PutMapping("/cliente/update")
    public ResponseEntity<?> update(@RequestBody ClienteEntity cliente) {
        return clienteService.update(cliente);
    }

    @DeleteMapping("/cliente/delete/{id_cliente}")
    public ResponseEntity<?> delete(@PathVariable int id_cliente) {
        return clienteService.delete(id_cliente);
    }





}

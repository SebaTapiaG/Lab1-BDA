<template>
	<div class="title">
		<h1>Registro de cliente</h1>
	</div>
	<div class="input">
	 	<FloatLabel variant="in">
      <InputText id="nombre" v-model="state.nombre" variant="filled" size="large"/>
      <label for="in_label">Nombre</label>
    </FloatLabel>
	</div>
	<div class="input">
	 	<FloatLabel variant="in">
      <InputText id="email" v-model="state.email" variant="filled" size="large"/>
      <label for="in_label">Correo electronico</label>
    </FloatLabel>
	</div>
	<div class="input">
	 	<FloatLabel variant="in">
      <InputText id="direccion" v-model="state.direccion" variant="filled" size="large"/>
      <label for="in_label">Dirección</label>
    </FloatLabel>
	</div>
	<div class="input">
	 	<FloatLabel variant="in">
      <InputText id="phone" v-model="state.telefono" variant="filled" size="large"/>
      <label for="in_label">Número telefonico</label>
    </FloatLabel>
	</div>
	<div class="input-pass">
	 	<FloatLabel variant="in">
      <Password id="contrasena" v-model="state.contrasena" variant="filled" :feedback="false" toggleMask/>
      <label for="in_label">Contraseña</label>
    </FloatLabel>
	</div>
	<div class="input-pass">
	 	<FloatLabel variant="in">
      <Password id="recontrasena" v-model="state.recontrasena" variant="filled" :feedback="false" toggleMask/>
      <label for="in_label">Confirme su contraseña</label>
    </FloatLabel>
	</div>

  <!-- Mostrar mensaje de error -->
  <div v-if="state.errorMessage" class="error-message">{{ state.errorMessage }}</div>

	<div class="button">
		<Button @click="register">Crear cuenta</Button>
	</div>
	<div class="text">
		<p>
    ¿Ya tienes cuenta? 
    <RouterLink to="/" class="link">Inicia sesión</RouterLink>
  	</p>
	</div>
</template>

<script setup>
import { FloatLabel, InputText, Button, Password } from 'primevue';
import { z } from 'zod';
import { reactive } from 'vue';
import axios from 'axios';
import { useRouter } from 'vue-router';

const router = useRouter()

// Definir el esquema de validación
const schema = z.object({
    nombre: z.string().min(1, 'El nombre es obligatorio'),
    email: z.string().email('Correo electrónico inválido'),
    contrasena: z.string().min(8, 'La contraseña debe tener al menos 8 caracteres'),
    recontrasena: z.string().min(8, 'La contraseña debe tener al menos 8 caracteres'),
    telefono: z.string().min(9, 'Número de teléfono inválido'),
}).refine(data => data.contrasena === data.recontrasena, {
    message: 'Las contraseñas no coinciden',
    path: ['recontrasena'],
});

const state = reactive({
    nombre: undefined,
    email: undefined,
    contrasena: undefined,
    recontrasena: undefined,
    telefono: undefined,
    direccion: undefined,
    errorMessage: null, // Agregar estado para el mensaje de error
});

async function register() {
    const result = schema.safeParse(state);
    
    // Si hay errores en la validación, mostrar el primer mensaje
    if (!result.success) {
        state.errorMessage = result.error.errors[0].message; // Mostrar el primer error
        console.log(result.error.errors); // Para depuración
        return;
    }
    
    const userObj = {
        nombre: state.nombre,
        email: state.email,
        contrasena: state.contrasena,
        telefono: state.telefono,
        direccion: state.direccion
    };

    try {
        const response = await axios.post('http://localhost:8080/api/cliente/register', userObj);
        console.log(response.data);
        console.log("Usuario creado", userObj);
        router.push("/");
    } catch (error) {
        // Manejo del error
        if (error.response && error.response.data) {
            state.errorMessage = error.response.data.message || "Error al registrar el usuario.";
        } else {
            state.errorMessage = "Error desconocido.";
        }
        console.log(error);
    }
}
</script>

<style scoped>
.title {
	margin-top: 10%; 
	margin-left: 40%;
}
.input {
	margin-top: 1%; 
	margin-left: 40%;
}
.input-pass {
	margin-top: 1%; 
	margin-left: 40%;
}
.button {
	margin-top: 2%;
	margin-left: 44%;
}
.text {
	margin-top: 1%;
	margin-left: 42%;
}
.error-message {
	color: red; /* Estilo para el mensaje de error */
	margin-top: 10px;
	margin-left: 40%;
}
</style>
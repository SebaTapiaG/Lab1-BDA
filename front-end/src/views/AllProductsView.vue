
<template>
	<div v-for="(product,index) in products" class="card">
		<Card>
        <template #title>{{product.nombre}}</template>
        <template #content>
            <p>{{product.descripcion}}</p>
						<p>Precio: {{ product.precio }}$</p>
						<p>Stock: {{ product.stock }} unidades</p>
						<div>
            	<label for="cantidad" > Cantidad: </label>
            	<InputNumber v-model="values[index]" inputId="minmax" :min="0" :max="product.stock" fluid />
        		</div>
						<br>
						<Button @click="agregarCarrito(product.id_producto, product.nombre, values[index], product.precio, index)">Agregar al carrito</Button>
        </template>
    </Card>
	</div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import { Button, InputNumber, Card } from "primevue";
import axios from 'axios';

const products = ref([]);
const values = new Array(products.length).fill(null);


onMounted(async () => {
  try {
    const response = await axios.get('http://localhost:8080/api/producto');
    products.value = response.data; // Store fetched data into the 'products' ref
  } catch (error) {
    console.error('Error fetching products:', error);
  }
});

function agregarCarrito(idProducto, producto, cantidad, precio, indice){

	const nuevoProducto = [idProducto, producto, cantidad, cantidad*precio]
	// Paso 1: Recuperar el arreglo almacenado
	const misProductos = sessionStorage.getItem('carrito');

	// Paso 2: Si ya hay un arreglo almacenado, parsearlo. Si no, crear uno vacío
	let productos = misProductos ? JSON.parse(misProductos) : [];

	//Paso 3: Agregar un nuevo elemento al arreglo
	let encontrado = false;

	for (const producto of productos) {
    if (producto[0] === idProducto) { // idProducto debería ser producto[0], no [1].
        producto[2] += cantidad;
        producto[3] += cantidad * precio;
        encontrado = true;
        break;
    }
	}

	if (!encontrado) {
    productos.push(nuevoProducto);
	}

	// Paso 4: Volver a guardar el arreglo actualizado en sessionStorage
	sessionStorage.setItem('carrito', JSON.stringify(productos));

}

</script>

<style>
.card{
	margin-top: 1%;
}
</style>

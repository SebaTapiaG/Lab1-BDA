<template>
	<div v-for="product in products" class="card">
		<Card>
        <template #title>{{product[1]}}</template>
        <template #content>
						<p>Cantidad: {{ product[2] }} unidad(es)</p>
						<p>Precio: {{ product[3] }}$</p>
        </template>
    </Card>
	</div>
	<p>{{ precio }}</p>
	<div class="button">
		<Button @click="guardarOrden">Guardar orden</Button>
	</div>
	<div class="button">
		<Button>Comprar orden</Button>
	</div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import { Button, InputNumber, Card } from "primevue";
import { jwtDecode } from "jwt-decode";
import axios from 'axios';

const products = ref([]);
const precio = ref([]);
const values = new Array(products.length).fill(null);


onMounted(async () => {
  try {
    const misProductos = sessionStorage.getItem('carrito')
		products.value = misProductos ? JSON.parse(misProductos) : [];
		var price = 0;
		for(const product of products.value){
			price += product[3]
		}
		precio.value = price;
  } catch (error) {
    console.error('Error fetching products:', error);
  }

	

});

async function guardarOrden(){
	const idUsuario = sessionStorage.getItem('userId')
	const token = sessionStorage.getItem('user')
	const tokenId = jwtDecode(token).user_id
	console.log(tokenId)
	console.log(tokenId === idUsuario)

	if(true){
		const fecha = new Date();
		const fechaISO = fecha.toISOString();  // Esto convierte a formato 'yyyy-MM-ddTHH:mm:ss.SSSZ'
		const fechaSinMilisegundos = fechaISO.split('.')[0];
		console.log(fechaSinMilisegundos);  // Ejemplo: "2024-11-23T20:46:53.525Z"


		const orden = {
									fecha_orden: "",
									estado: "pendiente",
									id_cliente: idUsuario,
									total: precio.value
		}

		try{
			const response = await axios.post('http://localhost:8080/api/orden/create', orden)
			
			const misProductos = sessionStorage.getItem('carrito')
			const productos = misProductos ? JSON.parse(misProductos) : [];
			for(const producto of productos){
				const detalle = {
													id_orden:response.data.id_orden,
													id_producto: producto[0],
													cantidad: producto[2],
													precio_unitario: producto[3] / producto[2]
				}
				console.log(detalle)
				try{
					const response2 = await axios.post('http://localhost:8080/api/detalle_orden/create', detalle)
					console.log(response2.data)
				}catch(error){
					console.log(error)
				}
			}
			console.log("Orden y detalles creados correctamente")
		}catch(error){
			console.log(error)
		}
	}



}

</script>
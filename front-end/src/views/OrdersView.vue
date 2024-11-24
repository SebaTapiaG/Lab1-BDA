<template>
	<div v-for="order in orders" class="card">
		<Card>
        <template #title>N° de orden: {{order.id_orden}}</template>
        <template #content>
						<p>Fecha: {{ order.fecha_orden }}</p>
						<p>Estado: {{ order.estado }}</p>
						<p>Costo total: {{ order.total }}$</p>
						<Button @click="">Ver detalles</Button>
						<br>
						<br>
						<span v-if="order.estado === 'pendiente'">
							<Button @click="">Pagar</Button>
						</span>	
        </template>
    </Card>
	</div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import { Button, InputNumber, Card } from "primevue";
import { jwtDecode } from "jwt-decode";
import axios from 'axios';

const orders = ref([]);

onMounted(async () => {
  try {
		const id = sessionStorage.getItem('userId')
    const response = await axios.get(`http://localhost:8080/api/orden/findByCliente/${id}`)
		orders.value = response.data
  } catch (error) {
    console.error('Error fetching products:', error);
  }
});


</script>
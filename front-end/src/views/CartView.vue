<template>
	<div v-for="(product, index) in products" :key="product[0]" class="card">
		<Card>
			<template #title>{{ product[1] }}</template>
			<template #content>
				<p>Cantidad: {{ product[2] }} unidad(es)</p>
				<p>Precio: {{ (product[3]).toFixed(2) }}$</p> <!-- Mostrar precio con dos decimales -->

				<!-- Botón para eliminar el producto -->
				<Button @click="confirmRemoveProduct(index)">Eliminar</Button>
			</template>
		</Card>
	</div>

	<div class="text">
		<p>Costo total: {{ precio.toFixed(2) }}$</p> <!-- Mostrar costo total con dos decimales -->
	</div>
	
	<div class="button">
		<Button @click="guardarOrden">Guardar orden</Button>
	</div>
	
	<div class="button">
		<Button @click="comprarOrden">Comprar orden</Button>
	</div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import { Button, Card } from "primevue";
import { jwtDecode } from "jwt-decode";
import axios from 'axios';

const products = ref([]);
const precio = ref(0); // Cambiado a un valor numérico

onMounted(async () => {
	try {
		const misProductos = sessionStorage.getItem('carrito');
        const productos = misProductos ? JSON.parse(misProductos) : [];
		
        // Guardar productos y calcular precio total
        products.value = productos;
        updateTotalPrice(); // Calcular el precio total al cargar
    } catch (error) {
        console.error('Error fetching products:', error);
    }
});

// Función para calcular el costo total
function updateTotalPrice() {
    let totalPrice = 0;
    for (const product of products.value) {
        totalPrice += product[3]; // Asumiendo que product[3] es el precio total por producto
    }
    precio.value = totalPrice; // Actualizar el precio total
}

// Función para confirmar y eliminar un producto del carrito
function confirmRemoveProduct(index) {
    const confirmation = confirm("¿Estás seguro que quieres borrar el producto de tu carrito?");
    if (confirmation) {
        removeProduct(index); // Llamar a la función removeProduct si se confirma
    }
}

// Función para eliminar un producto del carrito
function removeProduct(index) {
    products.value.splice(index, 1); // Eliminar el producto del array
    updateTotalPrice(); // Actualizar el costo total
    updateSessionStorage(); // Actualizar sessionStorage
}

// Función para actualizar sessionStorage
function updateSessionStorage() {
    sessionStorage.setItem('carrito', JSON.stringify(products.value));
}

async function guardarOrden() {
	const idUsuario = sessionStorage.getItem('userId');
	const token = sessionStorage.getItem('user');
	const tokenId = jwtDecode(token).user_id;

	if (products.value.length === 0) { // Verificar si hay productos en el carrito
        alert("No hay productos en el carrito para guardar la orden.");
        return; // Salir si no hay productos
    }

	const fecha = new Date();
	const fechaISO = fecha.toISOString(); // Formato 'yyyy-MM-ddTHH:mm:ss.SSSZ'

	const orden = {
		fecha_orden: "",
		estado: "pendiente",
		id_cliente: idUsuario,
		total: precio.value,
	};

    try {
        const response = await axios.post('http://localhost:8080/api/orden/create', orden);
        const misProductos = sessionStorage.getItem('carrito');
        const productos = misProductos ? JSON.parse(misProductos) : [];
        for (const producto of productos) {
            const detalle = {
                id_orden: response.data.id_orden,
                id_producto: producto[0],
                cantidad: producto[2],
                precio_unitario: producto[3] / producto[2],
            };

            try {
                await axios.post('http://localhost:8080/api/detalle_orden/create', detalle);
            } catch (error) {
                console.error("Error al crear detalle de la orden:", error.response.data.message || error.message);
                alert(`Error: ${error.response.data.message || 'La orden no se pudo crear debido a falta de stock'}`);
                return; // Salir para evitar guardar la orden en caso de error
            }
        }

        sessionStorage.setItem('carrito', []);
        alert("Orden creada correctamente");
        window.location.reload(); // Recargar la página

    } catch (error) {
        console.error("Error al crear la orden:", error.response?.data?.message || error.message);
        alert(`Error: ${error.response?.data?.message || 'No se pudo crear la orden'}`);
    }
}

async function comprarOrden() {
	const idUsuario = sessionStorage.getItem('userId');
	const token = sessionStorage.getItem('user');
	const tokenId = jwtDecode(token).user_id;

	if (products.value.length === 0) { // Verificar si hay productos en el carrito
        alert("No hay productos en el carrito para realizar la compra.");
        return; // Salir si no hay productos
    }

	const fecha = new Date();
	const fechaISO = fecha.toISOString(); // Formato 'yyyy-MM-ddTHH:mm:ss.SSSZ'

	const orden = {
		fecha_orden: "",
		estado: "pagada",
		id_cliente: idUsuario,
		total: precio.value,
	};

	try {
	    const response = await axios.post('http://localhost:8080/api/orden/create', orden);
	    const misProductos = sessionStorage.getItem('carrito');
	    const productos = misProductos ? JSON.parse(misProductos) : [];
	    for (const producto of productos) {
	        const detalle = {
	            id_orden: response.data.id_orden,
	            id_producto: producto[0],
	            cantidad: producto[2],
	            precio_unitario: producto[3] / producto[2],
	        };

	        try {
	            await axios.post('http://localhost:8080/api/detalle_orden/create', detalle);
	        } catch (error) {
	            console.error("Error al crear detalle de la orden:", error.response.data.message || error.message);
	            alert(`Error: ${error.response.data.message || 'La orden no se pudo crear debido a falta de stock'}`);
	            return; // Salir para evitar guardar la orden en caso de error
	        }
	    }

	    sessionStorage.setItem('carrito', []);
	    alert("Orden creada correctamente");
	    window.location.reload(); // Recargar la página

	} catch (error) {
	    console.error("Error al crear la orden:", error.response?.data?.message || error.message);
	    alert(`Error: ${error.response?.data?.message || 'No se pudo crear la orden'}`);
	}
}
</script>

<style scoped>
.card{
	margin-top: 1%;
}

.text {
	margin-top: 20px;
	font-weight: bold;
}

.button {
	margin-top: 10px;
}
</style>
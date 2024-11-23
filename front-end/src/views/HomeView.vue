<template>
  <div class="home">
    <header class="hero">
      <h1>Bienvenido a nuestra tienda</h1>
      <p>Encuentra los mejores productos al mejor precio</p>
    </header>

    <section class="categories">
      <h2>Filtrar por Categorías</h2>
      <div class="category-filter">
        <label for="category-select">Selecciona una categoría:</label>
        <select id="category-select" v-model="selectedCategory">
          <option value="">-- Selecciona una categoría --</option>
          <option v-for="category in categories" :key="category.id" :value="category.id">
            {{ category.name }}
          </option>
        </select>
        <button @click="filterByCategory" class="filter-button">Filtrar</button>
      </div>
    </section>

    <section class="featured-products">
      <h2>Productos</h2>

      <!-- Mostrar mensaje si no hay productos -->
      <div v-show="featuredProducts.length === 0" class="no-products">
        No hay productos disponibles.
      </div>

      <!-- Mostrar productos si hay alguno -->
      <div v-show="featuredProducts.length > 0" class="product-grid">
        <ProductCard
          v-for="product in featuredProducts"
          :key="product.id"
          :id="product.id"
          :name="product.name"
          :price="product.price"
          :imgId="product.imgId"
          :descripcion="product.description"
          :stock="product.stock"
          :estado="product.estado"
          :categoriaId="product.categoriaId"
        />
      </div>
    </section>
  </div>
</template>

<script setup>
import { ref } from 'vue';
import ProductCard from '@/components/ProductCard.vue';
import axios from 'axios';

const categories = ref([
  { id: 1, name: 'Electrónica' },
  { id: 2, name: 'Ropa' },
  { id: 3, name: 'Hogar' },
  { id: 4, name: 'Juguetes' },
  { id: 5, name: 'Deportes' },
]);

const featuredProducts = ref([]); // Lista de productos filtrados
const selectedCategory = ref(null); // Categoría seleccionada

// Función para filtrar productos por categoría
async function filterByCategory() {
  if (selectedCategory.value) {
    try {
      const response = await axios.get(`http://localhost:8080/api/producto/categoria/${selectedCategory.value}`);
      featuredProducts.value = response.data;
    } catch (error) {
      console.error('Error al filtrar productos por categoría:', error);
      featuredProducts.value = [];
    }
  } else {
    // Si no se selecciona categoría, vaciar la lista de productos
    featuredProducts.value = [];
  }
}
</script>

<style scoped>
.home {
  padding: 20px;
  font-family: 'Arial', sans-serif;
  color: #333;
  background-color: #f9f9f9; 
}

.hero {
  text-align: center;
  margin-bottom: 40px;
  background-color: #4caf50; 
  color: white;
  padding: 40px 20px;
  border-radius: 10px;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); 
}

.hero h1 {
  font-size: 2.5rem;
  margin: 0;
}

.hero p {
  font-size: 1.2rem;
  margin: 10px 0 0;
}

.featured-products, .categories {
  margin-bottom: 40px;
}

.featured-products h2, .categories h2 {
  font-size: 1.8rem;
  color: #333;
  text-align: center;
  margin-bottom: 20px;
}

.product-grid, .category-grid {
  display: grid;
  gap: 20px;
  grid-template-columns: repeat(auto-fill, minmax(250px, 1fr)); /* Columnas más amplias */
}

.product-grid > div, .category-grid > div {
  background: white;
  border-radius: 10px;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
  padding: 20px;
  text-align: center;
  transition: transform 0.2s, box-shadow 0.2s;
}

.product-grid > div:hover, .category-grid > div:hover {
  transform: translateY(-5px);
  box-shadow: 0 6px 10px rgba(0, 0, 0, 0.15);
}

.product-grid img, .category-grid img {
  max-width: 100%;
  border-radius: 10px;
  margin-bottom: 10px;
}

.product-grid h3, .category-grid h3 {
  font-size: 1.2rem;
  color: #4caf50;
}

.product-grid p, .category-grid p {
  font-size: 1rem;
  color: #666;
}
.category-filter {
  display: flex;
  flex-direction: column;
  align-items: center;
  margin-bottom: 20px;
}

.category-filter label {
  font-size: 1.2rem;
  margin-bottom: 10px;
}

.category-filter select {
  padding: 10px;
  font-size: 1rem;
  border: 1px solid #ccc;
  border-radius: 5px;
  width: 250px;
  text-align: center;
}

.no-products {
  text-align: center;
  font-size: 1.2rem;
  color: #666;
  margin-top: 20px;
}

@media (min-width: 768px) {
  .hero h1 {
    font-size: 3rem;
  }

  .hero p {
    font-size: 1.5rem;
  }
}

</style>

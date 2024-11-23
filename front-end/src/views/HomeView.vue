<template>
  <div class="home">
    <header class="hero">
      <h1>Bienvenido a nuestra tienda</h1>
      <p>Encuentra los mejores productos al mejor precio</p>
    </header>

    <section class="featured-products">
      <h2>Productos Destacados</h2>
      <div class="product-grid">
        <ProductCard
            v-for="product in featuredProducts"
            :key="product.id"
            :id="product.id"
            :name="product.name"
            :price="product.price"
            :imgId="product.imgId"
        />
      </div>
    </section>

    <section class="categories">
      <h2>Categorías</h2>
      <div class="category-grid">
        <CategoryCard
            v-for="category in categories"
            :key="category.id"
            :name="category.name"
            :imgId="category.imgId"
        />
      </div>
    </section>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import ProductCard from '@/components/ProductCard.vue';
//import CategoryCard from '@/components/CategoryCard.vue';

const featuredProducts = ref([]);
const categories = ref([]);

async function fetchFeaturedProducts() {
  featuredProducts.value = await fetch('/api/featured-products').then(res => res.json());
}

async function fetchCategories() {
  // Aquí realizarías la llamada a tu API para obtener categorías
  categories.value = await fetch('/api/categories').then(res => res.json());
}

onMounted(() => {
  fetchFeaturedProducts();
  fetchCategories();
});
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

@media (min-width: 768px) {
  .hero h1 {
    font-size: 3rem;
  }

  .hero p {
    font-size: 1.5rem;
  }
}

</style>

<script>
import { auth } from "@/services/authService";

export default {
	name: "App",
  setup() {
    return {
      auth
    }
  },

  methods: {
    getUser() {
      this.user = sessionStorage.getItem('user');  // Recupera el usuario de sessionStorage
    },
    logout() {
      auth.logout();  // Llama al método logout del servicio
      this.$router.push('/login');  // Redirige al login después de hacer logout
    }
  }
};
</script>

<template>
  <nav>
    <router-link to="/">Home | </router-link>
    
    <!-- Mostrar Login y Register solo si el usuario no está logueado -->
    <router-link to="/login" v-if="!auth.isLogged()">Login | </router-link> 
    <router-link to="/register" v-if="!auth.isLogged()">Register </router-link> 

    <!-- Mostrar Logout solo si el usuario está logueado -->
    <router-link to="/" @click="logout" v-if="auth.isLogged()">Logout | </router-link> 
  </nav>
  <router-view/>
</template>

<style scoped>
header {
  line-height: 1.5;
}

.logo {
  display: block;
  margin: 0 auto 2rem;
}

@media (min-width: 1024px) {
  header {
    display: flex;
    place-items: center;
    padding-right: calc(var(--section-gap) / 2);
  }

  .logo {
    margin: 0 2rem 0 0;
  }

  header .wrapper {
    display: flex;
    place-items: flex-start;
    flex-wrap: wrap;
  }
}
</style>

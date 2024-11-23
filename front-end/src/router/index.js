import { createRouter, createWebHistory } from 'vue-router';
import HomeView from '../views/HomeView.vue';
import ProductView from '../views/ProductView.vue';
import RegisterView from '../views/RegisterView.vue';
import LoginView from '../views/LoginView.vue';

const routes = [
    {
        path: '/',
        name: 'Home',
        component: HomeView,
    },
    {
        path: '/producto/:id',
        name: 'Product',
        component: ProductView,
    },
		{
			path: '/register',
			name: 'Register',
			component: RegisterView,
		},
		{
			path: '/login',
			name: 'Login',
			component: LoginView,
		},
];

const router = createRouter({
    history: createWebHistory(),
    routes,
});

export default router;

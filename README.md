🏛️ Expotec Ágora 

¡Bienvenido al repositorio del proyecto **Ágora**! Este sistema cuenta con una arquitectura dividida en un servidor backend (Node.js + Express) y una aplicación frontend construida en React (`AGORA`).

---

~~ Guía de Inicio Rápido ~~

Sigue estos pasos en tu terminal para instalar todas las dependencias requeridas y poner a funcionar el proyecto de manera local.

📁 1. Configuración del Backend

El servidor se encarga de la API, autenticación y la base de datos. Entra a la carpeta correspondiente, instala sus paquetes e inicialízalo:

```bash
# Entrar a la carpeta del servidor
cd backend

# Instalar todas las dependencias del backend
npm install express cors dotenv bcrypt bcryptjs jsonwebtoken pg google-auth-library

# Iniciar el servidor backend
npm start
```

💻 2. Configuración del Frontend (AGORA)

La interfaz de usuario interactiva esta hecha en React. As[i que abre una **nueva terminal** (sin cerrar la del backend), ve a la carpeta del frontend, instala los módulos e inicializa la app:

```bash
# Entrar a la carpeta del frontend
cd AGORA

# Instalar dependencias de producción y diseño
npm install react react-dom react-router-dom framer-motion lucide-react sweetalert2 @react-oauth/google

# Instalar herramientas de desarrollo (Webpack y Babel)
npm install --save-dev webpack webpack-cli webpack-dev-server babel-loader @babel/core @babel/preset-env @babel/preset-react css-loader style-loader html-webpack-plugin

# Iniciar la aplicación frontend
npm start
```
🗄️ 3. Configuración de la Base de Datos

Este proyecto utiliza **PostgreSQL**. Dentro de la carpeta `backend/` te dejamos el diseño de la base de datos listo para usar de dos formas diferentes. Elige la que prefieras al descargar el proyecto:

* **Opción A (Copiar y pegar - Recomendado):** Abre el archivo `backend/agoraexpo.sql`, copia todo su contenido de texto y ejecútalo en la consola de consultas (Query Tool) de tu pgAdmin.
* **Opción B (Restaurar archivo):** Si gustas de restaurar el archivo binario completo, crea una base de datos vacía llamada `agora`, haz clic derecho sobre ella en pgAdmin, selecciona **Restore** y carga el archivo `backend/agoraexpo.sql`.

🛠️ Tecnologías y Dependencias Clave

### Backend (`agoraya@1.0.0`)
* **Framework:** Express
* **Base de Datos:** PostgreSQL (`pg`)
* **Seguridad y Auth:** bcrypt, bcryptjs, jsonwebtoken, google-auth-library
* **Variables de entorno:** dotenv

### Frontend (`agora@1.0.0`)
* **Librería Principal:** React 19
* **Enrutamiento:** React Router Dom 7
* **Animaciones e Iconos:** Framer Motion, Lucide React
* **Alertas:** SweetAlert2
* **Autenticación:** Google OAuth
* **Empaquetador:** Webpack con Babel Compiler

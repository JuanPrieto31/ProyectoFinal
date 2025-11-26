<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Propuestas</title>
    

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.9.4/css/bulma.min.css">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
 
        :root {
            --wireframe-bg: #ffffff;
            --wireframe-card-bg: #eaecef;
            --wireframe-text: #2c3e50;
            --wireframe-skeleton: #34495e;
            --wireframe-image-bg: #1a1a1a;
            --primary-spinner: #c17817; 
        }

        body {
            background-color: var(--wireframe-bg);
            min-height: 100vh;
            font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
            color: var(--wireframe-text);
        }

        /* --- Navbar Minimalista --- */
        .custom-navbar {
            padding: 1rem 0;
            margin-bottom: 1rem;
            background: transparent;
        }

        .custom-nav-link {
            color: #4a4a4a !important;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .custom-nav-link:hover {
            background-color: transparent !important;
            color: #000 !important;
        }

        .custom-wireframe-card {
            background-color: var(--wireframe-card-bg);
            border: 1px solid #dbdbdb;
            border-radius: 0; /* Bordes rectos según wireframe */
            box-shadow: none;
            padding: 1.5rem;
            margin-bottom: 2rem;
        }

        .custom-image-placeholder {
            background-color: var(--wireframe-image-bg);
            height: 200px;
            width: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            margin-bottom: 1rem;
        }

        .custom-card-footer {
            border-top: none;
            padding-top: 1rem;
            justify-content: center;
            gap: 1rem;
            display: flex;
            flex-wrap: wrap;
        }

        .custom-action-link {
            color: #4a4a4a;
            font-size: 0.9rem;
            padding: 0.5rem;
            border: none;
            background: none;
            cursor: pointer;
            text-decoration: none;
        }

        .custom-action-link:hover {
            text-decoration: underline;
            color: #000;
        }

        .footer {
            background-color: white;
            padding: 3rem 1.5rem;
        }
        
        .footer-border-top {
            border-top: 1px solid #dbdbdb;
        }

        .custom-footer-link {
            color: #7a7a7a;
            margin: 0 1rem;
            transition: color 0.2s;
        }

        .custom-footer-link:hover {
            color: #363636;
        }

        .loading-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(255, 255, 255, 0.95);
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 9999;
            display: none; /* Oculto por defecto */
        }

        .spinner {
            width: 50px;
            height: 50px;
            border: 3px solid rgba(193, 120, 23, 0.3);
            border-radius: 50%;
            border-top-color: var(--primary-spinner);
            animation: spin 1s ease-in-out infinite;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }
        
        .text-skeleton-content {
            color: #2c3e50;
            line-height: 1.6;
            margin-bottom: 1.5rem;
        }
    </style>
</head>
<body>
    <%
        // Lógica de sesión/parámetros existente
        String correo = request.getParameter("correo");
        if (correo == null || correo.trim().isEmpty()) {
            // Redirigir o manejar error si es necesario, por ahora permitimos renderizar para demo
            // response.sendRedirect("login.jsp?error=no_correo");
        }
    %>

    <!-- Spinner de Carga -->
    <div id="loading-spinner" class="loading-overlay">
        <div class="spinner"></div>
    </div>

    <!-- Navbar Minimalista -->
    <nav class="navbar is-transparent custom-navbar" role="navigation" aria-label="main navigation">
        <div class="container">
            <div class="navbar-brand">
                <!-- Link Perfil -->
                <a class="navbar-item custom-nav-link" href="perfil.jsp?correo=<%= correo %>">
                    <span class="icon"><i class="fas fa-user-circle fa-lg"></i></span>
                    <span>Perfil</span>
                </a>
            </div>
            <div class="navbar-menu is-active" style="box-shadow: none; padding: 0;"> <!-- Forzado activo para ver estructura -->
                <div class="navbar-end">
                    <!-- Link Menu (Dropdown simplificado o enlace directo) -->
                    <div class="navbar-item has-dropdown is-hoverable">
                        <a class="navbar-link custom-nav-link" href="#">
                            Menu
                        </a>
                        <div class="navbar-dropdown is-right">
                             <a class="navbar-item" href="index.jsp">
                                Inicio
                            </a>
                             <a class="navbar-item" href="login.jsp">
                                Cerrar Sesión
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </nav>

    <!-- Título Principal -->
    <section class="section pt-0 pb-4">
        <div class="container has-text-centered">
            <h1 class="title is-3 has-text-grey-dark" style="font-weight: 400;">Propuestas</h1>
        </div>
    </section>

    <!-- Contenedor de Propuestas -->
    <section class="section pt-0">
        <div class="container">
            <div class="columns is-centered">
                <div class="column is-12-mobile is-8-tablet is-6-desktop" id="propuestas-container">
                    <!-- Aquí se inyectarán las tarjetas vía JS -->
                </div>
            </div>
        </div>
    </section>

    <!-- Footer Global -->
    <footer class="footer footer-border-top">
        <div class="container">
            <div class="columns">
                <!-- Logo y Copyright -->
                <div class="column is-4">
                    <h4 class="title is-5 has-text-grey-dark">Logo</h4>
                    <p class="has-text-grey-light is-size-7">© 2025 Your Website. All rights reserved</p>
                </div>
                
                <!-- Links Centrales -->
                <div class="column is-4 has-text-centered-desktop">
                    <div class="is-flex is-justify-content-center" style="gap: 1rem; flex-wrap: wrap;">
                        <a href="#" class="custom-footer-link">Link one</a>
                        <a href="#" class="custom-footer-link">Link two</a>
                        <a href="#" class="custom-footer-link">Link three</a>
                        <a href="#" class="custom-footer-link">Link four</a>
                    </div>
                </div>
                
                <!-- Redes y Legales -->
                <div class="column is-4 has-text-right-desktop">
                    <div class="mb-4">
                        <span class="icon is-medium has-text-grey-dark mr-2"><i class="fab fa-facebook-square fa-lg"></i></span>
                        <span class="icon is-medium has-text-grey-dark"><i class="fab fa-twitter-square fa-lg"></i></span>
                    </div>
                    <div class="is-size-7">
                        <a href="#" class="has-text-grey-light mr-3">Privacy Policy</a>
                        <a href="#" class="has-text-grey-light">Terms of Service</a>
                    </div>
                </div>
            </div>
        </div>
    </footer>

    <script>
        const correoUsuario = "<%= correo != null ? correo : "" %>";
        // URL de tu Backend
        const apiURL = "http://localhost:8080/propuesta-ms/PropuestaControl";

        document.addEventListener('DOMContentLoaded', function() {
            console.log('🚀 Front iniciado para usuario: ' + correoUsuario);
            cargarPropuestas();
        });

        function setLoading(loading) {
            const spinner = document.getElementById('loading-spinner');
            spinner.style.display = loading ? 'flex' : 'none';
        }

        async function cargarPropuestas() {
            const contenedor = document.getElementById("propuestas-container");
            contenedor.innerHTML = "";
            setLoading(true);

            try {
                console.log('📤 Solicitando propuestas...');
                
                // Petición al Backend (Mantenemos tu lógica original)
                const response = await fetch(apiURL, {
                    method: "POST",
                    headers: { 
                        "Content-Type": "application/json",
                        "Accept": "application/json"
                    },
                    body: JSON.stringify({
                        accion: "listar",
                        correo: correoUsuario
                    })
                });

                if (!response.ok) {
                    // Fallback para demo si el backend no está corriendo
                    throw new Error('Error conexión backend'); 
                }

                const result = await response.json();
                setLoading(false);

                if (result.success && result.propuestas) {
                    renderizarPropuestas(result.propuestas, contenedor);
                } else {
                    mostrarMensaje("No se encontraron propuestas.", contenedor);
                }

            } catch (error) {
                console.error('❌ Error o Backend no disponible. Usando datos de prueba para visualización.', error);
                setLoading(false);
                
                // DATOS DE PRUEBA (Para que veas el diseño aunque falle la conexión)
                const datosPrueba = [
                    { autor: "User 1", contenido: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", titulo: "Propuesta Ejemplo" },
                    { autor: "User 2", contenido: "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", titulo: "Mejora de Parques" }
                ];
                renderizarPropuestas(datosPrueba, contenedor);
            }
        }

        function renderizarPropuestas(propuestas, contenedor) {
            if (propuestas.length === 0) {
                mostrarMensaje("No hay propuestas disponibles.", contenedor);
                return;
            }

            let html = '';
            propuestas.forEach(p => {
                // Mapeo de datos al diseño del Wireframe
                html += `
                <div class="card custom-wireframe-card">
                    <div class="card-content p-0">
                        <!-- Header Usuario -->
                        <div class="media mb-4">
                            <div class="media-left">
                                <figure class="image is-32x32">
                                    <i class="fas fa-user-circle fa-2x has-text-grey-dark"></i>
                                </figure>
                            </div>
                            <div class="media-content">
                                <p class="title is-6 has-text-grey-dark">\${p.autor || 'Usuario Anónimo'}</p>
                            </div>
                        </div>

                        <!-- Contenido Texto -->
                        <div class="content text-skeleton-content">
                            <p>\${p.contenido || p.descripcion || 'Sin contenido disponible.'}</p>
                        </div>

                        <!-- Placeholder Imagen (Wireframe) -->
                        <div class="custom-image-placeholder mb-4">
                            <i class="fas fa-image fa-3x has-text-grey-light"></i>
                        </div>
                    </div>
                    
                    <!-- Footer Acciones -->
                    <footer class="card-footer custom-card-footer">
                        <a href="#" class="custom-action-link">Donar</a>
                        <a href="#" class="custom-action-link">Reportar</a>
                        <a href="#" class="custom-action-link">Comentar</a>
                        <a href="#" class="custom-action-link">Compartir</a>
                    </footer>
                </div>
                `;
            });
            contenedor.innerHTML = html;
        }

        function mostrarMensaje(mensaje, contenedor) {
             contenedor.innerHTML = `
                <div class="notification is-light has-text-centered">
                    <p>\${mensaje}</p>
                </div>`;
        }
    </script>
</body>
</html>

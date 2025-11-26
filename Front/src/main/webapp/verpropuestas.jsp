<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Propuestas</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.9.4/css/bulma.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">

        <style>
            :root {
                --primary: #C17817;
                --primary-dark: #8B5A0F;
                --primary-light: #E89F3C;
                --bg-main: #FAFAFA;
                --shadow-sm: 0 4px 12px rgba(193, 120, 23, 0.08);
                --shadow-md: 0 12px 28px rgba(193, 120, 23, 0.12);
                --shadow-lg: 0 20px 48px rgba(193, 120, 23, 0.15);
            }

            body {
                background: linear-gradient(135deg, #FAFAFA 0%, #F3F4F6 100%);
                min-height: 100vh;
                font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
                position: relative;
            }

            body::before {
                content: '';
                position: fixed;
                top: -20%;
                left: -10%;
                width: 600px;
                height: 600px;
                background: radial-gradient(circle, rgba(193, 120, 23, 0.03) 0%, transparent 70%);
                border-radius: 50%;
                animation: float 25s ease-in-out infinite;
            }

            @keyframes float {
                0%, 100% {
                    transform: translate(0, 0);
                }
                50% {
                    transform: translate(30px, 30px);
                }
            }

            .navbar {
                background: white;
                box-shadow: var(--shadow-sm);
                border-bottom: 1px solid rgba(193, 120, 23, 0.08);
                backdrop-filter: blur(20px);
                display: flex;
                align-items: center;
                justify-content: space-between;
                padding: 0 1.5rem;
            }

            .navbar-item {
                color: var(--primary-dark);
                font-weight: 700;
                transition: all 0.3s ease;
                border-radius: 10px;
                margin: 0 0.25rem;
                font-size: 0.95rem;
                letter-spacing: 0.2px;
                padding: 0.75rem 1rem;
            }

            .navbar-item:hover {
                background: linear-gradient(135deg, rgba(193, 120, 23, 0.08), rgba(232, 159, 60, 0.12));
                color: var(--primary);
                transform: translateY(-2px);
            }

            .navbar-link {
                color: var(--primary-dark);
                font-weight: 700;
                border-radius: 10px;
                transition: all 0.3s ease;
                padding: 0.75rem 1rem;
            }

            .navbar-link:hover {
                background: linear-gradient(135deg, rgba(193, 120, 23, 0.08), rgba(232, 159, 60, 0.12));
            }

            .navbar-dropdown {
                background: white;
                border: 1px solid rgba(193, 120, 23, 0.08);
                box-shadow: var(--shadow-md);
                border-radius: 16px;
                padding: 0.75rem;
                margin-top: 0.5rem;
                position: absolute;
                top: 100%;
                right: 0;
                min-width: 200px;
                display: none;
            }

            .navbar-dropdown.is-active {
                display: block;
                animation: dropdownSlide 0.3s cubic-bezier(0.16, 1, 0.3, 1);
            }

            @keyframes dropdownSlide {
                from {
                    opacity: 0;
                    transform: translateY(-10px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .navbar-dropdown .navbar-item {
                padding: 0.875rem 1.5rem;
                margin: 0.25rem;
                border-radius: 10px;
                font-weight: 600;
            }

            .navbar-dropdown .navbar-item:hover {
                transform: translateX(5px);
            }

            /* Centrar el título en el navbar */
            .navbar-center {
                flex: 1;
                display: flex;
                justify-content: center;
                align-items: center;
            }

            .navbar-title {
                font-weight: 800;
                font-size: 1.5rem;
                color: var(--primary-dark);
                letter-spacing: -0.5px;
            }

            .navbar-start {
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .navbar-end {
                display: flex;
                align-items: center;
                gap: 0.5rem;
                position: relative;
            }

            .main-container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 3rem 1.5rem;
                position: relative;
                z-index: 1;
            }

            .propuesta-card {
                background: white;
                border-radius: 20px;
                margin-bottom: 2rem;
                box-shadow: var(--shadow-sm);
                transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
                border: 1px solid rgba(193, 120, 23, 0.08);
                overflow: hidden;
                animation: cardAppear 0.5s cubic-bezier(0.16, 1, 0.3, 1);
            }

            @keyframes cardAppear {
                from {
                    opacity: 0;
                    transform: translateY(20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .propuesta-card:hover {
                transform: translateY(-8px);
                box-shadow: var(--shadow-lg);
            }

            .propuesta-card .card-header {
                background: linear-gradient(135deg, rgba(193, 120, 23, 0.06), rgba(232, 159, 60, 0.10));
                padding: 2rem 2.5rem;
                border-bottom: 2px solid rgba(193, 120, 23, 0.12);
            }

            .propuesta-card .card-header-title {
                color: var(--primary-dark);
                font-weight: 800;
                font-size: 1.5rem;
                display: flex;
                align-items: center;
                gap: 1rem;
                letter-spacing: -0.3px;
            }

            .propuesta-card .card-header-title i {
                color: var(--primary);
                font-size: 1.75rem;
            }

            .propuesta-card .card-content {
                padding: 2.5rem;
                color: #374151;
                line-height: 1.8;
            }

            .propuesta-card .card-content .content {
                font-size: 1.05rem;
                margin-bottom: 2rem;
                font-weight: 500;
            }

            .propuesta-card .card-footer {
                border-top: 1px solid rgba(193, 120, 23, 0.08);
                background: linear-gradient(135deg, rgba(250, 250, 250, 0.3), rgba(243, 244, 246, 0.5));
                padding: 0;
                display: flex;
                justify-content: flex-end;
            }

            /* Solo botón de editar */
            .propuesta-card .card-footer-item {
                padding: 1.25rem 2rem;
                color: white;
                font-weight: 700;
                transition: all 0.3s ease;
                display: flex;
                align-items: center;
                gap: 0.75rem;
                font-size: 0.95rem;
                background: linear-gradient(135deg, var(--primary), var(--primary-light));
                border: none;
                cursor: pointer;
                border-radius: 10px;
                margin: 1rem;
                text-decoration: none;
            }

            .propuesta-card .card-footer-item:hover {
                background: linear-gradient(135deg, var(--primary-dark), var(--primary));
                color: white;
                transform: translateY(-2px);
                box-shadow: var(--shadow-md);
            }

            .loading-spinner {
                width: 56px;
                height: 56px;
                border: 5px solid rgba(193, 120, 23, 0.12);
                border-top: 5px solid var(--primary);
                border-radius: 50%;
                animation: spin 0.7s linear infinite;
                margin: 4rem auto;
                display: none;
            }

            @keyframes spin {
                to {
                    transform: rotate(360deg);
                }
            }

            .notification {
                border-radius: 16px;
                box-shadow: var(--shadow-sm);
                border-left: 5px solid;
                font-weight: 600;
                animation: fadeIn 0.4s ease;
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(-10px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .notification.is-warning {
                border-left-color: #F59E0B;
                background: linear-gradient(135deg, #FFFBEB 0%, #FEF3C7 100%);
                color: #92400E;
            }

            .notification.is-danger {
                border-left-color: #DC2626;
                background: linear-gradient(135deg, #FEF2F2 0%, #FEE2E2 100%);
                color: #991B1B;
            }

            .meta-info {
                display: flex;
                gap: 2rem;
                flex-wrap: wrap;
                margin-top: 1.5rem;
                padding-top: 1.5rem;
                border-top: 1px solid rgba(193, 120, 23, 0.08);
            }

            .meta-item {
                display: flex;
                align-items: center;
                gap: 0.75rem;
                color: #6B7280;
                font-size: 0.95rem;
                font-weight: 600;
            }

            .meta-item i {
                color: var(--primary-light);
                font-size: 1.1rem;
            }

            .meta-item strong {
                color: var(--primary-dark);
                font-weight: 700;
            }

            .navbar-burger {
                color: var(--primary-dark);
                transition: all 0.3s ease;
                background: none;
                border: none;
                cursor: pointer;
                font-size: 1.5rem;
            }

            .navbar-burger:hover {
                background: linear-gradient(135deg, rgba(193, 120, 23, 0.08), rgba(232, 159, 60, 0.12));
            }

            @media (max-width: 768px) {
                .navbar {
                    flex-wrap: wrap;
                    padding: 1rem;
                }

                .navbar-center {
                    display: none;
                }

                .navbar-menu {
                    background: white;
                    box-shadow: var(--shadow-md);
                    border-radius: 0 0 16px 16px;
                }

                .main-container {
                    padding: 2rem 1rem;
                }

                .propuesta-card .card-header {
                    padding: 1.5rem 1.75rem;
                }

                .propuesta-card .card-content {
                    padding: 2rem 1.75rem;
                }
            }
        </style>
    </head>

    <body>
        <%
            String correo = request.getParameter("correo");
            if (correo == null || correo.trim().isEmpty()) {
                response.sendRedirect("login.jsp?error=no_correo");
                return;
            }

            String correoEncoded = java.net.URLEncoder.encode(correo, "UTF-8");
        %>

        <!-- Navbar simplificado y centrado -->
        <nav class="navbar is-fixed-top" role="navigation" aria-label="main navigation">
            <div class="navbar-start">
                <a role="button" class="navbar-burger" aria-label="menu" aria-expanded="false" data-target="navbarMenu">
                    <i class="fas fa-bars"></i>
                </a>
                <a class="navbar-item" href="perfil.jsp?correo=<%= correoEncoded%>">
                    <i class="fas fa-user-circle"></i>
                    <span class="ml-2">Perfil</span>
                </a>
            </div>

            <!-- Título centrado en el navbar -->
            <div class="navbar-center">
                <h1 class="navbar-title">
                    <i class="fas fa-lightbulb mr-2"></i>Mis Propuestas
                </h1>
            </div>

            <div class="navbar-end">
                <div style="position: relative;">
                    <a class="navbar-link" id="menuToggle">
                        <i class="fas fa-ellipsis-v"></i>
                    </a>
                    <div class="navbar-dropdown is-right" id="menuDropdown">
                        <a class="navbar-item" href="verpropuestas.jsp?correo=<%= correoEncoded%>">
                            <i class="fas fa-list"></i>
                            <span>Ver Mis Propuestas</span>
                        </a>
                        <a class="navbar-item" href="nuevapropuesta.jsp?correo=<%= correoEncoded%>">
                            <i class="fas fa-plus"></i>
                            <span>Nueva Propuesta</span>
                        </a>
                        <hr style="margin: 0.5rem 0; border: none; border-top: 1px solid rgba(193, 120, 23, 0.08);">
                        <a class="navbar-item" href="login.jsp">
                            <i class="fas fa-sign-out-alt"></i>
                            <span>Cerrar Sesión</span>
                        </a>
                    </div>
                </div>
            </div>
        </nav>

        <div style="height: 80px;"></div>

        <!-- Eliminado el page-header duplicado y contenedor main innecesario -->
        <div class="main-container">
            <div class="loading-spinner" id="loadingSpinner"></div>
            <div id="propuestas"></div>
        </div>

        <script>
            const correoUsuario = "<%= correo%>";
            const apiURL = "http://localhost:8080/propuesta-ms/propuestas/";

            console.log('🚀 Front iniciado para usuario: ' + correoUsuario);

            document.addEventListener('DOMContentLoaded', function () {
                console.log('🔧 Configurando menús...');

                const menuToggle = document.getElementById('menuToggle');
                const menuDropdown = document.getElementById('menuDropdown');

                menuToggle.addEventListener('click', function (e) {
                    e.stopPropagation();
                    menuDropdown.classList.toggle('is-active');
                    console.log('📱 Menú ' + (menuDropdown.classList.contains('is-active') ? 'abierto' : 'cerrado'));
                });

                document.addEventListener('click', function (e) {
                    if (!menuDropdown.contains(e.target) && e.target !== menuToggle) {
                        menuDropdown.classList.remove('is-active');
                    }
                });

                const navbarBurger = document.querySelector('.navbar-burger');
                if (navbarBurger) {
                    navbarBurger.addEventListener('click', function () {
                        navbarBurger.classList.toggle('is-active');
                        console.log('🍔 Menú hamburguesa ' + (navbarBurger.classList.contains('is-active') ? 'abierto' : 'cerrado'));
                    });
                }

                console.log('📥 Iniciando carga de propuestas...');
                cargarPropuestas();
            });

            function setLoading(loading) {
                const spinner = document.getElementById('loadingSpinner');
                spinner.style.display = loading ? 'block' : 'none';
                console.log('🔄 Loading: ' + loading);
            }

            async function cargarPropuestas() {
                const contenedor = document.getElementById("propuestas");
                contenedor.innerHTML = "";
                setLoading(true);

                try {
                    console.log('📤 Solicitando propuestas para: ' + correoUsuario);

                    const url = new URL(apiURL);
                    if (correoUsuario && correoUsuario !== "null") {
                        url.searchParams.append('correo', correoUsuario);
                    }

                    console.log('🔗 URL de solicitud: ' + url.toString());

                    const response = await fetch(url, {
                        method: "GET",
                        headers: {
                            "Accept": "application/json"
                        }
                    });

                    console.log('📥 Response status: ' + response.status);
                    console.log('📥 Response ok: ' + response.ok);

                    if (!response.ok) {
                        throw new Error('Error en la API: ' + response.status + ' - ' + response.statusText);
                    }

                    const result = await response.json();
                    console.log('📋 Respuesta del servidor: ', result);

                    setLoading(false);

                    if (result.success) {
                        const propuestas = result.propuestas || [];
                        console.log('✅ Propuestas recibidas: ' + propuestas.length);

                        if (propuestas.length === 0) {
                            contenedor.innerHTML =
                                    '<div class="notification is-warning has-text-centered">' +
                                    '<i class="fas fa-info-circle fa-2x mb-3"></i>' +
                                    '<p>No hay propuestas disponibles. ¡Sé el primero en crear una!</p>' +
                                    '</div>';
                            return;
                        }

                        let html = '';
                        for (let i = 0; i < propuestas.length; i++) {
                            const p = propuestas[i];
                            const propuestaID = p.id || '';
                            html +=
                                    '<div class="card propuesta-card">' +
                                    '<header class="card-header">' +
                                    '<p class="card-header-title">' +
                                    '<i class="fas fa-lightbulb"></i>' +
                                    (p.titulo || 'Sin título') +
                                    '</p>' +
                                    '</header>' +
                                    '<div class="card-content">' +
                                    '<div class="content">' +
                                    (p.descripcion || 'Sin descripción') +
                                    '</div>' +
                                    '<div class="meta-info">' +
                                    '<div class="meta-item">' +
                                    '<i class="fas fa-calendar"></i>' +
                                    '<span><strong>' + (p.fechaCreacion || 'N/A') + '</strong></span>' +
                                    '</div>' +
                                    '<div class="meta-item">' +
                                    '<i class="fas fa-user"></i>' +
                                    '<span><strong>' + (p.autor || 'N/A') + '</strong></span>' +
                                    '</div>' +
                                    '</div>' +
                                    '</div>' +
                                    '<div class="card-footer">' +
                                    '<a href="editarpropuesta.jsp?id=' + propuestaID + '&correo=<%= correoEncoded%>' + '" class="card-footer-item">' +
                                    '<i class="fas fa-edit"></i>' +
                                    '<span>Editar</span>' +
                                    '</a>' +
                                    '</div>' +
                                    '</div>';
                        }
                        contenedor.innerHTML = html;
                    } else {
                        contenedor.innerHTML =
                                '<div class="notification is-danger">' +
                                '<p>' + (result.message || 'Error al cargar propuestas') + '</p>' +
                                '</div>';
                    }
                } catch (error) {
                    console.error('❌ Error:', error);
                    setLoading(false);
                    contenedor.innerHTML =
                            '<div class="notification is-danger">' +
                            '<p>Error al conectar con el servidor. Intenta más tarde.</p>' +
                            '</div>';
                }
            }
        </script>
    </body>
</html>
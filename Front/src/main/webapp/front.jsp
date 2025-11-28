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
            /* Paleta de colores suave para adultos mayores */
            :root {
                --primary: #8B7355;
                --primary-dark: #6B5344;
                --primary-light: #A89078;
                --primary-soft: #C4B5A5;
                --bg-main: #FAF8F5;
                --bg-warm: #F5F2EE;
                --card-bg: #FFFFFF;
                --text-dark: #4A4A4A;
                --text-medium: #6B6B6B;
                --text-light: #8B8B8B;
                --border-soft: rgba(139, 115, 85, 0.12);
                --shadow-soft: 0 4px 20px rgba(107, 83, 68, 0.08);
                --shadow-hover: 0 12px 36px rgba(107, 83, 68, 0.14);
                --warning-bg: #FFF8E1;
                --warning-text: #F57C00;
                --warning-border: #FFE082;
                --error-bg: #FFEBEE;
                --error-text: #C62828;
                --error-border: #EF9A9A;
            }

            body {
                background: linear-gradient(145deg, var(--bg-main) 0%, var(--bg-warm) 100%);
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
                background: radial-gradient(circle, rgba(139, 115, 85, 0.04) 0%, transparent 70%);
                border-radius: 50%;
                animation: float 25s ease-in-out infinite;
            }

            @keyframes float {
                0%, 100% { transform: translate(0, 0); }
                50% { transform: translate(30px, 30px); }
            }

            /* Navbar con estilo suave */
            .navbar {
                background: white;
                box-shadow: var(--shadow-soft);
                border-bottom: 1px solid var(--border-soft);
                backdrop-filter: blur(20px);
            }

            .navbar-item {
                color: var(--text-dark);
                font-weight: 600;
                transition: all 0.3s ease;
                border-radius: 10px;
                margin: 0 0.25rem;
                font-size: 0.95rem;
                letter-spacing: 0.2px;
            }

            .navbar-item:hover {
                background: linear-gradient(135deg, rgba(139, 115, 85, 0.08), rgba(168, 144, 120, 0.12));
                color: var(--primary);
                transform: translateY(-2px);
            }

            .navbar-link {
                color: var(--text-dark);
                font-weight: 600;
                border-radius: 10px;
                transition: all 0.3s ease;
            }

            .navbar-link:hover {
                background: linear-gradient(135deg, rgba(139, 115, 85, 0.08), rgba(168, 144, 120, 0.12));
            }

            .navbar-dropdown {
                background: white;
                border: 1px solid var(--border-soft);
                box-shadow: var(--shadow-hover);
                border-radius: 16px;
                padding: 0.75rem;
                margin-top: 0.5rem;
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
                font-weight: 500;
            }

            .navbar-dropdown .navbar-item:hover {
                transform: translateX(5px);
            }

            .navbar-center {
                flex-grow: 1;
                display: flex;
                justify-content: center;
                align-items: center;
            }

            .navbar-title {
                font-weight: 700;
                font-size: 1.5rem;
                color: var(--text-dark);
                letter-spacing: -0.5px;
            }

            .main-container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 3rem 1.5rem;
                position: relative;
                z-index: 1;
            }

            /* Cards con animaciones suaves */
            .propuesta-card {
                background: white;
                border-radius: 20px;
                margin-bottom: 2rem;
                box-shadow: var(--shadow-soft);
                transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
                border: 1px solid var(--border-soft);
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
                transform: translateY(-6px);
                box-shadow: var(--shadow-hover);
            }

            .propuesta-card .card-header {
                background: linear-gradient(135deg, rgba(139, 115, 85, 0.06), rgba(168, 144, 120, 0.10));
                padding: 2rem 2.5rem;
                border-bottom: 2px solid var(--border-soft);
            }

            .propuesta-card .card-header-title {
                color: var(--text-dark);
                font-weight: 700;
                font-size: 1.4rem;
                display: flex;
                align-items: center;
                gap: 1rem;
                letter-spacing: -0.3px;
            }

            .propuesta-card .card-header-title i {
                color: var(--primary);
                font-size: 1.5rem;
            }

            .propuesta-card .card-content {
                padding: 2.5rem;
                color: var(--text-medium);
                line-height: 1.8;
            }

            .propuesta-card .card-content .content {
                font-size: 1.05rem;
                margin-bottom: 2rem;
                font-weight: 500;
            }

            .propuesta-card .card-footer {
                border-top: 1px solid var(--border-soft);
                background: linear-gradient(135deg, rgba(250, 248, 245, 0.5), rgba(245, 242, 238, 0.7));
                padding: 0;
                display: flex;
                align-items: center;
                gap: 0;
            }

            .propuesta-card .card-footer-item {
                padding: 1.25rem 2rem;
                color: var(--primary);
                font-weight: 600;
                transition: all 0.3s ease;
                display: flex;
                align-items: center;
                gap: 0.75rem;
                font-size: 0.95rem;
                flex: 1;
                justify-content: center;
                border-right: 1px solid var(--border-soft);
            }

            .propuesta-card .card-footer-item:last-child {
                border-right: none;
            }

            .propuesta-card .card-footer-item:hover {
                background: linear-gradient(135deg, rgba(139, 115, 85, 0.08), rgba(168, 144, 120, 0.12));
                color: var(--primary-dark);
            }

            /* Botón de donación con color suave */
            .btn-donation {
                background: linear-gradient(145deg, var(--primary-light), var(--primary));
                color: white;
                border: none;
                padding: 1.25rem 2rem;
                border-radius: 0;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                display: flex;
                align-items: center;
                gap: 0.75rem;
                font-size: 0.95rem;
                flex: 1;
                justify-content: center;
            }

            .btn-donation:hover {
                background: linear-gradient(145deg, var(--primary), var(--primary-dark));
                color: white;
                transform: scale(1.02);
                box-shadow: 0 8px 16px rgba(139, 115, 85, 0.25);
            }

            .loading-spinner {
                width: 56px;
                height: 56px;
                border: 5px solid rgba(139, 115, 85, 0.12);
                border-top: 5px solid var(--primary);
                border-radius: 50%;
                animation: spin 0.7s linear infinite;
                margin: 4rem auto;
                display: none;
            }

            @keyframes spin {
                to { transform: rotate(360deg); }
            }

            .notification {
                border-radius: 16px;
                box-shadow: var(--shadow-soft);
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
                border-left-color: var(--warning-text);
                background: var(--warning-bg);
                color: var(--warning-text);
            }

            .notification.is-danger {
                border-left-color: var(--error-text);
                background: var(--error-bg);
                color: var(--error-text);
            }

            .button-as-link {
                background: none;
                border: none;
                color: inherit;
                font: inherit;
                cursor: pointer;
                display: flex;
                align-items: center;
                gap: 0.75rem;
                height: 100%;
                padding: 0.875rem 1.5rem;
                transition: all 0.3s ease;
                border-radius: 10px;
                width: 100%;
                text-align: left;
                margin: 0.25rem;
                font-weight: 500;
            }

            .button-as-link:hover {
                background: linear-gradient(135deg, rgba(139, 115, 85, 0.08), rgba(168, 144, 120, 0.12));
                transform: translateX(5px);
            }

            .meta-info {
                display: flex;
                gap: 2rem;
                flex-wrap: wrap;
                margin-top: 1.5rem;
                padding-top: 1.5rem;
                border-top: 1px solid var(--border-soft);
            }

            .meta-item {
                display: flex;
                align-items: center;
                gap: 0.75rem;
                color: var(--text-light);
                font-size: 0.95rem;
                font-weight: 500;
            }

            .meta-item i {
                color: var(--primary-light);
                font-size: 1.1rem;
            }

            .meta-item strong {
                color: var(--text-dark);
                font-weight: 600;
            }

            .navbar-burger {
                color: var(--text-dark);
                transition: all 0.3s ease;
            }

            .navbar-burger:hover {
                background: linear-gradient(135deg, rgba(139, 115, 85, 0.08), rgba(168, 144, 120, 0.12));
            }

            @media (max-width: 768px) {
                .navbar-center {
                    display: none;
                }

                .navbar-menu {
                    background: white;
                    box-shadow: var(--shadow-hover);
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

        <nav class="navbar is-fixed-top" role="navigation" aria-label="main navigation">
            <div class="navbar-brand">
                <a role="button" class="navbar-burger" aria-label="menu" aria-expanded="false" data-target="navbarMenu">
                    <span aria-hidden="true"></span>
                    <span aria-hidden="true"></span>
                    <span aria-hidden="true"></span>
                </a>
            </div>

            <div id="navbarMenu" class="navbar-menu">
                <div class="navbar-start">
                    <a class="navbar-item" href="perfil.jsp?correo=<%= correoEncoded%>">
                        <i class="fas fa-user-circle"></i>
                        <span class="ml-2">Perfil</span>
                    </a>
                </div>

                <div class="navbar-center">
                    <h1 class="navbar-title">
                        <i class="fas fa-lightbulb mr-2"></i>Propuestas
                    </h1>
                </div>

                <div class="navbar-end">
                    <div class="navbar-item has-dropdown">
                        <a class="navbar-link" id="menuToggle">
                            <i class="fas fa-bars"></i>
                            <span class="ml-2">Menú</span>
                        </a>
                        <div class="navbar-dropdown is-right" id="menuDropdown">
                            <a class="navbar-item" href="#">
                                <i class="fas fa-home"></i>
                                Inicio
                            </a>
                            <a class="navbar-item" href="verpropuestas.jsp?correo=<%= correoEncoded%>">
                                <i class="fas fa-user-circle"></i>
                                <span class="ml-2">Ver Mis Propuesta</span>
                            </a>
                            <a class="navbar-item" href="nuevapropuesta.jsp?correo=<%= correoEncoded%>">
                                <i class="fas fa-user-circle"></i>
                                <span class="ml-2">Nuevas Propuestas</span>
                            </a>
                            <hr class="navbar-divider">
                            <a class="navbar-item" href="#">
                                <i class="fas fa-cog"></i>
                                Configuración
                            </a>
                            <a class="navbar-item" href="login.jsp">
                                <i class="fas fa-sign-out-alt"></i>
                                Cerrar Sesión
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </nav>

        <div style="height: 52px;"></div>

        <main class="main-container">
            <div class="loading-spinner" id="loadingSpinner"></div>
            <div id="propuestas"></div>
        </main>

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

                const menuItems = menuDropdown.querySelectorAll('.navbar-item, .button-as-link');
                menuItems.forEach(item => {
                    item.addEventListener('click', function () {
                        menuDropdown.classList.remove('is-active');
                    });
                });

                const navbarBurger = document.querySelector('.navbar-burger');
                const navbarMenu = document.getElementById('navbarMenu');

                if (navbarBurger) {
                    navbarBurger.addEventListener('click', function () {
                        navbarBurger.classList.toggle('is-active');
                        navbarMenu.classList.toggle('is-active');
                        console.log('🍔 Menú hamburguesa ' + (navbarMenu.classList.contains('is-active') ? 'abierto' : 'cerrado'));
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
                            html +=
                                    '<div class="card propuesta-card">' +
                                    '<header class="card-header">' +
                                    '<p class="card-header-title">' +
                                    '<i class="fas fa-lightbulb"></i>' +
                                    (p.titulo || 'Sin título') +
                                    '</p>' +
                                    '</header>' +
                                    '<div class="card-content">' +
                                    '<div class="content">' + (p.descripcion || p.contenido || 'Sin descripción') + '</div>' +
                                    '<div class="meta-info">' +
                                    '<div class="meta-item">' +
                                    '<i class="fas fa-calendar-alt"></i>' +
                                    '<strong>Creado:</strong> ' + (p.fechaCreacion || p.fechacreacion || 'Fecha no disponible') +
                                    '</div>' +
                                    '<div class="meta-item">' +
                                    '<i class="fas fa-user"></i>' +
                                    '<strong>Autor:</strong> ' + (p.autor || 'Anónimo') +
                                    '</div>' +
                                    '</div>' +
                                    '</div>' +
                                    '<footer class="card-footer">' +
                                    '<button class="btn-donation" onclick="realizarDonacion(' + i + ', \'' + (p.id || '') + '\')">' +
                                    '<i class="fas fa-heart"></i>' +
                                    'Donar' +
                                    '</button>' +
                                    '</footer>' +
                                    '</div>';
                        }
                        contenedor.innerHTML = html;
                        console.log('🎉 Propuestas mostradas: ' + propuestas.length);
                    } else {
                        contenedor.innerHTML =
                                '<div class="notification is-danger has-text-centered">' +
                                '<i class="fas fa-exclamation-circle fa-2x mb-3"></i>' +
                                '<p>' + (result.message || 'Error al cargar propuestas') + '</p>' +
                                '</div>';
                    }
                } catch (error) {
                    console.error('❌ Error: ', error.message);
                    setLoading(false);
                    contenedor.innerHTML =
                            '<div class="notification is-danger has-text-centered">' +
                            '<i class="fas fa-exclamation-circle fa-2x mb-3"></i>' +
                            '<p>Error al conectar con el servidor: ' + error.message + '</p>' +
                            '</div>';
                }
            }

            function realizarDonacion(indice, propuestaId) {
                console.log('💝 Iniciando donación para propuesta: ' + propuestaId);
                // Aquí puedes integrar con tu sistema de pagos (Stripe, PayPal, etc.)
                alert('¡Gracias por tu intención de donar a esta propuesta!\n\nPropuesta ID: ' + propuestaId + '\n\nEsta funcionalidad se integrará con un sistema de pagos próximamente.');
            }
        </script>
    </body>
</html>

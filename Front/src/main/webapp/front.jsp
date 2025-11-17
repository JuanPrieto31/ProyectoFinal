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
                --primary: #C17817;
                --primary-dark: #8B5A0F;
                --primary-light: #E89F3C;
                --bg-main: #FAFAFA;
                --shadow-sm: 0 2px 8px rgba(193, 120, 23, 0.08);
                --shadow-md: 0 8px 24px rgba(193, 120, 23, 0.12);
                --shadow-lg: 0 16px 40px rgba(193, 120, 23, 0.15);
            }

            body {
                background: var(--bg-main);
                min-height: 100vh;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            .navbar {
                background: white;
                box-shadow: var(--shadow-sm);
                border-bottom: 1px solid rgba(193, 120, 23, 0.1);
            }

            .navbar-item {
                color: var(--primary-dark);
                font-weight: 600;
                transition: all 0.3s ease;
                border-radius: 8px;
                margin: 0 0.25rem;
            }

            .navbar-item:hover {
                background: rgba(193, 120, 23, 0.1);
                color: var(--primary);
                transform: translateY(-2px);
            }

            .navbar-link {
                color: var(--primary-dark);
                font-weight: 600;
                border-radius: 8px;
                transition: all 0.3s ease;
            }

            .navbar-link:hover {
                background: rgba(193, 120, 23, 0.1);
            }

            .navbar-dropdown {
                background: white;
                border: 1px solid rgba(193, 120, 23, 0.1);
                box-shadow: var(--shadow-md);
                border-radius: 12px;
                padding: 0.5rem 0;
                margin-top: 0.5rem;
                display: none;
            }

            .navbar-dropdown.is-active {
                display: block;
            }

            .navbar-dropdown .navbar-item {
                padding: 0.875rem 1.5rem;
                margin: 0.25rem 0.5rem;
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
                color: var(--primary-dark);
            }

            .main-container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 2.5rem 1.5rem;
            }

            .propuesta-card {
                background: white;
                border-radius: 16px;
                margin-bottom: 1.75rem;
                box-shadow: var(--shadow-sm);
                transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                border: 1px solid rgba(193, 120, 23, 0.1);
                overflow: hidden;
            }

            .propuesta-card:hover {
                transform: translateY(-6px);
                box-shadow: var(--shadow-md);
            }

            .propuesta-card .card-header {
                background: linear-gradient(135deg, rgba(193, 120, 23, 0.05), rgba(232, 159, 60, 0.08));
                padding: 1.5rem 2rem;
                border-bottom: 2px solid rgba(193, 120, 23, 0.1);
            }

            .propuesta-card .card-header-title {
                color: var(--primary-dark);
                font-weight: 700;
                font-size: 1.375rem;
                display: flex;
                align-items: center;
                gap: 0.75rem;
            }

            .propuesta-card .card-header-title i {
                color: var(--primary);
            }

            .propuesta-card .card-content {
                padding: 2rem;
                color: #374151;
                line-height: 1.7;
            }

            .propuesta-card .card-content .content {
                font-size: 1.05rem;
                margin-bottom: 1.5rem;
            }

            .propuesta-card .card-footer {
                border-top: 1px solid rgba(193, 120, 23, 0.1);
                background: rgba(250, 250, 250, 0.5);
                padding: 0;
            }

            .propuesta-card .card-footer-item {
                padding: 1rem 1.5rem;
                color: var(--primary);
                font-weight: 600;
                transition: all 0.3s ease;
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .propuesta-card .card-footer-item:hover {
                background: rgba(193, 120, 23, 0.1);
                color: var(--primary-dark);
            }

            .loading-spinner {
                width: 48px;
                height: 48px;
                border: 5px solid rgba(193, 120, 23, 0.15);
                border-top: 5px solid var(--primary);
                border-radius: 50%;
                animation: spin 0.8s linear infinite;
                margin: 3rem auto;
                display: none;
            }

            @keyframes spin {
                to { transform: rotate(360deg); }
            }

            .notification {
                border-radius: 12px;
                box-shadow: var(--shadow-sm);
                border-left: 4px solid;
            }

            .notification.is-warning {
                border-left-color: #F59E0B;
                background: #FFFBEB;
                color: #92400E;
            }

            .notification.is-danger {
                border-left-color: #DC2626;
                background: #FEF2F2;
                color: #991B1B;
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
                border-radius: 8px;
                width: 100%;
                text-align: left;
                margin: 0.25rem 0.5rem;
            }

            .button-as-link:hover {
                background: rgba(193, 120, 23, 0.1);
                transform: translateX(5px);
            }

            .meta-info {
                display: flex;
                gap: 1.5rem;
                flex-wrap: wrap;
                margin-top: 1.25rem;
                padding-top: 1.25rem;
                border-top: 1px solid rgba(193, 120, 23, 0.1);
            }

            .meta-item {
                display: flex;
                align-items: center;
                gap: 0.5rem;
                color: #6B7280;
                font-size: 0.95rem;
            }

            .meta-item i {
                color: var(--primary-light);
            }

            .meta-item strong {
                color: var(--primary-dark);
            }

            .navbar-burger {
                color: var(--primary-dark);
                transition: all 0.3s ease;
            }

            .navbar-burger:hover {
                background: rgba(193, 120, 23, 0.1);
            }

            @media (max-width: 768px) {
                .navbar-center {
                    display: none;
                }

                .navbar-menu {
                    background: white;
                    box-shadow: var(--shadow-md);
                    border-radius: 0 0 12px 12px;
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
                    <a class="navbar-item" href="perfil.jsp?correo=<%= correoEncoded %>">
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
                            <form action="PropuestaControl" method="post" style="margin: 0;">
                                <input type="hidden" name="accion" value="ver">
                                <input type="hidden" name="correo" value="<%= correo %>">
                                <button type="submit" class="navbar-item button-as-link">
                                    <i class="fas fa-lightbulb"></i>
                                    Ver Propuestas
                                </button>
                            </form>
                            <form action="PropuestaControl" method="post" style="margin: 0;">
                                <input type="hidden" name="accion" value="crear">
                                <input type="hidden" name="correo" value="<%= correo %>">
                                <button type="submit" class="navbar-item button-as-link">
                                    <i class="fas fa-plus-circle"></i>
                                    Nueva Propuesta
                                </button>
                            </form>
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
            const correoUsuario = "<%= correo %>";
            const apiURL = "http://localhost:8080/propuesta-ms/PropuestaControl";

            console.log('🚀 Front iniciado para usuario: ' + correoUsuario);

            document.addEventListener('DOMContentLoaded', function() {
                console.log('🔧 Configurando menús...');
                
                const menuToggle = document.getElementById('menuToggle');
                const menuDropdown = document.getElementById('menuDropdown');
                
                menuToggle.addEventListener('click', function(e) {
                    e.stopPropagation();
                    menuDropdown.classList.toggle('is-active');
                    console.log('📱 Menú ' + (menuDropdown.classList.contains('is-active') ? 'abierto' : 'cerrado'));
                });
                
                document.addEventListener('click', function(e) {
                    if (!menuDropdown.contains(e.target) && e.target !== menuToggle) {
                        menuDropdown.classList.remove('is-active');
                    }
                });
                
                const menuItems = menuDropdown.querySelectorAll('.navbar-item, .button-as-link');
                menuItems.forEach(item => {
                    item.addEventListener('click', function() {
                        menuDropdown.classList.remove('is-active');
                    });
                });
                
                const navbarBurger = document.querySelector('.navbar-burger');
                const navbarMenu = document.getElementById('navbarMenu');
                
                if (navbarBurger) {
                    navbarBurger.addEventListener('click', function() {
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

                    console.log('📥 Response status: ' + response.status);
                    console.log('📥 Response ok: ' + response.ok);

                    if (!response.ok) {
                        throw new Error('Error en la API: ' + response.status + ' - ' + response.statusText);
                    }

                    const result = await response.json();
                    console.log('📋 Respuesta del servidor: ', result);

                    setLoading(false);

                    if (result.success && result.propuestas) {
                        const propuestas = result.propuestas;
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
                                '</div>';
                        }
                        contenedor.innerHTML = html;
                        console.log('🎉 Propuestas mostradas: ' + propuestas.length);
                        
                    } else {
                        throw new Error(result.mensaje || 'Error al cargar propuestas');
                    }

                } catch (error) {
                    console.error('❌ Error cargando propuestas: ', error);
                    setLoading(false);
                    contenedor.innerHTML = 
                        '<div class="notification is-danger has-text-centered">' +
                        '<i class="fas fa-exclamation-triangle fa-2x mb-3"></i>' +
                        '<p>Error al cargar las propuestas: ' + error.message + '</p>' +
                        '</div>';
                }
            }

            console.log('🎯 Script de front completamente cargado');
        </script>
    </body>
</html>


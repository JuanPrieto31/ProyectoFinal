<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Propuesta</title>
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
            --shadow-hover: 0 8px 32px rgba(107, 83, 68, 0.12);
        }

        * {
            font-family: 'Inter', "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background: linear-gradient(145deg, var(--bg-main) 0%, var(--bg-warm) 100%);
            color: var(--text-dark);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .custom-navbar {
            background: white;
            box-shadow: var(--shadow-soft);
            border-bottom: 1px solid var(--border-soft);
            padding: 0 1.5rem;
        }

        .navbar-brand .navbar-item {
            font-weight: 600;
            color: var(--text-dark) !important;
            font-size: 1.1rem;
        }

        .navbar-brand .navbar-item:hover {
            color: var(--primary) !important;
            background: transparent !important;
        }

        .navbar-item {
            color: var(--text-dark);
            font-weight: 600;
            transition: all 0.3s ease;
            border-radius: 8px;
            margin: 0 0.25rem;
        }

        .navbar-item:hover {
            background: rgba(139, 115, 85, 0.08) !important;
            color: var(--primary) !important;
        }

        .navbar-link {
            color: var(--text-dark);
            font-weight: 600;
        }

        .navbar-dropdown {
            border: 1px solid var(--border-soft);
            box-shadow: var(--shadow-hover);
            border-radius: 12px;
            padding: 0.5rem;
        }

        .navbar-dropdown .navbar-item {
            border-radius: 6px;
        }

        .navbar-burger {
            color: var(--text-dark);
        }

        .navbar-menu {
            box-shadow: none;
        }

        @media screen and (max-width: 1023px) {
            .navbar-menu {
                position: absolute;
                left: 0;
                right: 0;
                top: 100%;
                background: white;
                box-shadow: var(--shadow-hover);
                display: none;
                z-index: 1000;
            }
            
            .navbar-menu.is-active {
                display: block;
            }
            
            .navbar-end {
                width: 100%;
            }
            
            .navbar-item.has-dropdown {
                width: 100%;
            }
            
            .navbar-dropdown {
                position: static;
                width: 100%;
                box-shadow: none;
                border: none;
                border-top: 1px solid var(--border-soft);
                border-radius: 0;
            }
        }

        .main-container {
            max-width: 900px;
            margin: 2rem auto;
            padding: 0 1rem;
            flex: 1;
            animation: fadeInUp 0.6s ease-out;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .page-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .page-header h1 {
            color: var(--text-dark);
            font-weight: 700;
            font-size: 2rem;
        }

        .section-card {
            background-color: var(--card-bg);
            border-radius: 16px;
            box-shadow: var(--shadow-soft);
            padding: 2rem;
            margin-bottom: 2rem;
            border-top: 4px solid var(--primary);
            border: 1px solid var(--border-soft);
            transition: all 0.3s ease;
        }

        .section-card:hover {
            box-shadow: var(--shadow-hover);
        }

        .section-card h2 {
            color: var(--text-dark);
            font-weight: 600;
            margin-bottom: 1.5rem;
            font-size: 1.25rem;
            display: flex;
            align-items: center;
            gap: 0.8rem;
        }

        .section-card h2 i {
            color: var(--primary);
            font-size: 1.1rem;
        }

        .title-input {
            width: 100%;
            padding: 1rem;
            border: 2px solid var(--border-soft);
            border-radius: 10px;
            font-size: 1rem;
            color: var(--text-dark);
            transition: all 0.3s ease;
            background: var(--bg-warm);
        }

        .title-input:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(139, 115, 85, 0.1);
            background: white;
            transform: translateY(-2px);
        }

        .title-input::placeholder {
            color: var(--text-light);
        }

        .content-textarea {
            width: 100%;
            padding: 1rem;
            border: 2px solid var(--border-soft);
            border-radius: 10px;
            font-size: 1rem;
            color: var(--text-dark);
            transition: all 0.3s ease;
            min-height: 300px;
            resize: vertical;
            font-family: 'Inter', "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
            background: var(--bg-warm);
        }

        .content-textarea:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(139, 115, 85, 0.1);
            background: white;
            transform: translateY(-2px);
        }

        .content-textarea::placeholder {
            color: var(--text-light);
        }

        .btn-publish {
            background: linear-gradient(145deg, var(--primary), var(--primary-light));
            color: white;
            border: none;
            border-radius: 12px;
            padding: 1rem 2.5rem;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: block;
            margin: 0 auto;
            box-shadow: 0 4px 16px rgba(139, 115, 85, 0.25);
            position: relative;
            overflow: hidden;
        }

        .btn-publish::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: left 0.5s ease;
        }

        .btn-publish:hover::before {
            left: 100%;
        }

        .btn-publish:hover {
            background: linear-gradient(145deg, var(--primary-dark), var(--primary));
            box-shadow: 0 8px 24px rgba(139, 115, 85, 0.3);
            transform: translateY(-3px);
        }

        .btn-publish:active {
            transform: translateY(-1px);
        }

        .btn-cancel {
            background: transparent;
            color: var(--text-medium);
            border: 2px solid var(--border-soft);
            border-radius: 12px;
            padding: 1rem 2.5rem;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: block;
            margin: 0 auto;
        }

        .btn-cancel:hover {
            background: var(--bg-warm);
            color: var(--text-dark);
            border-color: var(--primary-soft);
        }

        .button-group {
            display: flex;
            gap: 1rem;
            justify-content: center;
            margin-top: 2rem;
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
            to {
                transform: rotate(360deg);
            }
        }

        .notification {
            border-radius: 16px;
            box-shadow: var(--shadow-soft);
            border-left: 5px solid;
            font-weight: 600;
            animation: fadeIn 0.4s ease;
            margin-bottom: 2rem;
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
            border-left-color: #F57C00;
            background: #FFF8E1;
            color: #F57C00;
        }

        .notification.is-danger {
            border-left-color: #C62828;
            background: #FFEBEE;
            color: #C62828;
        }

        .notification.is-success {
            border-left-color: #2E7D32;
            background: #E8F5E9;
            color: #2E7D32;
        }

        .footer-section {
            background-color: white;
            border-top: 1px solid var(--border-soft);
            padding: 3rem 1.5rem;
            margin-top: 3rem;
        }

        .footer-section .footer-logo {
            font-weight: 700;
            color: var(--text-dark);
            margin-bottom: 0.5rem;
        }

        .footer-links {
            display: flex;
            justify-content: center;
            gap: 2rem;
            flex-wrap: wrap;
            margin: 1.5rem 0;
        }

        .footer-links a {
            color: var(--text-medium);
            text-decoration: none;
            transition: color 0.3s;
            font-size: 0.95rem;
        }

        .footer-links a:hover {
            color: var(--primary);
        }

        .footer-copyright {
            text-align: center;
            color: var(--text-light);
            font-size: 0.85rem;
            margin-top: 1.5rem;
            padding-top: 1.5rem;
            border-top: 1px solid var(--border-soft);
        }

        @media screen and (max-width: 768px) {
            .main-container {
                margin: 1rem auto;
            }

            .section-card {
                padding: 1.5rem;
            }

            .page-header h1 {
                font-size: 1.5rem;
            }

            .footer-links {
                gap: 1rem;
            }

            .button-group {
                flex-direction: column;
                align-items: center;
            }

            .btn-publish, .btn-cancel {
                width: 100%;
                max-width: 300px;
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

        String idPropuesta = request.getParameter("id");
        if (idPropuesta == null || idPropuesta.trim().isEmpty()) {
            response.sendRedirect("verpropuestas.jsp?correo=" + java.net.URLEncoder.encode(correo, "UTF-8"));
            return;
        }

        String correoEncoded = java.net.URLEncoder.encode(correo, "UTF-8");
    %>

    <!-- Navbar -->
    <nav class="navbar custom-navbar is-fixed-top" role="navigation" aria-label="main navigation">
        <div class="navbar-brand">
            <a class="navbar-item" href="index.jsp?correo=<%= correoEncoded%>">
                <i class="fas fa-lightbulb mr-2"></i>
                <span>Propuestas Comunitarias</span>
            </a>

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
                <a class="navbar-item" href="verpropuestas.jsp?correo=<%= correoEncoded%>">
                    <i class="fas fa-list"></i>
                    <span class="ml-2">Mis Propuestas</span>
                </a>
                <a class="navbar-item" href="nuevapropuesta.jsp?correo=<%= correoEncoded%>">
                    <i class="fas fa-plus-circle"></i>
                    <span class="ml-2">Nueva Propuesta</span>
                </a>
            </div>

            <div class="navbar-end">
                <div class="navbar-item has-dropdown is-hoverable">
                    <a class="navbar-link">
                        <i class="fas fa-user"></i>
                        <span class="ml-2"><%= correo %></span>
                    </a>

                    <div class="navbar-dropdown">
                        <a class="navbar-item" href="perfil.jsp?correo=<%= correoEncoded%>">
                            <i class="fas fa-cog"></i>
                            Configuración
                        </a>
                        <hr class="navbar-divider">
                        <a class="navbar-item" href="login.jsp">
                            <i class="fas fa-sign-out-alt"></i>
                            Cerrar Sesión
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </nav>

    <div style="height: 76px;"></div>

    <main class="main-container">
        <div class="page-header">
            <h1><i class="fas fa-edit mr-2"></i>Editar Propuesta</h1>
            <p class="has-text-medium" style="color: var(--text-medium);">Actualiza los detalles de tu propuesta</p>
        </div>

        <div class="loading-spinner" id="loadingSpinner"></div>
        <div id="mensajes"></div>

        <div class="section-card">
            <h2><i class="fas fa-edit"></i>Información de la Propuesta</h2>
            <form id="formEditarPropuesta">
                <div class="field">
                    <label class="label" style="color: var(--text-dark); font-weight: 600;">Título</label>
                    <div class="control">
                        <input class="title-input" type="text" id="titulo" name="titulo" placeholder="Título de la propuesta" required>
                    </div>
                </div>
                <div class="field">
                    <label class="label" style="color: var(--text-dark); font-weight: 600;">Contenido</label>
                    <div class="control">
                        <textarea class="content-textarea" id="contenido" name="contenido" placeholder="Describe tu propuesta en detalle..." required></textarea>
                    </div>
                </div>
                <div class="button-group">
                    <button type="submit" class="btn-publish">
                        <i class="fas fa-save mr-2"></i>Guardar Cambios
                    </button>
                    <a href="verpropuestas.jsp?correo=<%= correoEncoded%>" class="btn-cancel">
                        <i class="fas fa-times mr-2"></i>Cancelar
                    </a>
                </div>
            </form>
        </div>
    </main>

    <!-- Footer -->
    <footer class="footer-section">
        <div class="container">
            <div class="content has-text-centered">
                <p class="footer-logo">
                    <i class="fas fa-lightbulb mr-2"></i>Propuestas Comunitarias
                </p>
                <div class="footer-links">
                    <a href="#">Acerca de</a>
                    <a href="#">Contacto</a>
                    <a href="#">Términos de uso</a>
                    <a href="#">Política de privacidad</a>
                </div>
                <p class="footer-copyright">
                    &copy; 2024 Propuestas Comunitarias. Todos los derechos reservados.
                </p>
            </div>
        </div>
    </footer>

    <script>
        const correoUsuario = "<%= correo%>";
        const idPropuesta = "<%= idPropuesta%>";
        const apiURL = "http://localhost:8080/propuesta-ms/propuestas/";

        document.addEventListener('DOMContentLoaded', function () {
            console.log('🔧 Configurando menús...');

            const navbarBurger = document.querySelector('.navbar-burger');
            const navbarMenu = document.getElementById('navbarMenu');

            if (navbarBurger) {
                navbarBurger.addEventListener('click', function () {
                    navbarBurger.classList.toggle('is-active');
                    navbarMenu.classList.toggle('is-active');
                });
            }

            console.log('📥 Cargando propuesta con ID: ' + idPropuesta);
            cargarPropuesta();
        });

        function setLoading(loading) {
            const spinner = document.getElementById('loadingSpinner');
            spinner.style.display = loading ? 'block' : 'none';
        }

        async function cargarPropuesta() {
            setLoading(true);

            try {
                const response = await fetch(apiURL + idPropuesta, {
                    method: "GET",
                    headers: {
                        "Accept": "application/json"
                    }
                });

                if (!response.ok) {
                    throw new Error('Error al cargar la propuesta: ' + response.status);
                }

                const result = await response.json();
                setLoading(false);

                if (result.success) {
                    const propuesta = result.propuesta || result.propuestas; // Depende de la estructura de la respuesta
                    if (propuesta) {
                        document.getElementById('titulo').value = propuesta.titulo || propuesta.Titulo || '';
                        document.getElementById('contenido').value = propuesta.contenido || propuesta.Contenido || propuesta.descripcion || '';
                    } else {
                        mostrarMensaje('No se encontró la propuesta.', 'danger');
                    }
                } else {
                    mostrarMensaje(result.mensaje || 'Error al cargar la propuesta', 'danger');
                }
            } catch (error) {
                setLoading(false);
                mostrarMensaje('Error de conexión: ' + error.message, 'danger');
            }
        }

        document.getElementById('formEditarPropuesta').addEventListener('submit', async function (e) {
            e.preventDefault();

            const titulo = document.getElementById('titulo').value.trim();
            const contenido = document.getElementById('contenido').value.trim();

            if (!titulo || !contenido) {
                mostrarMensaje('Título y contenido son obligatorios.', 'danger');
                return;
            }

            setLoading(true);

            try {
                const response = await fetch(apiURL + idPropuesta, {
                    method: "PUT",
                    headers: {
                        "Content-Type": "application/json",
                        "Accept": "application/json"
                    },
                    body: JSON.stringify({
                        id: parseInt(idPropuesta),
                        titulo: titulo,
                        contenido: contenido
                    })
                });

                const result = await response.json();
                setLoading(false);

                if (result.success) {
                    mostrarMensaje('Propuesta actualizada exitosamente.', 'success');
                    // Redirigir después de 2 segundos
                    setTimeout(() => {
                        window.location.href = 'verpropuestas.jsp?correo=' + encodeURIComponent(correoUsuario);
                    }, 2000);
                } else {
                    mostrarMensaje(result.mensaje || 'Error al actualizar la propuesta', 'danger');
                }
            } catch (error) {
                setLoading(false);
                mostrarMensaje('Error de conexión: ' + error.message, 'danger');
            }
        });

        function mostrarMensaje(mensaje, tipo) {
            const mensajesDiv = document.getElementById('mensajes');
            let clase = 'is-danger';
            if (tipo === 'success') clase = 'is-success';
            if (tipo === 'warning') clase = 'is-warning';


            window.scrollTo(0, 0);
        }
    </script>
</body>
</html>
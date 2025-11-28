<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Crear Propuesta</title>

        <!-- Bulma CSS -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.9.4/css/bulma.min.css">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

        <style>
            :root {
                --primary-color: #c17817;
                --primary-dark: #a86514;
                --primary-light: #d9941e;
                --text-primary: #2c3e50;
                --text-secondary: #34495e;
                --bg-light: #f5f5f5;
                --bg-card: #ffffff;
                --border-light: #eaecef;
                --border-gray: #ddd;
            }

            * {
                font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
            }

            body {
                background-color: var(--bg-light);
                color: var(--text-primary);
                min-height: 100vh;
                display: flex;
                flex-direction: column;
            }

            /* Navbar mejorada */
            .custom-navbar {
                background: white;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
                border-bottom: 1px solid var(--border-light);
                padding: 0 1.5rem;
            }

            .navbar-brand .navbar-item {
                font-weight: 700;
                color: var(--text-primary) !important;
                font-size: 1.2rem;
            }

            .navbar-brand .navbar-item:hover {
                color: var(--primary-color) !important;
                background: transparent !important;
            }

            .navbar-item {
                color: var(--text-primary);
                font-weight: 600;
                transition: all 0.3s ease;
                border-radius: 6px;
                margin: 0 0.25rem;
            }

            .navbar-item:hover {
                background: rgba(193, 120, 23, 0.08) !important;
                color: var(--primary-color) !important;
            }

            .navbar-link {
                color: var(--text-primary);
                font-weight: 600;
            }

            .navbar-dropdown {
                border: 1px solid var(--border-light);
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
                border-radius: 8px;
                padding: 0.5rem;
            }

            .navbar-dropdown .navbar-item {
                border-radius: 4px;
            }

            .navbar-burger {
                color: var(--text-primary);
            }

            /* Fix para el menú hamburguesa */
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
                    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
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
                    border-top: 1px solid var(--border-light);
                    border-radius: 0;
                }
            }


            .main-container {
                max-width: 900px;
                margin: 2rem auto;
                padding: 0 1rem;
                flex: 1;
            }


            .page-header {
                text-align: center;
                margin-bottom: 2rem;
            }

            .page-header h1 {
                color: var(--text-primary);
                font-weight: 600;
                font-size: 2rem;
            }


            .section-card {
                background-color: var(--bg-card);
                border-radius: 8px;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
                padding: 2rem;
                margin-bottom: 2rem;
                border-top: 4px solid var(--primary-color);
            }

            .section-card h2 {
                color: var(--text-primary);
                font-weight: 600;
                margin-bottom: 1.5rem;
                font-size: 1.3rem;
                display: flex;
                align-items: center;
                gap: 0.8rem;
            }

            .section-card h2 i {
                color: var(--primary-color);
                font-size: 1.1rem;
            }

            .title-input {
                width: 100%;
                padding: 1rem;
                border: 2px solid var(--border-light);
                border-radius: 6px;
                font-size: 1rem;
                color: var(--text-primary);
                transition: border-color 0.2s ease;
            }

            .title-input:focus {
                outline: none;
                border-color: var(--primary-color);
                box-shadow: 0 0 0 3px rgba(193, 120, 23, 0.1);
            }

            .title-input::placeholder {
                color: #aaa;
            }

            .content-textarea {
                width: 100%;
                padding: 1rem;
                border: 2px solid var(--border-light);
                border-radius: 6px;
                font-size: 1rem;
                color: var(--text-primary);
                transition: border-color 0.2s ease;
                min-height: 300px;
                resize: vertical;
                font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
                line-height: 1.6;
            }

            .content-textarea:focus {
                outline: none;
                border-color: var(--primary-color);
                box-shadow: 0 0 0 3px rgba(193, 120, 23, 0.1);
            }

            .content-textarea::placeholder {
                color: #aaa;
            }

            .btn-publish {
                background-color: var(--primary-color);
                color: white;
                border: none;
                border-radius: 6px;
                padding: 0.75rem 2rem;
                font-size: 1rem;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                display: block;
                margin: 0 auto;
                box-shadow: 0 2px 6px rgba(193, 120, 23, 0.2);
            }

            .btn-publish:hover {
                background-color: var(--primary-dark);
                box-shadow: 0 4px 12px rgba(193, 120, 23, 0.3);
                transform: translateY(-2px);
            }

            .btn-publish:active {
                transform: translateY(0);
            }

            .footer-section {
                background-color: white;
                border-top: 1px solid var(--border-light);
                padding: 3rem 1.5rem;
                margin-top: 3rem;
            }

            .footer-section .footer-logo {
                font-weight: 700;
                color: var(--text-primary);
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
                color: #666;
                text-decoration: none;
                transition: color 0.2s;
                font-size: 0.95rem;
            }

            .footer-links a:hover {
                color: var(--primary-color);
            }

            .footer-copyright {
                text-align: center;
                color: #999;
                font-size: 0.85rem;
                margin-top: 1.5rem;
                padding-top: 1.5rem;
                border-top: 1px solid var(--border-light);
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

        <nav class="navbar custom-navbar" role="navigation" aria-label="main navigation">
            <div class="navbar-brand">
                <a class="navbar-item" href="perfil.jsp?correo=<%= correoEncoded%>">
                    <i class="fas fa-lightbulb" style="color: var(--primary-color);"></i>
                    &nbsp; <strong>SistemaPropuestas</strong>
                </a>

                <a role="button" class="navbar-burger" aria-label="menu" aria-expanded="false" data-target="navbarMenu">
                    <span aria-hidden="true"></span>
                    <span aria-hidden="true"></span>
                    <span aria-hidden="true"></span>
                </a>
            </div>

            <div id="navbarMenu" class="navbar-menu">
                <div class="navbar-end">
                    <div class="navbar-item has-dropdown is-hoverable">
                        <a class="navbar-link">
                            <i class="fas fa-bars"></i>
                            &nbsp; Menú
                        </a>

                        <div class="navbar-dropdown">
                            <a class="navbar-item" href="front.jsp?correo=<%= correoEncoded%>">
                                <i class="fas fa-home"></i>
                                &nbsp; Inicio
                            </a>

                            <a class="navbar-item" href="front.jsp?correo=<%= correoEncoded%>">
                                <i class="fas fa-list"></i>
                                &nbsp; Mis Propuestas
                            </a>
                            
                            <hr class="navbar-divider">
                            <a class="navbar-item" href="login.jsp">
                                <i class="fas fa-sign-out-alt"></i>
                                &nbsp; Cerrar Sesión
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </nav>

        <div class="main-container">
            <!-- Encabezado -->
            <div class="page-header">
                <h1>
                    <i class="fas fa-pen-fancy"></i>
                    Crear Nueva Propuesta
                </h1>
                <p style="color: #666; margin-top: 0.5rem;">Comparte tu idea con la comunidad</p>
            </div>

            <div class="section-card">
                <h2>
                    <i class="fas fa-heading"></i>
                    Título de la Propuesta
                </h2>
                <input 
                    type="text" 
                    class="title-input" 
                    id="titleInput"
                    placeholder="Escribe el título de tu propuesta aquí..."
                    maxlength="100"
                    >
                <small style="color: #999; margin-top: 0.5rem; display: block;">Máximo 100 caracteres</small>
            </div>

            <div class="section-card">
                <h2>
                    <i class="fas fa-file-alt"></i>
                    Contenido de la Propuesta
                </h2>
                <textarea 
                    class="content-textarea" 
                    id="contentTextarea"
                    placeholder="Describe tu propuesta de manera detallada. Explica el problema que resuelve, los beneficios, y cualquier información relevante..."
                    maxlength="5000"
                    ></textarea>
                <small style="color: #999; margin-top: 0.5rem; display: block;">Máximo 5000 caracteres</small>
            </div>

            <!-- Sección: Acción -->
            <div class="section-card" style="border-top-color: var(--primary-dark); text-align: center;">
                <button class="btn-publish" id="publishBtn">
                    <i class="fas fa-paper-plane"></i>
                    Publicar Propuesta
                </button>
                <small style="display: block; margin-top: 1rem; color: #999;">
                    Asegúrate de que todos los campos estén completos antes de publicar
                </small>
            </div>
        </div>

        <footer class="footer-section">
            <div class="container">
                <div class="columns">
                    <div class="column is-4">
                        <div class="footer-logo">
                            <i class="fas fa-lightbulb" style="color: var(--primary-color); margin-right: 0.5rem;"></i>
                            Sistema de Propuestas
                        </div>
                        <p style="color: #999; font-size: 0.9rem;">Plataforma para compartir y gestionar ideas innovadoras</p>
                    </div>
                    <div class="column is-4 has-text-centered">
                        <div class="footer-links">
                            <a href="front.jsp?correo=<%= correoEncoded%>">Inicio</a>
                            <a href="nuevapropuesta.jsp?correo=<%= correoEncoded%>">Crear Propuesta</a>
                            <a href="#">Ayuda</a>
                        </div>
                    </div>
                    <div class="column is-4 has-text-right">
                        <div class="footer-links" style="justify-content: flex-end;">
                            <a href="#">Política de Privacidad</a>
                            <a href="#">Términos de Servicio</a>
                        </div>
                    </div>
                </div>
                <div class="footer-copyright">
                    &copy; 2025 Sistema de Propuestas. Todos los derechos reservados.
                </div>
            </div>
        </footer>

        <script>

            document.addEventListener('DOMContentLoaded', () => {

                const $navbarBurgers = Array.prototype.slice.call(document.querySelectorAll('.navbar-burger'), 0);

                $navbarBurgers.forEach(el => {
                    el.addEventListener('click', () => {

                        const target = el.dataset.target;
                        const $target = document.getElementById(target);


                        el.classList.toggle('is-active');
                        $target.classList.toggle('is-active');
                    });
                });
            });

            const publishBtn = document.getElementById('publishBtn');
            const titleInput = document.getElementById('titleInput');
            const contentTextarea = document.getElementById('contentTextarea');


            const apiURL = "http://localhost:8080/propuesta-ms/propuestas/";

            const urlParams = new URLSearchParams(window.location.search);
            const correo = urlParams.get("correo");

            publishBtn.addEventListener('click', async () => {
                const titulo = titleInput.value.trim();
                const contenido = contentTextarea.value.trim();

                if (!correo) {
                    alert("❌ No se encontró el correo del usuario");
                    return;
                }
                if (!titulo) {
                    alert('Por favor ingresa un título');
                    titleInput.focus();
                    return;
                }
                if (!contenido) {
                    alert('Por favor ingresa el contenido de la propuesta');
                    contentTextarea.focus();
                    return;
                }


                publishBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Publicando...';
                publishBtn.disabled = true;

                const propuestaData = {
                    correo: correo,
                    titulo: titulo,
                    contenido: contenido
                };

                try {
                    const response = await fetch(apiURL, {
                        method: "POST",
                        headers: {
                            "Content-Type": "application/json"
                        },
                        body: JSON.stringify(propuestaData)
                    });

                    if (!response.ok) {
                        throw new Error(`Error HTTP: ${response.status}`);
                    }

                    const result = await response.json();

                    if (result.success) {
                        alert("✅ Propuesta creada exitosamente");
                        window.location.href = "front.jsp?correo=" + encodeURIComponent(correo);
                    } else {
                        alert("❌ Error al crear la propuesta: " + (result.message || ""));
                    }

                } catch (error) {
                    console.error("Error en el fetch:", error);
                    alert("❌ Error de conexión: " + error.message);
                } finally {
                    publishBtn.innerHTML = '<i class="fas fa-paper-plane"></i> Publicar Propuesta';
                    publishBtn.disabled = false;
                }
            });
        </script>
    </body>
</html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Mi Perfil</title>

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.9.4/css/bulma.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">

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

            body {
                background: linear-gradient(145deg, var(--bg-main) 0%, var(--bg-warm) 100%);
                font-family: 'Inter', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                min-height: 100vh;
            }

            .navbar {
                background: white;
                box-shadow: var(--shadow-soft);
                border-bottom: 1px solid var(--border-soft);
            }

            .navbar-item {
                color: var(--text-dark);
                font-weight: 600;
                transition: all 0.3s ease;
                border-radius: 8px;
                margin: 0 0.25rem;
            }

            .navbar-item:hover {
                background-color: rgba(139, 115, 85, 0.1);
                color: var(--primary);
                transform: translateX(-3px);
            }

            .navbar-item i {
                transition: transform 0.3s ease;
            }

            .navbar-item:hover i {
                transform: scale(1.2);
            }

            .profile-container {
                max-width: 1400px;
                margin: 2.5rem auto;
                padding: 0 1.5rem;
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

            .welcome-section {
                background: linear-gradient(145deg, var(--primary) 0%, var(--primary-light) 100%);
                border-radius: 20px;
                padding: 3rem 2.5rem;
                margin-bottom: 2.5rem;
                box-shadow: var(--shadow-hover);
                color: white;
                position: relative;
                overflow: hidden;
            }

            .welcome-section::before {
                content: '';
                position: absolute;
                top: -50%;
                right: -10%;
                width: 400px;
                height: 400px;
                background: radial-gradient(circle, rgba(255, 255, 255, 0.1) 0%, transparent 70%);
                border-radius: 50%;
                animation: pulse 4s ease-in-out infinite;
            }

            @keyframes pulse {
                0%, 100% {
                    transform: scale(1);
                    opacity: 0.5;
                }
                50% {
                    transform: scale(1.1);
                    opacity: 0.8;
                }
            }

            .welcome-section h1 {
                font-size: 2.5rem;
                font-weight: 700;
                margin-bottom: 0.5rem;
                position: relative;
            }

            .welcome-section p {
                font-size: 1.1rem;
                opacity: 0.95;
                position: relative;
            }

            .stats-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
                gap: 1.5rem;
                margin-bottom: 2.5rem;
            }

            .stat-card {
                background: white;
                border-radius: 16px;
                padding: 2rem;
                box-shadow: var(--shadow-soft);
                transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                border: 1px solid var(--border-soft);
                position: relative;
                overflow: hidden;
            }

            .stat-card::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                width: 4px;
                height: 100%;
                background: linear-gradient(to bottom, var(--primary), var(--primary-light));
                transform: scaleY(0);
                transition: transform 0.3s ease;
            }

            .stat-card:hover {
                transform: translateY(-6px);
                box-shadow: var(--shadow-hover);
            }

            .stat-card:hover::before {
                transform: scaleY(1);
            }

            .stat-icon {
                width: 56px;
                height: 56px;
                background: linear-gradient(135deg, rgba(139, 115, 85, 0.1), rgba(168, 144, 120, 0.15));
                border-radius: 14px;
                display: flex;
                align-items: center;
                justify-content: center;
                margin-bottom: 1.25rem;
            }

            .stat-icon i {
                font-size: 1.75rem;
                color: var(--primary);
            }

            .stat-label {
                font-size: 0.9rem;
                color: var(--text-light);
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                margin-bottom: 0.5rem;
            }

            .stat-value {
                font-size: 2rem;
                font-weight: 700;
                color: var(--text-dark);
            }

            .data-card {
                background: white;
                border-radius: 16px;
                padding: 2.5rem;
                box-shadow: var(--shadow-soft);
                border: 1px solid var(--border-soft);
            }

            .data-card-header {
                display: flex;
                align-items: center;
                gap: 1rem;
                margin-bottom: 2rem;
                padding-bottom: 1.5rem;
                border-bottom: 2px solid var(--border-soft);
            }

            .data-card-icon {
                width: 48px;
                height: 48px;
                background: linear-gradient(145deg, var(--primary), var(--primary-light));
                border-radius: 12px;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .data-card-icon i {
                color: white;
                font-size: 1.5rem;
            }

            .data-card-title {
                font-size: 1.5rem;
                font-weight: 700;
                color: var(--text-dark);
            }

            .data-grid {
                display: grid;
                gap: 1.25rem;
                grid-template-columns: repeat(2, 1fr);
            }

            .data-item {
                background: linear-gradient(135deg, rgba(139, 115, 85, 0.03), rgba(168, 144, 120, 0.05));
                padding: 1.25rem 1.5rem;
                border-radius: 12px;
                border-left: 3px solid var(--primary-light);
                transition: all 0.3s ease;
            }

            .data-item:hover {
                background: linear-gradient(135deg, rgba(139, 115, 85, 0.08), rgba(168, 144, 120, 0.1));
                transform: translateX(5px);
            }

            .data-label {
                font-size: 0.85rem;
                color: var(--primary);
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                margin-bottom: 0.5rem;
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .data-label i {
                font-size: 0.9rem;
            }

            .data-value {
                color: var(--text-dark);
                font-size: 1.05rem;
                font-weight: 600;
            }

            .actions-section {
                background: white;
                border-radius: 16px;
                padding: 2.5rem;
                box-shadow: var(--shadow-soft);
                border: 1px solid var(--border-soft);
                margin-top: 2.5rem;
            }

            .buttons-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 1.25rem;
            }

            .action-button {
                padding: 1.25rem 2rem;
                border: none;
                border-radius: 12px;
                font-size: 1rem;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 0.75rem;
                position: relative;
                overflow: hidden;
                letter-spacing: 0.3px;
            }

            .action-button::before {
                content: '';
                position: absolute;
                top: 50%;
                left: 50%;
                width: 0;
                height: 0;
                border-radius: 50%;
                background: rgba(255, 255, 255, 0.2);
                transform: translate(-50%, -50%);
                transition: width 0.5s, height 0.5s;
            }

            .action-button:hover::before {
                width: 300px;
                height: 300px;
            }

            .action-button i {
                font-size: 1.1rem;
                position: relative;
                z-index: 1;
            }

            .action-button span {
                position: relative;
                z-index: 1;
            }

            .button-primary {
                background: linear-gradient(145deg, var(--primary) 0%, var(--primary-light) 100%);
                color: white;
                box-shadow: 0 4px 12px rgba(139, 115, 85, 0.2);
            }

            .button-primary:hover {
                transform: translateY(-3px);
                box-shadow: 0 8px 20px rgba(139, 115, 85, 0.3);
            }

            .button-primary:active {
                transform: translateY(-1px);
                box-shadow: 0 4px 12px rgba(139, 115, 85, 0.25);
            }

            .button-secondary {
                background: linear-gradient(145deg, #78909C 0%, #90A4AE 100%);
                color: white;
                box-shadow: 0 4px 12px rgba(120, 144, 156, 0.2);
            }

            .button-secondary:hover {
                transform: translateY(-3px);
                box-shadow: 0 8px 20px rgba(120, 144, 156, 0.3);
                background: linear-gradient(145deg, #607D8B 0%, #78909C 100%);
            }

            .button-secondary:active {
                transform: translateY(-1px);
                box-shadow: 0 4px 12px rgba(120, 144, 156, 0.25);
            }

            .loading-spinner {
                width: 32px;
                height: 32px;
                border: 4px solid rgba(139, 115, 85, 0.2);
                border-top: 4px solid var(--primary);
                border-radius: 50%;
                animation: spin 0.8s linear infinite;
                margin: 1rem auto;
                display: none;
            }

            @keyframes spin {
                to {
                    transform: rotate(360deg);
                }
            }

            .message-box {
                margin-top: 1.5rem;
                padding: 1rem;
                border-radius: 10px;
                text-align: center;
                font-weight: 500;
                animation: fadeIn 0.3s ease;
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

            .loading-overlay {
                background: white;
                border-radius: 16px;
                padding: 3rem;
                text-align: center;
                box-shadow: var(--shadow-hover);
            }

            .loading-overlay p {
                color: var(--text-dark);
                font-size: 1.1rem;
                margin-top: 1.5rem;
            }

            @media (max-width: 768px) {
                .welcome-section {
                    padding: 2rem 1.5rem;
                }

                .welcome-section h1 {
                    font-size: 1.75rem;
                }

                .stats-grid {
                    grid-template-columns: 1fr;
                }

                .data-grid {
                    grid-template-columns: 1fr;
                }
            }
        </style>
    </head>
    <body>
        <nav class="navbar is-fixed-top">
            <div class="navbar-brand">
                <a class="navbar-item" href="#" id="backButton">
                    <i class="fas fa-arrow-left"></i>
                    <span class="ml-2">Volver</span>
                </a>
            </div>
        </nav>

        <div style="height: 52px;"></div>

        <div class="profile-container">
            <div id="loadingSection" class="loading-overlay">
                <div class="loading-spinner" style="display: block;"></div>
                <p>Cargando información del perfil...</p>
            </div>

            <div id="profileContent" style="display: none;">
                <div class="welcome-section">
                    <h1>¡Hola, <span id="userName"></span>!</h1>
                    <p>Gestiona tu perfil y mantén tus datos actualizados</p>
                </div>

                <div class="stats-grid">
                    <div class="stat-card">
                        <div class="stat-icon">
                            <i class="fas fa-lightbulb"></i>
                        </div>
                        <div class="stat-label">Propuestas Publicadas</div>
                        <div class="stat-value" id="propuestasCount">0</div>
                    </div>

                    <div class="stat-card">
                        <div class="stat-icon">
                            <i class="fas fa-heart"></i>
                        </div>
                        <div class="stat-label">Donaciones Realizadas</div>
                        <div class="stat-value" id="donacionesCount">0</div>
                    </div>
                </div>

                <div class="data-card">
                    <div class="data-card-header">
                        <div class="data-card-icon">
                            <i class="fas fa-user"></i>
                        </div>
                        <h2 class="data-card-title">Datos Personales</h2>
                    </div>

                    <div class="data-grid">
                        <div class="data-item">
                            <div class="data-label">
                                <i class="fas fa-user-circle"></i>
                                Nombre y Apellido
                            </div>
                            <div class="data-value" id="dataNombre"></div>
                        </div>

                        <div class="data-item">
                            <div class="data-label">
                                <i class="fas fa-envelope"></i>
                                Correo Electrónico
                            </div>
                            <div class="data-value" id="dataCorreo"></div>
                        </div>

                        <div class="data-item">
                            <div class="data-label">
                                <i class="fas fa-phone"></i>
                                Teléfono
                            </div>
                            <div class="data-value" id="dataTelefono"></div>
                        </div>

                        <div class="data-item">
                            <div class="data-label">
                                <i class="fas fa-lock"></i>
                                Contraseña
                            </div>
                            <div class="data-value">••••••••</div>
                        </div>

                        <div class="data-item">
                            <div class="data-label">
                                <i class="fas fa-user-tag"></i>
                                Rol
                            </div>
                            <div class="data-value" id="dataRol"></div>
                        </div>

                        <div class="data-item">
                            <div class="data-label">
                                <i class="fas fa-id-card"></i>
                                Cédula
                            </div>
                            <div class="data-value" id="dataCedula"></div>
                        </div>

                        <div class="data-item">
                            <div class="data-label">
                                <i class="fas fa-calendar"></i>
                                Fecha de Nacimiento
                            </div>
                            <div class="data-value" id="dataFechaNacimiento"></div>
                        </div>
                    </div>
                </div>

                <div class="actions-section">
                    <div class="loading-spinner" id="actionSpinner"></div>
                    <div class="message-box" id="messageBox"></div>

                    <div class="buttons-grid">
                        <button class="action-button button-primary" id="updateProfile">
                            <i class="fas fa-user-edit"></i>
                            <span>Modificar</span>
                        </button>
                        <button class="action-button button-secondary" id="deleteProfile">
                            <i class="fas fa-user-minus"></i>
                            <span>Eliminar Cuenta</span>
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <script>
            document.addEventListener('DOMContentLoaded', async () => {
                console.log('🔍 Iniciando carga de perfil...');

                const loadingSection = document.getElementById('loadingSection');
                const profileContent = document.getElementById('profileContent');
                const actionSpinner = document.getElementById('actionSpinner');
                const messageBox = document.getElementById('messageBox');
                const backButton = document.getElementById('backButton');

                const userName = document.getElementById('userName');
                const dataNombre = document.getElementById('dataNombre');
                const dataCorreo = document.getElementById('dataCorreo');
                const dataTelefono = document.getElementById('dataTelefono');
                const dataRol = document.getElementById('dataRol');
                const dataCedula = document.getElementById('dataCedula');
                const dataFechaNacimiento = document.getElementById('dataFechaNacimiento');

                const urlParams = new URLSearchParams(window.location.search);
                const correo = urlParams.get('correo');

                console.log('📧 Correo obtenido de URL:', correo);

                if (!correo) {
                    console.error('❌ No se proporcionó correo');
                    showMessage('Error: No se proporcionó correo del usuario', 'error');
                    loadingSection.innerHTML = '<p class="has-text-centered has-text-danger">Error: No se encontró información del usuario</p>';
                    return;
                }

                backButton.href = 'front.jsp?correo=' + encodeURIComponent(correo);

                await cargarPerfilUsuario();

                function showMessage(message, type) {
                    console.log('💬 Mensaje:', message, 'Tipo:', type);
                    messageBox.textContent = message;
                    messageBox.className = 'message-box';
                    if (type === 'success') {
                        messageBox.style.cssText = 'color: #065F46; background-color: #ECFDF5; border: 1px solid #A7F3D0;';
                    } else {
                        messageBox.style.cssText = 'color: #991B1B; background-color: #FEF2F2; border: 1px solid #FECACA;';
                    }
                    messageBox.style.display = 'block';
                }

                function setActionLoading(loading) {
                    console.log('🔄 Estado loading:', loading);
                    actionSpinner.style.display = loading ? 'block' : 'none';
                }

                async function cargarPerfilUsuario() {
                    try {
                        console.log('🚀 Iniciando carga de datos via GET para:', correo);


                        const url = `http://localhost:8080/usuario-ms/usuarios/perfil?correo=\${encodeURIComponent(correo)}`;
                        console.log('📤 URL de petición:', url);

                        const controller = new AbortController();
                        const timeoutId = setTimeout(() => controller.abort(), 8000);

                        const response = await fetch(url, {
                            method: "GET",
                            headers: {
                                "Accept": "application/json"
                            },
                            signal: controller.signal
                        });

                        clearTimeout(timeoutId);

                        console.log('📥 Response status:', response.status);
                        console.log('📥 Response ok:', response.ok);

                        if (!response.ok) {
                            const errorText = await response.text();
                            console.error('❌ Error HTTP:', response.status, errorText);
                            throw new Error(`Error del servidor: ${response.status} - ${response.statusText}`);
                        }

                        const result = await response.json();
                        console.log('📋 Respuesta del servidor:', result);

                        if (result && result.success !== undefined) {
                            if (result.success && result.usuario) {
                                console.log('✅ Usuario encontrado:', result.usuario);
                                displayUserData(result.usuario);
                                loadingSection.style.display = 'none';
                                profileContent.style.display = 'block';
                                console.log('🎉 Perfil cargado exitosamente');
                            } else {
                                throw new Error(result.mensaje || 'Error al cargar datos del usuario');
                            }
                        } else {
                            throw new Error('Respuesta del servidor inválida');
                        }

                    } catch (error) {
                        console.error('❌ Error cargando perfil:', error);

                        let errorMessage = 'Error al cargar el perfil: ';

                        if (error.name === 'AbortError') {
                            errorMessage += 'Timeout - El servidor no respondió a tiempo';
                        } else if (error.message.includes('Failed to fetch')) {
                            errorMessage += 'No se pudo conectar al servidor. Verifica que esté ejecutándose.';
                        } else {
                            errorMessage += error.message;
                        }

                        loadingSection.innerHTML =
                                '<div class="has-text-centered">' +
                                '<p class="has-text-danger mb-3"><strong>❌ Error al cargar el perfil</strong></p>' +
                                '<p class="mb-3">' + errorMessage + '</p>' +
                                '<div class="buttons is-centered">' +
                                '<button onclick="cargarPerfilUsuario()" class="button is-primary mr-2">' +
                                '<i class="fas fa-redo"></i> Reintentar' +
                                '</button>' +
                                '<button onclick="usarMetodoLegacy()" class="button is-warning mr-2">' +
                                '<i class="fas fa-history"></i> Usar método anterior' +
                                '</button>' +
                                '<a href="login.jsp" class="button is-light">' +
                                '<i class="fas fa-sign-in-alt"></i> Volver al Login' +
                                '</a>' +
                                '</div>' +
                                '</div>';
                    }
                }

                async function usarMetodoLegacy() {
                    console.log('🔄 Intentando método legacy...');
                    loadingSection.innerHTML = '<div class="loading-spinner" style="display: block;"></div><p>Intentando con método anterior...</p>';

                    try {
                        const response = await fetch("http://localhost:8080/usuario-ms/UsuarioControl", {
                            method: "POST",
                            headers: {
                                "Content-Type": "application/json",
                                "Accept": "application/json"
                            },
                            body: JSON.stringify({
                                accion: "obtenerPerfil",
                                correo: correo
                            })
                        });

                        const result = await response.json();
                        console.log('📋 Respuesta legacy:', result);

                        if (result.success && result.usuario) {
                            displayUserData(result.usuario);
                            loadingSection.style.display = 'none';
                            profileContent.style.display = 'block';
                            showMessage('✅ Perfil cargado (usando método anterior)', 'success');
                        } else {
                            throw new Error(result.mensaje || 'Error con método anterior');
                        }
                    } catch (error) {
                        console.error('❌ Error con método legacy:', error);
                        loadingSection.innerHTML =
                                '<div class="has-text-centered">' +
                                '<p class="has-text-danger mb-3"><strong>❌ Error crítico</strong></p>' +
                                '<p class="mb-3">No se pudo cargar el perfil con ningún método.</p>' +
                                '<div class="buttons is-centered">' +
                                '<a href="front.jsp?correo=' + encodeURIComponent(correo) + '" class="button is-primary">' +
                                '<i class="fas fa-arrow-left"></i> Volver al Inicio' +
                                '</a>' +
                                '</div>' +
                                '</div>';
                    }
                }

                function displayUserData(usuario) {
                    console.log('🎨 Mostrando datos del usuario:', usuario);

                    // ✅ Asignación segura con valores por defecto
                    userName.textContent = usuario.nombre || 'Usuario';
                    dataNombre.textContent = usuario.nombre || 'No especificado';
                    dataCorreo.textContent = usuario.correo || 'No especificado';
                    dataTelefono.textContent = usuario.telefono || 'No especificado';
                    dataRol.textContent = usuario.rol || 'Usuario';
                    dataCedula.textContent = usuario.cedula || 'No especificado';
                    dataFechaNacimiento.textContent = usuario.fechanacimiento || 'No especificada';

                    console.log('📊 Datos mostrados en la interfaz');
                }

                document.getElementById('updateProfile').addEventListener('click', () => {
                    console.log('✏️ Navegando a editar perfil');
                    window.location.href = 'editarPerfil.jsp?correo=' + encodeURIComponent(correo);
                });

                document.getElementById('deleteProfile').addEventListener('click', async () => {
                    console.log('🗑️ Iniciando eliminación de usuario');

                    if (!confirm('¿Estás seguro de que quieres eliminar tu cuenta? Esta acción no se puede deshacer.')) {
                        console.log('❌ Eliminación cancelada por el usuario');
                        return;
                    }

                    setActionLoading(true);
                    showMessage('Eliminando cuenta...', 'error');

                    try {
                        // ✅ NUEVO ENDPOINT DELETE
                        const response = await fetch("http://localhost:8080/usuario-ms/usuarios", {
                            method: "DELETE",
                            headers: {
                                "Content-Type": "application/json",
                                "Accept": "application/json"
                            },
                            body: JSON.stringify({
                                correo: correo
                            })
                        });

                        console.log('📥 Response status eliminación:', response.status);

                        if (!response.ok) {
                            throw new Error(`Error HTTP: ${response.status}`);
                        }

                        const result = await response.json();
                        console.log('📋 Respuesta eliminación:', result);

                        setActionLoading(false);

                        if (result.success) {
                            showMessage("✅ " + result.mensaje, 'success');
                            console.log('🔄 Redirigiendo a login en 2 segundos...');
                            setTimeout(() => {
                                window.location.href = "login.jsp?mensaje=cuenta_eliminada";
                            }, 2000);
                        } else {
                            showMessage("❌ " + (result.mensaje || "Error al eliminar cuenta"), 'error');
                        }

                    } catch (error) {
                        console.error('💥 Error en eliminación:', error);
                        setActionLoading(false);
                        showMessage("⚠️ Error al conectar con el servidor: " + error.message, 'error');
                    }
                });

                console.log('🎯 Script de perfil completamente cargado');
            });
        </script>
    </body>
</html>

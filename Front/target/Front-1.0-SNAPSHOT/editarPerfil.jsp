<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Editar Perfil</title>

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.9.4/css/bulma.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

        <style>
            :root {
                --primary: #C17817;
                --primary-dark: #8B5A0F;
                --primary-light: #E89F3C;
                --bg-main: #FAFAFA;
                --card-bg: #FFFFFF;
                --shadow-sm: 0 2px 8px rgba(193, 120, 23, 0.08);
                --shadow-md: 0 8px 24px rgba(193, 120, 23, 0.12);
                --shadow-lg: 0 16px 40px rgba(193, 120, 23, 0.15);
            }

            body {
                background: var(--bg-main);
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                min-height: 100vh;
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
                background-color: rgba(193, 120, 23, 0.1);
                color: var(--primary);
                transform: translateX(-3px);
            }

            .navbar-item i {
                transition: transform 0.3s ease;
            }

            .navbar-item:hover i {
                transform: scale(1.2);
            }

            .form-container {
                max-width: 1200px;
                margin: 2.5rem auto;
                padding: 0 1.5rem;
            }

            .page-header {
                background: linear-gradient(135deg, var(--primary) 0%, var(--primary-light) 100%);
                border-radius: 20px;
                padding: 2.5rem 2rem;
                margin-bottom: 2.5rem;
                box-shadow: var(--shadow-lg);
                color: white;
                text-align: center;
            }

            .page-header h1 {
                font-size: 2.25rem;
                font-weight: 700;
                margin-bottom: 0.5rem;
            }

            .page-header p {
                font-size: 1.1rem;
                opacity: 0.95;
            }

            .form-card {
                background: white;
                border-radius: 16px;
                padding: 2.5rem;
                box-shadow: var(--shadow-sm);
                border: 1px solid rgba(193, 120, 23, 0.1);
            }

            .section-header {
                display: flex;
                align-items: center;
                gap: 1rem;
                margin-bottom: 2rem;
                padding-bottom: 1.5rem;
                border-bottom: 2px solid rgba(193, 120, 23, 0.1);
            }

            .section-icon {
                width: 48px;
                height: 48px;
                background: linear-gradient(135deg, var(--primary), var(--primary-light));
                border-radius: 12px;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .section-icon i {
                color: white;
                font-size: 1.5rem;
            }

            .section-title {
                font-size: 1.5rem;
                font-weight: 700;
                color: var(--primary-dark);
            }

            .field-grid {
                display: grid;
                grid-template-columns: repeat(2, 1fr);
                gap: 1.5rem;
                margin-bottom: 2rem;
            }

            .field-full {
                grid-column: span 2;
            }

            .custom-field {
                position: relative;
            }

            /* Corregido el posicionamiento de los iconos para alinearlos verticalmente con los inputs */
            .field-icon {
                position: absolute;
                left: 1rem;
                margin-top: 2px;
                color: var(--primary);
                font-size: 1.1rem;
                z-index: 1;
                pointer-events: none;
                display: flex;
                align-items: center;
                height: 3rem;
            }

            .custom-input,
            .custom-select {
                width: 100%;
                padding: 0.875rem 1rem 0.875rem 3rem;
                border: 2px solid rgba(193, 120, 23, 0.2);
                border-radius: 10px;
                font-size: 1rem;
                transition: all 0.3s ease;
                background: white;
                color: var(--primary-dark);
            }

            .custom-input:focus,
            .custom-select:focus {
                outline: none;
                border-color: var(--primary);
                box-shadow: 0 0 0 3px rgba(193, 120, 23, 0.1);
                transform: translateY(-2px);
            }

            .custom-input:hover,
            .custom-select:hover {
                border-color: var(--primary-light);
            }

            .custom-select {
                cursor: pointer;
                appearance: none;
                background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath fill='%23C17817' d='M6 9L1 4h10z'/%3E%3C/svg%3E");
                background-repeat: no-repeat;
                background-position: right 1rem center;
                padding-right: 2.5rem;
            }

            .non-editable {
                background-color: #F3F4F6;
                cursor: not-allowed;
                opacity: 0.7;
            }

            .password-toggle {
                position: absolute;
                right: 1rem;
                top: 50%;
                transform: translateY(-50%);
                cursor: pointer;
                color: var(--primary);
                font-size: 1rem;
                z-index: 2;
                transition: all 0.3s ease;
                display: flex;
                align-items: center;
            }

            .custom-field {
                position: relative;
                min-height: 100px; /* ajusta si quieres, 90–110 funciona bien */
            }


            .buttons-section {
                display: flex;
                gap: 1rem;
                justify-content: flex-end;
                margin-top: 2.5rem;
                padding-top: 2rem;
                border-top: 2px solid rgba(193, 120, 23, 0.1);
            }

            .form-button {
                padding: 1rem 2.5rem;
                border: none;
                border-radius: 12px;
                font-size: 1rem;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                display: flex;
                align-items: center;
                gap: 0.75rem;
                letter-spacing: 0.3px;
            }

            .button-primary {
                background: linear-gradient(135deg, var(--primary) 0%, var(--primary-light) 100%);
                color: white;
                box-shadow: 0 4px 12px rgba(193, 120, 23, 0.2);
            }

            .button-primary:hover {
                transform: translateY(-3px);
                box-shadow: 0 8px 20px rgba(193, 120, 23, 0.3);
            }

            .button-secondary {
                background: linear-gradient(135deg, #64748B 0%, #94A3B8 100%);
                color: white;
                box-shadow: 0 4px 12px rgba(100, 116, 139, 0.2);
            }

            .button-secondary:hover {
                transform: translateY(-3px);
                box-shadow: 0 8px 20px rgba(100, 116, 139, 0.3);
            }

            .loading-spinner {
                width: 32px;
                height: 32px;
                border: 4px solid rgba(193, 120, 23, 0.2);
                border-top: 4px solid var(--primary);
                border-radius: 50%;
                animation: spin 0.8s linear infinite;
                margin: 0 auto 1rem;
                display: none;
            }

            @keyframes spin {
                to {
                    transform: rotate(360deg);
                }
            }

            .message-box {
                margin-bottom: 1.5rem;
                padding: 1rem 1.5rem;
                border-radius: 10px;
                font-weight: 500;
                display: none;
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

            .message-success {
                background: #ECFDF5;
                color: #065F46;
                border: 1px solid #A7F3D0;
            }

            .message-error {
                background: #FEF2F2;
                color: #991B1B;
                border: 1px solid #FECACA;
            }

            .required-indicator {
                color: #EF4444;
                margin-left: 0.25rem;
            }

            .help-text {
                color: var(--primary);
                margin-top: 0.25rem;
                display: block;
                font-size: 0.8rem;
            }

            @media (max-width: 768px) {
                .field-grid {
                    grid-template-columns: 1fr;
                }

                .field-full {
                    grid-column: span 1;
                }

                .buttons-section {
                    flex-direction: column-reverse;
                }

                .form-button {
                    width: 100%;
                    justify-content: center;
                }

                .page-header h1 {
                    font-size: 1.75rem;
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

        <div class="form-container">
            <div class="page-header">
                <h1><i class="fas fa-user-edit"></i> Editar Perfil</h1>
                <p>Actualiza tu información personal y mantén tu perfil al día</p>
            </div>

            <div class="form-card">
                <div class="loading-spinner" id="loadingSpinner"></div>
                <div class="message-box" id="messageBox"></div>

                <form id="editProfileForm">
                    <div class="section-header">
                        <div class="section-icon">
                            <i class="fas fa-user"></i>
                        </div>
                        <h2 class="section-title">Información Personal</h2>
                    </div>

                    <div class="field-grid">
                        <div class="custom-field field-full">
                            <label class="custom-label" for="nombre">
                                Nombre y Apellido <span class="required-indicator">*</span>
                            </label>
                            <i class="field-icon fas fa-user-circle"></i>
                            <input 
                                type="text" 
                                class="custom-input non-editable" 
                                id="nombre" 
                                name="nombre" 
                                placeholder="Ingresa tu nombre completo"
                                required
                                readonly
                                >
                            <small class="help-text">
                                <i class="fas fa-info-circle"></i> Este campo no se puede modificar
                            </small>
                        </div>

                        <div class="custom-field">
                            <label class="custom-label" for="correo">
                                Correo Electrónico <span class="required-indicator">*</span>
                            </label>
                            <i class="field-icon fas fa-envelope"></i>
                            <input 
                                type="email" 
                                class="custom-input" 
                                id="correo" 
                                name="correo" 
                                placeholder="correo@ejemplo.com"
                                required
                                >
                        </div>

                        <div class="custom-field">
                            <label class="custom-label" for="telefono">
                                Teléfono <span class="required-indicator">*</span>
                            </label>
                            <i class="field-icon fas fa-phone"></i>
                            <input 
                                type="tel" 
                                class="custom-input" 
                                id="telefono" 
                                name="telefono" 
                                placeholder="0412-1234567"
                                required
                                >
                        </div>

                        <div class="custom-field">
                            <label class="custom-label" for="cedula">
                                Cédula <span class="required-indicator">*</span>
                            </label>
                            <i class="field-icon fas fa-id-card"></i>
                            <input 
                                type="text" 
                                class="custom-input non-editable" 
                                id="cedula" 
                                name="cedula" 
                                placeholder="V-12345678"
                                required
                                readonly
                                >
                            <small class="help-text">
                                <i class="fas fa-info-circle"></i> Este campo no se puede modificar
                            </small>
                        </div>

                        <div class="custom-field">
                            <label class="custom-label" for="fechaNacimiento">
                                Fecha de Nacimiento <span class="required-indicator">*</span>
                            </label>
                            <i class="field-icon fas fa-calendar"></i>
                            <input 
                                type="date" 
                                class="custom-input non-editable" 
                                id="fechaNacimiento" 
                                name="fechaNacimiento"
                                required
                                readonly
                                >
                            <small class="help-text">
                                <i class="fas fa-info-circle"></i> Este campo no se puede modificar
                            </small>
                        </div>
                    </div>

                    <div class="section-header" style="margin-top: 2.5rem;">
                        <div class="section-icon">
                            <i class="fas fa-lock"></i>
                        </div>
                        <h2 class="section-title">Seguridad</h2>
                    </div>

                    <div class="field-grid">
                        <div class="custom-field">
                            <label class="custom-label" for="passwordActual">
                                Contraseña Actual
                            </label>
                            <i class="field-icon fas fa-lock"></i>
                            <input 
                                type="password" 
                                class="custom-input" 
                                id="passwordActual" 
                                name="passwordActual" 
                                placeholder="Ingresa tu contraseña actual"
                                >
                            <i class="password-toggle fas fa-eye" onclick="togglePassword('passwordActual')"></i>
                        </div>

                        <div class="custom-field">
                            <label class="custom-label" for="rol">
                                Rol
                            </label>
                            <i class="field-icon fas fa-user-tag"></i>
                            <input 
                                type="text" 
                                class="custom-input non-editable" 
                                id="rol" 
                                name="rol" 
                                readonly
                                >
                            <small class="help-text">
                                <i class="fas fa-info-circle"></i> Este campo no se puede modificar
                            </small>
                        </div>

                        <div class="custom-field">
                            <label class="custom-label" for="passwordNueva">
                                Nueva Contraseña
                            </label>
                            <i class="field-icon fas fa-key"></i>
                            <input 
                                type="password" 
                                class="custom-input" 
                                id="passwordNueva" 
                                name="passwordNueva" 
                                placeholder="Deja en blanco para mantener actual"
                                >
                            <i class="password-toggle fas fa-eye" onclick="togglePassword('passwordNueva')"></i>
                        </div>

                        <div class="custom-field">
                            <label class="custom-label" for="passwordConfirmar">
                                Confirmar Nueva Contraseña
                            </label>
                            <i class="field-icon fas fa-key"></i>
                            <input 
                                type="password" 
                                class="custom-input" 
                                id="passwordConfirmar" 
                                name="passwordConfirmar" 
                                placeholder="Confirma la nueva contraseña"
                                >
                            <i class="password-toggle fas fa-eye" onclick="togglePassword('passwordConfirmar')"></i>
                        </div>
                    </div>

                    <div class="buttons-section">
                        <button type="button" class="form-button button-secondary" id="cancelButton">
                            <i class="fas fa-times"></i>
                            <span>Cancelar</span>
                        </button>
                        <button type="submit" class="form-button button-primary">
                            <i class="fas fa-save"></i>
                            <span>Guardar Cambios</span>
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <script>
            let userEmail = '';

            document.addEventListener('DOMContentLoaded', async () => {
                console.log('🔍 Iniciando carga de formulario de edición...');

                const urlParams = new URLSearchParams(window.location.search);
                userEmail = urlParams.get('correo');
                const backButton = document.getElementById('backButton');
                const loadingSpinner = document.getElementById('loadingSpinner');

                console.log('📧 Correo obtenido de URL:', userEmail);

                if (!userEmail) {
                    console.error('❌ No se proporcionó correo');
                    showMessage('Error: No se proporcionó correo del usuario', 'error');
                    return;
                }

                backButton.href = 'perfil.jsp?correo=' + encodeURIComponent(userEmail);

                try {
                    loadingSpinner.style.display = 'block';
                    console.log('🚀 Cargando datos del usuario...');

                    const response = await fetch("http://localhost:8080/usuario-ms/UsuarioControl", {
                        method: "POST",
                        headers: {
                            "Content-Type": "application/json",
                            "Accept": "application/json"
                        },
                        body: JSON.stringify({
                            accion: "obtenerPerfil",
                            correo: userEmail
                        })
                    });

                    const result = await response.json();
                    console.log('📋 Respuesta del servidor:', result);

                    if (result.success && result.usuario) {
                        fillFormWithUserData(result.usuario);
                        console.log('✅ Formulario poblado con datos del usuario');
                    } else {
                        throw new Error(result.mensaje || 'Error al cargar datos del usuario');
                    }

                } catch (error) {
                    console.error('❌ Error cargando datos:', error);
                    showMessage('Error al cargar datos del usuario: ' + error.message, 'error');
                } finally {
                    loadingSpinner.style.display = 'none';
                }
            });

            function fillFormWithUserData(usuario) {
                document.getElementById('nombre').value = usuario.nombre || '';
                document.getElementById('correo').value = usuario.correo || '';
                document.getElementById('telefono').value = usuario.telefono || '';
                document.getElementById('cedula').value = usuario.cedula || '';
                document.getElementById('fechaNacimiento').value = usuario.fechanacimiento || '';
                document.getElementById('rol').value = usuario.rol || '';
            }

            function togglePassword(fieldId) {
                const field = document.getElementById(fieldId);
                const icon = field.nextElementSibling;

                if (field.type === 'password') {
                    field.type = 'text';
                    icon.classList.remove('fa-eye');
                    icon.classList.add('fa-eye-slash');
                } else {
                    field.type = 'password';
                    icon.classList.remove('fa-eye-slash');
                    icon.classList.add('fa-eye');
                }
            }

            function showMessage(message, type) {
                const messageBox = document.getElementById('messageBox');
                messageBox.textContent = message;
                messageBox.className = 'message-box message-' + type;
                messageBox.style.display = 'block';

                setTimeout(() => {
                    messageBox.style.display = 'none';
                }, 5000);
            }

            document.getElementById('cancelButton').addEventListener('click', () => {
                if (confirm('¿Deseas cancelar los cambios? Se perderán los datos no guardados.')) {
                    window.location.href = 'perfil.jsp?correo=' + encodeURIComponent(userEmail);
                }
            });

            document.getElementById('editProfileForm').addEventListener('submit', async (e) => {
                e.preventDefault();
                console.log('📝 Iniciando actualización de perfil...');

                const loadingSpinner = document.getElementById('loadingSpinner');
                const passwordNueva = document.getElementById('passwordNueva').value;
                const passwordConfirmar = document.getElementById('passwordConfirmar').value;

                if (passwordNueva || passwordConfirmar) {
                    if (passwordNueva !== passwordConfirmar) {
                        showMessage('Las contraseñas no coinciden', 'error');
                        return;
                    }
                    if (passwordNueva.length < 6) {
                        showMessage('La contraseña debe tener al menos 6 caracteres', 'error');
                        return;
                    }
                }

                try {
                    loadingSpinner.style.display = 'block';

                    const updateData = {
                        accion: "actualizar",
                        correo: userEmail, 
                        nuevoCorreo: document.getElementById('correo').value, 
                        telefono: document.getElementById('telefono').value
                    };

                    if (passwordNueva) {
                        updateData.password = passwordNueva;
                    }

                    console.log('📤 Enviando actualización (solo campos editables):', updateData);

                    const response = await fetch("http://localhost:8080/usuario-ms/UsuarioControl", {
                        method: "POST",
                        headers: {
                            "Content-Type": "application/json",
                            "Accept": "application/json"
                        },
                        body: JSON.stringify(updateData)
                    });

                    const result = await response.json();
                    console.log('📋 Respuesta:', result);

                    if (result.success) {
                        showMessage('✅ Perfil actualizado correctamente', 'success');
                        setTimeout(() => {

                            const nuevoCorreo = document.getElementById('correo').value;
                            window.location.href = 'perfil.jsp?correo=' + encodeURIComponent(nuevoCorreo);
                        }, 1500);
                    } else {
                        showMessage('❌ ' + (result.mensaje || 'Error al actualizar perfil'), 'error');
                    }

                } catch (error) {
                    console.error('❌ Error:', error);
                    showMessage('⚠️ Error al conectar con el servidor', 'error');
                } finally {
                    loadingSpinner.style.display = 'none';
                }
            });

            console.log('🎯 Script de edición de perfil cargado completamente');
        </script>
    </body>
</html>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Registro de Usuario</title>

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
                min-height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            .register-container {
                width: 100%;
                max-width: 480px;
                padding: 1.5rem;
            }

            .register-box {
                background: white;
                border-radius: 16px;
                box-shadow: var(--shadow-sm);
                padding: 2.5rem 2rem;
                border: 1px solid rgba(193, 120, 23, 0.1);
            }

            .register-header {
                text-align: center;
                margin-bottom: 2rem;
            }

            .register-header h2 {
                color: var(--primary-dark);
                font-size: 1.8rem;
                font-weight: 700;
                margin-bottom: 0.5rem;
            }

            .register-header p {
                color: #6B7280;
                font-size: 0.9rem;
            }

            .field {
                margin-bottom: 1.2rem;
            }

            .field label {
                color: var(--primary-dark);
                font-weight: 600;
                margin-bottom: 0.5rem;
                display: block;
                font-size: 0.9rem;
            }

            .input {
                border: 2px solid #E5E7EB;
                border-radius: 12px;
                padding: 0.75rem 1rem;
                font-size: 0.95rem;
                background: white;
                color: var(--primary-dark);
                transition: all 0.3s ease;
                width: 100%;
            }

            .input::placeholder {
                color: #9CA3AF;
            }

            .input:focus {
                border-color: var(--primary);
                box-shadow: 0 0 0 4px rgba(193, 120, 23, 0.1);
                outline: none;
            }

            .input.is-valid {
                border-color: #48C78E;
            }

            .input.is-invalid {
                border-color: #F14668;
            }

            .button-register {
                width: 100%;
                background: linear-gradient(135deg, var(--primary) 0%, var(--primary-light) 100%);
                color: white;
                border: none;
                border-radius: 12px;
                padding: 0.875rem;
                font-size: 1rem;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                margin-top: 1rem;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 0.5rem;
                box-shadow: var(--shadow-sm);
            }

            .button-register:hover {
                transform: translateY(-2px);
                box-shadow: var(--shadow-md);
            }

            .button-register:disabled {
                background: #CCC;
                cursor: not-allowed;
                opacity: 0.6;
            }

            .register-footer {
                text-align: center;
                margin-top: 1.5rem;
                padding-top: 1.2rem;
                border-top: 1px solid rgba(193, 120, 23, 0.1);
            }

            .register-footer p {
                color: #6B7280;
                font-size: 0.9rem;
            }

            .register-footer a {
                color: var(--primary);
                font-weight: 600;
                text-decoration: none;
                transition: color 0.3s ease;
            }

            .register-footer a:hover {
                color: var(--primary-dark);
            }

            .loading-spinner {
                border: 2px solid rgba(255, 255, 255, 0.3);
                border-top: 2px solid white;
                border-radius: 50%;
                width: 18px;
                height: 18px;
                animation: spin 0.8s linear infinite;
                display: none;
            }

            @keyframes spin {
                0% { transform: rotate(0deg); }
                100% { transform: rotate(360deg); }
            }

            .message-box {
                padding: 0.875rem 1rem;
                border-radius: 10px;
                margin-bottom: 1.2rem;
                text-align: center;
                font-weight: 500;
                font-size: 0.9rem;
                display: none;
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

            .form-group {
                margin-bottom: 0;
            }

            .password-strength {
                height: 3px;
                background: #E5E7EB;
                border-radius: 2px;
                margin-top: 0.4rem;
                overflow: hidden;
                display: none;
            }

            .password-strength-bar {
                height: 100%;
                width: 0;
                transition: all 0.3s ease;
                border-radius: 2px;
            }

            .strength-weak { 
                width: 33%; 
                background: #F14668; 
            }

            .strength-medium { 
                width: 66%; 
                background: var(--primary-light); 
            }

            .strength-strong { 
                width: 100%; 
                background: #48C78E; 
            }

            @media (max-width: 768px) {
                .register-container {
                    padding: 1rem;
                }

                .register-box {
                    padding: 2rem 1.5rem;
                }

                .register-header h2 {
                    font-size: 1.6rem;
                }
            }
        </style>
    </head>
    <body>

        <div class="register-container">
            <div class="register-box">
                <div class="register-header">
                    <h2>Crear Cuenta</h2>
                    <p>Completa el formulario para registrarte</p>
                </div>

                <div id="messageBox" class="message-box"></div>

                <form id="registerForm">
                    <div class="form-group">
                        <!-- Campos simplificados sin iconos decorativos -->
                        <div class="field">
                            <label for="nombre">Nombre</label>
                            <input 
                                class="input" 
                                type="text" 
                                id="nombre" 
                                name="nombre" 
                                placeholder="Tu nombre completo" 
                                required
                            >
                        </div>

                        <div class="field">
                            <label for="cedula">Cédula</label>
                            <input 
                                class="input" 
                                type="text" 
                                id="cedula" 
                                name="cedula" 
                                placeholder="Número de cédula" 
                                required 
                                pattern="[0-9]+" 
                                oninput="this.value = this.value.replace(/[^0-9]/g, '')"
                            >
                        </div>

                        <div class="field">
                            <label for="email">Correo electrónico</label>
                            <input 
                                class="input" 
                                type="email" 
                                id="email" 
                                name="email" 
                                placeholder="ejemplo@correo.com" 
                                required
                            >
                        </div>

                        <div class="field">
                            <label for="password1">Contraseña</label>
                            <input 
                                class="input" 
                                type="password" 
                                id="password1" 
                                name="password1" 
                                placeholder="Mínimo 6 caracteres" 
                                required
                            >
                            <div class="password-strength" id="passwordStrength">
                                <div class="password-strength-bar" id="strengthBar"></div>
                            </div>
                        </div>

                        <div class="field">
                            <label for="password2">Confirmar contraseña</label>
                            <input 
                                class="input" 
                                type="password" 
                                id="password2" 
                                name="password2" 
                                placeholder="Repite tu contraseña" 
                                required
                            >
                        </div>

                        <div class="field">
                            <label for="telefono">Teléfono</label>
                            <input 
                                class="input" 
                                type="text" 
                                id="telefono" 
                                name="telefono" 
                                placeholder="Número de teléfono" 
                                required 
                                pattern="[0-9]+" 
                                oninput="this.value = this.value.replace(/[^0-9]/g, '')"
                            >
                        </div>

                        <div class="field">
                            <label for="fechaNacimiento">Fecha de Nacimiento</label>
                            <input 
                                class="input" 
                                type="date" 
                                id="fechaNacimiento" 
                                name="fechaNacimiento" 
                                required
                            >
                        </div>
                    </div>

                    <div class="control">
                        <button type="submit" class="button-register" id="submitButton">
                            <span id="buttonText">Registrarse</span>
                            <div class="loading-spinner" id="loadingSpinner"></div>
                        </button>
                    </div>
                </form>

                <div class="register-footer">
                    <p>¿Ya tienes cuenta? <a href="login.jsp">Inicia sesión aquí</a></p>
                </div>
            </div>
        </div>

        <script>
            document.addEventListener('DOMContentLoaded', function() {
                const form = document.getElementById('registerForm');
                const messageBox = document.getElementById('messageBox');
                const submitButton = document.getElementById('submitButton');
                const buttonText = document.getElementById('buttonText');
                const loadingSpinner = document.getElementById('loadingSpinner');

                console.log('🚀 Formulario de registro cargado');

                function showMessage(message, type) {
                    messageBox.textContent = message;
                    messageBox.className = 'message-box message-' + type;
                    messageBox.style.display = 'block';
                    console.log('💬 Mensaje: ' + message + ' | Tipo: ' + type);
                }

                function setLoading(loading) {
                    if (loading) {
                        submitButton.disabled = true;
                        buttonText.textContent = 'Registrando...';
                        loadingSpinner.style.display = 'block';
                    } else {
                        submitButton.disabled = false;
                        buttonText.textContent = 'Registrarse';
                        loadingSpinner.style.display = 'none';
                    }
                    console.log('🔄 Loading: ' + loading);
                }

                const password1 = document.getElementById('password1');
                const strengthIndicator = document.getElementById('passwordStrength');
                const strengthBar = document.getElementById('strengthBar');

                password1.addEventListener('input', function() {
                    const value = this.value;
                    strengthIndicator.style.display = value.length > 0 ? 'block' : 'none';
                    
                    let strength = 0;
                    if (value.length >= 6) strength++;
                    if (value.length >= 10) strength++;
                    if (/[A-Z]/.test(value)) strength++;
                    if (/[0-9]/.test(value)) strength++;
                    if (/[^A-Za-z0-9]/.test(value)) strength++;

                    strengthBar.className = 'password-strength-bar';
                    if (strength <= 2) {
                        strengthBar.classList.add('strength-weak');
                    } else if (strength <= 3) {
                        strengthBar.classList.add('strength-medium');
                    } else {
                        strengthBar.classList.add('strength-strong');
                    }
                });

                form.addEventListener('submit', async function(e) {
                    e.preventDefault();
                    console.log('📝 Iniciando proceso de registro');

                    const nombre = document.getElementById('nombre').value.trim();
                    const cedula = document.getElementById('cedula').value.trim();
                    const email = document.getElementById('email').value.trim();
                    const password1 = document.getElementById('password1').value;
                    const password2 = document.getElementById('password2').value;
                    const telefono = document.getElementById('telefono').value.trim();
                    const fechaNacimiento = document.getElementById('fechaNacimiento').value;

                    console.log('📋 Datos del formulario:', {
                        nombre, cedula, email, telefono, fechaNacimiento
                    });

                    if (password1 !== password2) {
                        showMessage('Las contraseñas no coinciden', 'error');
                        return;
                    }

                    if (password1.length < 6) {
                        showMessage('La contraseña debe tener al menos 6 caracteres', 'error');
                        return;
                    }

                    if (!email.includes('@')) {
                        showMessage('Por favor ingresa un correo electrónico válido', 'error');
                        return;
                    }

                    setLoading(true);
                    messageBox.style.display = 'none';

                    try {
                        const userData = {
                            accion: 'registrar',
                            nombre: nombre,
                            correo: email,
                            contraseña: password1,
                            telefono: telefono,
                            cedula: parseInt(cedula),
                            fechanacimiento: fechaNacimiento,
                            rol: 'usuario'
                        };

                        console.log('📤 Enviando datos al servidor:', userData);

                        const response = await fetch('http://localhost:8080/usuario-ms/UsuarioControl', {
                            method: 'POST',
                            headers: {
                                'Content-Type': 'application/json',
                            },
                            body: JSON.stringify(userData)
                        });

                        console.log('📥 Response status:', response.status);
                        console.log('📥 Response ok:', response.ok);

                        if (!response.ok) {
                            throw new Error('Error del servidor: ' + response.status);
                        }

                        const result = await response.json();
                        console.log('📋 Respuesta del servidor:', result);

                        setLoading(false);

                        if (result.success) {
                            showMessage('✅ ' + result.mensaje, 'success');
                            console.log('🎉 Registro exitoso, redirigiendo...');
                            
                            form.reset();
                            strengthIndicator.style.display = 'none';
                            
                            setTimeout(() => {
                                window.location.href = 'login.jsp?mensaje=registro_exitoso';
                            }, 2000);
                        } else {
                            showMessage('❌ ' + (result.mensaje || 'Error en el registro'), 'error');
                        }

                    } catch (error) {
                        console.error('💥 Error en el registro:', error);
                        setLoading(false);
                        showMessage('⚠️ Error de conexión: ' + error.message, 'error');
                    }
                });

                const password2 = document.getElementById('password2');

                function validatePasswords() {
                    if (password1.value && password2.value) {
                        if (password1.value === password2.value) {
                            password2.classList.remove('is-invalid');
                            password2.classList.add('is-valid');
                        } else {
                            password2.classList.remove('is-valid');
                            password2.classList.add('is-invalid');
                        }
                    } else {
                        password2.classList.remove('is-valid', 'is-invalid');
                    }
                }

                password1.addEventListener('input', validatePasswords);
                password2.addEventListener('input', validatePasswords);

                const urlParams = new URLSearchParams(window.location.search);
                const mensaje = urlParams.get('mensaje');
                
                if (mensaje === 'registro_exitoso') {
                    showMessage('✅ ¡Registro exitoso! Ahora puedes iniciar sesión', 'success');
                }

                console.log('🎯 Script de registro completamente cargado');
            });
        </script>
    </body>
</html>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Registro de Usuario</title>
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
                --success-bg: #E8F5E9;
                --success-text: #2E7D32;
                --success-border: #A5D6A7;
                --error-bg: #FFEBEE;
                --error-text: #C62828;
                --error-border: #EF9A9A;
            }

            body {
                background: linear-gradient(145deg, var(--bg-main) 0%, var(--bg-warm) 100%);
                min-height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
                font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
                padding: 2rem 0;
                position: relative;
            }

            body::before {
                content: '';
                position: fixed;
                top: -30%;
                right: -20%;
                width: 700px;
                height: 700px;
                background: radial-gradient(circle, rgba(139, 115, 85, 0.04) 0%, transparent 70%);
                border-radius: 50%;
                animation: floatBg 22s ease-in-out infinite;
            }

            @keyframes floatBg {
                0%, 100% { transform: translate(0, 0); }
                50% { transform: translate(25px, 25px); }
            }

            .register-container {
                width: 100%;
                max-width: 540px;
                padding: 1.5rem;
                animation: slideUp 0.6s cubic-bezier(0.16, 1, 0.3, 1);
                position: relative;
                z-index: 1;
            }

            @keyframes slideUp {
                from {
                    opacity: 0;
                    transform: translateY(30px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .register-box {
                background: white;
                border-radius: 24px;
                box-shadow: var(--shadow-soft);
                padding: 3rem 2.75rem;
                border: 1px solid var(--border-soft);
                position: relative;
                transition: all 0.4s ease;
            }

            .register-box:hover {
                box-shadow: var(--shadow-hover);
            }

            .register-box::before {
                content: '';
                position: absolute;
                top: 0;
                left: 50%;
                transform: translateX(-50%);
                width: 80px;
                height: 4px;
                background: linear-gradient(90deg, var(--primary) 0%, var(--primary-light) 100%);
                border-radius: 0 0 8px 8px;
            }

            .register-header {
                text-align: center;
                margin-bottom: 2.5rem;
            }

            .register-header h2 {
                color: var(--text-dark);
                font-size: 2rem;
                font-weight: 700;
                margin-bottom: 0.75rem;
                letter-spacing: -0.5px;
            }

            .register-header p {
                color: var(--text-medium);
                font-size: 1rem;
                font-weight: 500;
            }

            .field {
                margin-bottom: 1.25rem;
            }

            .field label {
                color: var(--text-dark);
                font-weight: 600;
                margin-bottom: 0.6rem;
                display: block;
                font-size: 0.9rem;
                text-transform: uppercase;
                letter-spacing: 0.3px;
            }

            .input {
                border: 2px solid var(--border-soft);
                border-radius: 12px;
                padding: 0.9rem 1.1rem;
                font-size: 1rem;
                background: var(--bg-warm);
                color: var(--text-dark);
                transition: all 0.3s ease;
                width: 100%;
                font-weight: 500;
            }

            .input::placeholder {
                color: var(--text-light);
                font-weight: 400;
            }

            .input:focus {
                border-color: var(--primary);
                box-shadow: 0 0 0 4px rgba(139, 115, 85, 0.1);
                outline: none;
                background: white;
                transform: translateY(-2px);
            }

            .input.is-valid {
                border-color: var(--success-border);
                background: linear-gradient(135deg, rgba(72, 199, 142, 0.03) 0%, rgba(72, 199, 142, 0.06) 100%);
            }

            .input.is-invalid {
                border-color: var(--error-border);
                background: linear-gradient(135deg, rgba(241, 70, 104, 0.03) 0%, rgba(241, 70, 104, 0.06) 100%);
            }

            .button-register {
                width: 100%;
                background: linear-gradient(145deg, var(--primary) 0%, var(--primary-light) 100%);
                color: white;
                border: none;
                border-radius: 14px;
                padding: 1.1rem;
                font-size: 1.05rem;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                margin-top: 1.25rem;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 0.75rem;
                box-shadow: 0 4px 16px rgba(139, 115, 85, 0.25);
                position: relative;
                overflow: hidden;
                letter-spacing: 0.5px;
            }

            .button-register::before {
                content: '';
                position: absolute;
                top: 0;
                left: -100%;
                width: 100%;
                height: 100%;
                background: linear-gradient(90deg, transparent, rgba(255,255,255,0.25), transparent);
                transition: left 0.5s;
            }

            .button-register:hover::before {
                left: 100%;
            }

            .button-register:hover {
                transform: translateY(-3px);
                box-shadow: 0 8px 24px rgba(139, 115, 85, 0.3);
            }

            .button-register:disabled {
                background: linear-gradient(145deg, #B5B5B5 0%, #9A9A9A 100%);
                cursor: not-allowed;
                opacity: 0.7;
            }

            .register-footer {
                text-align: center;
                margin-top: 2rem;
                padding-top: 2rem;
                border-top: 1px solid var(--border-soft);
            }

            .register-footer p {
                color: var(--text-medium);
                font-size: 0.95rem;
                font-weight: 500;
            }

            .register-footer a {
                color: var(--primary);
                font-weight: 600;
                text-decoration: none;
                transition: color 0.3s ease;
                position: relative;
            }

            .register-footer a::after {
                content: '';
                position: absolute;
                bottom: -2px;
                left: 0;
                width: 0;
                height: 2px;
                background: var(--primary);
                transition: width 0.3s ease;
            }

            .register-footer a:hover::after {
                width: 100%;
            }

            .register-footer a:hover {
                color: var(--primary-dark);
            }

            .loading-spinner {
                border: 2px solid rgba(255, 255, 255, 0.3);
                border-top: 2px solid white;
                border-radius: 50%;
                width: 20px;
                height: 20px;
                animation: spin 0.7s linear infinite;
                display: none;
            }

            @keyframes spin {
                0% { transform: rotate(0deg); }
                100% { transform: rotate(360deg); }
            }

            .message-box {
                padding: 1rem 1.25rem;
                border-radius: 12px;
                margin-bottom: 1.5rem;
                text-align: center;
                font-weight: 600;
                font-size: 0.95rem;
                display: none;
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

            .message-success {
                background: var(--success-bg);
                color: var(--success-text);
                border: 1px solid var(--success-border);
            }

            .message-error {
                background: var(--error-bg);
                color: var(--error-text);
                border: 1px solid var(--error-border);
            }

            .form-group {
                margin-bottom: 0;
            }

            .password-strength {
                height: 4px;
                background: #E5E7EB;
                border-radius: 4px;
                margin-top: 0.5rem;
                overflow: hidden;
                display: none;
            }

            .password-strength-bar {
                height: 100%;
                width: 0;
                transition: all 0.3s ease;
                border-radius: 4px;
            }

            .strength-weak {
                width: 33%;
                background: linear-gradient(90deg, var(--error-border) 0%, #F87171 100%);
            }

            .strength-medium {
                width: 66%;
                background: linear-gradient(90deg, var(--primary-light) 0%, var(--primary) 100%);
            }

            .strength-strong {
                width: 100%;
                background: linear-gradient(90deg, #66BB6A 0%, #43A047 100%);
            }

            @media (max-width: 768px) {
                .register-container {
                    padding: 1rem;
                }

                .register-box {
                    padding: 2.5rem 2rem;
                    border-radius: 20px;
                }

                .register-header h2 {
                    font-size: 1.75rem;
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
            document.addEventListener('DOMContentLoaded', function () {
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

                password1.addEventListener('input', function () {
                    const value = this.value;
                    strengthIndicator.style.display = value.length > 0 ? 'block' : 'none';

                    let strength = 0;
                    if (value.length >= 6)
                        strength++;
                    if (value.length >= 10)
                        strength++;
                    if (/[A-Z]/.test(value))
                        strength++;
                    if (/[0-9]/.test(value))
                        strength++;
                    if (/[^A-Za-z0-9]/.test(value))
                        strength++;

                    strengthBar.className = 'password-strength-bar';
                    if (strength <= 2) {
                        strengthBar.classList.add('strength-weak');
                    } else if (strength <= 3) {
                        strengthBar.classList.add('strength-medium');
                    } else {
                        strengthBar.classList.add('strength-strong');
                    }
                });

                form.addEventListener('submit', async function (e) {
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
                        
                        const response = await fetch('http://localhost:8080/usuario-ms/usuarios', {
                            method: 'POST',
                            headers: {
                                'Content-Type': 'application/json',
                            },
                            body: JSON.stringify({
                                nombre: nombre,
                                correo: email,
                                contraseña: password1,
                                telefono: telefono,
                                cedula: parseInt(cedula),
                                fechanacimiento: fechaNacimiento,
                                rol: 'usuario'
                            })
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
            });
        </script>
    </body>
</html>

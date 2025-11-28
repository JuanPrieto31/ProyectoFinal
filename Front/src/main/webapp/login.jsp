<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Inicio de Sesión</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.9.4/css/bulma.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">

        <style>
            /* Nueva paleta de colores suave para adultos mayores */
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

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                background: linear-gradient(145deg, var(--bg-main) 0%, var(--bg-warm) 100%);
                display: flex;
                align-items: center;
                justify-content: center;
                min-height: 100vh;
                font-family: 'Inter', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                position: relative;
                overflow-x: hidden;
            }

            /* Decoración de fondo suave y animada */
            body::before {
                content: '';
                position: fixed;
                top: -30%;
                right: -20%;
                width: 600px;
                height: 600px;
                background: radial-gradient(circle, rgba(139, 115, 85, 0.05) 0%, transparent 70%);
                border-radius: 50%;
                animation: floatBg 20s ease-in-out infinite;
            }

            body::after {
                content: '';
                position: fixed;
                bottom: -20%;
                left: -15%;
                width: 500px;
                height: 500px;
                background: radial-gradient(circle, rgba(168, 144, 120, 0.04) 0%, transparent 70%);
                border-radius: 50%;
                animation: floatBg 25s ease-in-out infinite reverse;
            }

            @keyframes floatBg {
                0%, 100% { transform: translate(0, 0) scale(1); }
                50% { transform: translate(20px, 20px) scale(1.05); }
            }

            .login-container {
                width: 100%;
                max-width: 460px;
                padding: 1.5rem;
                position: relative;
                z-index: 1;
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

            .login-card {
                background: var(--card-bg);
                border-radius: 24px;
                box-shadow: var(--shadow-soft);
                padding: 3rem 2.5rem;
                border: 1px solid var(--border-soft);
                transition: all 0.4s ease;
            }

            .login-card:hover {
                box-shadow: var(--shadow-hover);
            }

            .login-header {
                text-align: center;
                margin-bottom: 2.5rem;
            }

            /* Icono con animación suave */
            .login-icon {
                width: 80px;
                height: 80px;
                background: linear-gradient(145deg, var(--primary) 0%, var(--primary-light) 100%);
                border-radius: 24px;
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 0 auto 1.5rem;
                box-shadow: 0 8px 24px rgba(139, 115, 85, 0.2);
                animation: iconPulse 3s ease-in-out infinite;
            }

            @keyframes iconPulse {
                0%, 100% { transform: scale(1); }
                50% { transform: scale(1.03); }
            }

            .login-icon i {
                font-size: 2.25rem;
                color: white;
            }

            .login-title {
                color: var(--text-dark);
                font-weight: 700;
                font-size: 2rem;
                margin-bottom: 0.5rem;
                letter-spacing: -0.5px;
            }

            .login-subtitle {
                color: var(--text-medium);
                font-size: 1rem;
                font-weight: 400;
            }

            .field {
                margin-bottom: 1.5rem;
            }

            .field label {
                color: var(--text-dark);
                font-weight: 600;
                font-size: 0.95rem;
                margin-bottom: 0.6rem;
                display: block;
            }

            .control {
                position: relative;
            }

            .control input {
                width: 100%;
                padding: 1rem 1rem 1rem 3.25rem;
                border: 2px solid var(--border-soft);
                border-radius: 14px;
                font-size: 1rem;
                transition: all 0.3s ease;
                background: var(--bg-warm);
                color: var(--text-dark);
            }

            .control input::placeholder {
                color: var(--text-light);
            }

            .control input:focus {
                border-color: var(--primary);
                box-shadow: 0 0 0 4px rgba(139, 115, 85, 0.1);
                outline: none;
                background: white;
                transform: translateY(-2px);
            }

            .control .icon {
                position: absolute;
                left: 1.1rem;
                top: 50%;
                transform: translateY(-50%);
                color: var(--primary-light);
                font-size: 1.15rem;
                transition: all 0.3s ease;
            }

            .control input:focus + .icon {
                color: var(--primary);
            }

            /* Botón con animación más suave */
            .button-submit {
                width: 100%;
                padding: 1.1rem;
                background: linear-gradient(145deg, var(--primary) 0%, var(--primary-light) 100%);
                color: white;
                border: none;
                border-radius: 14px;
                font-size: 1.1rem;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                box-shadow: 0 4px 16px rgba(139, 115, 85, 0.25);
                position: relative;
                overflow: hidden;
            }

            .button-submit::before {
                content: '';
                position: absolute;
                top: 0;
                left: -100%;
                width: 100%;
                height: 100%;
                background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
                transition: left 0.5s ease;
            }

            .button-submit:hover::before {
                left: 100%;
            }

            .button-submit:hover {
                transform: translateY(-3px);
                box-shadow: 0 8px 24px rgba(139, 115, 85, 0.3);
            }

            .button-submit:active {
                transform: translateY(-1px);
            }

            /* Spinner con colores suaves */
            .loading-spinner {
                width: 28px;
                height: 28px;
                border: 3px solid rgba(139, 115, 85, 0.2);
                border-top: 3px solid var(--primary);
                border-radius: 50%;
                animation: spin 0.8s linear infinite;
                margin: 0 auto;
                display: none;
            }

            @keyframes spin {
                to { transform: rotate(360deg); }
            }

            .message-box {
                margin-top: 1.25rem;
                padding: 1rem 1.25rem;
                border-radius: 12px;
                font-size: 0.95rem;
                font-weight: 500;
                text-align: center;
                display: none;
                animation: slideIn 0.3s ease;
            }

            @keyframes slideIn {
                from {
                    opacity: 0;
                    transform: translateY(-10px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .message-box.success {
                background: var(--success-bg);
                color: var(--success-text);
                border: 1px solid var(--success-border);
                display: block;
            }

            .message-box.error {
                background: var(--error-bg);
                color: var(--error-text);
                border: 1px solid var(--error-border);
                display: block;
            }

            .register-text {
                text-align: center;
                margin-top: 2rem;
                padding-top: 2rem;
                border-top: 1px solid var(--border-soft);
                color: var(--text-medium);
                font-size: 0.95rem;
            }

            .register-text a {
                color: var(--primary);
                font-weight: 600;
                text-decoration: none;
                transition: all 0.3s ease;
                position: relative;
            }

            .register-text a::after {
                content: '';
                position: absolute;
                bottom: -2px;
                left: 0;
                width: 0;
                height: 2px;
                background: var(--primary);
                transition: width 0.3s ease;
            }

            .register-text a:hover::after {
                width: 100%;
            }

            .register-text a:hover {
                color: var(--primary-dark);
            }

            @media (max-width: 768px) {
                .login-card {
                    padding: 2.5rem 1.75rem;
                }

                .login-title {
                    font-size: 1.75rem;
                }

                .login-icon {
                    width: 70px;
                    height: 70px;
                }

                .login-icon i {
                    font-size: 2rem;
                }
            }
        </style>
    </head>
    <body>

        <div class="login-container">
            <div class="login-card">
                <div class="login-header">
                    <div class="login-icon">
                        <i class="fas fa-users"></i>
                    </div>
                    <h1 class="login-title">Bienvenido</h1>
                    <p class="login-subtitle">Inicia sesión para continuar</p>
                </div>

                <form id="formLogin">
                    <div class="field">
                        <label>Correo Electrónico</label>
                        <div class="control">
                            <input type="email" id="Correo" placeholder="tu@correo.com" required>
                            <span class="icon">
                                <i class="fas fa-envelope"></i>
                            </span>
                        </div>
                    </div>

                    <div class="field">
                        <label>Contraseña</label>
                        <div class="control">
                            <input type="password" id="password" placeholder="••••••••" required>
                            <span class="icon">
                                <i class="fas fa-lock"></i>
                            </span>
                        </div>
                    </div>

                    <div class="field">
                        <button class="button-submit" type="submit">
                            <i class="fas fa-sign-in-alt"></i>&nbsp; Iniciar Sesión
                        </button>
                    </div>
                </form>

                <div class="loading-spinner" id="loadingSpinner"></div>
                <div class="message-box" id="messageBox"></div>

                <div class="register-text">
                    ¿No tienes cuenta?
                    <a href="registro.jsp">Regístrate aquí</a>
                </div>
            </div>
        </div>

        <script>
            const form = document.getElementById("formLogin");
            const messageBox = document.getElementById("messageBox");
            const spinner = document.getElementById("loadingSpinner");

            form.addEventListener("submit", async (e) => {
                e.preventDefault();

                spinner.style.display = "block";
                messageBox.style.display = "none";
                messageBox.className = "message-box";

                const correo = document.getElementById("Correo").value.trim();
                const contraseña = document.getElementById("password").value.trim();

                if (!correo || !contraseña) {
                    spinner.style.display = "none";
                    messageBox.className = "message-box error";
                    messageBox.textContent = "Por favor, completa todos los campos.";
                    messageBox.style.display = "block";
                    return;
                }

                try {
                    const response = await fetch("http://localhost:8080/usuario-ms/usuarios/login", {
                        method: "POST",
                        headers: {"Content-Type": "application/json"},
                        body: JSON.stringify({
                            correo: correo,
                            contraseña: contraseña
                        })
                    });

                    const result = await response.json();
                    spinner.style.display = "none";

                    if (result.success) {
                        messageBox.className = "message-box success";
                        messageBox.textContent = "✅ " + result.mensaje;
                        messageBox.style.display = "block";
                        setTimeout(() => window.location.href = "front.jsp?correo=" + encodeURIComponent(correo), 1500);
                    } else {
                        messageBox.className = "message-box error";
                        messageBox.textContent = "❌ " + (result.mensaje || "Correo o contraseña incorrectos");
                        messageBox.style.display = "block";
                    }

                } catch (error) {
                    spinner.style.display = "none";
                    messageBox.className = "message-box error";
                    messageBox.textContent = "⚠️ Error al conectar con el servidor";
                    messageBox.style.display = "block";
                    console.error("Error:", error);
                }
            });
        </script>
    </body>
</html>


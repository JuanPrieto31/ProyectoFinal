<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Inicio de Sesión</title>
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

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                background: var(--bg-main);
                display: flex;
                align-items: center;
                justify-content: center;
                min-height: 100vh;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            .login-container {
                width: 100%;
                max-width: 440px;
                padding: 1.5rem;
            }

            .login-card {
                background: white;
                border-radius: 16px;
                box-shadow: var(--shadow-sm);
                padding: 3rem 2.5rem;
                border: 1px solid rgba(193, 120, 23, 0.1);
            }

            .login-header {
                text-align: center;
                margin-bottom: 2.5rem;
            }

            .login-icon {
                width: 72px;
                height: 72px;
                background: linear-gradient(135deg, var(--primary) 0%, var(--primary-light) 100%);
                border-radius: 20px;
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 0 auto 1.5rem;
                box-shadow: var(--shadow-md);
            }

            .login-icon i {
                font-size: 2rem;
                color: white;
            }

            .login-title {
                color: var(--primary-dark);
                font-weight: 700;
                font-size: 2rem;
                margin-bottom: 0.5rem;
            }

            .login-subtitle {
                color: #6B7280;
                font-size: 0.95rem;
                font-weight: 400;
            }

            .field {
                margin-bottom: 1.5rem;
            }

            .field label {
                color: var(--primary-dark);
                font-weight: 600;
                font-size: 0.9rem;
                margin-bottom: 0.5rem;
                display: block;
            }

            .control {
                position: relative;
            }

            .control input {
                width: 100%;
                padding: 0.875rem 1rem 0.875rem 3rem;
                border: 2px solid #E5E7EB;
                border-radius: 12px;
                font-size: 1rem;
                transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                background: white;
            }

            .control input:focus {
                border-color: var(--primary);
                box-shadow: 0 0 0 4px rgba(193, 120, 23, 0.1);
                outline: none;
            }

            .control .icon {
                position: absolute;
                left: 1rem;
                top: 50%;
                transform: translateY(-50%);
                color: var(--primary);
                font-size: 1.1rem;
                transition: all 0.3s ease;
            }

            .control input:focus + .icon {
                color: var(--primary-dark);
            }

            .button-submit {
                width: 100%;
                padding: 1rem;
                background: linear-gradient(135deg, var(--primary) 0%, var(--primary-light) 100%);
                color: white;
                border: none;
                border-radius: 12px;
                font-size: 1.05rem;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                box-shadow: var(--shadow-sm);
            }

            .button-submit:hover {
                transform: translateY(-2px);
                box-shadow: var(--shadow-md);
            }

            .button-submit:active {
                transform: translateY(0);
            }

            .loading-spinner {
                width: 24px;
                height: 24px;
                border: 3px solid rgba(193, 120, 23, 0.2);
                border-top: 3px solid var(--primary);
                border-radius: 50%;
                animation: spin 0.8s linear infinite;
                margin: 0 auto;
                display: none;
            }

            @keyframes spin {
                to {
                    transform: rotate(360deg);
                }
            }

            .message-box {
                margin-top: 1rem;
                padding: 0.875rem 1rem;
                border-radius: 10px;
                font-size: 0.9rem;
                font-weight: 500;
                text-align: center;
                display: none;
            }

            .message-box.success {
                background: #ECFDF5;
                color: #065F46;
                border: 1px solid #A7F3D0;
                display: block;
            }

            .message-box.error {
                background: #FEF2F2;
                color: #991B1B;
                border: 1px solid #FECACA;
                display: block;
            }

            .register-text {
                text-align: center;
                margin-top: 2rem;
                padding-top: 2rem;
                border-top: 1px solid rgba(193, 120, 23, 0.1);
                color: #6B7280;
                font-size: 0.95rem;
            }

            .register-text a {
                color: var(--primary);
                font-weight: 600;
                text-decoration: none;
                transition: all 0.3s ease;
            }

            .register-text a:hover {
                color: var(--primary-dark);
            }

            @media (max-width: 768px) {
                .login-card {
                    padding: 2rem 1.5rem;
                }

                .login-title {
                    font-size: 1.75rem;
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

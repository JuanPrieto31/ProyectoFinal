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
        }

        /* Navbar personalizada */
        .navbar.is-transparent {
            box-shadow: 0 2px 0 0 var(--border-light);
        }

        .navbar-brand .navbar-item {
            font-weight: 600;
            color: var(--text-primary) !important;
        }

        .navbar-brand .navbar-item:hover {
            color: var(--primary-color) !important;
        }

        /* Contenedor principal */
        .main-container {
            max-width: 900px;
            margin: 2rem auto;
            padding: 0 1rem;
        }

        /* Encabezado */
        .page-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .page-header h1 {
            color: var(--text-primary);
            font-weight: 600;
            font-size: 2rem;
        }

        /* Tarjeta de sección */
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

        /* Barra de herramientas de formato */
        .format-toolbar {
            display: flex;
            gap: 0.5rem;
            margin-bottom: 1rem;
            flex-wrap: wrap;
            padding: 1rem;
            background-color: #fafafa;
            border-radius: 6px;
        }

        .format-btn {
            background-color: white;
            border: 1px solid var(--border-gray);
            border-radius: 4px;
            padding: 0.5rem 0.75rem;
            cursor: pointer;
            font-weight: 500;
            font-size: 0.9rem;
            transition: all 0.2s ease;
            color: var(--text-secondary);
        }

        .format-btn:hover {
            background-color: var(--border-light);
            border-color: var(--primary-color);
            color: var(--primary-color);
        }

        .format-btn.active {
            background-color: var(--primary-color);
            color: white;
            border-color: var(--primary-color);
        }

        .format-btn select {
            background-color: white;
            border: 1px solid var(--border-gray);
            border-radius: 4px;
            padding: 0.5rem 0.75rem;
            font-size: 0.9rem;
            cursor: pointer;
            color: var(--text-secondary);
        }

        /* Input de título */
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

        /* Área de carga */
        .upload-area {
            border: 2px dashed var(--border-gray);
            border-radius: 8px;
            padding: 3rem 2rem;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s ease;
            background-color: #fafafa;
        }

        .upload-area:hover {
            border-color: var(--primary-color);
            background-color: rgba(193, 120, 23, 0.05);
        }

        .upload-area.dragover {
            border-color: var(--primary-color);
            background-color: rgba(193, 120, 23, 0.1);
        }

        .upload-icon {
            font-size: 3rem;
            color: var(--primary-color);
            margin-bottom: 1rem;
        }

        .upload-area p {
            color: var(--text-secondary);
            font-size: 1rem;
            margin: 0;
        }

        .upload-area small {
            display: block;
            color: #999;
            font-size: 0.85rem;
            margin-top: 0.5rem;
        }

        /* Botones */
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

        /* Divisor */
        .section-divider {
            height: 1px;
            background-color: var(--border-light);
            margin: 2rem 0;
        }

        /* Footer */
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

        /* Archivo subido */
        .uploaded-file {
            background-color: #f0f8ff;
            border-left: 4px solid var(--primary-color);
            padding: 1rem;
            border-radius: 4px;
            margin-top: 1rem;
            display: none;
        }

        .uploaded-file.show {
            display: block;
        }

        .uploaded-file i {
            color: var(--primary-color);
            margin-right: 0.5rem;
        }

        /* Responsive */
        @media screen and (max-width: 768px) {
            .main-container {
                margin: 1rem auto;
            }

            .section-card {
                padding: 1.5rem;
            }

            .format-toolbar {
                padding: 0.75rem;
                gap: 0.35rem;
            }

            .format-btn {
                padding: 0.4rem 0.6rem;
                font-size: 0.8rem;
            }

            .page-header h1 {
                font-size: 1.5rem;
            }

            .upload-area {
                padding: 2rem 1rem;
            }

            .upload-icon {
                font-size: 2rem;
            }

            .footer-links {
                gap: 1rem;
            }
        }
    </style>
</head>
<body>
    <!-- Navbar Minimalista -->
    <nav class="navbar is-transparent" role="navigation" aria-label="main navigation">
        <div class="container">
            <div class="navbar-brand">
                <a class="navbar-item" href="#" style="font-weight: 700; font-size: 1.1rem;">
                    <i class="fas fa-lightbulb" style="color: var(--primary-color); margin-right: 0.5rem;"></i>
                    Propuestas
                </a>
            </div>
            <div class="navbar-menu is-active">
                <div class="navbar-end">
                    <div class="navbar-item">
                        <a href="#" class="navbar-item" style="color: var(--text-primary);">
                            <i class="fas fa-user-circle" style="margin-right: 0.5rem;"></i>
                            Perfil
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </nav>

    <!-- Contenedor principal -->
    <div class="main-container">
        <!-- Encabezado -->
        <div class="page-header">
            <h1>
                <i class="fas fa-pen-fancy"></i>
                Crear Nueva Propuesta
            </h1>
            <p style="color: #666; margin-top: 0.5rem;">Comparte tu idea con la comunidad</p>
        </div>

        <!-- Sección: Título -->
        <div class="section-card">
            <h2>
                <i class="fas fa-heading"></i>
                Título de la Propuesta
            </h2>
            <div class="format-toolbar">
                <button class="format-btn" data-format="bold" title="Negrita">
                    <i class="fas fa-bold"></i>
                </button>
                <button class="format-btn" data-format="italic" title="Cursiva">
                    <i class="fas fa-italic"></i>
                </button>
                <button class="format-btn" data-format="underline" title="Subrayado">
                    <i class="fas fa-underline"></i>
                </button>
                <div style="width: 1px; background-color: var(--border-light);"></div>
                <select class="format-btn" title="Fuente">
                    <option>Fuente</option>
                    <option>Arial</option>
                    <option>Times New Roman</option>
                    <option>Verdana</option>
                    <option>Georgia</option>
                </select>
                <select class="format-btn" title="Tamaño">
                    <option>Tamaño</option>
                    <option>Pequeño</option>
                    <option>Normal</option>
                    <option>Grande</option>
                </select>
                <div style="width: 1px; background-color: var(--border-light);"></div>
                <button class="format-btn" data-format="color" title="Color de texto">
                    <i class="fas fa-palette"></i>
                </button>
            </div>
            <input 
                type="text" 
                class="title-input" 
                placeholder="Escribe el título de tu propuesta aquí..."
                maxlength="100"
            >
            <small style="color: #999; margin-top: 0.5rem; display: block;">Máximo 100 caracteres</small>
        </div>

        <!-- Sección: Imagen -->
        <div class="section-card">
            <h2>
                <i class="fas fa-image"></i>
                Cargar Imagen
            </h2>
            <div class="upload-area" id="uploadArea">
                <div class="upload-icon">
                    <i class="fas fa-cloud-upload-alt"></i>
                </div>
                <p><strong>Haz clic o arrastra una imagen</strong></p>
                <small>Formatos soportados: JPG, PNG, GIF (máx. 5MB)</small>
                <input type="file" id="fileInput" accept="image/*" style="display: none;">
            </div>
            <div class="uploaded-file" id="uploadedFile">
                <i class="fas fa-check-circle"></i>
                <span id="fileName"></span>
            </div>
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

    <!-- Footer -->
    <footer class="footer-section">
        <div class="container">
            <div class="columns">
                <div class="column is-4">
                    <div class="footer-logo">Logo</div>
                    <p style="color: #999; font-size: 0.9rem;">© 2025 Your Website. All rights reserved</p>
                </div>
                <div class="column is-4 has-text-centered">
                    <div class="footer-links">
                        <a href="#">Link one</a>
                        <a href="#">Link two</a>
                        <a href="#">Link three</a>
                    </div>
                </div>
                <div class="column is-4 has-text-right">
                    <div class="footer-links" style="justify-content: flex-end;">
                        <a href="#">Privacy Policy</a>
                        <a href="#">Terms of Service</a>
                    </div>
                </div>
            </div>
            <div class="footer-copyright">
                Powered by Propuestas Platform
            </div>
        </div>
    </footer>

    <script>
        // Elementos del DOM
        const uploadArea = document.getElementById('uploadArea');
        const fileInput = document.getElementById('fileInput');
        const uploadedFile = document.getElementById('uploadedFile');
        const fileName = document.getElementById('fileName');
        const publishBtn = document.getElementById('publishBtn');
        const titleInput = document.querySelector('.title-input');

        // Click en área de carga
        uploadArea.addEventListener('click', () => {
            fileInput.click();
        });

        // Drag over
        uploadArea.addEventListener('dragover', (e) => {
            e.preventDefault();
            uploadArea.classList.add('dragover');
        });

        // Drag leave
        uploadArea.addEventListener('dragleave', () => {
            uploadArea.classList.remove('dragover');
        });

        // Drop
        uploadArea.addEventListener('drop', (e) => {
            e.preventDefault();
            uploadArea.classList.remove('dragover');
            
            if (e.dataTransfer.files.length) {
                handleFile(e.dataTransfer.files[0]);
            }
        });

        // Change en input de archivo
        fileInput.addEventListener('change', () => {
            if (fileInput.files.length) {
                handleFile(fileInput.files[0]);
            }
        });

        // Manejar archivo
        function handleFile(file) {
            if (file.type.startsWith('image/')) {
                fileName.textContent = file.name;
                uploadedFile.classList.add('show');
                console.log('✅ Archivo cargado:', file.name);
            } else {
                alert('Por favor selecciona un archivo de imagen válido');
                fileInput.value = '';
            }
        }

        // Botones de formato
        document.querySelectorAll('.format-btn[data-format]').forEach(button => {
            button.addEventListener('click', function() {
                if (this.tagName === 'BUTTON') {
                    this.classList.toggle('active');
                }
            });
        });

        // Botón publicar
        publishBtn.addEventListener('click', () => {
            const title = titleInput.value.trim();
            if (!title) {
                alert('Por favor ingresa un título');
                return;
            }
            if (!fileInput.files.length) {
                alert('Por favor carga una imagen');
                return;
            }
            alert('✅ Propuesta publicada: ' + title);
            // Aquí iría la lógica de envío al servidor
        });
    </script>
</body>
</html>

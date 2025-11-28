<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Registrar Donación</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.9.4/css/bulma.min.css">
</head>

<body class="has-background-light">

<section class="section">
<div class="container">
    <div class="box" style="max-width: 550px; margin:auto;">

        <h1 class="title has-text-centered">Registrar Donación</h1>

        <!-- ID propuesta (si viene desde otra página) -->
        <%
            String idPropuesta = request.getParameter("idPropuesta");
            if (idPropuesta == null) idPropuesta = "";
        %>

        <form id="formDonacion">

            <input type="hidden" id="idPropuesta" value="<%= idPropuesta %>">

            <!-- Tipo Donación -->
            <div class="field">
                <label class="label">Tipo de Donación</label>
                <div class="control">
                    <div class="select is-fullwidth">
                    <select id="TipoDonacion" required>
                        <option value="">Seleccione...</option>
                        <option value="Dinero">Dinero</option>
                        <option value="Especie">Especie</option>
                    </select>
                    </div>
                </div>
            </div>

            <!-- Nombre -->
            <div class="field">
                <label class="label">Nombre</label>
                <div class="control">
                    <input class="input" type="text" id="Nombre" required>
                </div>
            </div>

            <!-- Correo -->
            <div class="field">
                <label class="label">Correo</label>
                <div class="control">
                    <input class="input" type="email" id="Correo" required>
                </div>
            </div>

            <!-- Número contacto -->
            <div class="field">
                <label class="label">Número de contacto</label>
                <div class="control">
                    <input class="input" type="text" id="NumeroContacto" required>
                </div>
            </div>

            <!-- Tipo ID -->
            <div class="field">
                <label class="label">Tipo Identificación</label>
                <div class="select is-fullwidth">
                    <select id="TipoIdentificacion" required>
                        <option value="CC">Cédula</option>
                        <option value="TI">Tarjeta Identidad</option>
                        <option value="CE">Cédula Extranjería</option>
                        <option value="PAS">Pasaporte</option>
                    </select>
                </div>
            </div>

            <!-- Identificación -->
            <div class="field">
                <label class="label">Número Identificación</label>
                <div class="control">
                    <input class="input" type="text" id="Identificacion" required>
                </div>
            </div>

            <!-- Campos Dinero -->
            <div id="dineroFields" style="display:none;">

                <div class="field">
                    <label class="label">Entidad Bancaria</label>
                    <div class="select is-fullwidth">
                    <select id="EntidadBancaria">
                        <option value="">Seleccione...</option>
                        <option value="Bancolombia">Bancolombia</option>
                        <option value="Davivienda">Davivienda</option>
                        <option value="BBVA">BBVA</option>
                        <option value="Banco de Bogotá">Banco de Bogotá</option>
                    </select>
                    </div>
                </div>

                <div class="field">
                    <label class="label">Monto</label>
                    <div class="control">
                        <input class="input" type="number" step="0.01" id="Monto">
                    </div>
                </div>

            </div>

            <!-- Mensaje -->
            <div class="field">
                <label class="label">Mensaje</label>
                <textarea class="textarea" id="Mensaje"></textarea>
            </div>

            <!-- BOTÓN -->
            <div class="field">
                <button type="submit" class="button is-link is-fullwidth">
                    Enviar Donación
                </button>
            </div>
        </form>

        <div class="has-text-centered">
            <a href="propuestas.jsp" class="button is-text">Volver</a>
        </div>

    </div>
</div>
</section>

<script>
    // Mostrar/Ocultar campos de dinero
    document.getElementById("TipoDonacion").addEventListener("change", function() {
        const tipo = this.value;
        document.getElementById("dineroFields").style.display = 
            (tipo === "Dinero") ? "block" : "none";
    });

    // Envío JSON al servlet DonacionControl
    document.getElementById("formDonacion").addEventListener("submit", async function(e){
        e.preventDefault();

        const data = {
            TipoDonacion: document.getElementById("TipoDonacion").value,
            Nombre: document.getElementById("Nombre").value,
            Correo: document.getElementById("Correo").value,
            NumeroContacto: document.getElementById("NumeroContacto").value,
            TipoIdentificacion: document.getElementById("TipoIdentificacion").value,
            Identificacion: document.getElementById("Identificacion").value,
            EntidadBancaria: document.getElementById("EntidadBancaria").value,
            Monto: parseFloat(document.getElementById("Monto").value || 0),
            Mensaje: document.getElementById("Mensaje").value
        };

        const response = await fetch("donaciones", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(data)
        });

        const json = await response.json();

        if (json.success) {
            window.location.href = "exito.jsp";
        } else {
            window.location.href = "error.jsp";
        }
    });
</script>

</body>
</html>



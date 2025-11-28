<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Registrar Donación</title>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@1.0.0/css/bulma.min.css">

    <!-- Tus estilos previos (si los necesitas) -->
    <link rel="stylesheet" href="css/estilos.css">
</head>

<body class="has-background-light">

<%
    String idPropuesta = request.getParameter("idPropuesta");
    if (idPropuesta == null) idPropuesta = "";
%>

<section class="section">
    <div class="container">
        <div class="box">

            <h1 class="title has-text-centered">Realizar Donación</h1>

            <form action="DonacionControl" method="post">

                <input type="hidden" name="accion" value="insertar">
                <input type="hidden" name="idPropuesta" value="<%= idPropuesta %>">

                <!-- Monto -->
                <div class="field">
                    <label class="label">Monto de Donación</label>
                    <div class="control">
                        <input class="input" type="number" step="0.01" name="monto" required>
                    </div>
                </div>

                <!-- Donante -->
                <div class="field">
                    <label class="label">Donante</label>
                    <div class="control">
                        <input class="input" type="text" name="donante" required>
                    </div>
                </div>

                <!-- Comentario -->
                <div class="field">
                    <label class="label">Comentario (opcional)</label>
                    <div class="control">
                        <textarea class="textarea" name="comentario"></textarea>
                    </div>
                </div>

                <!-- BOTÓN -->
                <div class="field">
                    <div class="control">
                        <button class="button is-primary is-fullwidth" type="submit">
                            Enviar Donación
                        </button>
                    </div>
                </div>

            </form>

            <div class="has-text-centered">
                <a href="propuestas.jsp" class="button is-light mt-3">
                    Volver a Propuestas
                </a>
            </div>

        </div>
    </div>
</section>

</body>
</html>


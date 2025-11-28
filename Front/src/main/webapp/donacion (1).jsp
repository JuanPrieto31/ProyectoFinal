<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Registrar Donación</title>
    <link rel="stylesheet" href="css/estilos.css">
</head>

<body>

    <!-- ================================
         REDIRECCIÓN DESDE PROPUESTAS
         ================================ -->
    <%
        String idPropuesta = request.getParameter("idPropuesta");
        if (idPropuesta == null) {
            idPropuesta = "";
        }
    %>

    <div class="contenedor">
        <h2>Realizar Donación</h2>

        <form action="DonacionControl" method="post">
            <input type="hidden" name="accion" value="insertar">
            <input type="hidden" name="idPropuesta" value="<%= idPropuesta %>">

            <label>Monto de Donación:</label>
            <input type="number" step="0.01" name="monto" required>

            <label>Donante:</label>
            <input type="text" name="donante" required>

            <label>Comentario (opcional):</label>
            <textarea name="comentario"></textarea>

            <button type="submit">Enviar Donación</button>
        </form>

        <a href="propuestas.jsp" class="volver">Volver a Propuestas</a>
    </div>

</body>
</html>


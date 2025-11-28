<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Error en Donación</title>
    <link rel="stylesheet" href="css/estilos.css">
</head>

<body>
    <div class="contenedor">
        <h2>Error al Procesar la Donación</h2>

        <p><%= request.getAttribute("mensajeError") != null 
                ? request.getAttribute("mensajeError")
                : "Ha ocurrido un error inesperado." %></p>

        <a href="donacion.jsp" class="volver">Intentar de Nuevo</a>
    </div>
</body>
</html>

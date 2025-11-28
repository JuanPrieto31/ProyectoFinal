package Presentacion;

import Modelo.Propuesta;
import Servicio.PropuestaServicio;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonElement;
import com.google.gson.JsonSyntaxException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;

@WebServlet(name = "PropuestaControl", urlPatterns = {"/propuestas/*"})
public class PropuestaControl extends HttpServlet {

    private final Gson gson = new Gson();
    private final PropuestaServicio ps = new PropuestaServicio();

    private void setCorsHeaders(HttpServletResponse response) {
        response.setHeader("Access-Control-Allow-Origin", "*");
        response.setHeader("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS");
        response.setHeader("Access-Control-Allow-Headers", "Content-Type, Authorization, Accept");
        response.setHeader("Access-Control-Max-Age", "3600");
    }

    @Override
    protected void doOptions(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        setCorsHeaders(response);
        response.setStatus(HttpServletResponse.SC_OK);
    }

    private JsonObject leerJson(HttpServletRequest request, HttpServletResponse response) throws IOException {
        StringBuilder sb = new StringBuilder();
        try (BufferedReader reader = request.getReader()) {
            String linea;
            while ((linea = reader.readLine()) != null) {
                sb.append(linea);
            }
        }

        if (sb.length() == 0) {
            JsonObject error = new JsonObject();
            error.addProperty("success", false);
            error.addProperty("mensaje", "Cuerpo de solicitud vacío");
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return error;
        }

        try {
            return gson.fromJson(sb.toString(), JsonObject.class);
        } catch (JsonSyntaxException e) {
            JsonObject error = new JsonObject();
            error.addProperty("success", false);
            error.addProperty("mensaje", "JSON inválido");
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return error;
        }
    }

    private void enviar(HttpServletResponse response, JsonObject data) throws IOException {
        response.setContentType("application/json;charset=UTF-8");
        response.getWriter().write(gson.toJson(data));
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        setCorsHeaders(response);
        String path = request.getPathInfo();
        JsonObject respuesta = new JsonObject();

        try {
            if ("/listarid".equals(path)) {
                // Obtener el correo del parámetro de la solicitud
                String correo = request.getParameter("correo");

                if (correo == null || correo.trim().isEmpty()) {
                    respuesta.addProperty("success", false);
                    respuesta.addProperty("mensaje", "Parámetro 'correo' requerido");
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    enviar(response, respuesta);
                    return;
                }

                System.out.println("=== INICIO DEBUG ===");
                System.out.println("Correo recibido: " + correo);

                JsonObject usuarioResponse = obtenerUsuarioPorCorreo(correo);

                System.out.println("Respuesta completa del servicio: "
                        + (usuarioResponse != null ? usuarioResponse.toString() : "NULL"));

                // Validar respuesta del servicio
                if (usuarioResponse == null) {
                    respuesta.addProperty("success", false);
                    respuesta.addProperty("mensaje", "No se recibió respuesta del servicio de usuarios");
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    enviar(response, respuesta);
                    return;
                }

                // Verificar campo success
                if (!usuarioResponse.has("success")) {
                    respuesta.addProperty("success", false);
                    respuesta.addProperty("mensaje", "Respuesta del servicio sin campo 'success'");
                    respuesta.addProperty("respuesta_recibida", usuarioResponse.toString());
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    enviar(response, respuesta);
                    return;
                }

                boolean success = usuarioResponse.get("success").getAsBoolean();
                System.out.println("Success: " + success);

                if (!success) {
                    respuesta.addProperty("success", false);
                    respuesta.addProperty("mensaje", "El servicio de usuarios devolvió success=false");
                    if (usuarioResponse.has("mensaje")) {
                        respuesta.addProperty("error_detalle", usuarioResponse.get("mensaje").getAsString());
                    }
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    enviar(response, respuesta);
                    return;
                }

                // Verificar objeto usuario
                if (!usuarioResponse.has("usuario")) {
                    respuesta.addProperty("success", false);
                    respuesta.addProperty("mensaje", "La respuesta no contiene el objeto 'usuario'");
                    respuesta.addProperty("respuesta_recibida", usuarioResponse.toString());
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    enviar(response, respuesta);
                    return;
                }

                JsonElement usuarioElement = usuarioResponse.get("usuario");

                if (usuarioElement == null || usuarioElement.isJsonNull() || !usuarioElement.isJsonObject()) {
                    respuesta.addProperty("success", false);
                    respuesta.addProperty("mensaje", "El campo 'usuario' no es un objeto JSON válido");
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    enviar(response, respuesta);
                    return;
                }

                JsonObject usuarioObj = usuarioElement.getAsJsonObject();
                System.out.println("Objeto usuario: " + usuarioObj.toString());

                // Verificar campo idusuario
                if (!usuarioObj.has("idusuario")) {
                    respuesta.addProperty("success", false);
                    respuesta.addProperty("mensaje", "El objeto usuario no contiene el campo 'idusuario'");
                    respuesta.addProperty("campos_disponibles", usuarioObj.keySet().toString());
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    enviar(response, respuesta);
                    return;
                }

                JsonElement idUsuarioElement = usuarioObj.get("idusuario");

                if (idUsuarioElement == null || idUsuarioElement.isJsonNull()) {
                    respuesta.addProperty("success", false);
                    respuesta.addProperty("mensaje", "El campo 'idusuario' es null");
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    enviar(response, respuesta);
                    return;
                }

                String idUsuario = idUsuarioElement.getAsString();
                System.out.println("ID Usuario extraído: " + idUsuario);
                System.out.println("=== FIN DEBUG ===");

                // Listar propuestas del usuario
                respuesta = ps.listarPropuestasPorUsuario(idUsuario);
                response.setStatus(HttpServletResponse.SC_OK);

            } else if (path == null || "/".equals(path)) {
                respuesta = ps.listarPropuestas();
                response.setStatus(HttpServletResponse.SC_OK);

            } else {
                respuesta.addProperty("success", false);
                respuesta.addProperty("mensaje", "Endpoint GET no encontrado");
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            }

        } catch (Exception e) {
            System.err.println("ERROR CAPTURADO: " + e.getMessage());
            e.printStackTrace();

            respuesta = new JsonObject();
            respuesta.addProperty("success", false);
            respuesta.addProperty("mensaje", "Error interno: " + e.getMessage());
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }

        enviar(response, respuesta);
    }

    private JsonObject obtenerUsuarioPorCorreo(String correo) {
        try {
            String url = "http://localhost:8080/usuario-ms/usuarios/perfil?correo="
                    + java.net.URLEncoder.encode(correo, "UTF-8");

            System.out.println("URL de solicitud: " + url);

            java.net.URL obj = new java.net.URL(url);
            java.net.HttpURLConnection con = (java.net.HttpURLConnection) obj.openConnection();

            con.setRequestMethod("GET");
            con.setRequestProperty("Accept", "application/json");
            con.setConnectTimeout(5000);
            con.setReadTimeout(5000);

            int responseCode = con.getResponseCode();
            System.out.println("Código de respuesta: " + responseCode);

            if (responseCode == HttpURLConnection.HTTP_OK) {
                BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
                String inputLine;
                StringBuilder content = new StringBuilder();

                while ((inputLine = in.readLine()) != null) {
                    content.append(inputLine);
                }
                in.close();

                String jsonResponse = content.toString();
                System.out.println("JSON recibido: " + jsonResponse);

                return gson.fromJson(jsonResponse, JsonObject.class);
            } else {
                JsonObject error = new JsonObject();
                error.addProperty("success", false);
                error.addProperty("mensaje", "Error en servicio de usuarios: " + responseCode);
                return error;
            }

        } catch (Exception e) {
            System.err.println("Error al llamar servicio de usuarios: " + e.getMessage());
            e.printStackTrace();

            JsonObject error = new JsonObject();
            error.addProperty("success", false);
            error.addProperty("mensaje", "Error al conectar con servicio de usuarios: " + e.getMessage());
            return error;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        setCorsHeaders(response);
        JsonObject json = leerJson(request, response);
        String path = request.getPathInfo();
        JsonObject respuesta;

        if (path == null || "/".equals(path)) {
            respuesta = ps.CrearPropuesta(json);
            if (respuesta.get("success").getAsBoolean()) {
                response.setStatus(HttpServletResponse.SC_CREATED);
            }
        } else {
            respuesta = new JsonObject();
            respuesta.addProperty("success", false);
            respuesta.addProperty("mensaje", "Endpoint POST no encontrado");
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
        }

        enviar(response, respuesta);
    }

    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        setCorsHeaders(response);
        response.setContentType("application/json;charset=UTF-8");

        JsonObject json = leerJson(request, response);
        String path = request.getPathInfo();
        JsonObject respuesta;

        try {
            if (path == null || "/".equals(path)) {
                respuesta = ps.actualizar(json);
                if (respuesta.get("success").getAsBoolean()) {
                    response.setStatus(HttpServletResponse.SC_OK);
                } else {
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                }
            } else {
                // Manejar rutas con ID: /propuestas/123
                String[] pathParts = path.split("/");
                if (pathParts.length >= 2) {
                    String id = pathParts[1];
                    json.addProperty("id", Integer.parseInt(id));
                    respuesta = ps.actualizar(json);
                    if (respuesta.get("success").getAsBoolean()) {
                        response.setStatus(HttpServletResponse.SC_OK);
                    } else {
                        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    }
                } else {
                    respuesta = new JsonObject();
                    respuesta.addProperty("success", false);
                    respuesta.addProperty("mensaje", "Endpoint PUT no encontrado");
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                }
            }
        } catch (Exception e) {
            respuesta = new JsonObject();
            respuesta.addProperty("success", false);
            respuesta.addProperty("mensaje", "Error interno: " + e.getMessage());
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }

        enviar(response, respuesta);
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        setCorsHeaders(response);
        response.setContentType("application/json;charset=UTF-8");

        JsonObject json = leerJson(request, response);
        String path = request.getPathInfo();
        JsonObject respuesta;

        try {
            if (path == null || "/".equals(path)) {
                respuesta = ps.eliminar(json);
                if (respuesta.get("success").getAsBoolean()) {
                    response.setStatus(HttpServletResponse.SC_OK);
                } else {
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                }
            } else {
                // Manejar rutas con ID: /propuestas/123
                String[] pathParts = path.split("/");
                if (pathParts.length >= 2) {
                    String id = pathParts[1];
                    json.addProperty("id", Integer.parseInt(id));
                    respuesta = ps.eliminar(json);
                    if (respuesta.get("success").getAsBoolean()) {
                        response.setStatus(HttpServletResponse.SC_OK);
                    } else {
                        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    }
                } else {
                    respuesta = new JsonObject();
                    respuesta.addProperty("success", false);
                    respuesta.addProperty("mensaje", "Endpoint DELETE no encontrado");
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                }
            }
        } catch (Exception e) {
            respuesta = new JsonObject();
            respuesta.addProperty("success", false);
            respuesta.addProperty("mensaje", "Error interno: " + e.getMessage());
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }

        enviar(response, respuesta);
    }
}

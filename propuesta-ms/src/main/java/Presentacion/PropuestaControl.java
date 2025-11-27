package Presentacion;

import Modelo.Propuesta;
import Servicio.PropuestaServicio;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
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
        JsonObject respuesta;

        if (path == null || "/".equals(path)) {

            respuesta = ps.listarPropuestas();
            response.setStatus(HttpServletResponse.SC_OK);

        } else {
            respuesta = new JsonObject();
            respuesta.addProperty("success", false);
            respuesta.addProperty("mensaje", "Endpoint GET no encontrado");
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
        }

        enviar(response, respuesta);
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
}

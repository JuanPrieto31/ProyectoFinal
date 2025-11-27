package Presentacion;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonSyntaxException;
import java.io.BufferedReader;
import java.io.IOException;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import Servicio.UsuarioServicio;

@WebServlet(name = "UsuarioControl", urlPatterns = {"/usuarios/*"})
public class UsuarioControl extends HttpServlet {

    private final Gson gson = new Gson();
    private final UsuarioServicio servicio = new UsuarioServicio();

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
        response.getWriter().write(gson.toJson(data));
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        setCorsHeaders(response);
        response.setContentType("application/json;charset=UTF-8");

        String path = request.getPathInfo();
        JsonObject respuesta;

        if ("/perfil".equals(path)) {
            String correo = request.getParameter("correo");
            respuesta = servicio.obtenerPerfil(correo);
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
        response.setContentType("application/json;charset=UTF-8");

        JsonObject json = leerJson(request, response);
        String path = request.getPathInfo();
        JsonObject respuesta;

        if ("/login".equals(path)) {
            respuesta = servicio.login(json);
        } else if (path == null || "/".equals(path)) {
            respuesta = servicio.registrar(json);
            response.setStatus(HttpServletResponse.SC_CREATED);
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

        if (path == null || "/".equals(path)) {
            respuesta = servicio.actualizar(json);
        } else {
            respuesta = new JsonObject();
            respuesta.addProperty("success", false);
            respuesta.addProperty("mensaje", "Endpoint PUT no encontrado");
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
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

        if (path == null || "/".equals(path)) {
            respuesta = servicio.eliminar(json);
        } else {
            respuesta = new JsonObject();
            respuesta.addProperty("success", false);
            respuesta.addProperty("mensaje", "Endpoint DELETE no encontrado");
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
        }

        enviar(response, respuesta);
    }
}
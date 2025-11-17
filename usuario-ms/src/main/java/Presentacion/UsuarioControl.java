package Presentacion;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import java.io.BufferedReader;
import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import Servicio.UsuarioServicio;
import Modelo.Usuario;
import java.time.LocalDate;
import java.time.Period;

@WebServlet(name = "UsuarioControl", urlPatterns = {"/UsuarioControl"})
public class UsuarioControl extends HttpServlet {

    private final Gson gson = new Gson();
    private final UsuarioServicio us = new UsuarioServicio();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("\n[DEBUG] ===== Iniciando solicitud POST /UsuarioControl =====");

        StringBuilder sb = new StringBuilder();
        try (BufferedReader reader = request.getReader()) {
            String linea;
            while ((linea = reader.readLine()) != null) {
                sb.append(linea);
            }
        }

        System.out.println("[DEBUG] JSON recibido: " + sb);

        JsonObject json = gson.fromJson(sb.toString(), JsonObject.class);
        String accion = json.has("accion") ? json.get("accion").getAsString() : "";

        System.out.println("[DEBUG] Acción: " + accion);

        response.setContentType("application/json;charset=UTF-8");
        JsonObject jsonResponse = new JsonObject();

        try {
            switch (accion) {
                case "login":
                    loginUsuario(json, jsonResponse);
                    break;
                case "obtenerPerfil":
                    obtenerPerfilUsuario(json, jsonResponse);
                    break;
                case "actualizar":
                    actualizarUsuario(json, jsonResponse);
                    break;
                case "eliminar":
                    eliminarUsuario(json, jsonResponse);
                    break;
                case "registrar":
                    registrarUsuario(json, jsonResponse);
                    break;
                default:
                    System.out.println("[DEBUG] Acción desconocida: " + accion);
                    jsonResponse.addProperty("success", false);
                    jsonResponse.addProperty("mensaje", "Acción no válida");
                    break;
            }
        } catch (Exception e) {
            System.out.println("[ERROR] Error al procesar la acción: " + e.getMessage());
            e.printStackTrace();
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("mensaje", "Error interno del servidor");
        }

        String respuestaFinal = gson.toJson(jsonResponse);
        System.out.println("[DEBUG] Respuesta enviada al cliente: " + respuestaFinal);
        System.out.println("[DEBUG] ===== Fin de solicitud POST =====\n");

        response.getWriter().write(respuestaFinal);
    }

    private void loginUsuario(JsonObject json, JsonObject jsonResponse) {
        String correo = json.has("correo") ? json.get("correo").getAsString() : null;
        String contraseña = json.has("contraseña") ? json.get("contraseña").getAsString() : null;

        System.out.println("[DEBUG] Login - Correo: " + correo);
        System.out.println("[DEBUG] Login - Contraseña: " + (contraseña != null ? "********" : "null"));

        if (correo == null || contraseña == null || correo.trim().isEmpty() || contraseña.trim().isEmpty()) {
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("mensaje", "Por favor ingrese correo y contraseña");
            return;
        }

        boolean valido = us.validarLogin(correo, contraseña);
        if (valido) {
            jsonResponse.addProperty("success", true);
            jsonResponse.addProperty("mensaje", "Login exitoso");
            jsonResponse.addProperty("correo", correo);
        } else {
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("mensaje", "Correo o contraseña incorrectos");
        }
    }

    private void obtenerPerfilUsuario(JsonObject json, JsonObject jsonResponse) {
        String correo = json.has("correo") ? json.get("correo").getAsString() : null;

        if (correo == null || correo.trim().isEmpty()) {
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("mensaje", "Correo no proporcionado");
            return;
        }

        try {
            Usuario usuario = us.obtenerUsuario(correo);
            if (usuario != null) {
                jsonResponse.addProperty("success", true);
                JsonObject usuarioJson = new JsonObject();
                usuarioJson.addProperty("nombre", usuario.getNombre());
                usuarioJson.addProperty("correo", usuario.getCorreo());
                usuarioJson.addProperty("telefono", usuario.getTelefono());
                usuarioJson.addProperty("rol", usuario.getRol());
                usuarioJson.addProperty("cedula", usuario.getCedula());
                usuarioJson.addProperty("fechanacimiento", usuario.getFechanacimiento() != null ? usuario.getFechanacimiento().toString() : null);
                jsonResponse.add("usuario", usuarioJson);
            } else {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("mensaje", "Usuario no encontrado");
            }
        } catch (Exception e) {
            System.out.println("[ERROR] Error al obtener perfil: " + e.getMessage());
            e.printStackTrace();
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("mensaje", "Error al obtener el perfil");
        }
    }

    private void actualizarUsuario(JsonObject json, JsonObject jsonResponse) {
        try {
            System.out.println("[DEBUG] Iniciando actualización de usuario");

            String correoOriginal = json.has("correo") ? json.get("correo").getAsString() : null;
            String nuevoCorreo = json.has("nuevoCorreo") ? json.get("nuevoCorreo").getAsString() : null;
            String telefono = json.has("telefono") ? json.get("telefono").getAsString() : null;
            String contraseña = json.has("password") ? json.get("password").getAsString() : null;

            System.out.println("[DEBUG] Datos recibidos - Correo original: " + correoOriginal + ", Nuevo correo: " + nuevoCorreo + ", Teléfono: " + telefono);

            if (correoOriginal == null || correoOriginal.trim().isEmpty()) {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("mensaje", "Correo original no proporcionado");
                return;
            }

            if ((nuevoCorreo == null || nuevoCorreo.trim().isEmpty() || nuevoCorreo.equals(correoOriginal))
                    && (telefono == null || telefono.trim().isEmpty())
                    && (contraseña == null || contraseña.trim().isEmpty())) {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("mensaje", "No hay cambios para actualizar");
                return;
            }

            Usuario usuario = us.obtenerUsuario(correoOriginal);
            if (usuario == null) {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("mensaje", "Usuario no encontrado");
                return;
            }

            if (nuevoCorreo != null && !nuevoCorreo.trim().isEmpty() && !nuevoCorreo.equals(correoOriginal)) {
                Usuario usuarioConNuevoCorreo = us.obtenerUsuario(nuevoCorreo);
                if (usuarioConNuevoCorreo != null) {
                    jsonResponse.addProperty("success", false);
                    jsonResponse.addProperty("mensaje", "El nuevo correo ya está en uso");
                    return;
                }
                usuario.setCorreo(nuevoCorreo);
            }

            if (telefono != null) {
                usuario.setTelefono(telefono);
            }
            if (contraseña != null && !contraseña.trim().isEmpty()) {
                usuario.setContraseña(contraseña);
            }

            us.actualizarUsuario(usuario, correoOriginal);
            jsonResponse.addProperty("success", true);
            jsonResponse.addProperty("mensaje", "Perfil actualizado correctamente");

        } catch (java.sql.SQLException e) {
            System.out.println("[ERROR] Error SQL al actualizar usuario: " + e.getMessage());
            e.printStackTrace();

            if (e.getMessage().contains("duplicate key") || e.getMessage().contains("ya existe")) {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("mensaje", "El correo ya está en uso");
            } else {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("mensaje", "Error al actualizar el perfil: " + e.getMessage());
            }

        } catch (Exception e) {
            System.out.println("[ERROR] Error inesperado al actualizar usuario: " + e.getMessage());
            e.printStackTrace();
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("mensaje", "Error inesperado al actualizar el perfil");
        }
    }

    private void eliminarUsuario(JsonObject json, JsonObject jsonResponse) {
        String correo = json.has("correo") ? json.get("correo").getAsString() : null;

        if (correo == null || correo.trim().isEmpty()) {
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("mensaje", "Correo no proporcionado");
            return;
        }

        try {
            boolean eliminado = us.eliminarUsuario(correo);
            if (eliminado) {
                jsonResponse.addProperty("success", true);
                jsonResponse.addProperty("mensaje", "Usuario eliminado correctamente");
            } else {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("mensaje", "No se pudo eliminar el usuario");
            }
        } catch (Exception e) {
            System.out.println("[ERROR] Error al eliminar usuario: " + e.getMessage());
            e.printStackTrace();
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("mensaje", "Error al eliminar el usuario");
        }
    }

    private void registrarUsuario(JsonObject json, JsonObject jsonResponse) {
        try {
            System.out.println("[DEBUG] Iniciando registro de usuario");

            String nombre = json.has("nombre") ? json.get("nombre").getAsString() : null;
            String correo = json.has("correo") ? json.get("correo").getAsString() : null;
            String contraseña = json.has("contraseña") ? json.get("contraseña").getAsString() : null;
            String telefono = json.has("telefono") ? json.get("telefono").getAsString() : null;
            int cedula = json.has("cedula") ? json.get("cedula").getAsInt() : 0;
            String fechanacimientoStr = json.has("fechanacimiento") ? json.get("fechanacimiento").getAsString() : null;

            System.out.println("[DEBUG] Datos recibidos - Nombre: " + nombre + ", Correo: " + correo + ", Cédula: " + cedula);

            if (nombre == null || nombre.trim().isEmpty()
                    || correo == null || correo.trim().isEmpty()
                    || contraseña == null || contraseña.trim().isEmpty()
                    || cedula == 0
                    || fechanacimientoStr == null || fechanacimientoStr.trim().isEmpty()
                    || telefono == null || telefono.trim().isEmpty()) {

                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("mensaje", "Todos los campos son obligatorios");
                return;
            }

            LocalDate fechanacimiento;
            try {
                fechanacimiento = LocalDate.parse(fechanacimientoStr);
            } catch (Exception e) {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("mensaje", "Formato de fecha inválido. Use YYYY-MM-DD");
                return;
            }

            int edad = Period.between(fechanacimiento, LocalDate.now()).getYears();
            String rol = (edad >= 60) ? "Adulto Mayor" : "Donante";

            System.out.println("[DEBUG] Edad calculada: " + edad + " años, Rol asignado: " + rol);

            Usuario usuario = new Usuario(
                    0,
                    nombre,
                    correo,
                    contraseña,
                    telefono,
                    rol,
                    cedula,
                    fechanacimiento
            );

            System.out.println("[DEBUG] Usuario creado: " + usuario.getNombre() + " - " + usuario.getCorreo());

            us.registrar(usuario);

            System.out.println("[DEBUG] Usuario registrado exitosamente en el servicio");

            jsonResponse.addProperty("success", true);
            jsonResponse.addProperty("mensaje", "Usuario registrado exitosamente");

        } catch (java.sql.SQLException e) {
            System.out.println("[ERROR] Error SQL al registrar usuario: " + e.getMessage());
            e.printStackTrace();

            if (e.getMessage().contains("duplicate key") || e.getMessage().contains("ya existe")) {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("mensaje", "El correo o cédula ya están registrados");
            } else {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("mensaje", "Error al registrar el usuario: " + e.getMessage());
            }

        } catch (Exception e) {
            System.out.println("[ERROR] Error inesperado al registrar usuario: " + e.getMessage());
            e.printStackTrace();
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("mensaje", "Error inesperado al registrar el usuario");
        }
    }
}

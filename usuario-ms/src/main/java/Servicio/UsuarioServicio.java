package Servicio;

import Modelo.Usuario;
import Persistencia.UsuarioDao;
import com.google.gson.JsonObject;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.Period;

public class UsuarioServicio {

    private UsuarioDao ud;

    public UsuarioServicio() {
        ud = new UsuarioDao();
    }

    public JsonObject registrar(JsonObject json) {
        JsonObject response = new JsonObject();

        try {
            String nombre = obtenerCampo(json, "nombre");
            String correo = obtenerCampo(json, "correo");
            String contraseña = obtenerCampo(json, "contraseña");
            String telefono = obtenerCampo(json, "telefono");
            int cedula = json.has("cedula") ? json.get("cedula").getAsInt() : 0;
            String fechanacimientoStr = obtenerCampo(json, "fechanacimiento");

            LocalDate fechanacimiento = null;
            if (fechanacimientoStr != null) {
                try {
                    fechanacimiento = LocalDate.parse(fechanacimientoStr);
                } catch (Exception e) {
                    response.addProperty("success", false);
                    response.addProperty("mensaje", "Formato de fecha inválido. Use YYYY-MM-DD");
                    return response;
                }
            }

            String resultado = registrarUsuario(nombre, correo, contraseña, telefono, cedula, fechanacimiento);
            response.addProperty("success", resultado.equals("Usuario registrado exitosamente"));
            response.addProperty("mensaje", resultado);

        } catch (Exception e) {
            response.addProperty("success", false);
            response.addProperty("mensaje", "Error inesperado: " + e.getMessage());
        }

        return response;
    }

    public JsonObject login(JsonObject json) {
        JsonObject response = new JsonObject();

        String correo = obtenerCampo(json, "correo");
        String contraseña = obtenerCampo(json, "contraseña");

        String[] resultado = validarLogin(correo, contraseña);
        response.addProperty("success", resultado[0].equals("success"));
        response.addProperty("mensaje", resultado[1]);
        if (resultado[0].equals("success") && resultado.length > 2) {
            response.addProperty("correo", resultado[2]);
        }

        return response;
    }

    public JsonObject obtenerPerfil(String correo) {
        JsonObject response = new JsonObject();

        if (correo == null || correo.trim().isEmpty()) {
            response.addProperty("success", false);
            response.addProperty("mensaje", "Correo no proporcionado");
            return response;
        }

        Object[] resultado = obtenerPerfilUsuario(correo);
        response.addProperty("success", resultado[0].equals("success"));
        response.addProperty("mensaje", (String) resultado[1]);

        if (resultado[0].equals("success") && resultado.length > 2) {
            Usuario usuario = (Usuario) resultado[2];
            JsonObject usuarioJson = new JsonObject();
            usuarioJson.addProperty("nombre", usuario.getNombre());
            usuarioJson.addProperty("correo", usuario.getCorreo());
            usuarioJson.addProperty("telefono", usuario.getTelefono());
            usuarioJson.addProperty("rol", usuario.getRol());
            usuarioJson.addProperty("cedula", usuario.getCedula());
            if (usuario.getFechanacimiento() != null) {
                usuarioJson.addProperty("fechanacimiento", usuario.getFechanacimiento().toString());
            }
            response.add("usuario", usuarioJson);
        }

        return response;
    }

    public JsonObject actualizar(JsonObject json) {
        JsonObject response = new JsonObject();

        String correoOriginal = obtenerCampo(json, "correo");
        String nuevoCorreo = obtenerCampo(json, "nuevoCorreo");
        String telefono = obtenerCampo(json, "telefono");
        String contraseña = obtenerCampo(json, "password");

        String resultado = actualizarUsuario(correoOriginal, nuevoCorreo, telefono, contraseña);
        response.addProperty("success", !resultado.contains("Error") && !resultado.contains("no"));
        response.addProperty("mensaje", resultado);

        return response;
    }

    public JsonObject eliminar(JsonObject json) {
        JsonObject response = new JsonObject();

        String correo = obtenerCampo(json, "correo");

        String resultado = eliminarUsuario(correo);
        response.addProperty("success", resultado.equals("Usuario eliminado correctamente"));
        response.addProperty("mensaje", resultado);

        return response;
    }

    public String registrarUsuario(String nombre, String correo, String contraseña,
            String telefono, int cedula, LocalDate fechanacimiento) {
        try {
            System.out.println("[SERVICIO] Iniciando registro de usuario: " + correo);

            if (nombre == null || nombre.trim().isEmpty()
                    || correo == null || correo.trim().isEmpty()
                    || contraseña == null || contraseña.trim().isEmpty()
                    || cedula == 0 || fechanacimiento == null
                    || telefono == null || telefono.trim().isEmpty()) {
                return "Todos los campos son obligatorios";
            }

            if (!correo.contains("@")) {
                return "El formato del correo no es válido";
            }

            int edad = Period.between(fechanacimiento, LocalDate.now()).getYears();
            if (edad < 18) {
                return "Debe ser mayor de 18 años para registrarse";
            }

            String rol = (edad >= 60) ? "Adulto Mayor" : "Donante";

            Usuario usuario = new Usuario(0, nombre, correo, contraseña, telefono, rol, cedula, fechanacimiento);
            ud.saveUsuario(usuario);

            System.out.println("[SERVICIO] Usuario registrado exitosamente");
            return "Usuario registrado exitosamente";

        } catch (SQLException e) {
            System.out.println("[SERVICIO-ERROR] " + e.getMessage());
            if (e.getMessage().contains("duplicate key") || e.getMessage().contains("ya existe")) {
                return "El correo o cédula ya están registrados";
            }
            return "Error al registrar el usuario: " + e.getMessage();
        } catch (Exception e) {
            System.out.println("[SERVICIO-ERROR] " + e.getMessage());
            return "Error inesperado al registrar el usuario";
        }
    }

    public String[] validarLogin(String correo, String contraseña) {
        System.out.println("[SERVICIO] Validando login para: " + correo);

        if (correo == null || correo.trim().isEmpty() || contraseña == null || contraseña.trim().isEmpty()) {
            return new String[]{"error", "Por favor ingrese correo y contraseña"};
        }

        boolean valido = ud.verificarLogin(correo, contraseña);
        if (valido) {
            return new String[]{"success", "Login exitoso", correo};
        } else {
            return new String[]{"error", "Correo o contraseña incorrectos"};
        }
    }

    public Object[] obtenerPerfilUsuario(String correo) {
        try {
            System.out.println("[SERVICIO] Obteniendo perfil para: " + correo);

            if (correo == null || correo.trim().isEmpty()) {
                return new Object[]{"error", "Correo no proporcionado"};
            }

            Usuario usuario = ud.buscarUsuarioPorCorreo(correo);
            if (usuario != null) {
                return new Object[]{"success", "Usuario encontrado", usuario};
            } else {
                return new Object[]{"error", "Usuario no encontrado"};
            }
        } catch (Exception e) {
            System.out.println("[SERVICIO-ERROR] " + e.getMessage());
            return new Object[]{"error", "Error al obtener el perfil"};
        }
    }

    public String actualizarUsuario(String correoOriginal, String nuevoCorreo,
            String telefono, String contraseña) {
        try {
            System.out.println("[SERVICIO] Actualizando usuario: " + correoOriginal);

            if (correoOriginal == null || correoOriginal.trim().isEmpty()) {
                return "Correo original no proporcionado";
            }
            boolean sinCambios = (nuevoCorreo == null || nuevoCorreo.trim().isEmpty() || nuevoCorreo.equals(correoOriginal))
                    && (telefono == null || telefono.trim().isEmpty())
                    && (contraseña == null || contraseña.trim().isEmpty());

            if (sinCambios) {
                return "No hay cambios para actualizar";
            }

            Usuario usuario = ud.buscarUsuarioPorCorreo(correoOriginal);
            if (usuario == null) {
                return "Usuario no encontrado";
            }

            if (nuevoCorreo != null && !nuevoCorreo.trim().isEmpty() && !nuevoCorreo.equals(correoOriginal)) {
                Usuario usuarioConNuevoCorreo = ud.buscarUsuarioPorCorreo(nuevoCorreo);
                if (usuarioConNuevoCorreo != null) {
                    return "El nuevo correo ya está en uso";
                }
                usuario.setCorreo(nuevoCorreo);
            }

            if (telefono != null && !telefono.trim().isEmpty()) {
                usuario.setTelefono(telefono);
            }
            if (contraseña != null && !contraseña.trim().isEmpty()) {
                usuario.setContraseña(contraseña);
            }

            ud.editarUsuario(usuario, correoOriginal);
            return "Perfil actualizado correctamente";

        } catch (SQLException e) {
            System.out.println("[SERVICIO-ERROR] " + e.getMessage());
            if (e.getMessage().contains("duplicate key")) {
                return "El correo ya está en uso";
            }
            return "Error al actualizar el perfil: " + e.getMessage();
        } catch (Exception e) {
            System.out.println("[SERVICIO-ERROR] " + e.getMessage());
            return "Error inesperado al actualizar el perfil";
        }
    }

    public String eliminarUsuario(String correo) {
        try {
            System.out.println("[SERVICIO] Eliminando usuario: " + correo);

            if (correo == null || correo.trim().isEmpty()) {
                return "Correo no proporcionado";
            }

            boolean eliminado = ud.eliminarPorCorreo(correo);
            if (eliminado) {
                return "Usuario eliminado correctamente";
            } else {
                return "No se pudo eliminar el usuario";
            }
        } catch (Exception e) {
            System.out.println("[SERVICIO-ERROR] " + e.getMessage());
            return "Error al eliminar el usuario";
        }
    }

    private String obtenerCampo(JsonObject json, String campo) {
        return json.has(campo) ? json.get(campo).getAsString() : null;
    }
}

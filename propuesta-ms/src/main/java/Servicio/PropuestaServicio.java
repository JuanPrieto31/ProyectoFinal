package Servicio;

import Modelo.Propuesta;
import Persistencia.PropuestaDao;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import java.sql.SQLException;
import java.util.List;

public class PropuestaServicio {

    private PropuestaDao pd;
    private final Gson gson;

    public PropuestaServicio() {
        pd = new PropuestaDao();

        this.gson = new GsonBuilder()
                .registerTypeAdapter(java.time.LocalDate.class,
                        (com.google.gson.JsonSerializer<java.time.LocalDate>) (src, typeOfSrc, context)
                        -> new com.google.gson.JsonPrimitive(src.toString())
                )
                .create();
    }

    public int obtenerId(String correo) throws SQLException {
        if (correo == null || correo.trim().isEmpty()) {
            throw new IllegalArgumentException("El correo no puede estar vacío");
        }
        return pd.buscarId(correo);
    }

    public JsonObject CrearPropuesta(JsonObject json) {
        JsonObject respuesta = new JsonObject();

        try {
            if (json == null
                    || !json.has("correo")
                    || !json.has("titulo")
                    || !json.has("contenido")) {

                respuesta.addProperty("success", false);
                respuesta.addProperty("mensaje", "Faltan campos obligatorios en el JSON");
                return respuesta;
            }

            String correo = json.get("correo").getAsString().trim();
            String titulo = json.get("titulo").getAsString().trim();
            String contenido = json.get("contenido").getAsString().trim();

            if (correo.isEmpty() || titulo.isEmpty() || contenido.isEmpty()) {
                respuesta.addProperty("success", false);
                respuesta.addProperty("mensaje", "Todos los campos son obligatorios");
                return respuesta;
            }

            int idUsuario = obtenerId(correo);
            if (idUsuario == 0) {
                respuesta.addProperty("success", false);
                respuesta.addProperty("mensaje", "Usuario no encontrado");
                return respuesta;
            }

            Propuesta propuesta = new Propuesta(0, titulo, contenido, idUsuario);
            pd.savePropuesta(propuesta);

            respuesta.addProperty("success", true);
            respuesta.addProperty("mensaje", "Propuesta creada exitosamente");

        } catch (SQLException e) {
            respuesta.addProperty("success", false);
            respuesta.addProperty("mensaje", "Error al guardar en la base de datos: " + e.getMessage());
        } catch (Exception e) {
            respuesta.addProperty("success", false);
            respuesta.addProperty("mensaje", "Error inesperado: " + e.getMessage());
        }

        return respuesta;
    }

    public JsonObject listarPropuestas() {
        JsonObject respuesta = new JsonObject();

        try {
            List<Propuesta> propuestas = pd.findAllPropuestas();

            respuesta.addProperty("success", true);
            respuesta.add("propuestas", gson.toJsonTree(propuestas));

        } catch (Exception e) {
            respuesta.addProperty("success", false);
            respuesta.addProperty("mensaje", "Error al listar propuestas: " + e.getMessage());
        }

        return respuesta;
    }

    public JsonObject listarPropuestasPorUsuario(String idUsuario) {
        JsonObject respuesta = new JsonObject();
        try {
            int usuarioId = Integer.parseInt(idUsuario);

            List<Propuesta> propuestas = pd.findPropuestasByUsuario(usuarioId);

            JsonArray propuestasArray = gson.toJsonTree(propuestas).getAsJsonArray();

            respuesta.addProperty("success", true);
            respuesta.add("propuestas", propuestasArray);
            respuesta.addProperty("mensaje", "Propuestas listadas correctamente para el usuario: " + idUsuario);

        } catch (NumberFormatException e) {
            respuesta.addProperty("success", false);
            respuesta.addProperty("mensaje", "ID de usuario inválido: " + idUsuario);
        } catch (SQLException e) {
            respuesta.addProperty("success", false);
            respuesta.addProperty("mensaje", "Error al listar propuestas: " + e.getMessage());
        } catch (Exception e) {
            respuesta.addProperty("success", false);
            respuesta.addProperty("mensaje", "Error inesperado: " + e.getMessage());
        }
        return respuesta;
    }

    public JsonObject actualizar(JsonObject json) {
        JsonObject respuesta = new JsonObject();

        try {
            if (json == null || !json.has("id") || !json.has("titulo") || !json.has("contenido")) {
                respuesta.addProperty("success", false);
                respuesta.addProperty("mensaje", "Faltan campos obligatorios: id, titulo, contenido");
                return respuesta;
            }

            int idPropuesta = json.get("id").getAsInt();
            String titulo = json.get("titulo").getAsString().trim();
            String contenido = json.get("contenido").getAsString().trim();

            if (titulo.isEmpty() || contenido.isEmpty()) {
                respuesta.addProperty("success", false);
                respuesta.addProperty("mensaje", "Título y contenido no pueden estar vacíos");
                return respuesta;
            }

            Propuesta propuestaExistente = pd.findPropuestaById(idPropuesta);
            if (propuestaExistente == null) {
                respuesta.addProperty("success", false);
                respuesta.addProperty("mensaje", "Propuesta no encontrada");
                return respuesta;
            }

            Propuesta propuesta = new Propuesta(idPropuesta, titulo, contenido, propuestaExistente.getIdUsuario());

            boolean actualizado = pd.updatePropuesta(propuesta);

            if (actualizado) {
                respuesta.addProperty("success", true);
                respuesta.addProperty("mensaje", "Propuesta actualizada exitosamente");
            } else {
                respuesta.addProperty("success", false);
                respuesta.addProperty("mensaje", "No se pudo actualizar la propuesta");
            }

        } catch (Exception e) {
            respuesta.addProperty("success", false);
            respuesta.addProperty("mensaje", "Error al actualizar propuesta: " + e.getMessage());
        }

        return respuesta;
    }

    public JsonObject eliminar(JsonObject json) {
        JsonObject respuesta = new JsonObject();

        try {
            if (json == null || !json.has("id")) {
                respuesta.addProperty("success", false);
                respuesta.addProperty("mensaje", "El campo 'id' es requerido");
                return respuesta;
            }

            int idPropuesta = json.get("id").getAsInt();

            Propuesta propuestaExistente = pd.findPropuestaById(idPropuesta);
            if (propuestaExistente == null) {
                respuesta.addProperty("success", false);
                respuesta.addProperty("mensaje", "Propuesta no encontrada");
                return respuesta;
            }

            boolean eliminado = pd.deletePropuesta(idPropuesta);

            if (eliminado) {
                respuesta.addProperty("success", true);
                respuesta.addProperty("mensaje", "Propuesta eliminada exitosamente");
            } else {
                respuesta.addProperty("success", false);
                respuesta.addProperty("mensaje", "No se pudo eliminar la propuesta");
            }

        } catch (Exception e) {
            respuesta.addProperty("success", false);
            respuesta.addProperty("mensaje", "Error al eliminar propuesta: " + e.getMessage());
        }

        return respuesta;
    }
}

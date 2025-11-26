package Persistencia;

import Modelo.Propuesta;
import Persistencia.datos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.util.List;
import java.util.ArrayList;


/**
 *
 * @author esteb
 */
public class PropuestaDao {

    static final String URL = "jdbc:postgresql://localhost:5432/ProyectoDS";
    private static final String USER = "postgres";
    private static final String PASSWORD = "123456789";

    // ============================================================
    // GUARDAR PROPUESTA
    // ============================================================
    public void savePropuesta(Propuesta propuesta) throws SQLException {

        System.out.println("[DEBUG] PropuestaDao.savePropuesta - Iniciando registro");
        System.out.println("[DEBUG] Datos -> Título: " + propuesta.getTitulo()
                + ", UsuarioID: " + propuesta.getIdUsuario());

        String sql = "INSERT INTO propuesta(titulo, contenido, fechacreacion, idusuario) "
                + "VALUES(?, ?, ?, ?)";

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            Class.forName("org.postgresql.Driver");
            datos conbd = new datos(URL, USER, PASSWORD);
            conn = conbd.getConn();

            if (conn == null) {
                throw new SQLException("No se pudo establecer conexión con la base de datos");
            }

            stmt = conn.prepareStatement(sql);
            stmt.setString(1, propuesta.getTitulo());
            stmt.setString(2, propuesta.getContenido());
            stmt.setDate(3, java.sql.Date.valueOf(propuesta.getFechacreacion()));
            stmt.setInt(4, propuesta.getIdUsuario());

            System.out.println("[DEBUG] Ejecutando INSERT...");
            int rows = stmt.executeUpdate();
            System.out.println("[DEBUG] Propuesta guardada. Filas afectadas: " + rows);

        } catch (ClassNotFoundException e) {
            throw new SQLException("Driver PostgreSQL no encontrado", e);

        } catch (SQLException e) {
            System.out.println("[ERROR] Error SQL al guardar propuesta: " + e.getMessage());
            throw e;

        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
                System.out.println("[DEBUG] Conexión cerrada (savePropuesta)");
            } catch (SQLException e) {
                System.out.println("[ERROR] Error cerrando recursos: " + e.getMessage());
            }
        }
    }

    // ============================================================
    // OBTENER PROPUESTA POR ID
    // ============================================================
    public Propuesta buscarPorId(int idPropuesta, int idUsuario) throws SQLException {
    String sql = "SELECT * FROM propuesta WHERE id = ? AND idusuario = ?";
    
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    Propuesta propuesta = null;

    try {
        Class.forName("org.postgresql.Driver");
        datos conbd = new datos(URL, USER, PASSWORD);
        conn = conbd.getConn();

        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, idPropuesta);
        stmt.setInt(2, idUsuario);

        rs = stmt.executeQuery();

        if (rs.next()) {
            propuesta = new Propuesta(
                rs.getInt("id"),
                rs.getString("titulo"),
                rs.getString("contenido"),
                rs.getDate("fechacreacion").toLocalDate(),
                rs.getInt("idusuario")
            );
        }

    } catch (Exception e) {
        throw new SQLException("Error en buscarPorIdYUsuario", e);
    } finally {
        if (rs != null) rs.close();
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
    return propuesta;
}

    // ============================================================
    // ELIMINAR PROPUESTA POR ID
    // ============================================================
    public boolean eliminarPropuestaDeUsuario(int idPropuesta, int idUsuario) throws SQLException {
    String sql = "DELETE FROM propuesta WHERE id = ? AND idusuario = ?";
    
    Connection conn = null;
    PreparedStatement stmt = null;
    
    try {
        Class.forName("org.postgresql.Driver");
        datos conbd = new datos(URL, USER, PASSWORD);
        conn = conbd.getConn();

        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, idPropuesta);
        stmt.setInt(2, idUsuario);

        int rows = stmt.executeUpdate();
        return rows > 0;

    } catch (Exception e) {
        throw new SQLException("Error eliminando propuesta del usuario", e);
    } finally {
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
}

    // ============================================================
    // ACTUALIZAR PROPUESTA
    // ============================================================
    public boolean editarPropuestaDeUsuario(Propuesta propuesta) throws SQLException {
    String sql = "UPDATE propuesta SET titulo = ?, contenido = ? "
               + "WHERE id = ? AND idusuario = ?";
    
    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        Class.forName("org.postgresql.Driver");
        datos conbd = new datos(URL, USER, PASSWORD);
        conn = conbd.getConn();

        stmt = conn.prepareStatement(sql);
        stmt.setString(1, propuesta.getTitulo());
        stmt.setString(2, propuesta.getContenido());
        stmt.setInt(3, propuesta.getId());
        stmt.setInt(4, propuesta.getIdUsuario());

        int rows = stmt.executeUpdate();
        return rows > 0;

    } catch (Exception e) {
        throw new SQLException("Error editando propuesta del usuario", e);
    } finally {
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
}
    public List<Propuesta> listarPorUsuario(int idUsuario) throws SQLException {
    String sql = "SELECT * FROM propuesta WHERE idusuario = ?";
    List<Propuesta> lista = new ArrayList<>();

    try {
        Class.forName("org.postgresql.Driver");
        datos conbd = new datos(URL, USER, PASSWORD);
        Connection conn = conbd.getConn();
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, idUsuario);

        ResultSet rs = stmt.executeQuery();

        while (rs.next()) {
            Propuesta p = new Propuesta(
                    rs.getInt("id"),
                    rs.getString("titulo"),
                    rs.getString("contenido"),
                    rs.getDate("fechacreacion").toLocalDate(),
                    rs.getInt("idusuario")
            );
            lista.add(p);
        }

        rs.close();
        stmt.close();
        conn.close();
    } catch (Exception e) {
        throw new SQLException("Error al listar propuestas", e);
    }

    return lista;
}

}

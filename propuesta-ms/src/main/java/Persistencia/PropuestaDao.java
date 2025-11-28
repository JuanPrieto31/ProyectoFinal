package Persistencia;

import Modelo.Propuesta;
import Persistencia.datos;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.Statement;
import java.time.LocalDate;
import java.util.List;
import java.util.ArrayList;
import java.util.LinkedList;


public class PropuestaDao {

    static final String URL = "jdbc:postgresql://localhost:5432/ProyectoDS";
    private static final String USER = "postgres";
    private static final String PASSWORD = "Prieto310106";

    public int buscarId(String correo) throws SQLException {
        System.out.println("[DEBUG] PropuestaRep.buscarId - Buscando ID de usuario por correo: " + correo);

        String sql = "SELECT idusuario FROM usuario WHERE correo = ?";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("org.postgresql.Driver");
            System.out.println("[DEBUG] Driver PostgreSQL cargado correctamente");

            datos conbd = new datos(URL, USER, PASSWORD);
            conn = conbd.getConn();

            if (conn == null) {
                throw new SQLException("No se pudo establecer conexión a la base de datos");
            }

            stmt = conn.prepareStatement(sql);
            stmt.setString(1, correo);
            rs = stmt.executeQuery();

            if (rs.next()) {
                int id = rs.getInt("idusuario");
                System.out.println("[DEBUG] ID encontrado: " + id);
                return id;
            } else {
                System.out.println("[WARN] No se encontró usuario con el correo: " + correo);
                return 0;
            }

        } catch (ClassNotFoundException e) {
            System.out.println("[ERROR] Driver PostgreSQL no encontrado: " + e.getMessage());
            e.printStackTrace();
            throw new SQLException("Driver PostgreSQL no encontrado", e);
        } catch (SQLException e) {
            System.out.println("[ERROR] Error SQL en buscarId: " + e.getMessage());
            e.printStackTrace();
            throw e;
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
                System.out.println("[DEBUG] Conexión cerrada correctamente");
            } catch (SQLException e) {
                System.out.println("[ERROR] Error al cerrar conexión: " + e.getMessage());
            }
        }
    }

    public void savePropuesta(Propuesta propuesta) throws SQLException {
        System.out.println("[DEBUG] PropuestaRep.savePropuesta - Iniciando registro de Propuesta");
        System.out.println("[DEBUG] Datos de la propuesta - Título: " + propuesta.getTitulo());

        String sql = "INSERT INTO propuesta (titulo, descripcion, idusuario) VALUES (?, ?, ?)";
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            Class.forName("org.postgresql.Driver");
            System.out.println("[DEBUG] Driver PostgreSQL cargado correctamente");

            datos conbd = new datos(URL, USER, PASSWORD);
            conn = conbd.getConn();

            if (conn == null) {
                throw new SQLException("No se pudo establecer conexión a la base de datos");
            }

            System.out.println("[DEBUG] Conexión establecida, preparando statement");

            stmt = conn.prepareStatement(sql);
            stmt.setString(1, propuesta.getTitulo());
            stmt.setString(2, propuesta.getContenido());
            stmt.setInt(3, propuesta.getIdUsuario());

            System.out.println("[DEBUG] Ejecutando INSERT en la base de datos");
            int rowsAffected = stmt.executeUpdate();
            System.out.println("[DEBUG] Propuesta guardada exitosamente. Filas afectadas: " + rowsAffected);

        } catch (ClassNotFoundException e) {
            System.out.println("[ERROR] Driver PostgreSQL no encontrado: " + e.getMessage());
            throw new SQLException("Driver PostgreSQL no encontrado", e);
        } catch (SQLException e) {
            System.out.println("[ERROR] Error SQL al guardar propuesta: " + e.getMessage());
            throw e;
        } catch (Exception e) {
            System.out.println("[ERROR] Error general al guardar propuesta: " + e.getMessage());
            throw new SQLException("Error al guardar propuesta", e);
        } finally {
            if (stmt != null) try {
                stmt.close();
            } catch (SQLException ignored) {
            }
            if (conn != null) try {
                conn.close();
            } catch (SQLException ignored) {
            }
            System.out.println("[DEBUG] Conexión cerrada correctamente");
        }
    }

    public List<Propuesta> findAllPropuestas() {
        List<Propuesta> lista = new LinkedList<>();
        String sql = "SELECT idpropuesta, titulo, descripcion, fechacreacion, idusuario FROM propuesta";

        try {
            datos conbd = new datos(URL, USER, PASSWORD);
            try (Connection conn = conbd.getConn(); Statement st = conn.createStatement(); ResultSet rs = st.executeQuery(sql)) {

                while (rs.next()) {
                    int idPropuesta = rs.getInt("idpropuesta");
                    String titulo = rs.getString("titulo");
                    String descripcion = rs.getString("descripcion");
                    Date fechaCreacionSQL = rs.getDate("fechacreacion");
                    int idUsuario = rs.getInt("idusuario");

                    Propuesta p = new Propuesta(idPropuesta, titulo, descripcion, idUsuario);

                    if (fechaCreacionSQL != null) {
                        p.setFechacreacion(fechaCreacionSQL.toLocalDate()); 
                    }

                    lista.add(p);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("[ERROR] Error al listar propuestas: " + e.getMessage());
        }

        return lista;
    }

    public List<Propuesta> findPropuestasByUsuario(int usuarioId) throws SQLException {
        System.out.println("[DEBUG] PropuestaDao.findPropuestasByUsuario - Buscando propuestas para usuario ID: " + usuarioId);

        List<Propuesta> lista = new LinkedList<>();
        String sql = "SELECT idpropuesta, titulo, descripcion, fechacreacion, idusuario FROM propuesta WHERE idusuario = ?";

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("org.postgresql.Driver");
            System.out.println("[DEBUG] Driver PostgreSQL cargado correctamente");

            datos conbd = new datos(URL, USER, PASSWORD);
            conn = conbd.getConn();

            if (conn == null) {
                throw new SQLException("No se pudo establecer conexión a la base de datos");
            }

            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, usuarioId);
            rs = stmt.executeQuery();

            while (rs.next()) {
                int idPropuesta = rs.getInt("idpropuesta");
                String titulo = rs.getString("titulo");
                String descripcion = rs.getString("descripcion");
                Date fechaCreacionSQL = rs.getDate("fechacreacion");
                int idUsuario = rs.getInt("idusuario");

                Propuesta p = new Propuesta(idPropuesta, titulo, descripcion, idUsuario);

                if (fechaCreacionSQL != null) {
                    p.setFechacreacion(fechaCreacionSQL.toLocalDate());
                }

                lista.add(p);
            }

            System.out.println("[DEBUG] Se encontraron " + lista.size() + " propuestas para el usuario ID: " + usuarioId);

        } catch (ClassNotFoundException e) {
            System.out.println("[ERROR] Driver PostgreSQL no encontrado: " + e.getMessage());
            throw new SQLException("Driver PostgreSQL no encontrado", e);
        } catch (SQLException e) {
            System.out.println("[ERROR] Error SQL en findPropuestasByUsuario: " + e.getMessage());
            throw e;
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
                System.out.println("[DEBUG] Conexión cerrada correctamente en findPropuestasByUsuario");
            } catch (SQLException e) {
                System.out.println("[ERROR] Error al cerrar conexión: " + e.getMessage());
            }
        }

        return lista;
    }

    public Propuesta findPropuestaById(int idPropuesta) throws SQLException {
        System.out.println("[DEBUG] PropuestaDao.findPropuestaById - Buscando propuesta ID: " + idPropuesta);

        String sql = "SELECT idpropuesta, titulo, descripcion, fechacreacion, idusuario FROM propuesta WHERE idpropuesta = ?";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("org.postgresql.Driver");
            datos conbd = new datos(URL, USER, PASSWORD);
            conn = conbd.getConn();

            if (conn == null) {
                throw new SQLException("No se pudo establecer conexión a la base de datos");
            }

            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, idPropuesta);
            rs = stmt.executeQuery();

            if (rs.next()) {
                int id = rs.getInt("idpropuesta");
                String titulo = rs.getString("titulo");
                String descripcion = rs.getString("descripcion");
                Date fechaCreacionSQL = rs.getDate("fechacreacion");
                int idUsuario = rs.getInt("idusuario");

                Propuesta propuesta = new Propuesta(id, titulo, descripcion, idUsuario);

                if (fechaCreacionSQL != null) {
                    propuesta.setFechacreacion(fechaCreacionSQL.toLocalDate());
                }

                System.out.println("[DEBUG] Propuesta encontrada: " + titulo);
                return propuesta;
            } else {
                System.out.println("[DEBUG] No se encontró propuesta con ID: " + idPropuesta);
                return null;
            }

        } catch (ClassNotFoundException e) {
            System.out.println("[ERROR] Driver PostgreSQL no encontrado: " + e.getMessage());
            throw new SQLException("Driver PostgreSQL no encontrado", e);
        } catch (SQLException e) {
            System.out.println("[ERROR] Error SQL en findPropuestaById: " + e.getMessage());
            throw e;
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                System.out.println("[ERROR] Error al cerrar conexión: " + e.getMessage());
            }
        }
    }

    public boolean updatePropuesta(Propuesta propuesta) throws SQLException {
        System.out.println("[DEBUG] PropuestaDao.updatePropuesta - Actualizando propuesta ID: " + propuesta.getId());

        String sql = "UPDATE propuesta SET titulo = ?, descripcion = ? WHERE idpropuesta = ?";
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            Class.forName("org.postgresql.Driver");
            datos conbd = new datos(URL, USER, PASSWORD);
            conn = conbd.getConn();

            if (conn == null) {
                throw new SQLException("No se pudo establecer conexión a la base de datos");
            }

            stmt = conn.prepareStatement(sql);
            stmt.setString(1, propuesta.getTitulo());
            stmt.setString(2, propuesta.getContenido());
            stmt.setInt(3, propuesta.getId());

            int rowsAffected = stmt.executeUpdate();
            System.out.println("[DEBUG] Filas afectadas en actualización: " + rowsAffected);

            return rowsAffected > 0;

        } catch (ClassNotFoundException e) {
            System.out.println("[ERROR] Driver PostgreSQL no encontrado: " + e.getMessage());
            throw new SQLException("Driver PostgreSQL no encontrado", e);
        } catch (SQLException e) {
            System.out.println("[ERROR] Error SQL en updatePropuesta: " + e.getMessage());
            throw e;
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                System.out.println("[ERROR] Error al cerrar conexión: " + e.getMessage());
            }
        }
    }

    public boolean deletePropuesta(int idPropuesta) throws SQLException {
        System.out.println("[DEBUG] PropuestaDao.deletePropuesta - Eliminando propuesta ID: " + idPropuesta);

        String sql = "DELETE FROM propuesta WHERE idpropuesta = ?";
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            Class.forName("org.postgresql.Driver");
            datos conbd = new datos(URL, USER, PASSWORD);
            conn = conbd.getConn();

            if (conn == null) {
                throw new SQLException("No se pudo establecer conexión a la base de datos");
            }

            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, idPropuesta);

            int rowsAffected = stmt.executeUpdate();
            System.out.println("[DEBUG] Filas afectadas en eliminación: " + rowsAffected);

            return rowsAffected > 0;

        } catch (ClassNotFoundException e) {
            System.out.println("[ERROR] Driver PostgreSQL no encontrado: " + e.getMessage());
            throw new SQLException("Driver PostgreSQL no encontrado", e);
        } catch (SQLException e) {
            System.out.println("[ERROR] Error SQL en deletePropuesta: " + e.getMessage());
            throw e;
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                System.out.println("[ERROR] Error al cerrar conexión: " + e.getMessage());
            }
        }
    }
}

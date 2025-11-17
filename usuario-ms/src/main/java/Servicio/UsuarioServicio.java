package Servicio;

import Modelo.Usuario;
import Persistencia.UsuarioDao;
import java.sql.SQLException;

public class UsuarioServicio {

    private UsuarioDao ud;

    public UsuarioServicio() {
        ud = new UsuarioDao();
    }

    public void registrar(Usuario usuario) throws SQLException {
        System.out.println("[DEBUG] UsuarioServicio.registrar - Validando datos del usuario");
        ud.saveUsuario(usuario);
        System.out.println("[DEBUG] Usuario registrado exitosamente en el servicio");
    }

    public boolean validarLogin(String correo, String contraseña) {
        System.out.println("[DEBUG] validarLogin - Verificando credenciales para: " + correo);
        return ud.verificarLogin(correo, contraseña);
    }

    public Usuario obtenerUsuario(String correo) throws SQLException {
        System.out.println("[DEBUG] obtenerUsuario - Buscando usuario: " + correo);
        return ud.buscarUsuarioPorCorreo(correo);
    }

    public boolean eliminarUsuario(String correo) throws SQLException {
        System.out.println("[DEBUG] eliminarUsuario - Eliminando usuario: " + correo);
        return ud.eliminarPorCorreo(correo);
    }

    public void actualizarUsuario(Usuario usuario, String correoOriginal) throws SQLException {
        System.out.println("[DEBUG] actualizarUsuario - Actualizando usuario: " + correoOriginal);
        ud.editarUsuario(usuario, correoOriginal);
    }
}

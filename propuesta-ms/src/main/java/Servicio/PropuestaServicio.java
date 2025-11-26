package Servicio;

import Modelo.Propuesta;
import Persistencia.PropuestaDao;
import java.util.List;

public class PropuestaServicio {

    private final PropuestaDao dao = new PropuestaDao();

    public boolean guardar(Propuesta p) {
        try {
            dao.savePropuesta(p);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public Propuesta buscarPorIdDeUsuario(int idPropuesta, int idUsuario) {
        try {
            return dao.buscarPorId(idPropuesta, idUsuario);
        } catch (Exception e) {
            return null;
        }
    }

    public boolean editar(Propuesta p) {
        try {
            return dao.editarPropuestaDeUsuario(p);
        } catch (Exception e) {
            return false;
        }
    }

    public boolean eliminar(int idPropuesta, int idUsuario) {
        try {
            return dao.eliminarPropuestaDeUsuario(idPropuesta, idUsuario);
        } catch (Exception e) {
            return false;
        }
    }

    public List<Propuesta> listarPorUsuario(int idUsuario) {
        try {
            return dao.listarPorUsuario(idUsuario);
        } catch (Exception e) {
            return null;
        }
    }
}

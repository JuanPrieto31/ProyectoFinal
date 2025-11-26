package Presentacion;

import Modelo.Propuesta;
import Servicio.PropuestaServicio;
import com.google.gson.Gson;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.BufferedReader;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/propuesta/*")
public class PropuestaControl extends HttpServlet {

    private final PropuestaServicio servicio = new PropuestaServicio();
    private final Gson gson = new Gson();

    // ==========================================
    // GET → listar o buscar por ID+usuario
    // /propuesta/usuario?idUsuario=1
    // /propuesta/buscar?id=3&idUsuario=1
    // ==========================================
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        resp.setContentType("application/json");
        String path = req.getPathInfo();

        if ("/usuario".equals(path)) {
            int idUsuario = Integer.parseInt(req.getParameter("idUsuario"));
            List<Propuesta> lista = servicio.listarPorUsuario(idUsuario);
            resp.getWriter().print(gson.toJson(lista));
            return;
        }

        if ("/buscar".equals(path)) {
            int id = Integer.parseInt(req.getParameter("id"));
            int idUsuario = Integer.parseInt(req.getParameter("idUsuario"));
            Propuesta p = servicio.buscarPorIdDeUsuario(id, idUsuario);
            resp.getWriter().print(gson.toJson(p));
            return;
        }

        resp.setStatus(400);
        resp.getWriter().print("{\"error\":\"Ruta GET no válida\"}");
    }

    // ==========================================
    // POST → crear propuesta
    // /propuesta
    // ==========================================
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        BufferedReader reader = req.getReader();
        Propuesta propuesta = gson.fromJson(reader, Propuesta.class);

        propuesta.setFechacreacion(LocalDate.now());

        boolean ok = servicio.guardar(propuesta);

        resp.setContentType("application/json");
        resp.getWriter().print("{\"success\":" + ok + "}");
    }

    // ==========================================
    // PUT → editar propuesta
    // /propuesta
    // ==========================================
    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        BufferedReader reader = req.getReader();
        Propuesta propuesta = gson.fromJson(reader, Propuesta.class);

        boolean ok = servicio.editar(propuesta);

        resp.setContentType("application/json");
        resp.getWriter().print("{\"success\":" + ok + "}");
    }

    // ==========================================
    // DELETE → eliminar propuesta
    // /propuesta?id=5&idUsuario=1
    // ==========================================
    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        int id = Integer.parseInt(req.getParameter("id"));
        int idUsuario = Integer.parseInt(req.getParameter("idUsuario"));

        boolean ok = servicio.eliminar(id, idUsuario);

        resp.setContentType("application/json");
        resp.getWriter().print("{\"success\":" + ok + "}");
    }
}

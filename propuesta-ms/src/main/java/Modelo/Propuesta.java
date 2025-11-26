/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Modelo;
import java.time.LocalDate;

/**
 *
 * @author esteb
 */
public class Propuesta {
    private int id;
    private String titulo;
    private String contenido;
    private LocalDate fechacreacion;
    private int idUsuario; 

    public Propuesta(int id, String titulo, String contenido, LocalDate fechacreacion, int idUsuario) {
        this.id = id;
        this.titulo = titulo;
        this.contenido = contenido;
        this.fechacreacion = fechacreacion;
        this.idUsuario = idUsuario;
    }

    public int getId() {
        return id;
    }

    public String getTitulo() {
        return titulo;
    }

    public String getContenido() {
        return contenido;
    }

    public LocalDate getFechacreacion() {
        return fechacreacion;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public void setContenido(String contenido) {
        this.contenido = contenido;
    }

    public void setFechacreacion(LocalDate fechacreacion) {
        this.fechacreacion = fechacreacion;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }
    
    
}


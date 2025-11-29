<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>Registrar Donación</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.9.4/css/bulma.min.css">
</head>
<body>

  <section class="section">
    <div class="container">
      <h1 class="title">Realizar Donación</h1>

      <div id="messageBox"></div>

      <form id="formDonacion">

        <div class="field">
          <label class="label">Tipo de Donación</label>
          <div class="control">
            <div class="select">
              <select name="tipoDonacion" id="tipoDonacion" onchange="toggleDinero()" required>
                <option value="">Seleccione...</option>
                <option value="Dinero">Dinero</option>
                <option value="Especie">Especie</option>
              </select>
            </div>
          </div>
        </div>

        <div class="field">
          <label class="label">Nombre</label>
          <input class="input" type="text" name="nombre" required>
        </div>

        <div class="field">
          <label class="label">Correo</label>
          <input class="input" type="email" name="correo" required>
        </div>

        <div class="field">
          <label class="label">Número de contacto</label>
          <input class="input" type="text" name="numeroContacto" required>
        </div>

        <div class="field">
          <label class="label">Tipo Identificación</label>
          <div class="select">
            <select name="tipoIdentificacion" required>
              <option value="CC">Cédula</option>
              <option value="TI">Tarjeta Identidad</option>
              <option value="CE">Cédula Extranjería</option>
              <option value="PAS">Pasaporte</option>
            </select>
          </div>
        </div>

        <div class="field">
          <label class="label">Número Identificación</label>
          <input class="input" type="text" name="identificacion" required>
        </div>

        <!-- CAMPOS EXCLUSIVOS DE DINERO -->
        <div id="dineroBox" class="is-hidden">
          <div class="field">
            <label class="label">Entidad Bancaria</label>
            <div class="select">
              <select name="entidadBancaria" id="entidadBancaria">
                <option value="">Seleccione...</option>
                <option value="Bancolombia">Bancolombia</option>
                <option value="Davivienda">Davivienda</option>
                <option value="BBVA">BBVA</option>
                <option value="Banco de Bogotá">Banco de Bogotá</option>
              </select>
            </div>
          </div>

          <div class="field">
            <label class="label">Monto</label>
            <input class="input" type="number" step="0.01" id="monto" name="monto">
          </div>
        </div>

        <div class="field">
          <label class="label">Mensaje (opcional)</label>
          <textarea class="textarea" name="mensaje"></textarea>
        </div>

        <div class="field">
          <button class="button is-primary" type="submit">Enviar Donación</button>
        </div>
      </form>
    </div>
  </section>

  <script>
    function toggleDinero() {
      const tipo = document.getElementById("tipoDonacion").value;
      const box = document.getElementById("dineroBox");

      if (tipo === "Dinero") {
        box.classList.remove("is-hidden");
      } else {
        box.classList.add("is-hidden");
      }
    }

    document.getElementById("formDonacion").addEventListener("submit", async (e) => {
      e.preventDefault();

      const form = new FormData(e.target);
      const json = {};

      form.forEach((value, key) => json[key] = value);

      const msg = document.getElementById("messageBox");

      try {
        const resp = await fetch("DonacionControl", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify(json)
        });

        const data = await resp.json();

        if (data.success) {
          window.location.href = "exito.jsp";
        } else {
          msg.innerHTML =
            `<div class="notification is-danger">${data.message}</div>`;
        }
      } catch (err) {
        msg.innerHTML =
          `<div class="notification is-danger">Error de conexión con el servidor</div>`;
      }
    });
  </script>

</body>
</html>


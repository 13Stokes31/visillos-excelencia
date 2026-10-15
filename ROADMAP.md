# ROADMAP — visillos-excelencia

Lo que está por hacer o por decidir. Lo ya hecho pero sin comprobar está en
`TESTING.md`.

## Pendiente

### Publicar la 0.3.0 en Universe
Estado: **pendiente** (código listo en local).
Pasos según la receta de meshpad: commit, etiqueta `v0.3.0` (el README enlaza la
miniatura a esa etiqueta), push, copiar `lib.typ`, `LICENSE`, `README.md`,
`typst.toml`, `thumbnail.png` y `template/` al fork `13Stokes31/packages` y abrir el
PR `visillos-excelencia:0.3.0`. Las versiones 0.1.0 y 0.2.0 no tienen etiqueta en git.

### Mantener a la par con luisito-u
Estado: **abierto**. `luisito-u` es una copia de esta plantilla con otra portada y
otras fuentes, y comparte la misma configuración del `main.typ` (basta con cambiar
el import). Cualquier arreglo o parámetro nuevo de `lib.typ` hay que llevarlo
también a `luisito-u`.

### ¿Bibliografía antes de los anexos?
Estado: **por decidir**. Ahora el orden es: capítulos → anexos → glosario →
bibliografía → listas. En muchos trabajos académicos la bibliografía va antes de los
anexos. Cambiarlo moverá la bibliografía en los proyectos de los alumnos que
actualicen.

### Versión mínima de Typst sin comprobar
Estado: **abierto**. `typst.toml` dice `compiler = "0.13.0"`, pero solo se ha
compilado con 0.15. Comprobarlo con 0.13 o subir el mínimo.

### Validar parámetros (menor)
Estado: **propuesta**. `lista-figuras`, `lista-tablas`, `doble-cara` y
`contar-palabras` aceptan cualquier valor sin avisar. Un `assert` con mensaje claro
ayudaría a los alumnos que se equivoquen al escribirlos.

### Pruebas automáticas (menor)
Estado: **propuesta**. Un documento de prueba en `tests/` con dos capítulos,
figuras, tablas, ecuaciones, referencias y anexos, compilado a una y doble cara.
De momento basta con `TESTING.md`.

## Descartado (no re-proponer)

- **`abstract: true` buscando solo su fichero.** Un paquete no puede abrir ficheros
  de la carpeta del alumno: las rutas tienen que escribirse en el `main.typ`.
- **Logo como tupla `("Logo.svg", 30%)`** y **bibliografía como
  `("apa", "Bibliografía")`**: mismo problema de rutas, quitan flexibilidad y
  cambiarían el `main.typ` de quien ya usa la plantilla.

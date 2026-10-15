# TESTING — visillos-excelencia

Comprobaciones manuales: cosas ya hechas que falta verificar a mano. Se marcan al
comprobarlas.

## Cómo compilar la plantilla sin publicar el paquete

El `main.typ` de la plantilla importa `@preview/visillos-excelencia:<versión>`, que
no existe hasta que Universe acepta la versión. Para probar el código local, se
crea un directorio de paquetes que apunte al repo y se compila con él:

```bash
mkdir -p /tmp/pk/preview/visillos-excelencia
ln -sfn ~/Proyectos/visillos-excelencia /tmp/pk/preview/visillos-excelencia/0.3.0
cd ~/Proyectos/visillos-excelencia/template
typst compile --package-path /tmp/pk main.typ /tmp/visillos.pdf
```

## 0.3.0

- [ ] **Capítulos sin import.** Ningún fichero de `template/Archivos/` empieza por
      `#import "@preview/visillos-excelencia…"`, y la plantilla compila igual.
- [ ] **Anexos numerados.** En el PDF, tras la Conclusión: «Anexos» sin número y
      después «Anexo I. Tablas de medidas» y «Anexo II. Fotografías del experimento».
      El índice los muestra igual.
- [ ] **Figuras y tablas de los anexos.** La tabla del Anexo I es «Tabla I.1» y la
      figura del Anexo II es «Figura II.1», también en las listas finales.
- [ ] **Citas a anexos.** En el Capítulo 3, la frase de ejemplo dice «…en el Anexo I…
      en el Anexo II», y al pulsar cada una salta a su anexo.
- [ ] **Anexos tras un capítulo con apartados.** Si el último capítulo antes de
      `#show: anexos` tiene `==` apartados, el primer anexo sigue siendo «Anexo I»
      (no «Anexo III»).
- [ ] **Contador de palabras.** Con `contar-palabras: true`, debajo del índice sale
      «Extensión del trabajo: N palabras» (con la plantilla de ejemplo, 5695). Con
      `false`, no sale nada.
- [ ] **El recuento es razonable en un proyecto real.** Comparar el número con el
      recuento de un procesador de textos sobre el mismo texto (sin figuras ni tablas):
      debe salir parecido.
- [ ] **Doble cara.** Con `doble-cara: true` los capítulos y los anexos empiezan en
      página impar.
- [ ] **typst.app.** Con la 0.3.0 ya publicada, crear un proyecto desde la plantilla
      en typst.app y comprobar que compila (incluido el contador, que usa el paquete
      `wordometer`).
- [ ] **Proyecto de un alumno con la 0.2.0.** Cambiar solo el import a la 0.3.0:
      debe compilar igual (los parámetros nuevos son opcionales). Los capítulos que
      importaban la 0.2.0 siguen funcionando, aunque cargan las dos versiones;
      conviene quitarles el import.

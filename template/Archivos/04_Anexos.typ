// Escribimos a partir de aquí.
// Cada "==" es un anexo: la plantilla lo numera solo (Anexo I, Anexo II…).
// Ponle una etiqueta, como <anexo-medidas>, para citarlo con @anexo-medidas.

= Anexos

== Tablas de medidas <anexo-medidas>

#lorem(150)

#figure(
  table(
    columns: 3,
    [Muestra], [pH inicial], [pH final],
    [A], [6.5], [4.6],
    [B], [6.4], [4.3],
  ),
  caption: [Evolución del pH de las muestras],
)

#lorem(300)

== Fotografías del experimento <anexo-fotos>

#lorem(100)

#figure(
  image("Imágenes/reliquias.png", width: 40%),
  caption: [Montaje del experimento],
)

#lorem(400)

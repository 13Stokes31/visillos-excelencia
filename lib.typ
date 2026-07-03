//// Funciones ////

// Extrae el texto plano de un contenido sencillo (para los metadatos del PDF).
#let a-texto(c) = {
  if type(c) == str { c }
  else if type(c) != content { str(c) }
  else if c == [ ] { " " }
  else if c.has("text") { c.text }
  else if c.has("children") { c.children.map(a-texto).join() }
  else if c.has("body") { a-texto(c.body) }
  else { "" }
}

// Número "capítulo.n" de una figura/tabla/ecuación, calculado en SU ubicación
// (así las referencias y las listas muestran el capítulo correcto).
#let numero-en-capitulo(contador, ubicacion, patron) = {
  numbering(patron, counter(heading).at(ubicacion).first(), ..contador.at(ubicacion))
}

#let insertar-imagen(
  anchura: auto,
  altura: auto,
  borde: none,
  ubicacion: none, // la imagen, p. ej. image("Imágenes/foto.png")
  descripcion: none,
) = {
  figure(
    box(stroke: borde, {
      // Aplica anchura/altura salvo que la imagen ya traiga los suyos
      set image(width: anchura, height: altura)
      ubicacion
    }),
    caption: descripcion
  )
}

#let proyecto(
  titulo: [Título del proyecto],
  autor: [Nombre del Alumno],
  supervisor: [Nombre del Tutor],
  instituto: [IES Carmen Martín Gaite],
  lugar: [Navalcarnero],
  fecha: [Mayo 2026],
  logo: none,
  fuente: "Libertinus Serif",
  abstract: none,
  resumen: none,
  agradecimientos: none,
  doble-cara: false, // true: capítulos en página impar (para imprimir a doble cara)
  body,
) = {

  // Metadatos del PDF
  set document(title: a-texto(titulo), author: a-texto(autor))

  // Salto de sección: solo fuerza página impar si se imprime a doble cara
  let salto = () => pagebreak(weak: true, to: if doble-cara { "odd" } else { none })
  // A doble cara el número de página va al lado exterior; a una cara, a la derecha
  let lado-de(pagina) = if doble-cara and calc.even(pagina) { left } else { right }

  // Configuración de página
  set page(
    margin: (left: 2.5cm, right: 2.5cm, top: 2.5cm, bottom: 2.5cm),
  )

  set text(12pt, font: fuente, lang: "es")

  // Numeración por capítulo: Figura 2.1, Tabla 3.2, ecuación (1.4)
  set math.equation(numbering: n => context numbering("(1.1)", counter(heading).get().first(), n))
  set figure(numbering: n => context numbering("1.1", counter(heading).get().first(), n))

  // Referencias cruzadas: el capítulo se calcula en la ubicación del elemento
  show ref: it => {
    let el = it.element
    if el == none { return it }
    let ubi = el.location()
    if el.func() == math.equation {
      link(ubi, numero-en-capitulo(counter(math.equation), ubi, "(1.1)"))
    } else if el.func() == figure {
      link(ubi, [#el.supplement #numero-en-capitulo(counter(figure.where(kind: el.kind)), ubi, "1.1")])
    } else {
      it
    }
  }

  // Portada
  v(2fr)
  if logo != none {
    align(center, box(radius: 3pt, clip: true, logo))
  }
  v(1.6fr)
  align(center, text(14pt, "Proyecto de Excelencia"))
  v(1fr)
  align(center, text(30pt, hyphenate: false, weight: "bold", upper(titulo)))
  v(1.6fr)
  align(center, text(20pt, [Realizado por: ] + autor))
  v(1.6fr)
  align(center, text(14pt, instituto))
  v(0.6fr)
  align(center, text(14pt, smallcaps[Bachillerato de Excelencia]))
  v(1fr)
  align(center, text(14pt, lugar + [, ] + fecha))
  v(0.6fr)
  line(start: (25%, 0pt), end: (75%, 0pt))
  v(0.6fr)
  align(center, text(14pt, [Supervisado por: ] + supervisor))
  v(1.6fr)

  salto()

  // Numeración romana para las páginas iniciales y los índices
  set par(justify: true, leading: 1em, spacing: 20pt)
  counter(page).update(1)
  set page(numbering: "I", footer: context {
    let pagina = counter(page).get().first()
    align(lado-de(pagina), counter(page).display("I"))
  })

  // Estilos de encabezado (capítulos, portadillas iniciales y títulos de índice)
  show heading.where(level: 1): it => [
    #salto()
    #counter(figure.where(kind: image)).update(0)
    #counter(figure.where(kind: table)).update(0)
    #counter(math.equation).update(0)
    #v(10pt)
    #set text(size: 16pt, fill: rgb("#279985"))
    #it
  ]

  show heading.where(level: 2): it => [
    #v(5pt)
    #set text(size: 14pt, weight: "bold", fill: rgb("#2a2a2a"))
    #it
  ]

  show heading.where(level: 3): it => [
    #set text(size: 12pt, weight: "regular", style: "italic", fill: black)
    #it
  ]

  set heading(numbering: "1.")

  // Formato de las descripciones de figuras y tablas
  show figure.caption: set align(left)
  set figure.caption(position: top)

  show figure.caption: it => block(width: 100%)[
    #set text(size: 10pt)
    #set par(spacing: 1em)
    #strong[#it.supplement #context it.counter.display(it.numbering)]
    #emph[#it.body]
  ]

  // Páginas iniciales: cada una con su título, en su página y en el índice
  let portadilla(nombre, cuerpo) = {
    heading(level: 1, numbering: none, outlined: true, nombre)
    cuerpo
  }
  if abstract != none { portadilla([Abstract], abstract) }
  if resumen != none { portadilla([Resumen], resumen) }
  if agradecimientos != none { portadilla([Agradecimientos], agradecimientos) }

  // Índice general (solo aquí van los capítulos en negrita)
  {
    show outline.entry.where(level: 1): it => {
      v(12pt, weak: true)
      strong(it)
    }
    outline(depth: 2, indent: auto)
  }

  // Listas de imágenes y tablas, con el número "capítulo.n" de cada elemento
  let lista-de(nombre, tipo) = {
    show outline.entry: it => context {
      let el = it.element
      it.indented(
        [#el.supplement #numero-en-capitulo(counter(figure.where(kind: tipo)), el.location(), "1.1")],
        it.inner(),
      )
    }
    outline(title: nombre, target: figure.where(kind: tipo))
  }
  lista-de("Lista de imágenes", image)
  lista-de("Lista de tablas", table)

  // Cuerpo del documento: numeración arábiga y cabecera con el capítulo actual
  set page(
    numbering: "1",
    header: context {
      let pagina = here().page()
      // En la página donde arranca un capítulo no hay cabecera
      if query(heading.where(level: 1)).any(h => h.location().page() == pagina) { return }
      let previos = query(selector(heading.where(level: 1)).before(here()))
      if previos.len() == 0 { return }
      let capitulo = previos.last()
      let numero = if capitulo.numbering == none { [] } else {
        [#numbering("1.", counter(heading).at(capitulo.location()).first()) ]
      }
      align(lado-de(pagina), text(10pt, style: "italic", numero + capitulo.body))
    },
    footer: context {
      let pagina = counter(page).get().first()
      align(lado-de(pagina), counter(page).display("1"))
    },
  )
  counter(page).update(1)

  // AQUÍ SE VOLCARÁ EL TEXTO DEL ALUMNO
  body
}

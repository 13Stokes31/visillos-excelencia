- Que sea true o false, si o si enlace al archivo con ese nombre:
    abstract: include "Archivos/00_1_Abstract.typ",
    resumen: include "Archivos/00_2_Resumen.typ",
    agradecimientos: include "Archivos/00_3_Agradecimientos.typ",
- Logo sea una dupla en el que haya que poner el nombre entre comillas y el tamaño: image("Logo.svg", width: 30%) -> ("Logo.svg", 30%)
- Simplificar bibliografía. Un único documento llamado referencias.yml. Por lo tanto cambiar: bibliografia: bibliography("referencias.yaml", style: "apa", title: "Bibliografía"), -> bibliografia: ("apa", "Bibliografía"),
- Mejorar la plantilla, añadir los diferentes estilos que puede tener la bibliografía, poner directamente lista-figuras: true, lista-tablas: true, bien puesto como ejemplo comentado, algo tal que así:


#import "@preview/visillos-excelencia:0.2.0": *

// Aquí configuras los datos de tu proyecto
#show: proyecto.with(
  titulo: "Las reliquias de la muerte",
  autor: "Harry Potter",
  supervisor: "Albus Dumbledore",
  instituto: "IES Carmen Martín Gaite",
  lugar: "Navalcarnero",
  fecha: "Mayo 2026", // Cambia la fecha a la de entrega
  logo: image("Logo.svg", width: 30%),
  fuente: "Libertinus Serif", // Puedes cambiar a "Times New Roman" si la tienes instalada
  // tamano-fuente: 12pt,     // Descomenta para ajustar el tamaño del texto
  // interlineado: 1em,       // Descomenta para ajustar el interlineado
  // color-acento: rgb("#279985"), // Descomenta para cambiar el color de los títulos
  doble-cara: false, // Pon true si vas a imprimir a doble cara (capítulos en página impar)

  // Páginas iniciales: la plantilla les pone título, página propia y entrada en el índice.
  // Cualquier pieza opcional se quita poniendo false (o none), o borrando su línea.
  abstract: include "Archivos/00_1_Abstract.typ",
  resumen: include "Archivos/00_2_Resumen.typ",
  agradecimientos: include "Archivos/00_3_Agradecimientos.typ",

  // Bibliografía y listas finales (van al final del documento, en este orden).
  // Las listas de figuras y tablas aparecen solas si el documento las tiene;
  // lista-figuras: true,
  // lista-tablas: true,
  // Los estilos que se pueden usar con "apa",...
  bibliografia: bibliography("referencias.yaml", style: "apa", title: "Bibliografía"),
)

// ==========================================
// INCLUYE AQUÍ LOS ARCHIVOS DE TU PROYECTO
// ==========================================

// Capítulos principales
#include "Archivos/01_Introducción.typ"
#include "Archivos/02_Capítulo 1.typ"
#include "Archivos/02_Capítulo 2.typ"
#include "Archivos/02_Capítulo 3.typ"
#include "Archivos/02_Capítulo 4.typ"
// #include "Archivos/02_Capítulo 5.typ" // Quita las barras (//) para añadir más capítulos

// Páginas finales
#include "Archivos/03_Conclusión.typ"
#include "Archivos/04_Anexos.typ"
#include "Archivos/05_Glosario.typ"

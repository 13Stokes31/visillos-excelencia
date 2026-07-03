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
  doble-cara: false, // Pon true si vas a imprimir a doble cara (capítulos en página impar)

  // Páginas iniciales: la plantilla les pone título, página propia y entrada en el índice
  abstract: include "Archivos/00_1_Abstract.typ",
  resumen: include "Archivos/00_2_Resumen.typ",
  agradecimientos: include "Archivos/00_3_Agradecimientos.typ",
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

// Bibliografía (asegúrate de que el archivo referencias.yaml esté en la misma carpeta)
#bibliography("referencias.yaml", style: "apa", title: "Bibliografía")

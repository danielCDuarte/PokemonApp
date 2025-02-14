# PokemonApp

Prueba Técnica - App Pokémon

# Descripción
Esta aplicación iOS es una demostración técnica que muestra información de Pokémon utilizando la API de Pokémon.
El proyecto implementa principios de Clean Architecture con el patrón VIPER, enfatizando la calidad del código, la capacidad de prueba y la mantenibilidad.

# Especificaciones Técnicas

- Plataforma: iOS 15.6+
- Lenguaje: Swift 5
- Framework UI: UIKit
- Arquitectura: Clean Architecture + VIPER
- Inyección de Dependencias: Contenedor DI personalizado

# Arquitectura

Clean Architecture con el patron arquitectonico VIPER

- Capa de Datos: Maneja operaciones de datos y servicios externos
- Capa de Dominio: Contiene la lógica de negocio y entidades
- Capa de Presentación: Implementa módulos VIPER y componentes UI

# Implementación VIPER

- Vista: Maneja elementos UI e interacciones del usuario
- Use case: Contiene lógica de negocio
- Presentador: Gestiona la lógica de la Vista y el formato de datos
- Entidad: Representa modelos de datos
- Coordinator: Maneja la navegación entre módulos

# Características

- Listado de Pokémon con paginación
- Información detallada de cada Pokémon
- Función de búsqueda de Pokémon

# Dependencias

- swift-snapshot-testing (snapshot test UI)
- Kingfisher (Carga de imágenes)

# Estrategia de Pruebas

- Pruebas Unitarias (XCTest)
- Cobertura completa para todos los modulos 
- snapshot test componentes visuales
  
# Pruebas de Snapshot

- Pruebas visuales de componentes UI

# Cobertura de Código
  
  Cobertura general: 90%
  ![Screenshot 2025-02-13 at 5 43 28 PM](https://github.com/user-attachments/assets/82ab463c-07d3-4c06-9223-671ee6321537)

# Instrucciones de Instalación

1. Clonar el repositorio
2. Abrir el proyecto PokemonApp.xcodeproj
3. Compilar y ejecutar

# Ejecución de Pruebas

1. Abrir el proyecto PokemonApp.xcodeproj
2. Seleccionar el esquema de pruebas PokemonAppTests
3. Presionar Cmd + U para ejecutar las pruebas
4. Ver el informe de cobertura en Xcode

# Prácticas de Desarrollo

- Implementación de principios SOLID
- Inyección de Dependencias para mejor capacidad de prueba
- Programación orientada a protocolos
- Arquitectura modular (Viper + Clean Arquitecture)
- Inyeccion de dependencias
- POO
- Patron Coordinator

# PrintScreen App

![Simulator Screenshot - iPhone 16 Pro - 2025-02-14 at 08 44 30](https://github.com/user-attachments/assets/abe2cf71-2772-4488-b8f6-ec346c4b0fed)
![Simulator Screenshot - iPhone 16 Pro - 2025-02-14 at 08 44 39](https://github.com/user-attachments/assets/a70c64b2-67f4-4735-860f-7bf14b2e4f6b)
![Simulator Screenshot - iPhone 16 Pro - 2025-02-14 at 08 44 41](https://github.com/user-attachments/assets/0bf34774-4225-488d-90b3-f0dbf458117d)


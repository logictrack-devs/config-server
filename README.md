# config-server
# Servidor de Configuración Centralizada (config-server)

Microservicio independiente de la infraestructura de LogiTrack encargado de centralizar, administrar y proveer las configuraciones externas de todos los componentes del ecosistema de manera dinámica y desacoplada.

## Funcionalidades Mínimas Implementadas
*   **Servidor de Configuración Activo:** Habilitado en la clase de arranque mediante la anotación `@EnableConfigServer`.
*   **Repositorio Git de Propiedades:** Conexión directa a un repositorio Git dedicado donde se almacenan y versionan los archivos de propiedades de la arquitectura.
*   **Estrategia de Multi-Ambiente:** Soporte nativo para perfiles diferenciados por entorno de despliegue, administrando archivos específicos para desarrollo (`dev`) y producción (`prod`).
*   **Consumo Nativo con Spring Cloud:** Preparado para que los microservicios clientes importen sus respectivas propiedades de forma nativa en el arranque utilizando la directiva `spring.config.import`.
*   **Inyección Segura de Secretos:** Arquitectura diseñada para omitir credenciales sensibles en el repositorio Git, delegando la carga de contraseñas y claves a variables de entorno del sistema.

## Propiedades Externalizadas por Microservicio
El servidor centraliza y distribuye los siguientes parámetros críticos para `shipment-service`, `courier-service` y `security-service`:
*   **Infraestructura de Red:** Puertos de ejecución (`server.port`) y nombres lógicos de aplicación (`spring.application.name`).
*   **Persistencia:** Cadenas de conexión, controladores y credenciales para la base de datos MySQL.
*   **Enrutamiento e Interoperabilidad:** URLs y rutas lógicas de comunicación para las llamadas Feign/HTTP entre servicios.
*   **Diagnóstico:** Niveles y patrones de registro de logs (`logging.level`).
*   **Seguridad General:** Parámetros no sensibles y configuraciones generales de Spring Security.

## Configuración Principal (`application.yml`)
```yaml
server:
  port: 8888

spring:
  application:
    name: config-server
  cloud:
    config:
      server:
        git:
          uri: https://github.com
          search-paths: '{application}'
          default-label: main

eureka:
  client:
    service-url:
      defaultZone: http://localhost:8761/eureka/
```

## Ejemplo de Integración en Clientes (`application.yml` de los servicios)
Cada microservicio cliente recupera sus datos del servidor mediante la siguiente estructura base:
```yaml
spring:
  application:
    name: courier-service
  profiles:
    active: dev
  config:
    import: "optional:configserver:http://localhost:8888"
```

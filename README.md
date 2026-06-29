# Evaluación Parcial 3 - Orquestación DevOps

Este repositorio contiene la entrega de la Evaluación Parcial 3, implementando una arquitectura de microservicios orquestada localmente utilizando K3s, simulando un entorno de AWS.

## Arquitectura del Proyecto

El sistema está compuesto por los siguientes elementos:

*   **Frontend:** Contenedor basado en Nginx que expone la interfaz de usuario ("Tienda de Alimentos para Perritos") y actúa como proxy inverso para enrutar las peticiones `/api` hacia el backend utilizando el DNS interno de Kubernetes.
*   **Backend:** Contenedor basado en Python que sirve los datos de la tienda.
*   **Registry Local:** Se utiliza `localhost:5000` para almacenar las imágenes de los contenedores, actuando como equivalente a AWS ECR.
*   **Networking y Orquestación:** Se utilizan objetos `Deployment` y `Service` de tipo `LoadBalancer` (gestionados localmente por MetalLB, equivalente a AWS ALB).
*   **Autoescalado (HPA):** El backend cuenta con un Horizontal Pod Autoscaler configurado con un umbral objetivo del 60% de uso de CPU, permitiendo escalar desde 1 hasta 5 réplicas de forma dinámica.

## Requisitos previos

*   Acceso al servidor K3s local.
*   Herramientas instaladas: `podman` (para el empaquetado de imágenes) y `kubectl` (para la orquestación).

## Instrucciones de Despliegue Automatizado (CI/CD)

Todo el proceso de integración y despliegue continuo ha sido automatizado mediante un script Bash (`pipeline-local.sh`), el cual simula el comportamiento de un entorno como GitHub Actions.

Para desplegar el proyecto completo, ejecuta los siguientes comandos en la terminal:

1. Otorga permisos de ejecución al script:
   ```bash
   chmod +x pipeline-local.sh

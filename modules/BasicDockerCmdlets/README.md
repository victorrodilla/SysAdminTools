## BasicDockerCmdlets

## Comenzando 🚀

_En este modulo desarollamos nuestro primeros módulos con PowerShell, en este caso para operaciones básicas de Docker._
### Pre-requisitos 📋

_Necesitamos tener instalados:_

PowerShel, al menos 3.0
Windows Subsystem for Linux 2
Docker Desktop 3.0

### Instrucciones

_Para poder utilizar los comandos, necesitamos descargarnos el módulo en cualquier carpeta._ local.

_Una vez descargado importamos el módulo:_

_Si queremos comprobar que nos lo ha importao correctamente:_

```pwsh
Get-Command -Name *docker*
```

_Todos los comandos tienen que ser alimentados el parámetro -Name con el **Nombre del contenedor**_

```Start-Docker -Name dockername```

_Comandos disponibles:_

```
Get-DockerExist
Get-DockerStatus
Start-Docker
Stop-Docker
Restart-Docker
```

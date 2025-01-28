# Historial de Enfermedades Familiares

- [ ] Create s Inicio de Sesion, Listado, Registro (just design and jump into pages by buttons)

## Inicio de Sesion 
 - [ ] Esta vista solicitará las credenciales para ingresar a la aplicación
  1. [ ] **Email** (Required | maxLength: 100): Este campo solo premitirá ingresar valores tipo email, cualquier otro valor que no cumpla con lo dicho patrón/expresión deberá de mostrar el error: 'Ingrese un email válido'.
  2. [ ] **Contraseña** (Required | maxLength: 100): Este campo permitirá ingresar caracteres de cualquier tipo, el valor ingresado no deberá ser legible.
  3. El botón iniciar sesión solo estará activo si ambos valores son correctos evitando continuar
  4. Una vez ingresado las credenciales correctas, al momento de iniciar sesión la aplicación mostrará la vista de **Listado**  

## Listado 

- [ ] Esta vista mostrará todos los registros capturados hasta el momento, mostrando una breve descripción **(50 caracteres max.)** del malestar 
- [ ] Ordenados de forma descendente por fecha de registro.
- [ ] Al ingresar un valor en el campo de búsqueda solo mostrará aquellos que contengan en los campos **paciente, doctor, malestar una coincidencia con el valor ingresado.**
- [ ] Si el valor del campo buscar es **limpiado deberá mostrar nuevamente la lista ordenada por fecha de registro**.
- [ ] Al presionar el **botón flotante** deberá mostrar la vista Registro.

## Registro

Esta vista solicitará la información de la receta: 

1. [ ] **Fecha** (Required | Date): Este campo al ser presionado despliega un **modal flotante DatePicker** para ingresar la fecha.
2. [ ] **Paciente** (Required | String | maxLength: 150): Este campo permitirá solo valores de tipo texto **excluyendo caracteres como simbolos** (permitir caracteres con acento y uso de Ñ). Cualquier otro valor que no cumpla con dicho patrón, **deberá de mostrar el error: 'Ingrese un valor válido'**.
3. [ ] **Doctor** (Required | String | maxLength: 150): Este campo permitirá solo valores de tipo texto **excluyendo caracteres como simbolos** (permitir caracteres con acento y uso de Ñ). Cualquier otro valor que no cumpla con dicho patrón, **deberá de mostrar el error: 'Ingrese un valor válido'**.
4. [ ] **Teléfono** (Required | String | maxLength: 10): Este campo permitira solo valores de tipo numérico. Cualquier otro valor que no cumpla con dicho patrón deberá de **mostrar el error: 'Ingrese valor válido'**.
5. [ ] **Malestar** (Required | String | maxLength: 1024): Este campo permitirá cualquier tipo de valor.
6. [ ] **Imagen** (Required | String): Este campo almacenara la referencia a la imagen capturada por el dispositivo.
7. [ ] El botón guardar estará **activo** si los **valores son correctos** evitando continuar.

## Notas

- [ ] La informacion debe ser persistente en el dispositivo (usar package Hive)
- [ ] Las credenciales para el inicio de sesión serán locales (sin servicios web) y deberán ser:
  - **Email:** *jhon@mail.com*
  - **Contraseña:** *77@1$*
- [x] El proyecto deberá ser administrado por el control de versiones de Git y deberá estar almacenado en alguna de las plataformas como GitLab ó GitHub
- [ ] Adicionar al proyecto un archivo README con el software requerido e instrucciones para ejecutar la app.
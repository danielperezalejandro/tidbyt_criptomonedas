# tidbyt_criptomonedas
#Introducción
Esta aplicación permite a los usuarios consultar el precio actual de varias criptomonedas (Bitcoin, Ethereum, BNB) y calcular el porcentaje de beneficio o pérdida basado en el precio de compra. La aplicación también muestra la última hora de actualización de los precios.
La aplicación obtiene datos de precios de criptomonedas desde la API de CoinGecko.

#Estructura
Tiene las siguientes funciones principalmente:
main(config): Función principal que procesa la entrada del usuario y renderiza la interfaz de usuario.
get_profit(price, buy): Calcula el porcentaje de beneficio o pérdida.
obtener_precio(crypto_name, moneda): Obtiene el precio actual de la criptomoneda.
obtener_fecha_actualizacion(crypto_name): Obtiene la fecha de la última actualización del precio.
obtener_ultimo_precio(crypto_name): Obtiene el precio de cierre del día anterior.
obtener_hora_actual(): Obtiene la hora actual.

#Instalación y uso
Para la instalación y uso de la aplicacion debes descargar este repositorio, una vez descargado, deberas acceder desde la consola al directorio donde esten los archivos y ejecutar el comando "pixlet serve nombre_del_archivo.star", con esto realizado la consola le devolverá la url en la que se esta ejectando la aplicación, si entra en ellá podrá usarla y verla funcionar.

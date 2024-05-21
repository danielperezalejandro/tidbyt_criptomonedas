## Introducción

Esta aplicación permite a los usuarios consultar el precio actual de varias criptomonedas (Bitcoin, Ethereum, BNB) y calcular el porcentaje de beneficio o pérdida basado en el precio de compra. La aplicación también muestra la última hora de actualización de los precios. La aplicación obtiene datos de precios de criptomonedas desde la API de CoinGecko.

## Estructura

Tiene las siguientes funciones principalmente:

- **main(config)**: Función principal que procesa la entrada del usuario y renderiza la interfaz de usuario.
- **get_profit(price, buy)**: Calcula el porcentaje de beneficio o pérdida.
- **obtener_precio(crypto_name, moneda)**: Obtiene el precio actual de la criptomoneda.
- **obtener_fecha_actualizacion(crypto_name)**: Obtiene la fecha de la última actualización del precio.
- **obtener_ultimo_precio(crypto_name)**: Obtiene el precio de cierre del día anterior.
- **obtener_hora_actual()**: Obtiene la hora actual.

#3 Instalación y Uso

Para la instalación y uso de la aplicación, debes descargar este repositorio. Una vez descargado, deberás acceder desde la consola al directorio donde estén los archivos y ejecutar el comando `pixlet serve nombre_del_archivo.star`. Con esto realizado, la consola te devolverá la URL en la que se está ejecutando la aplicación. Si ingresas en ella, podrás usarla y verla funcionar.

"""
Applet: Pixlet
Summary: Tidbyt app
Description: Tydbyt app.
Author: daniel
"""
load("render.star", "render")
load("http.star", "http")
load("encoding/base64.star", "base64")
load("animation.star", "animation")
load("math.star","math")
load("schema.star", "schema")
load("time.star", "time")



# Imagenes 
BTC_ICON = base64.decode("""
iVBORw0KGgoAAAANSUhEUgAAABEAAAARCAYAAAA7bUf6AAAAlklEQVQ4T2NkwAH+H2T/jy7FaP+
TEZtyDEG4Zi0TTPXXzoDF0A1DMQRsADbN6MZdO4NiENwQbAbERh1lWLzMmgFGo5iFZBDYEFwuwG
sISCPUIKyGgDRjAyBXYXMNIz5XgDQga8TpLboYgux8DO/AwoUuLiEqTLBFMcmxQ7V0gssgklIsL
AYozjsoBoE45OZi5DRBSnkCAMLhlPBiQGHlAAAAAElFTkSuQmCC
""")
ETH_ICON=base64.decode("iVBORw0KGgoAAAANSUhEUgAAABIAAAAQCAYAAAAbBi9cAAAAAXNSR0IArs4c6QAAAL9JREFUOE9jZCAChMVs/r9qiS8jPqV4JUEafXM//+d8f4Dhu6ADw+bJvDjV08cgkGtAroK5CMTG5Sq8LqKKQTBD0F2Ey1VYXYRsCDaDsBmGYRC6IbgMQjcMxSBshuAzCNkwggY9OrmMQV1NiuHmrWcMcuZRGGkSFotwg5BdA9KMDGAGIYshGwoyDGwQzBB0A2AasRkEk4MZiOEibIbhMghmCNxFMNNxuQyf1zDCCNn/6AYiG4TsCmQ9OLMIqSkbALiTfb2tH4bQAAAAAElFTkSuQmCC")
BNB_ICON=base64.decode("iVBORw0KGgoAAAANSUhEUgAAABMAAAATCAYAAAByUDbMAAAAAXNSR0IArs4c6QAAALhJREFUOE+1lMENgDAIRe3NkyM5komTmDiSI3nypqEJhOKH1qR6MoX/+kuhaQi++5huG07zmTwJDGjIul+i3ZZR/hG0gFknGsQUDaQ1DRWY54YEBLBg5PIFi0RejN1lGLvy6mMLjvIIWMBIRIm2Luj2bF6GoetHTlo2EJjnqHZ0rcswT1BrDavr70zXCB23de3/1vBGh1sHxaXPdONGgtrQw9lEwKhFinFi291eDX2jXd4zO0ZfX9oHosWpGjQ0xhAAAAAASUVORK5CYII=")
#Variables 
DEFAULT_PRICE=-1
DEFAULT_CRYPTO="bitcoin"
DEFAULT_MONEDA="EUR"


def main(config):
    COLOR="#00FF00"
    COLOR_INVESTEMENT="#00FF00"
    
    #se obtienen los datos que introduce el usuario
    investment = config.str("investment_price", DEFAULT_PRICE)
    crypto=config.str("cryptos", DEFAULT_CRYPTO)
    moneda=config.str("monedas", DEFAULT_MONEDA)
    porcentaje=0
    profit=-1
    simbolo="$"

    if moneda=="EUR":
        simbolo="€"
    elif moneda=="GBP":
        simbolo="£"
    

    ICON=BTC_ICON
    if crypto=="ethereum":
        ICON=ETH_ICON
    elif crypto=="binancecoin":
        ICON=BNB_ICON

    rate = obtener_precio(crypto,moneda)
    f=obtener_fecha_actualizacion(crypto)
    ultimo_precio=obtener_ultimo_precio(crypto)


    #Se muestra toda la información junto con el porcentage de beneficio/perdida
    if investment!="":
        profit = float(investment)
        porcentaje=float(get_profit(rate,profit))
        porcentaje_message = "{}%".format(int(porcentaje))
        if porcentaje<0:
            COLOR_INVESTEMENT="#FF0000"

    if ultimo_precio>=0:
        COLOR="#00FF00"
        
    else:
        COLOR="#FF0000"
        

    
    if profit>0:
        return render.Root(
            child = render.Box(
                render.Column(
                    expanded=True,
                    main_align="space_evenly",
                    cross_align="center",
                    children = [
                        render.Row(
                            expanded=True,
                            main_align="space_evenly",
                            cross_align="center",
                            children=[ 
                                render.Image(src=ICON),
                                render.Column(
                                    children=[
                                        render.Text("{} %d".format(simbolo) % rate, color=COLOR),
                                        render.Text(porcentaje_message, color=COLOR_INVESTEMENT), 
                                    ]
                                ),
                                
                            ]
                        ),
                        render.Marquee(
                            width=64,
                            child=render.Text(obtener_hora_actual()),
                            offset_start=5,
                            offset_end=5,
                        ),  
                    ],
                ),
            ),   
        )    
    else:
        #Se muestra la información sin porcentage de beneficio/perdida
         return render.Root(
            child = render.Box(
                render.Column(
                    expanded=True,
                    main_align="space_evenly",
                    cross_align="center",
                    children = [
                        render.Row(
                            expanded=True,
                            main_align="space_evenly",
                            cross_align="center",
                            children=[ 
                                render.Image(src=ICON),
                                render.Column(
                                    children=[
                                        render.Text("{} %d".format(simbolo) % rate, color=COLOR),
                                        
                                    ]
                                ),
                                
                            ]
                        ),
                        render.Marquee(
                            width=64,
                            child=render.Text(obtener_hora_actual()),
                            offset_start=5,
                            offset_end=5,
                        ),  
                    ],
                ),
            ),   
        )


def get_schema():
    crypto_options = [
        schema.Option(display="Bitcoin", value="bitcoin"),
        schema.Option(display="Ethereum", value="ethereum"),
        schema.Option(display="BNB", value="binancecoin")
    ]

    moneda_options = [
        schema.Option(display="EUR", value="EUR"),
        schema.Option(display="USD", value="USD"),
        schema.Option(display="GBP", value="GBP")
    ]
    return schema.Schema(
        version = "1",
        fields = [
            schema.Text(
                id = "investment_price",
                name = "Inversión",
                desc = "Seleccione su precio de compra",
                icon = "wallet",
            ),
            schema.Dropdown(
                id="cryptos",
                name="Criptomoneda",
                desc="Seleccione la criptomoneda",
                options=crypto_options,
                default="bitcoin",
                icon = "dollar",
            ),
            schema.Dropdown(
                id="monedas",
                name="Moneda",
                desc="Seleccione la moneda",
                options=moneda_options,
                default="EUR",
                icon = "euro",
            )
            
        ],
        
       
        
    )
# Se obtiene el porcentaje de benficio/perdida
def get_profit(price, buy):
    porcentaje_beneficio = ((price - buy) / buy) * 100
    return porcentaje_beneficio

#Se obtiene el precio de la criptomoneda
def obtener_precio(crypto_name,moneda):
    url = "https://api.coingecko.com/api/v3/coins/markets?vs_currency={}".format(moneda)
    response = http.get(url)
    
    if response.status_code == 200:
        data = response.json()
        for cripto in data:
            if cripto.get("id") == crypto_name:
                precio_cripto = cripto.get("current_price")
                
                return precio_cripto
       
        return None
    else:
        print("Error al obtener los datos de la API")
        return None

# Se obtiene la fecha de la ultima actualizacion del precio
def obtener_fecha_actualizacion(crypto_name):
    url = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=EUR"
    response = http.get(url)
    
    if response.status_code == 200:
        data = response.json()
        for cripto in data:
            if cripto.get("id") == crypto_name:
                actualizacion = cripto.get("last_updated")
                actualizacion=actualizacion.replace("T", " ")
                return actualizacion
    
        return None
    else:
        print("Error al obtener los datos de la API")
        return None

# Se obtiene el precio de cierre del dia anterior
def obtener_ultimo_precio(crypto_name):
    url = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=EUR"
    response = http.get(url)
    
    if response.status_code == 200:
        data = response.json()
        for cripto in data:
            if cripto.get("id") == crypto_name:
                actualizacion = cripto.get("price_change_24h")
                return actualizacion
        # Si no se encuentra el Bitcoin en la lista
        print("Cripto no encontrada en la respuesta de la API")
        return None
    else:
        print("Error al obtener los datos de la API")
        return None

# Se obtiene la hora actual
def obtener_hora_actual():
    hora_actual = str(time.now())
    partes = hora_actual.split()

    # Obtener la parte de la fecha y dividirla en año, mes y día
    fecha_parte = partes[0]
    hora=partes[1]
    year, month, day = fecha_parte.split("-")

    # Formar la fecha en el nuevo formato dd-mm-aaaa
    nueva_fecha = "{}-{}-{}".format(day,month,year)
    mensaje="{}  {}".format(nueva_fecha,hora)

    return mensaje



   
    

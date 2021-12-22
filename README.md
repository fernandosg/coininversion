# Coininversion

Este es un pequeño ejercicio para manejar la API de Coinbase y mostrar
las ganancias de inversión tomando como referencia un 5% de interés
para la moneda bitcoin y un 3% de ETH

## Instalación
Ejecuta las gemas del proyecto en un gemset

```bash
bundle install
```
Ejecuta las dependencias agregadas con Yarn
```bash
yarn install
```

## Uso

Para poder hacer uso de la aplicación se necesita agregar el API key de Coinmarketcap, tanto para el ambiente de desarrollo como el de pruebas.

En el archivo development.rb y el archivo test.rb agrega la variable de entornoCOINMARKET_KEY

```ruby
ENV['COINMARKET_KEY'] = 'APIKEY'
```
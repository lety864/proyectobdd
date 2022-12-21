import express from 'express'
const app = express()
import config from './config.js'


/*Configuraciones*/

//Puerto
app.set('port',config.port);

//Rutas
import rutas from './rutas/Rutas.js'

app.use(rutas)

export default app
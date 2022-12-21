//Guardando variables de entorno

import {config} from 'dotenv' // traemos el objeto 
config(); // lee las variables de entorno


export default {
    port: process.env.PORT //|| 3000
}
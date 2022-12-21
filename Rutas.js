import {Router} from 'express';
const router = Router()

import * as CONSULTAS from '../controllers/Controllers.js'

//Definicion de Rutas 

router.get('/consultaA', CONSULTAS.getconsultaA)

router.get('/consultaB', CONSULTAS.getconsultaB)

router.get('/consultaC', CONSULTAS.getconsultaC)

router.get('/consultaD', CONSULTAS.getconsultaD)

router.get('/consultaE', CONSULTAS.getconsultaE)

router.get('/consultaF', CONSULTAS.getconsultaF)

router.get('/consultaG', CONSULTAS.getconsultaG)

router.get('/consultaH', CONSULTAS.getconsultaH)

router.get('/consultaI', CONSULTAS.getconsultaI)

router.get('/consultaJ', CONSULTAS.getconsultaJ)

export default router
//import { pool } from 'mssql';
import pkg from 'mssql';
const { pool } = pkg;
import {getConnection,sql} from '../Database/conect.js'

//Hacer consultas en la base de datos
export const getconsultaA = async (req, res) => {
    try {
        const pool = await getConnection(); // llamo a la conexion que retorna un pool (cliente para conectarnos)
        let cat = 3
        const result = await pool.request().query('execute Consulta_A @cat = ' + cat) //con el pool hacemos las peticiones que es una consulta a la base que tomara tiempo
        console.table(result.recordset) // muestra el resultado de la consulta 
        res.json(result.recordset)
    } catch (error) {
        res.status(500)
        res.send(error.message)
    }

};

export const getconsultaB = async (req, res) => {
    try {
        const pool = await getConnection(); 
        let territorio = 4
        const result = await pool.request().query('execute Consulta_B @territorio = ' + territorio) 
        console.table(result.recordset) 
        res.json(result.recordset)
    } catch (error) {
        res.status(500)
        res.send(error.message)
    }

};


export const getconsultaC = async (req, res) => {
    try {
        const pool = await getConnection(); 
        let loc = 1
        let cat = 2
        const result = await pool.request().query('execute Consulta_C @loc = '+ loc + ', @cat = ' + cat) 
        console.table(result.recordset) 
        res.json(result.recordset)
    } catch (error) {
        res.status(500)
        res.send(error.message)
    }

};

export const getconsultaD = async (req, res) => {
    try {
        const pool = await getConnection(); 
        let IDterritorio = 4
        const result = await pool.request().query('exec Consulta_D @IDterritorio= ' + IDterritorio) 
        console.table(result.recordset) 
        res.json(result.recordset)
    } catch (error) {
        res.status(500)
        res.send(error.message)
    }

};

export const getconsultaE = async (req, res) => {
    try {
        const pool = await getConnection(); 
        let IDproduct = 776
        let IDorder = 43659
        let cantidad = 1
        const result = await pool.request().query('exec Consulta_E	@IDproduct =' + IDproduct + ', @IDorder=' + IDorder + ', @cantidad =' + cantidad) 
        console.table(result.recordset) 
        res.json(result.recordset)
    } catch (error) {
        res.status(500)
        res.send(error.message)
    }

};

export const getconsultaF = async (req, res) => {
    try {
        const pool = await getConnection(); 
        let IDorder = 43659
        let Menvio = 5
        const result = await pool.request().query('exec Consulta_F	 @IDorder=' + IDorder + ', @Menvio =' + Menvio) 
        console.table(result.recordset) 
        res.json(result.recordset)
    } catch (error) {
        res.status(500)
        res.send(error.message)
    }

};

export const getconsultaG = async (req, res) => {
    try {
        const pool = await getConnection(); 
        let nom = "Rebecca"
        let ape = "Robinson"
        var correonuevo = "rebecca@gmailcom"
        const result = await pool.request().query('exec Consulta_G '+ nom +','+ ape +',' + correonuevo ) 
        console.table(result.recordset) 
        res.json(result.recordset)
    } catch (error) {
        res.status(500)
        res.send(error.message)
    }

};

export const getconsultaH = async (req, res) => {
    try {
        const pool = await getConnection(); 
        const result = await pool.request().query('exec Consulta_H') 
        console.table(result.recordset) 
        res.json(result.recordset)
    } catch (error) {
        res.status(500)
        res.send(error.message)
    }

};

export const getconsultaI = async (req, res) => {
    try {
        const pool = await getConnection(); 
        var minicio = 8
        var mfin = 12

        const result = await pool.request().query('exec Consulta_I @mesinicio='+minicio+', @mesfin =' + mfin) 
        console.table(result.recordset) 
        res.json(result.recordset)
    } catch (error) {
        res.status(500)
        res.send(error.message)
    }

};

export const getconsultaJ = async (req, res) => {
    try {
        const pool = await getConnection(); 
        let minicio = 6
        let mfin = 11
        const result = await pool.request().query('exec Consulta_J @mesinicio='+minicio+', @mesfin='+mfin) 
        console.table(result.recordset) 
        res.json(result.recordset)
    } catch (error) {
        res.status(500)
        res.send(error.message)
    }

};








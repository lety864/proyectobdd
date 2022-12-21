//conexion a base de datos
import {Router} from 'express';
const router = Router()

import sql from 'mssql'

//Definicion de las variables de conexion
const config1 = {
    user: 'sa', 
    password: '123',
    port: '1433',
    server: 'localhost\\SALESAW',
    database: 'SalesAW',
    pool: {
        max: 10,
        min: 0,
        idleTimeoutMillis: 30000
    },
    options:{
        encrypt: true,
        trustServerCertificate: true
    }
};


const config2 = {
    user: 'sa', 
    password: '456',
    port: '1433',
    server: 'localhost\\PRODUCTIONAW',
    database: 'ProductionAW',
    pool: {
        max: 10,
        min: 0,
        idleTimeoutMillis: 30000
    },
    options:{
        encrypt: true,
        trustServerCertificate: true
    }
};


const config3 = {
    user: 'sa', 
    password: '789',
    port: '1433',
    server: 'localhost\\OTROS2AW',
    database: 'OtrosAW',
    pool: {
        max: 10,
        min: 0,
        idleTimeoutMillis: 30000
    },
    options:{
        encrypt: true,
        trustServerCertificate: true
    }
};

export async function getConnection(){

    try {
        /*Para conectar por instancia se puede comentar las demas varibles de conexion, si no, puede retonrar todas las variables para la conexion*/ 
       
        /* const pool1 = new sql.ConnectionPool(config1);
        const pool1_1= await pool1.connect();
        console.log('instancia1 result:');*/

        const pool2 = new sql.ConnectionPool(config2);
        const pool2_2= await pool2.connect();
        console.log('instancia2 result:');

        /*const pool3 = new sql.ConnectionPool(config3);
        await pool3.connect();
        console.log('instancia3 result:');*/
        
        return pool2;
        /*return pool1;return pool3;*/ 

    } catch (error) {
        return {error: err};
    }

};

export {sql}
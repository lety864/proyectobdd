//archivo donde entrara servidor

import app from './app.js' 
//import './Database/conect.js' // para probar el funcionamiento de la conexion de la base

//Puerto
app.listen(app.get('port'), ()=>{
    console.log(`Servidor escuchando en puerto ${app.get('port')}`);
});



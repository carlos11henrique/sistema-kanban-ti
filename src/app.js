const express = require('express');
const setoresRoutes = require('./routes/setoresRoutes');
const usuariosRoutes = require('./routes/usuariosRoutes');
const blocosRoutes = require('./routes/blocosRoutes');
const salasRoutes = require('./routes/salasRoutes');
const maquinasRoutes = require('./routes/maquinasRoutes');
const problemasRoutes = require('./routes/problemasRoutes');
const chamadosRoutes = require('./routes/chamadosRoutes');
const chamadosMaquinasRoutes = require('./routes/chamados_maquinasRoutes');
const atribuídosRoutes = require('./routes/atribuidosRoutes');
const logsRoutes = require('./routes/logsRoutes');
const cors = require('cors');
const usuarioModel = require('./models/usuariosModel');
const usuariosController = require('./controllers/usuariosController');


const app = express();
app.use(express.json());
app.use(cors())
app.get('/', (req, res) => {
  res.send('Bem-vindo à API! Utilize as rotas disponíveis para acessar os recursos.');
});
app.post('/login', (req, res) => {

});
app.post('/register', usuariosController.create);
app.use('/setores', setoresRoutes);
app.use('/usuarios', usuariosRoutes);
app.use('/blocos', blocosRoutes);
app.use('/salas', salasRoutes);
app.use('/maquinas', maquinasRoutes);
app.use('/problemas', problemasRoutes);
app.use('/chamados', chamadosRoutes);
app.use('/chamados-maquinas', chamadosMaquinasRoutes);
app.use('/atribuidos', atribuídosRoutes);
app.use('/logs', logsRoutes);

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Servidor rodando na porta ${PORT}`);
});

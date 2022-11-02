import matching from "../models/Matching.js";
import repetidos from "../models/Repetidos.js";
import usuarios from "../models/Usuarios.js";
import RepetidoController from "./repetidosController.js";
import UsuarioController from "./usuariosController.js";


class MatchingController {
  static listarMatching = (req, res) => {
    matching
      .find()
      .exec((err, matches) => {
        res.status(200).json(matches);
      });
  };

  static listarMatchingPorId = (req, res) => {
    const id = req.params.id;
    matching
      .findById(id)
      .exec((err, match) => {
        if (err) {
          res
            .status(400)
            .send({ message: `${err.message} - Id do match não localizado` });
        } else {
          res.status(200).send(match);
        }
      });
  };

  static listarMatchingPorUsuarioBase = (usuarioBase, usuarioChecado, res) => {
    matching
      .findOne({usuarioBase: usuarioBase, usuarioChecado: usuarioChecado})
      .exec((err, match) => {
        if (err) {
          res
            .status(400)
            .send({ message: `${err.message} - Id do match não localizado` });
        } else if (match) {

        }
      })
  };

  static cadastrarMatching = (req, res) => {
    let match = new matching(req.body);
    match.save((err) => {
      if (err) {
        res
          .status(500)
          .send({ message: `${err.message} - falha ao cadastrar match` });
      }
    });
  };

  static excluirMatchingPorId = (id, res) => {
    console.log("excluirMatchingPorId = ", id)
    matching.findByIdAndDelete(id, (err) => {
      if (err) {
        res.status(500).send({ message: err.message });
      }
    });
  };

  static excluirMatchingPorUsuarios = (usuarioBase, usuarioChecado, res) => {
    matching.deleteOne( {usuarioBase: usuarioBase, usuarioChecado: usuarioChecado}, (err) => {
      if (err) {
        res.status(500).send({ message: err.message });
      }
    });
  };

  static proximoMatching = (req, res) => {

    const usuarioBase = req.body.usuarioBase;
    const usuarioChecado = req.body.usuarioChecado;
    const resposta = req.body.resposta;

    RepetidoController.insereRepetido(usuarioBase, usuarioBase, res);

    if (usuarioChecado) {
      console.log("id usuario checado\n")
      RepetidoController.insereRepetido(usuarioBase, usuarioChecado, res);   // insere usuarioChecado na blacklist
      
      if (resposta === false) {   
        console.log("if resposta false\n")                                           // se resposta for false insere usuarioBase na blacklist do usuarioChecado
        RepetidoController.insereRepetido(usuarioChecado, usuarioBase, res); 
        MatchingController.excluirMatchingPorUsuarios(usuarioChecado, usuarioBase, res); // checar se usuarioChecado deu like em usuarioBase e apagar
      } else {   
        console.log("else resposta true\n")                                                            // se resposta for true checa se usuariChecado também deu like no usuarioBase
        matching
        .findOne({ $and: [
          { usuarioBase: usuarioChecado, 
            usuarioChecado: usuarioBase }]})
        .exec((err, match) => {
          if (err) {     
            console.log("if erro findOne matching\n")                                                    // se der erro retorna 404
            res.status(400).send({ message: `${err.message} - Falha ao buscar usuario checado` });
          } else if (match) {    
            console.log("else if encontrou match\n")                                            // se achar o match , insere em cada usuario o seu respectivo match
            UsuarioController.insereMatches(usuarioBase, usuarioChecado, res);
            UsuarioController.insereMatches(usuarioChecado, usuarioBase, res);
            MatchingController.excluirMatchingPorId(match._id, res)               // exclui o controle de likes da tabela Matching

          } else {
            console.log("else nao encontrou match\n")
            MatchingController.cadastrarMatching(req, res);                  // inclui o controle de like na tabela Matching
          }
        });
      }
    }

    console.log("comecou o algoritimo de busca\n")
    repetidos
    .findOne({usuarioBase: usuarioBase })
    .exec((err, repetidosLista) => {
      if (err) {      
        console.log("if erro find repetidos 2\n")                                                   // se der erro retorna 404
        res.status(400).send({ message: `${err.message} - Falha ao buscar usuario checado` });
      } else if (repetidosLista) {
        console.log("repetidosLista = ", repetidosLista.usuarioChecado)
        // repetidosLista.usuarioChecado.push(usuarioBase);                                    // insere vc mesmo na blacklist
        console.log("repetidosLista = ", repetidosLista.usuarioChecado)
        matching                                                             // busca na tabela Matching se algum usuario deu like no usuario base. E o retorna
        .findOne({$and: [
          { usuarioBase: { $nin: repetidosLista.usuarioChecado }}, 
          { usuarioChecado: usuarioBase }]})
        .exec((err, match) => {
          if (err) {      
            console.log("if erro findOne matching 2\n")                                                   // se der erro retorna 404
            res.status(400).send({ message: `${err.message} - Falha ao buscar usuario checado` });
          } else if (match) {     
            console.log("else if encontrou match 2\n")                                          // se achar o match , retorna o usuario como resposta
            console.log("match 2 = \n", match) 
            req.params.id = match.usuarioBase                                              
            UsuarioController.listarUsuarioPorId(req, res)
          } else {
            console.log("else procura usuario por jogo ou comunidade\n") 
            usuarios                                                                           // procura dados do usuarioBase
            .findById(usuarioBase)
            .exec((err, usuario) => {
              if (err) {      
                console.log("if erro findById usuarioBase 3\n")                                                   // se der erro retorna 400
                res.status(400) .send({ message: `${err.message} - Falha ao buscar usuarioBase 3` });
              } else if(usuario){
                console.log("else if usuarioBase encontrado 3\n")
                usuarios                                                             // busca na tabela usuarios se algum usuario possui algum jogo ou comunidade em comum com usuarioBase. E o retorna
                .findOne(
                    {
                      $or: [
                        { $and: [{jogos: { $elemMatch: { $in: usuario.jogos }}},{_id: { $nin: repetidosLista.usuarioChecado }}]} , 
                        { $and: [{comunidades: { $elemMatch: { $in: usuario.comunidades }}}, {_id: { $nin: repetidosLista.usuarioChecado }}]}
                      ]
                    }, { senha:0 } )
                .populate({ path: "plataformas", select: "nome" })
                .populate({ path: "jogos", select: "nome" })
                .exec((err, usuariob) => {
                  if (err) {      
                    console.log("if erro findOne usuario 4\n")                                                   // se der erro retorna 400
                    res.status(400).send({ message: `${err.message} - Falha ao buscar usuario` });
                  } else if (usuariob) {
                    console.log("else if achou usuario para retornar 4\n") 
                    res.status(200).send(usuariob.toJSON());
                  } else {
                    console.log("else nao achou usuario 4\n")
                    res.status(400).send({ message: `Nao ha mais usuarios no perfil` });
                  }
                });
              } else {                                                                                       // se nao achar usuarioBase  retorna 400
                console.log("else usuario não encontrado 3\n")
                res.status(400).send({ message: `usuarioBase não encontrado 3` });
              }
            });
          }
        });
      }
    })

    // -- fazer o conteudo abaixo caso usuario nao encontrado na tabela Matching --

    // busca blackList do usuario base
    // busca usuario que não esteja na blacklist, com mesmo jogo do usuario base 
    // res.status(200).send(match.toJSON());
    // busca usuario que não esteja na blacklist, com mesma comunidade do usuario base 
    // res.status(200).send(match.toJSON());
    // caso nao ache nenhum usuario retorna mensagem de que nao ha mais usuarios no perfil com codigo 202
    // res.status(202).send({ message: "Nao ha mais usuarios no perfil" });
  };

}

export default MatchingController;

import jogos from "../models/Jogos.js";

class JogoController {

    static listarJogos = (req, res) => {
        jogos.find((err, jogos) => {
            res.status(200).json(jogos)
        })
    }

    static listarJogoPorId = (req, res) => {
        const id  = req.params.id
        jogos.findById(id, (err, jogo) => {
            if(err) {
                res.status(400).send({message: `${err.message} - Id do jogo não localizado`})
            } else {
                res.status(200).send(jogo);
            }
        })
    }

    static cadastrarJogo = (req, res) => {
        let jogo = new jogos(req.body);
        jogo.save((err) => {
            if(err) {
                res.status(500).send({message: `${err.message} - falha ao cadastrar jogo`})
            } else {
                res.status(201).send(jogo.toJSON())
            }
        })
    }

    static atualizarJogo = (req, res) => {
        const id  = req.params.id
        jogos.findByIdAndUpdate(id, {$set: req.body}, (err) => {
            if(!err) {
                res.status(200).send({message: 'jogo atualizado com sucesso'})
            } else {
                res.status(500).send({message: err.message})
            }
        })
    }

    static excluirJogo = (req, res) => {
        const id  = req.params.id
        jogos.findByIdAndDelete(id, (err) => {
            if(!err) {
                res.status(200).send({message: 'jogo removido com sucesso' })
            } else {
                res.status(500).send({message: err.message});
            }
        })
    }
}

export default JogoController;
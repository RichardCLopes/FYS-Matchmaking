import topicos from "../models/Topicos.js";

class TopicoController {

    static listarTopicos = (req, res) => {
        topicos.find((err, topicos) => {
            res.status(200).json(topicos)
        })
    }

    static listarTopicoPorId = (req, res) => {
        const id  = req.params.id
        topicos.findById(id, (err, topico) => {
            if(err) {
                res.status(400).send({message: `${err.message} - Id do topico não localizado`})
            } else {
                res.status(200).send(topico);
            }
        })
    }

    static cadastrarTopico = (req, res) => {
        let topico = new topicos(req.body);
        topico.save((err) => {
            if(err) {
                res.status(500).send({message: `${err.message} - falha ao cadastrar topico`})
            } else {
                res.status(201).send(topico.toJSON())
            }
        })
    }

    static atualizarTopico = (req, res) => {
        const id  = req.params.id
        topicos.findByIdAndUpdate(id, {$set: req.body}, (err) => {
            if(!err) {
                res.status(200).send({message: 'topico atualizado com sucesso'})
            } else {
                res.status(500).send({message: err.message})
            }
        })
    }

    static excluirTopico = (req, res) => {
        const id  = req.params.id
        topicos.findByIdAndDelete(id, (err) => {
            if(!err) {
                res.status(200).send({message: 'topico removido com sucesso' })
            } else {
                res.status(500).send({message: err.message});
            }
        })
    }
}

export default TopicoController;
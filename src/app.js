const express = require("express")
const morgan = require("morgan")
const fs = require("fs-extra")
const {dados} = require("./dados")
const { exec } = require('child_process')
const app = express()
port = dados.porta

app.use(morgan("dev"))
app.use(express.json())
app.listen(port, () => {
  console.log("Api rodando na porta "+port)
})

if(fs.existsSync("./token.txt")) {
  var rtoken =  fs.readFileSync("./token.txt").toString().replaceAll("\n", "").replaceAll("\r", "")
} else {
  var rtoken = require('crypto').randomBytes(50).toString('base64')
  fs.writeFileSync("./token.txt", rtoken)
}

app.get("/", (req, res) => {
  res.status(200)
  res.json({msg: "online"})
})
app.get("/favicon.ico", (req, res) => {
  res.status(200)
  res.sendFile(__dirname+"/favicon.ico")
})
app.post("/criarlogin", async (req, res) => {
  try {
  var {user} = req.body
  var {senha} = req.body
  var {token} = req.body
  var {dias} = req.body
  var {limite} = req.body
  
  if(!dias) dias = "31"
  if(!limite) limite = "1"
  if(!token) {
    res.status(400)
    res.json({msg: "Cade o token?"})
    return
  }
  if(token != rtoken) {
    res.status(403)
    res.json({msg: "token invalido", token})
    return
  }
  if(!user) {
    res.status(400)
    res.json({msg: "Cade o user?"})
    return
  }
  if(!senha) {
    res.status(400)
    res.json({msg: "Cade a senha?"})
    return
  }
  exec(`sh ./src/user.sh ${user} ${senha} ${dias} ${limite}`)
  res.status(200)
  res.json({msg: "sucesso", user, senha, dias, limite})
  } catch (e) {
    console.log(e)
    res.status(500)
    res.json({msg: "Ocorreu um erro ao processar a solicitacao"})
    return
  }
})
app.post("/criarteste", async (req, res) => {
  try {
  var {user} = req.body
  var {temp} = req.body
  var {token} = req.body
  //console.log(req.body)
  if(!token) {
    res.status(400)
    res.json({msg: "Cade o token?"})
    return
  }
  if(token != rtoken) {
    res.status(403)
    res.json({msg: "token invalido"})
    return
  }
  if(!user) {
    res.status(400)
    res.json({msg: "Cade o user?"})
    return
  }
  if(!temp) {
    res.status(400)
    res.json({msg: "Cade o tempo em min?"})
    return
  }
  exec(`sh ./src/teste.sh ${user} ${temp}`)
  res.status(200)
  res.json({msg: "sucesso", user, temp})
  } catch (e) {
    console.log(e)
    res.status(500)
    res.json({msg: "Ocorreu um erro ao processar a solicitacao"})
    return
  }
})
app.post("/renovar", async (req, res) => {
  try {
  var {user} = req.body
  var {dias} = req.body
  var {token} = req.body
  if(!token) {
    res.status(400)
    res.json({msg: "Cade o token?"})
    return
  }
  if(token != rtoken) {
    res.status(403)
    res.json({msg: "token invalido"})
    return
  }
  if(!user) {
    res.status(400)
    res.json({msg: "Cade o user?"})
    return
  }
  if(!dias) {
    res.status(400)
    res.json({msg: "Cade os dias?"})
    return
  }
  exec(`sh ./src/renovar.sh ${user} ${dias}`)
  res.status(200)
  res.json({msg: "sucesso", user, dias})
  } catch (e) {
    console.log(e)
    res.status(500)
    res.json({msg: "Ocorreu um erro ao processar a solicitacao "})
    return
  }
})
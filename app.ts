import express from 'express'
import http from 'http'
import cors from 'cors'

import { router } from 'router'

const port = 4000

const app = express()
const server = http.createServer(app)

app.use(cors())
app.use(express.json())
app.use('/', router)

server.listen(port, () => {
  console.log(`
    Server listening on port: ${port}
  `);
})

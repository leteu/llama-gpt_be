import axios, { AxiosResponse } from 'axios'
import { Router, Response } from 'express'
import { Readable } from 'readable-stream'

const router = Router()

router.get('/', async (req, res, next) => {
  const prompt = req.query.prompt

  if (!prompt) return res.sendStatus(500)

  try {
    const result = await axios.request<Readable>(
      {
        method: 'POST',
        url: 'http://127.0.0.1:11434/api/generate',
        data: {
          model: 'llama2',
          prompt,
        },
        responseType: 'stream',
      }
    )
    result.data.on('data', (chunk) => {
      res.write(chunk)

      const parseJson = JSON.parse(chunk.toString('utf8'))
      if (parseJson.done) {
        res.end()
        next()
        return
      }
    })
  } catch (e) {
    console.log(e)
  }



  // const txt = await readStreamChunk(result)

  // return res.status(200).send(txt)
})

export { router as llamaRouter }

function readStreamChunk(result: AxiosResponse<Readable, any>) {
  return new Promise((res) => {
    let txt = ''
    result.data.on('data', (chunk) => {
      const parseJson = JSON.parse(chunk.toString('utf8'))

      if (parseJson.done) {
        res(txt)
        return
      }

      txt += parseJson.response
    })
  })
}

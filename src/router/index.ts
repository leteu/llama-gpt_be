import { Router } from 'express'
import { llamaRouter } from './llamaRouter'

const router = Router()
router.use('/llama', llamaRouter)

export { router }

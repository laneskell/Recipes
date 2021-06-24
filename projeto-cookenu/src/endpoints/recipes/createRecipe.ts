import { recipesTableName } from './../../types';
import { getTokenData } from './../../services/authentication';
import { Request, Response } from "express";
import generateId from '../../services/idGenerator';
import connection from '../../connection';


export default async function createRecipe(
    req: Request,
    res: Response
    ): Promise<void> {
    try{
            const token = req.headers.authorization
            const {title, image, description} = req.body

            const tokenData = getTokenData(token!)

            if(!tokenData){
                res.statusCode = 401
                throw new Error("Unauthorized, token invalid")
            }

            if(!title || !description){
                res.statusCode = 422
                throw new Error(" 'title' and 'description' required") 
            }

            const id = generateId()

            await connection(recipesTableName)
                .insert({
                    id,
                    title,
                    image,
                    description,
                    author_id:tokenData!.id
                })

            res.send("Recipe sucessfuly created!")

    } catch (error){
        console.log(error.message);
        
        if(res.statusCode === 200){
            res.status(500).send("Internal server error")
        } else{
            res.send(error.message)
        }
    }
    
}
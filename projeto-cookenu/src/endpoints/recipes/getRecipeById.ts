import { getTokenData } from './../../services/authentication';
import { recipesTableName } from './../../types';
import { Request, Response } from "express";
import connection from "../../connection";


export default async function getRecipeById(
    req: Request,
    res: Response
    ): Promise<void> {
    try{
        const token = req.headers.authorization

        const tokenData = getTokenData(token!)

        if(!tokenData){
            res.statusCode = 401
            throw new Error("Unauthorized, token invalid")
        }


        const [recipe] = await connection(recipesTableName)
            .where({id: req.params.id})

        
        if(!recipe){
            res.statusCode = 404
            throw new Error("Recipe not found"); 
        }

        res.send({recipe})
        } catch (error){
        console.log(error.message);
        
        if(res.statusCode === 200){
            res.status(500).send("Internal server error")
        } else{
            res.send(error.message)
        }
    }
    
}
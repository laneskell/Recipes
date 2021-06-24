import { generateToken } from './../../services/authentication';
import { userTableName } from './../../types';
import { generateHash } from './../../services/hashManager';
import { Request, Response } from "express";
import generateId from "../../services/idGenerator";
import connection from '../../connection';

export default async function signup(
    req: Request,
    res: Response
    ): Promise<void> {
    try{
        const {name, email, password} = req.body
        
        if(!name || !email || !password){
            res.statusCode = 422
            throw new Error(" 'name' , 'email' and 'password' required") 
        }

        if(password.length < 6){
            res.statusCode = 422
            throw new Error(" 'password' must be at least 6 characters long") 
        }

        const [user] = await connection(userTableName)
            .where({email})
        if(user){
            res.statusCode = 409
            throw new Error("Email already in use");
        }

        const id: string = generateId()

        const cypherPassword: string = generateHash(password)

        const token: string = generateToken({id})
        
        await connection(userTableName)
            .insert({id, name, email, password: cypherPassword})

        res.send({token})
    } catch (error){
        console.log(error.message);
        
        if(res.statusCode === 200){
            res.status(500).send("Internal server error")
        } else{
            res.send(error.message)
        }
    }
    
}
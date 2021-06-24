import { Request, Response } from "express";
import connection from "../connection";
import { getTokenData } from "../services/authentication";

import { authenticationData } from "../types";

export default async function followUser(
  req: Request,
  res: Response
): Promise<void> {
  try {
    const { userToFollowId } = req.body;
  
    const token: string = req.headers.authorization!

    const tokenData = getTokenData(token)

    if (!userToFollowId) {
      res.statusCode = 422;
      throw new Error("Body must have 'userToFollowId'");
    }

    if (!tokenData) {
      res.statusCode = 401;
      throw new Error("Unauthorized");
    }

    const [user] = await connection("Cookenu_User").where({
      id: userToFollowId,
    });

    if (!user) {
      res.statusCode = 409;
      throw new Error("User not found");
    }

    if(tokenData.id === userToFollowId){
      res.statusCode = 409;
      throw new Error("You cannot follow yourself");
    }
    const users = {
      user_follower_id: tokenData.id,
      user_to_follow_id: userToFollowId,
    };

    const uniqueUsers = await connection("Cookenu_Followers")
      .select()
      .where("user_follower_id", "=", `${tokenData.id}`)
      .andWhere("user_to_follow_id", "=", `${userToFollowId}`);

    if (uniqueUsers.length !== 0) {
      throw new Error("You're already following this user");
    }

    await connection("Cookenu_Followers").insert(users);

    res.status(201).send("Followed successfully");
  } catch (error) {
    res.send({ message: error.message });
  }
}
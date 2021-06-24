import { Request, Response } from "express";
import connection from "../connection";
import { getTokenData } from "../services/authentication";

import { authenticationData } from "../types";

export default async function unfollowUser(
  req: Request,
  res: Response
): Promise<void> {
  try {
    const { userToUnfollowId } = req.body;
    const token: string = req.headers.authorization!

    const tokenData = getTokenData(token)
    if (!userToUnfollowId) {
      res.statusCode = 422;
      throw new Error("Body must have 'userToUnfollowId'");
    }

    if (!tokenData) {
      res.statusCode = 401;
      throw new Error("Unauthorized");
    }

    const [user] = await connection("Cookenu_User").where({
      id: userToUnfollowId,
    });

    if (!user) {
      res.statusCode = 409;
      throw new Error("User not found");
    }

    const result = await connection("Cookenu_Followers")
      .del()
      .where("user_follower_id", "=", `${tokenData.id}`)
      .andWhere("user_to_follow_id", "=", `${userToUnfollowId}`);

    if (!result) {
      res.statusCode = 409;
      throw new Error("You are not following this user");
    } else {
      res.status(200).send("Unfollowed successfully");
    }
  } catch (error) {
    res.send({ message: error.message });
  }
}

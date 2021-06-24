
import { Request, Response } from "express";
import connection from "../connection";
import { getTokenData } from "../services/authentication";

import { authenticationData } from "../types";

export default async function getFeed(
  req: Request,
  res: Response
): Promise<void> {
  try {
    const token: string = req.headers.authorization!

        const tokenData = getTokenData(token)
    if (!tokenData) {
      res.statusCode = 401;
      throw new Error("Unauthorized");
    }

    const recipes = await connection("Cookenu_Followers")
      .join(
        "Cookenu_Recipe",
        "Cookenu_Recipe.user_id",
        "Cookenu_Followers.user_to_follow_id"
      )
      .join("Cookenu_User", "Cookenu_Recipe.user_id", "Cookenu_User.id")
      .select(
        "Cookenu_Recipe.id",
        "Cookenu_Recipe.title",
        "Cookenu_Recipe.description",
        "Cookenu_Recipe.createdAt",
        { userId: "Cookenu_Recipe.user_id" },
        { userName: "Cookenu_User.name" }
      )
      .where({ "Cookenu_Recipe.user_id": tokenData.id });

    if (recipes.length === 0) {
      throw new Error("Your followers haven't posted any recipe yet.");
    }
    if (recipes.length !== 0) {
      recipes.forEach((recipe) => {
        recipe.createdAt = Date()
      });
    }
    res.send({ recipes });
  } catch (error) {
    res.send({ message: error.message });
  }
}
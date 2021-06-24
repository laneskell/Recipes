
export const userTableName = "sudu_recipes_users"
export const recipesTableName = "sudu_recipes_recipes"

export type authenticationData = {
    id: string
}

export type recipes = {
    id: string
    title: string
    image: string
    description: string
    createdAt: string
    authorId: string
}

export type user = {
    id: string
    name: string
    email: string
    password:string
    // recipes?: recipes[]
}

export type recipeFullInfo = {
    id: string;
    user_id: string;
    title: string;
    image:string;
    description: string;
    createdAt: string;
  };
import app from "./app"
import getProfile from "./endpoints/users/getProfile"
import login from "./endpoints/users/login"
import signup from "./endpoints/users/signup"
import getUserById from "./endpoints/users/getUserById"
import createRecipe from "./endpoints/recipes/createRecipe"
import getRecipeById from "./endpoints/recipes/getRecipeById"
import getAllRecipes from "./endpoints/recipes/getAllRecipes"
import getFeed from "./endpoints/getFeed"
import followUser from "./endpoints/followUser"
import unfollowUser from "./endpoints/unfollowUser"


app.post("/users/signup", signup)
app.post("/users/login", login)
app.get("/users/profile", getProfile)
app.get("/users/:id/profile", getUserById)

app.post("/recipe", createRecipe)
app.get("/recipe", getAllRecipes)
app.get("/recipe/:id", getRecipeById)

app.get("/user/feed", getFeed)

app.post("/user/follow", followUser)
app.post("/user/unfollow", unfollowUser)


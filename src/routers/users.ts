import express from "express";
const router = express.Router();
const UserController = require("../controller/user");

router.post("/signUp", UserController.handleSignup);
router.post("/signIn", UserController.handleSignin);

export default router;

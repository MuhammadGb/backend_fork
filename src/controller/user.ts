import bcrypt from "bcrypt";
import { NextFunction, Request, Response } from "express";
import jwt from "jsonwebtoken";
import { PrismaClient } from "@prisma/client";
import dotenv from "dotenv";
dotenv.config();
import { find, create } from "../services/user";
import { validatePasswordFormat } from "../utils/user";
const prisma = new PrismaClient();

const { JWT_TOKEN } = process.env;

export const handleSignup = async (
  req: Request,
  res: Response,
  next: NextFunction,
) => {
  try {
    const { fullName, email, password } = req.body;
    if (!fullName || !email || !password) {
      //console.log("First");
      throw new Error("Some parameters are missing...");
    }
    const user = await find({ email });

    if (user) {
      throw new Error("Email already exists!");
    }
    if (!validatePasswordFormat(password)) {
      throw new Error("Password does not meet specifications.");
    }

    const newUser = await create({ fullName, email, password });
    res
      .status(201)
      .json({ message: "User added successfully!", user: newUser });
  } catch (error) {
    next(error);
    // res.status(500).json({
    //   error: error,
    // });
  }
};
export const handleSignin = async (
  req: Request,
  res: Response,
  next: NextFunction,
) => {
  try {
    const { email, password } = req.body;
    if (!email || !password) {
      throw new Error("Some parameters are missing...");
    }
    const user = await find({ email });

    if (!user) {
      throw new Error("User not found!");
    }
    const validPassword =
      user?.password !== null &&
      (await bcrypt.compare(password, user?.password));
    if (!validPassword) {
      throw new Error("Incorrect password!");
    }
    if (JWT_TOKEN) {
      const token = jwt.sign({ userId: user.userId }, JWT_TOKEN, {
        expiresIn: 24 * 60 * 60,
      });
      res.status(201).json({
        userId: user.userId,
        name: user.fullName,
        token: token,
      });
    }
  } catch (error) {
    next(error);
  }
};

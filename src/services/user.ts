import express, { NextFunction, Request, Response } from "express";
import dotenv from "dotenv";
import * as path from "path";
import * as http from "http";
import cors from "cors";
import { PrismaClient } from "@prisma/client";
import { UserRes } from "../types/user";
import { generateUserId, userData } from "../utils/user";
import { UserData } from "../types/user";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import { Prisma, user } from "../../node_modules/.prisma/client";

const prisma = new PrismaClient();
const { JWT_TOKEN } = process.env;

export type UserDat = Omit<user, "createdAt,modifiedAt"> & { userId: string };

export const create = async ({
  email,
  fullName,
  password,
  phoneNumber,
}: UserRes) => {
  const userId = generateUserId(email);
  const hashPassword = await bcrypt.hash(password, 10);
  const phoneNo = phoneNumber?.toString();
  const newUser: UserData = {
    ...userData,
    email,
    fullName,
    password: hashPassword,
    userId,
    phoneNumber: phoneNo,
  };
  const createNewUser = await prisma.user.create({
    data: newUser,
  });
  console.log(JSON.stringify(createNewUser));

  if (JWT_TOKEN && createNewUser) {
    console.log(JWT_TOKEN);
    const token = jwt.sign({ id: newUser.userId }, JWT_TOKEN, {
      expiresIn: 24 * 60 * 60,
    });

    newUser.token = token;

    return {
      fullName: newUser.fullName,
      email: newUser.email,
      userId: newUser.userId,
      token: newUser.token,
    };
  }
};

export const find = async ({ email }: { email?: string }) => {
  if (email) {
    const user = await prisma.user.findUnique({ where: { email } });
    return user;
  }
};

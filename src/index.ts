import { PrismaClient } from "@prisma/client";
import express, { NextFunction, Request, Response } from "express";
import dotenv from "dotenv";
//const path = require("path");
//const http = require("http");
import swaggerUI from "swagger-ui-express";
import swaggerJsdoc from "swagger-jsdoc";
import { swaggerDocument } from "./docs/info";
//const cors = require("cors");

import { handleError } from "./utils/error";
import usersRouter from "./routers/users";
const specs = swaggerJsdoc(swaggerDocument);

const app = express();
dotenv.config();
const prisma = new PrismaClient();

//app.use(cors());
//ALTERNATIVE
app.use((req: Request, res: Response, next: NextFunction) => {
  res.setHeader("Access-Control-Allow-Origin", "*"); //TO BE CHANGED
  res.setHeader("Access-Control-Allow-Credentials", "true");
  res.setHeader(
    "Access-Control-Allow-Headers",
    "Origin, X-Requested-With, Content, Accept, Content-Type, Authorization",
  );
  res.setHeader(
    "Access-Control-Allow-Methods",
    "GET, POST, PUT, DELETE, PATCH, OPTIONS",
  );
  next();
});

/*app.use((req, res, next) => {
  const { method, path } = req;
  console.log(
  `New request to: ${method} ${path} at ${new Date().toISOString()}`
  );
  next();
});*/

app.get("/", (req: any, res: any, next: any) => {
  res.status(201).send("Server connected.");
});

app.use(express.json());
app.use(express.static("public"));
app.use(express.urlencoded({ extended: true }));

//Swagger
app.use(
  "/api-docs",
  swaggerUI.serve,
  swaggerUI.setup(specs, { explorer: true }),
);

app.use("/api/v1/auth", usersRouter);

app.use(handleError);

const port = process.env.PORT || 4000;

app.listen(port, () => {
  console.log(`Server is up on port ${port}.`);
});

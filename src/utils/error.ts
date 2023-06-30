import express, { NextFunction, Request, Response } from "express";

class CustomError extends Error {
  statusCode: number;
  constructor(statusCode: number, public readonly message: string | any) {
    super(message);
    this.statusCode = statusCode;
    //this.message = message;
  }
}

export const handleError = (
  err: Error | CustomError,
  req: Request,
  res: Response,
  next: NextFunction,
) => {
  // @ts-ignore
  let { statusCode, message } = err;

  if (!statusCode) statusCode = 500;

  console.error(statusCode, message);

  res.status(statusCode).json({
    status: "error",
    statusCode,
    message,
  });
};

// const errorHandler = ({ err, server, port }) => {
//   const error = err;

//   if (error.syscall !== "listen") {
//     throw error;
//   }
//   const address = server.address();
//   const bind =
//     typeof address === "string" ? "pipe " + address : "port: " + port;
//   switch (error.code) {
//     case "EACCES":
//       console.error(bind + " requires elevated privileges.");
//       process.exit(1);
//       break;
//     case "EADDRINUSE":
//       console.error(bind + " is already in use.");
//       process.exit(1);
//       break;
//     default:
//       throw error;
//   }
// };
// module.exports = {
//   CustomError,
//   //errorHandler,
// };

import { Prisma, user } from "../../node_modules/.prisma/client";

export type UserRes = {
  email: string;
  fullName: string;
  password: string;
  phoneNumber?: string;
};

//export type UserData = Omit<user, "id, createdAt, modifiedAt"> & { userId: string };
export type UserData = {
  id?: number;
  email: string;
  fullName: string;
  password: string;
  phoneNumber?: string | undefined;
  orderDetails?: {} | undefined;
  orderList?: {} | undefined;
  shoppingSession?: {} | undefined;
  userAddress?: {} | undefined;
  userPayment?: {} | undefined;
  userId: string;
  token?: string;
};

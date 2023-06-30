import { UserData } from "../types/user";

export const validatePasswordFormat = (password: string): boolean => {
  const passwordRegex =
    /^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[@#$%.,^*()<>]).{8,}$/;
  console.log(passwordRegex.test(password));
  return passwordRegex.test(password);
  /*
  At least one lowercase letter
  At least one uppercase letter
  At least one digit
  At least one special character
  Minimum length of 8 characters
*/
};
export const generateUserId = (email: string): string => {
  const truncatedEmail = email.slice(0, 12);
  const shuffledEmail = truncatedEmail
    .split("")
    .sort(() => 0.5 - Math.random())
    .join("");
  const randomNumber = Math.floor(1000 + Math.random() * 9000).toString();
  const addedId = shuffledEmail + randomNumber;
  const userId = addedId.slice(0, 21);

  return userId;
};

export const userData: UserData = {
  password: "",
  fullName: "",
  email: "",
  phoneNumber: "",
  orderDetails: {},
  orderList: {},
  shoppingSession: {},
  userAddress: {},
  userPayment: {},
  userId: "",
};

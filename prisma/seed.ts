import { PrismaClient } from "@prisma/client";
const prisma = new PrismaClient();

async function main() {
  try {
    const user = {
      password: "something",
      fullName: "Larina4a Akigbey",
      email: "something@larina4a.co",
      phoneNumber: "411084136214",
      orderDetails: {},
      orderList: {},
      shoppingSession: {},
      userAddress: {},
      userPayment: {},
      userId: "som41g@l3ta4aAkig",
    };
    const roles = [
      {
        name: "Admin",
        description: "Admin role",
      },
      {
        name: "Seller",
        description: "Seller role",
      },
    ];

    const userData = await prisma.user.create({
      data: user,
      //skipDuplicates: true,
    });

    const rolesData = await prisma.roles.createMany({
      data: roles,
      skipDuplicates: true,
    });

    console.log(userData);
    console.log(rolesData);

    // await prisma.tag.createMany({
    //   data: [{ name: "Apple" }],
    //   skipDuplicates: true,
    // });
  } catch (err) {
    console.log(err);
    //process.exit(1);
  } finally {
    await prisma.$disconnect();
    process.exit(1);
  }
}

main();

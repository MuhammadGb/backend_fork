export const swaggerDocument = {
  definition: {
    openapi: "3.1.0",
    info: {
      version: "1.0.0",
      title: "Bitsaac ecommerce",
      description: "An ecommerce for template",
      termsOfService: "",
      contact: {
        name: "Bitsaac",
        email: "bitsaac@gmail.com",
        url: "https://ecommercetemplates.com",
      },
      license: {
        name: "MIT",
        url: "https://opensource.org/licenses/MIT",
      },
    },
    servers: [
      {
        url: "http://localhost:4000/api/v1",
        description: "Local server",
      },
      {
        url: "https://app-dev.herokuapp.com/api/v1",
        description: "Dev Env",
      },
    ],
  },
  apis: ["./routes/*.ts"],
  schemes: ["https", "http"],
  consumes: ["application/json"],
  produces: ["application/json"],
  tags: [
    {
      name: "Auth",
      description: "Endpoint for authentication.",
    },
  ],
};

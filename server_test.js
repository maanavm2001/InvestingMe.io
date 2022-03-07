const express = require("express");
const app = express();
const cors = require("cors");
const mongoose = require("mongoose");
const morgan = require("morgan");

const usersEndpoint = require("./routes/userRouter");
const daysEndpoint = require("./routes/dayRouter");

require("dotenv").config();

const PORT = process.env.PORT;
const url = process.env.MONGODB_URI;

const errorHandler = (error, request, response, next) => {
  console.error(`error.message contents: ${error.message}`);
  if (error.name === "CastError") {
    return response.status(400).send({ error: "malformatted id" });
  } else if (error.name === "ValidationError") {
    return response.status(400).json({ error: error.message });
  }
  next(error);
};

const unknownEndpoint = (request, response) => {
  response.status(404).send({ error: "unknown endpoint" });
};

app.use(express.static("build"));
app.use(express.json());
app.use(cors());

console.log("connecting to db");

mongoose.connect(url, { useNewUrlParser: true })
const db = mongoose.connection;
db.on("error", console.error.bind(console, "connection error: "));
db.once("open", function() {
    console.log("Connected successfully");
});

morgan.token("body", (request) => {
    if (request.method !== "POST") return " ";
    return JSON.stringify(request.body);
});

app.use(
    morgan(":method :url :status :res[content-length] :response-time ms :body")
);

app.use("/api/user", usersEndpoint);
app.use("/api/day", daysEndpoint);

app.use(unknownEndpoint);

app.use(errorHandler);

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
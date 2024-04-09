const ethers = require("ethers");
const express = require("express");

require("dotenv").config();

const {
  abi,
} = require("./artifacts/contracts/CRUD_Student.sol/CRUD_Student.json");

const API_URL = process.env.API_URL;
const PRIVATE_KEY = process.env.PRIVATE_KEY;
const CONTRACT_ADDRESS = process.env.CONTRACT_ADDRESS;

const provider = new ethers.providers.JsonRpcProvider(API_URL);
const signer = new ethers.Wallet(PRIVATE_KEY, provider);
const contract = new ethers.Contract(CONTRACT_ADDRESS, abi, signer);

const app = express();
app.use(express.json());

app.post("/", async (req, res) => {
  try {
    const { id, name } = req.body;
    const tx = await contract.createStudent(id, name);
    await tx.wait();
    res.status(200).json(tx);
  } catch (error) {
    res.status(500).json(error);
  }
});

app.get("/", async (req, res) => {
  try {
    const allStudent = await contract.getAllStudent();
    const students = allStudent.map((student) => ({
      id: parseInt(student.id),
      name: student.name,
    }));
    res.status(200).json(students);
    res.status(200).json({ msg: "Hello World" });
  } catch (error) {
    res.status(500).json(error);
  }
});

app.get("/:id", async (req, res) => {
  try {
    const student = await contract.getStudent(req.params.id);
    const studentData = { id: parseInt(student.id), name: student.name };
    res.status(200).json(studentData);
  } catch (error) {
    res.status(500).json(error);
  }
});

app.get("/total", async (req, res) => {
  try {
    const totalStudent = await contract.getTotalStudent();
    res.status(200).json(parseInt(totalStudent));
  } catch (error) {
    res.status(500).json(error);
  }
});

app.put("/:id", async (req, res) => {
  try {
    const { name } = req.body;
    const tx = await contract.updateStudent(req.params.id, name);
    await tx.wait();

    res.status(200).json(tx);
  } catch (error) {
    res.status(500).json(error);
  }
});

app.delete("/:id", async (req, res) => {
  try {
    const tx = await contract.deleteStudent(req.params.id);
    await tx.wait();
    res.status(200).json(tx);
  } catch (error) {
    res.status(500).json(error);
  }
});

app.listen(3000, () => {
  console.log("Server running on port 3000");
});

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

contract CRUD_Student {
    struct Student {
        uint256 id;
        string name;
    }

    Student[] public students;
    uint256 public totalStudent;

    constructor() {
        totalStudent = 0;
    }

    function createStudent(
        uint256 _id,
        string memory _name
    ) external returns (bool) {
        Student memory newStudent = Student(_id, _name);
        students.push(newStudent);
        totalStudent++;
        return true;
    }

    function updateStudent(
        uint256 _id,
        string memory _name
    ) external returns (bool) {
        for (uint i = 0; i < students.length; i++) {
            if (students[i].id == _id) {
                students[i].name = _name;
                return true;
            }
        }
        return false;
    }

    function deleteStudent(uint256 _id) external returns (bool) {
        for (uint i = 0; i < students.length; i++) {
            if (students[i].id == _id) {
                for (uint j = i; j < students.length - 1; j++) {
                    students[j] = students[j + 1];
                }
                totalStudent--;
                students.pop();
                return true;
            }
        }
        return false;
    }

    function getStudent(
        uint256 _id
    ) external view returns (uint256, string memory) {
        for (uint i = 0; i < students.length; i++) {
            if (students[i].id == _id) {
                return (students[i].id, students[i].name);
            }
        }
        revert("Student not found");
    }

    function getAllStudent() external view returns (Student[] memory) {
        return students;
    }

    function getTotalStudent() external view returns (uint256) {
        return totalStudent;
    }
}

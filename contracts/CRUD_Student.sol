// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CRUD_Student {
    struct Student {
        uint id;
        string name;
    }

    Student[] private _students;

    uint private _totalStudents;

    constructor() {
        _totalStudents = 0;
    }

    event AddEvent(uint id, string name);
    event UpdateEvent(uint id, string name);
    event DeleteEvent(uint id);

    function addStudent(uint id, string memory name) public returns (bool) {
        Student memory newStudent = Student(id, name);
        _students.push(newStudent);
        _totalStudents++;

        emit AddEvent(id, name);
        return true;
    }

    function updateStudent(
        uint id,
        string memory name
    ) public returns (bool success) {
        for (uint i = 0; i < _students.length; i++) {
            if (_students[i].id == id) {
                _students[i].name = name;
                emit UpdateEvent(id, name);
                return true;
            }
        }
        return false;
    }

    function deleteStudent(uint id) public returns (bool success) {
        require(_students.length > 0, "No student to delete");
        require(id <= _totalStudents, "Student does not exist");

        for (uint i = id; i < _totalStudents - 1; i++) {
            _students[i] = _students[i + 1];
        }
        _students.pop();
        _totalStudents--;

        return false;
    }

    function getStudent(uint id) public view returns (Student memory) {
      for (uint i = 0; i < _totalStudents; i++) {
        if (_students[i].id == id) {
          return _students[i];
        }
      }
      revert("Student does not exist");
    }

    function getTotalStudents() public view returns (uint) {
        return _totalStudents;
    }

    function getAllStudents() public view returns (Student[] memory) {
        return _students;
    }
}

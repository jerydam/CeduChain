// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

import "./School.sol"; // Import the SchoolSystem contract

contract SchoolSystemFactory {
    address[] internal deployedSchoolSystems; // Store addresses of deployed SchoolSystem contracts
    mapping(address => address) internal schoolOwners; // Map school owner to school address
    mapping(address => address[]) internal schoolsByOwner; // Map owner address to array of school addresses
    
    // Event emitted when a new SchoolSystem contract is deployed
    event SchoolSystemDeployed(address indexed schoolSystem, address indexed owner);
    
    // Function to deploy a new SchoolSystem contract
    function createSchoolSystem(string memory name, string memory symbol) external {
        SchoolSystem newSchoolSystem = new SchoolSystem(name, symbol); // Deploy a new instance of SchoolSystem
        address newSchoolAddress = address(newSchoolSystem);
        deployedSchoolSystems.push(newSchoolAddress); // Store the address of the deployed contract
        schoolOwners[newSchoolAddress] = msg.sender; // Store the owner of the school
        schoolsByOwner[msg.sender].push(newSchoolAddress); // Store the school address under the owner's list
        emit SchoolSystemDeployed(newSchoolAddress, msg.sender); // Emit an event
    }

    // Function to get the number of deployed SchoolSystem contracts
    function getDeployedSchoolSystemsCount() external view returns (uint) {
        return deployedSchoolSystems.length;
    }
    
    // Function to return all schools created by an address
    function getSchoolsByOwner(address owner) external view returns (address[] memory) {
        return schoolsByOwner[owner];
    }

    // Function to get the owner of a specific school
    function getSchoolOwner(address schoolAddress) external view returns (address) {
        return schoolOwners[schoolAddress];
    }

    // Function to check if a school exists
    function schoolExists(address schoolAddress) external view returns (bool) {
        return schoolOwners[schoolAddress] != address(0);
    }

    // Function to get details of a specific school
    function getSchoolDetails(address schoolAddress) external view returns (string memory name, string memory symbol, address owner) {
        SchoolSystem school = SchoolSystem(schoolAddress);
        return (school.name(), school.symbol(), schoolOwners[schoolAddress]);
    }

    // Modifier to restrict access to certain functions only to the owner of a school
    modifier onlySchoolOwner(address schoolAddress) {
        require(msg.sender == schoolOwners[schoolAddress], "Only the owner of the school can call this function");
        _;
    }
}

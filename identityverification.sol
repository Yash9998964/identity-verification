// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract DecentralizedIdentity {
    struct Identity {
        string name;
        string dob;
        string email;
        string phone;
        bool isVerified;
        bool isRevoked;
        uint256 registeredAt;
        uint256 updatedAt;
    }

    mapping(address => Identity) public identities;
    mapping(address => bool) public isRegistered;
    mapping(address => bool) public isVerifier;
    address public admin;
    
    event IdentityRegistered(address indexed user, string name);
    event IdentityUpdated(address indexed user, string name);
    event IdentityVerified(address indexed user);
    event IdentityRevoked(address indexed user);
    event AdminChanged(address indexed oldAdmin, address indexed newAdmin);
    event VerifierAdded(address indexed verifier);
    event VerifierRemoved(address indexed verifier);
    
    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action");
        _;
    }

    modifier onlyUser() {
        require(isRegistered[msg.sender], "User not registered");
        _;
    }

    modifier onlyVerifier() {
        require(isVerifier[msg.sender] || msg.sender == admin, "Only verifier or admin can perform this action");
        _;
    }

    constructor() {
        admin = msg.sender;
    }

    function registerIdentity(string memory _name, string memory _dob, string memory _email, string memory _phone) public {
        require(!isRegistered[msg.sender], "Identity already registered");
        
        identities[msg.sender] = Identity({
            name: _name,
            dob: _dob,
            email: _email,
            phone: _phone,
            isVerified: false,
            isRevoked: false,
            registeredAt: block.timestamp,
            updatedAt: block.timestamp
        });
        
        isRegistered[msg.sender] = true;
        emit IdentityRegistered(msg.sender, _name);
    }

    function updateIdentity(string memory _name, string memory _dob, string memory _email, string memory _phone) public onlyUser {
        require(!identities[msg.sender].isRevoked, "Identity is revoked");
        
        identities[msg.sender].name = _name;
        identities[msg.sender].dob = _dob;
        identities[msg.sender].email = _email;
        identities[msg.sender].phone = _phone;
        identities[msg.sender].isVerified = false;
        identities[msg.sender].updatedAt = block.timestamp;
        
        emit IdentityUpdated(msg.sender, _name);
    }

    function verifyIdentity(address _user) public onlyVerifier {
        require(isRegistered[_user], "User not registered");
        require(!identities[_user].isRevoked, "Identity is revoked");
        
        identities[_user].isVerified = true;
        emit IdentityVerified(_user);
    }

    function revokeIdentity() public onlyUser {
        identities[msg.sender].isRevoked = true;
        emit IdentityRevoked(msg.sender);
    }

    function adminRevokeIdentity(address _user) public onlyAdmin {
        require(isRegistered[_user], "User not registered");
        
        identities[_user].isRevoked = true;
        emit IdentityRevoked(_user);
    }

    function getIdentity(address _user) public view returns (Identity memory) {
        require(isRegistered[_user], "User not registered");
        return identities[_user];
    }

    function changeAdmin(address _newAdmin) public onlyAdmin {
        require(_newAdmin != address(0), "Invalid address");
        address oldAdmin = admin;
        admin = _newAdmin;
        emit AdminChanged(oldAdmin, _newAdmin);
    }
    
    function addVerifier(address _verifier) public onlyAdmin {
        require(!isVerifier[_verifier], "Already a verifier");
        isVerifier[_verifier] = true;
        emit VerifierAdded(_verifier);
    }
    
    function removeVerifier(address _verifier) public onlyAdmin {
        require(isVerifier[_verifier], "Not a verifier");
        isVerifier[_verifier] = false;
        emit VerifierRemoved(_verifier);
    }
}

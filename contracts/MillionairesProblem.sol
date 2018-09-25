pragma solidity ^0.4.17; 


contract MillionairesProblem {
	// Stores # of millionaires that have joined and stated their net worths
	uint public numMillionaires; 
	// Stores Millionaire structs (defined below)
	Millionaire[] millionaires; 
	// Stores address of richest millionaire; set in callback function below
	uint public value; 
	address public owner;
	address public enigma;

	// Millionaire struct which holds encrypted address and net worth
	struct Millionaire {
		bytes myAddress; 
		bytes myNetWorth; 
	}

	// Event emitted upon callback completion; watched from front end
	event CallbackFinished(uint callbackValue); 

	// Modifier to ensure only enigma contract can call function
	modifier onlyEnigma() {
		require(msg.sender == enigma);
		_;
	}

	// Constructor called when new contract is deployed
	constructor(address _enigmaAddress, address _owner) public {
		owner = _owner; 
		enigma = _enigmaAddress;
	}

	// Add a new millionaire with encrypted address and net worth arguments
	function addMillionaire(bytes _encryptedAddress, bytes _encryptedNetWorth) 
		public 
	{
		Millionaire memory millionaire = Millionaire({
			myAddress: _encryptedAddress, 
			myNetWorth: _encryptedNetWorth
		}); 
		millionaires.push(millionaire); 
		numMillionaires++; 
	}

	// Return encrypted address and net worth for a particular millionaire
	function getInfoForMillionaire(uint index) 
		public 
		view 
		returns (bytes, bytes) 
	{
		Millionaire memory millionaire = millionaires[index]; 
		bytes memory encryptedAddress = millionaire.myAddress; 
		bytes memory encryptedNetWorth = millionaire.myNetWorth; 
		return (encryptedAddress, encryptedNetWorth); 
	}
	
	/*
	CALLABLE FUNCTION run in SGX to decipher encrypted net worths to 
	determine richest millionaire
	*/
	function saveValue(uint _val) 
		public 
		pure 
		returns (uint) 
	{
		// return _val;
		return _val; 
	}

	/*
	CALLBACK FUNCTION to change contract state tracking richest 
	millionaire's name
	*/
	function setValue(uint _val) public onlyEnigma() {
		value = _val; 
		emit CallbackFinished(_val); 
	}
}
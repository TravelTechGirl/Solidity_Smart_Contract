Joint Savings Account
---------------------

To automate the creation of joint savings accounts, you will create a solidity smart contract that accepts two user addresses that are then able to control a joint savings account. Your smart contract will use ether management functions to implement various requirements from the financial institution to provide the features of the joint savings account.

The Starting file provided for this challenge contains a `pragma` for solidity version `5.0.0`.
You will do the following:

1. Create and work within a local blockchain development environment using the JavaScript VM provided by the Remix IDE.

2. Script and deploy a **JointSavings** smart contract.

3. Interact with your deployed smart contract to transfer and withdraw funds.

*/

pragma solidity ^0.5.0;

// Define a new contract named `JointSavings`
contract JointSavings {

    
    // Variables
    address payable accountOne;
    address payable accountTwo;
    address public lastToWithdraw;
    uint public lastToWithdrawAmount;
    uint public contractBalance;

    /*
    Define a function named **withdraw** that will accept two arguments.
    - A `uint` variable named `amount`
    - A `payable address` named `recipient`
    */
    function withdraw(uint amount, address payable recipient) public {

        
        // Require the account making the function call to be the ownerof accountOne or accountTwo
        require(recipient == accountOne || recipient == accountTwo, "You don't own this account!");

      
        // Require the account to have enough to withdraw
        require(contractBalance >=amount, "Insufficient funds!");

        
        // Set the lastToWithdraw to the recipient
        if (lastToWithdraw != recipient){
            lastToWithdraw = recipient;
        }

   
        // transfer amount to the recipient
        recipient.transfer(amount);

        // Set lastToWithdrawAmount equal to amount
        lastToWithdrawAmount = amount;

        //get new contractBalance
        contractBalance = address(this).balance;
    }

    // Define a `public payable` function named `deposit`.
    function deposit() public payable {
        // get new contractBalance
        contractBalance = address(this).balance;
    }

    /*
    Define a `public` function named `setAccounts` that receive two `address payable` arguments named `account1` and `account2`.
    */
    function setAccounts(address payable account1, address payable account2) public{
        // Set the accountOne and accountTwo addresses
        accountOne = account1;
        accountTwo = account2;
    }

    /*
    Finally, add the **default fallback function** so that your contract can store Ether sent from outside the deposit function.
    */
    // function() external payable {}
}

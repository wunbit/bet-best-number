pragma solidity 0.4.20;

contract BetBestNumber {
    address public owner;
    uint256 public minimumBet;
    uint256 public totalBet;
    uint256 public numberofBets;
    uint256 public maxAmountfBets = 100;
    address[] public players;

    struct Player {
        uint256 amountBet;
        uint256 numberSelected;
    }

    // The address of the player and => the user info
    mapping (address=> Player) public playerInfo;

    function BetBestNumber(uint256 _minimumBet) public {
        owner = msg.sender;
        if(_minimumBet != 0) minimumBet = _minimumBet;
    }

    function kill() public {
        if(msg.sender == owner) selfdestruct(owner);
    }

    function checkPlayerExists(address player) public constant returns(bool) {
        for(uint256 i = 0; i < players.length; i++) {
            if(players[i] == player) return true;
        }
        return false;
    }

    // To bet for a number between 1 and 10 both inclusive
    function bet(uint256 numberSelected) public payable {
        require(!checkPlayerExists(msg.sender));
        require(numberSelected >= 1 && numberSelected <= 10);
        require(msg.value >= minimumBet);

        playerInfo[msg.sender].amountBet = msg.value;
        playerInfo[msg.sender].numberSelected = numberSelected;
        numberofBets++;
        players.push(msg.sender);
        totalBet += msg.value;

    }
}

//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;


contract BlcDev{
    string public name = "Blockchain Dev Simplified";
    string public symbol = "BLCDEVS";
    string public standard = "BlcDev v.0.1";
    uint256 public totalSupply;
    address public ownerOfContract;
    uint256 public _userId;

    address[] public holderToken; //Keep addresses of all the users token holders



    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 _value
    );


    mapping(address => TokenHolderInfo) public tokenHolderInfos;


    struct TokenHolderInfo {
        uint256 _tokenId;
        address _from;
        address _to;
        uint256 _totalToken; //Store total numbers of tokens users buys
        bool _tokenoHolder;
    }


    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    constructor(uint256 _initialSupply){
        ownerOfContract = msg.sender;
        balanceOf[msg.sender] = _initialSupply;
        totalSupply = _initialSupply;
    }

    function inc() internal {
        _userId++;
    }

function transfer(address _to, uint256 _value) 
        public  
     returns (bool success) 

    {

        require(balanceOf[msg.sender] >= _value);
        inc();

        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
    
            TokenHolderInfo storage tokenHolderInfo = tokenHolderInfos[_to];

        tokenHolderInfo._to = _to;
        tokenHolderInfo._from = msg.sender;
        tokenHolderInfo._totalToken = _value;
        tokenHolderInfo._tokenoHolder = true;
        tokenHolderInfo._tokenId = _userId;


        holderToken.push(_to);

        emit Transfer(msg.sender, _to, _value);


    return true;
    }





function approve(address _spender, uint256 _value)
        public

        returns (bool success)

        {
            allowance[msg.sender][_spender] = _value;

            emit Approval(msg.sender, _spender, _value);

            return true;
        }


            

}
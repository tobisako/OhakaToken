pragma solidity >=0.4.21 <0.6.0;
import "openzeppelin-solidity/contracts/token/ERC721/ERC721Full.sol";
import "openzeppelin-solidity/contracts/token/ERC721/ERC721Mintable.sol";

contract OhakaToken is ERC721Full, ERC721Mintable {
    address public owner;
    struct KojinInfo {
        string kojinName;
        uint deathAge;
        uint ohakaDirty;
        uint ohakaCleanBlockNumber;
        uint balance;
        mapping (address => bool) isFamily;
        mapping (address => bool) isFriend;
    }
    string[3][3] ipfsHash;
    bool[3][3] isShowOnlyFamily;
    KojinInfo[] public kojinList;
    // データ構造再考必要

    string constant name = "OhakaToken";
    string constant symbol = "OHA";

    constructor() ERC721Full(name, symbol) public {
        owner = msg.sender;
    }

    // お墓を生成する
    function mintOhaka(address _initOwner, string memory _kojinName, uint _deathAge) public {
        require(owner == msg.sender);
        KojinInfo memory kojin = KojinInfo({kojinName:_kojinName, deathAge:_deathAge, ohakaDirty:0, ohakaCleanBlockNumber:block.number, balance:0});
        uint256 _tokenId = kojinList.push(kojin) - 1;
        kojinList[_tokenId].isFamily[_initOwner] = true;
        _mint(_initOwner, _tokenId);
        //emit Mint(_initOwner, _tokenId, _tokenURI);
    }

    // 故人データを取得する
    function getKojinData(uint _tokenId) public view returns (string memory, uint, uint) {
        return 
        (
            kojinList[_tokenId].kojinName,
            kojinList[_tokenId].deathAge,
            getDirty(_tokenId)
        );
    }

    // 関係取得（0:親族、1:友人、2:他人）
    function getRelation(uint _tokenId) public view returns(uint) {
        uint _relation;
        if (kojinList[_tokenId].isFamily[msg.sender] == true) {
            _relation = 0;
            return _relation;
        } if (kojinList[_tokenId].isFriend[msg.sender] == true) {
            _relation = 1;
        } else {
            _relation = 2;
        }
        return _relation;
    }

    // IPFSを取得する
    function getIPFS(uint _tokenId, uint _index) public view returns (string memory) {
        if(isShowOnlyFamily[_tokenId][_index] == true) {
            if(isFamily(_tokenId, msg.sender) != true) {
                return "Qmdp9d8LQMZMCGZza7ug7DY1YaT2E8pi2A2FxgrudimDvX";    // BATSU
            }
        }
        return ipfsHash[_tokenId][_index];
    }
    
    // IPFSをセットする
        // 問題：親族以外も自由にセット出来る
    function setIPFS(uint _tokenId, uint _index, string memory _ipfsHash, bool _isShowOnlyFamily) public {
        ipfsHash[_tokenId][_index] = _ipfsHash;
        isShowOnlyFamily[_tokenId][_index] = _isShowOnlyFamily;
    }

    // お墓の汚れ具合を取得する
    function getDirty(uint _tokenId) public view returns (uint) {
        return kojinList[_tokenId].ohakaDirty + (block.number - kojinList[_tokenId].ohakaCleanBlockNumber);
    }

    // お墓をキレイにする
    function cleanOhaka(uint _tokenId) public {
        kojinList[_tokenId].ohakaCleanBlockNumber = block.number;
        kojinList[_tokenId].ohakaDirty = 0;
    }

    // is Family
    function isFamily(uint _tokenId, address _address) public view returns (bool) {
        return kojinList[_tokenId].isFamily[_address];
    }

    // set Family
    function setFamily(uint _tokenId, address _newFamily) public {
        require(kojinList[_tokenId].isFamily[msg.sender] == true);
        kojinList[_tokenId].isFamily[_newFamily] = true;
    }

    // is Friend
    function isFriend(uint _tokenId, address _address) public view returns (bool) {
        return kojinList[_tokenId].isFriend[_address];
    }

    // set Friend
    function setFriend(uint _tokenId, address _newFriend) public {
        require(kojinList[_tokenId].isFamily[msg.sender] == true);
        kojinList[_tokenId].isFriend[_newFriend] = true;
    }

    // 投げ銭を投げる処理
    function deposit(uint256 _tokenId) payable public {
        kojinList[_tokenId].balance += msg.value;
    }

    // お墓の投げ銭残高を取得する
    function getOhakaBalance(uint256 _tokenId) view public returns (uint) {
        return kojinList[_tokenId].balance;
    }

    // お墓からＥＴＨを抜く
    function withdraw(uint256 _tokenId) public {
        require(kojinList[_tokenId].isFamily[msg.sender] == true);
        uint256 _amount = kojinList[_tokenId].balance;
        kojinList[_tokenId].balance = 0;
        msg.sender.transfer(_amount);
    }

    // お墓全体のＥＴＨ残高を取得する    
    function getOhakaAllBalance() public view returns (uint) {
        return address(this).balance;
    }
}

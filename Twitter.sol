// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;
contract TwitterContract{
    
    struct Tweet{
        uint ID;
        address Author;
        string Content;
        uint CreatedAt;
    }

    struct Message{
        uint ID;
        address from;
        address to;
        string content;
        uint CreatedAt;
    }
    mapping(uint => Tweet) public tweets; // to handle Tweet struct --- it gives all data of a tweet
    mapping(address=> uint[]) public tweetsof; // it gives all id's of that person
    mapping(address=>Message[]) public conversations; // use array of struct[] in this to store multiple message of single person
    mapping(address=>mapping(address=>bool)) public operators; // it gives permission to use account on his behalf
    mapping (address => address[]) public following; // to store the record of following list 
    
    uint nextID;
    uint nextMessageID;
    // User can Tweet by using this function 
    function tweet(address from,string memory content) internal {
        require(from == msg.sender,"Take Valid Address");
        tweets[nextID] = Tweet(nextID ,from ,content  , block.timestamp);
        tweetsof[from].push(nextID);
        nextID++;

    }
    // user can send a message to anyone
    function sendmessage(address from,address to, string memory message) internal {
        require(from == msg.sender,"Take Valid Address");
        conversations[from].push(Message(nextMessageID ,from ,to,message,block.timestamp));
        nextMessageID++;
    }
    function _tweet(string memory content) public {
        tweet(msg.sender,content);
    }
    function _tweet(address from,string memory content) public {
        tweet(from,content);
    }
    function sendMessage(string memory message,address to) public{
        sendmessage(msg.sender,to,message);
    }
    function sendMessage(address from,address to,string memory message) public {
        sendmessage(from,to,message);
    }
    function follow(address followed) public {
        following[msg.sender].push(followed);
    }
    function allow(address _operator) public {
        operators[msg.sender][_operator] = true;
    }
    function Disallow(address _operator) public {
        operators[msg.sender][_operator] = false;
    }
    function getLatestTweets(uint count) public view returns(Tweet[] memory){
        require(count > 0 && count<= nextID,"Invalid count ID");
        Tweet[] memory _tweets = new Tweet[](count); 
        uint  j;        
        for(uint i = nextID - count;i<nextID;i++){
            Tweet storage structure = tweets[i];
            _tweets[j] = Tweet(
                structure.ID,
                structure.Author,
                structure.Content,
                structure.CreatedAt

            );
            j = j+1;
        }
        return _tweets;
        
    }
    // to fetch the other user information
    function getLatestofUser(address user,uint count) public view returns(Tweet[] memory){
        Tweet[] memory _tweets = new Tweet[](count); 
                                               
        uint[] memory ids = tweetsof[user];  
        require(count > 0 && count<= ids.length,"Invalid count ID");
        uint  j;
        for(uint i = ids.length - count;i<ids.length;i++){
            Tweet storage structure = tweets[ids[i]];
            _tweets[j] = Tweet(
                structure.ID,
                structure.Author,
                structure.Content,
                structure.CreatedAt

            );
            j = j+1;
        }
        return _tweets;
    }
}


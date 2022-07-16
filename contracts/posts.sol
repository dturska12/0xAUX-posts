// SPDX-License-Identifier: MIT

/******************************
 *           0xAUX
 *      A New Way to Web3
 ******************************/

pragma solidity ^0.8.7;

contract posts {

    address public owner;
    uint256 private counter;

    constructor() {
        counter = 0;
        owner = msg.sender;
     }

    struct post {
        address poster;
        uint256 id;
        string postTxt;
        string postImg;
        string postMusic;
    }

    event postCreated (
        address poster,
        uint256 id,
        string postTxt,
        string postImg,
        string postMusic
    );

    mapping(uint256 => post) Posts;

    function addPost(
        string memory postTxt,
        string memory postImg,
        string memory postMusic
        ) public payable {
            require(msg.value == (.000042 ether), "Please submit .000042 Phoenix");
            post storage newPost = Posts[counter];
            newPost.postTxt = postTxt;
            newPost.postImg = postImg;
            newPost.postMusic = postMusic;
            newPost.poster = msg.sender;
            newPost.id = counter;
            emit postCreated(
                msg.sender, 
                counter, 
                postTxt, 
                postImg, 
                postMusic
            );
            counter++;

            payable(owner).transfer(msg.value);
    }

    function getPost(uint256 id) public view returns (string memory, string memory, address){
        require(id < counter, "No such Post");

        post storage t = Posts[id];
        return (t.postTxt, t.postImg, t.poster);
    }
}
              

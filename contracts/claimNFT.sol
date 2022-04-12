// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.4;

interface airdrop {
    function transferFrom(address from,address to,uint256 tokenId) external;
    function balanceOf(address account) external view returns (uint256);
    function tokenOfOwnerByIndex(address owner, uint256 index) external view returns (uint256);
    function mint() external;
}
contract multiCall{
    address constant contra = address(0xCCB9D89e0F77Df3618EEC9f6BF899Be3B5561A89);
    function call(uint256 times) public {
        for(uint i=0;i<times;++i){
           new claimer(contra);
        }
    }
}
contract claimer{
    constructor(address contra){
        airdrop(contra).mint();
        uint256 id = airdrop(contra).tokenOfOwnerByIndex(address(this),0);
        airdrop(contra).transferFrom(address(this),msg.sender,id);
        selfdestruct(payable(address(msg.sender)));
    }
}

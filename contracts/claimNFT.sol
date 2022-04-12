// SPDX-License-Identifier: GPL-3.0
// 在之前批量 claim ERC20 Token 的基础上，将interface 改为了 REC721 ,可以实现批量 mint NFT 的合约
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
        //uint256 balance = airdrop(contra).balanceOf(address(this));
        uint256 id = airdrop(contra).tokenOfOwnerByIndex(address(this),0);

        airdrop(contra).transferFrom(address(this),msg.sender,id);
        selfdestruct(payable(address(msg.sender)));
    }
}

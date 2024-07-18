// SPDX-License-Identifier: GLP-3.0
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";


contract PocketDio is ERC721 {
    struct Pokemon {
        string name;
        uint level;
        string img;
    }

    Pokemon[] public Pokemons;
    address public gameOwner;

    constructor () ERC721("PocketDIO", "PKD"){
        gameOwner = msg.sender;

    }

    modifier onlyOwner(uint _monsterId){
        require(ownerOf(_monsterId) == msg.sender, "Apenas o dono pode usar este Pokemon");
        _;
    }

    function battle(uint _attackPokemon, uint _defendingPokemon) public onlyOwner(_attackPokemon){
        Pokemon storage attacker = Pokemons[_attackPokemon];
        Pokemon storage defender = Pokemons[_defendingPokemon];

        if (attacker.level > defender.level){
            attacker.level += 2;
            defender.level += 1;
        } else {
            attacker.level += 1;
            defender.level += 2;
        }
    }

    function createPokemon(string memory _name, address _to, string memory _img) public {
        require(msg.sender == gameOwner, "Apenas o dono pode criar novos Pokemons");
        
        Pokemon memory newPokemon = Pokemon(_name, 1, _img);

        uint ItemId = Pokemons.length;
        Pokemons.push(newPokemon);
        _safeMint(msg.sender, ItemId);
    }
}

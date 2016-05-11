//
//  day21.swift
//  AdventOfCode
//
//  Created by Robbie Plankenhorn on 5/10/16.
//  Copyright © 2016 Plankenhorn.net. All rights reserved.
//

import Foundation

private struct Boss {
    var name:String
    var hitPoints:Double
    var damage:Double
    var armor:Double
}

private struct PlayerOne {
    var name:String
    var hitPoints:Double
    
    let weapon:Weapon
    let armorItem:Armor?
    let ringOne:Ring?
    let ringTwo:Ring?
    
    var cost:Double {
        return weapon.cost + (armorItem?.cost ?? 0) + (ringOne?.cost ?? 0) + (ringTwo?.cost ?? 0)
    }
    
    var damage:Double {
        return weapon.damage + (armorItem?.damage ?? 0) + (ringOne?.damage ?? 0) + (ringTwo?.damage ?? 0)
    }
    
    var armor:Double {
        return weapon.armor + (armorItem?.armor ?? 0) + (ringOne?.armor ?? 0) + (ringTwo?.armor ?? 0)
    }
}

extension PlayerOne: Hashable {
    var hashValue: Int {
        return name.hashValue ^ hitPoints.hashValue ^ weapon.hashValue ^ (armorItem?.hashValue ?? 0) ^ (ringOne?.hashValue ?? 0) ^ (ringTwo?.hashValue ?? 0)
    }
}

private func ==(lhs: PlayerOne, rhs: PlayerOne) -> Bool {
    return lhs.name == rhs.name && lhs.hitPoints == rhs.hitPoints && lhs.weapon == rhs.weapon && lhs.armorItem == rhs.armorItem && lhs.ringOne == rhs.ringOne && lhs.ringTwo == rhs.ringTwo
}

private protocol Item: Hashable {
    var name:String { get }
    var cost:Double { get }
    var damage:Double { get }
    var armor:Double { get }
}

extension Item where Self: Hashable {
    var hashValue: Int {
        return name.hashValue ^ cost.hashValue ^ damage.hashValue ^ armor.hashValue
    }
}

private struct Weapon: Item {
    var name:String
    var cost:Double
    var damage:Double
    var armor:Double
}

private func ==(lhs: Weapon, rhs: Weapon) -> Bool {
    return lhs.name == rhs.name && lhs.cost == rhs.cost && lhs.damage == rhs.damage && lhs.armor == rhs.armor
}

private struct Armor: Item {
    var name:String
    var cost:Double
    var damage:Double
    var armor:Double
}

private func ==(lhs: Armor, rhs: Armor) -> Bool {
    return lhs.name == rhs.name && lhs.cost == rhs.cost && lhs.damage == rhs.damage && lhs.armor == rhs.armor
}

private struct Ring: Item {
    var name:String
    var cost:Double
    var damage:Double
    var armor:Double
}

private func ==(lhs: Ring, rhs: Ring) -> Bool {
    return lhs.name == rhs.name && lhs.cost == rhs.cost && lhs.damage == rhs.damage && lhs.armor == rhs.armor
}

private func getPlayerCombinations() -> [PlayerOne] {
    let weapons:[Weapon] = [Weapon(name: "Dagger", cost: 8, damage: 4, armor: 0),
                            Weapon(name: "Shortsword", cost: 10, damage: 5, armor: 0),
                            Weapon(name: "Warhammer", cost: 25, damage: 6, armor: 0),
                            Weapon(name: "Longsword", cost: 40, damage: 7, armor: 0),
                            Weapon(name: "Greataxe", cost: 74, damage: 8, armor: 0)]
    
    let armor:[Armor] = [Armor(name: "Leather", cost: 13, damage: 0, armor: 1),
                         Armor(name: "Chainmail", cost: 31, damage: 0, armor: 2),
                         Armor(name: "Splitmail", cost: 53, damage: 0, armor: 3),
                         Armor(name: "Bandedmail", cost: 75, damage: 0, armor: 4),
                         Armor(name: "Platemail", cost: 102, damage: 0, armor: 5)]
    
    let rings:[Ring] = [Ring(name: "Damage +1", cost: 25, damage: 1, armor: 0),
                        Ring(name: "Damage +2", cost: 50, damage: 2, armor: 0),
                        Ring(name: "Damage +3", cost: 100, damage: 3, armor: 0),
                        Ring(name: "Defence +1", cost: 20, damage: 0, armor: 1),
                        Ring(name: "Defence +2", cost: 40, damage: 0, armor: 2),
                        Ring(name: "Defence +3", cost: 80, damage: 0, armor: 3)]
    
    var playerCombinations:Set<PlayerOne> = Set()
    var ringCombinations:Set<Set<Ring>> = Set()
    
    for ring1 in rings {
        ringCombinations.insert(Set([ring1]))
        
        for ring2 in rings {
            ringCombinations.insert(Set([ring1, ring2]))
        }
    }
    
    var arrayOfRingCombinations:[[Ring]] = []
    
    for ringSet in ringCombinations {
        arrayOfRingCombinations.append(Array(ringSet))
    }
    
    for weapon in weapons {
        playerCombinations.insert(PlayerOne(name: "Player", hitPoints: 100, weapon: weapon, armorItem: nil, ringOne: nil, ringTwo: nil))
        
        for armor in armor {
            playerCombinations.insert(PlayerOne(name: "Player", hitPoints: 100, weapon: weapon, armorItem: armor, ringOne: nil, ringTwo: nil))
            
            for ringCombination in arrayOfRingCombinations {
                playerCombinations.insert(PlayerOne(name: "Player", hitPoints: 100, weapon: weapon, armorItem: armor, ringOne: ringCombination.first!, ringTwo: (ringCombination.last ?? nil)))
            }
        }
        
        for ringCombination in arrayOfRingCombinations {
            playerCombinations.insert(PlayerOne(name: "Player", hitPoints: 100, weapon: weapon, armorItem: nil, ringOne: ringCombination.first!, ringTwo: (ringCombination.last ?? nil)))
        }
    }
    
    return Array(playerCombinations)
}

private extension PlayerOne {

    func battle(boss:Boss) -> Bool {
        let numberOfPlayerTurns = ceil(boss.hitPoints / Swift.max(self.damage - boss.armor, 1))
        let numberOfBossTurns = ceil(self.hitPoints / Swift.max(boss.damage - self.armor, 1))
        
        return numberOfPlayerTurns < numberOfBossTurns
    }
    
}

func day21Part1() -> Int {
    var minimumCost = Int.max
    let boss = Boss(name: "Boss", hitPoints: 109, damage: 8, armor: 2)
    
    for player in getPlayerCombinations() {
        if player.battle(boss) {
            minimumCost = Swift.min(minimumCost, Int(player.cost))
        }

    }
    
    return minimumCost
}
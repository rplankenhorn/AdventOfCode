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
    
    let weapon:Item
    let armorItem:Item
    let rings:(Item,Item)
    
    init(name:String = "Player", hitPoints:Double = 100.0, weapon:Item, armorItem:Item, rings:(Item,Item)) {
        self.name = name
        self.hitPoints = hitPoints
        self.weapon = weapon
        self.armorItem = armorItem
        self.rings = rings
    }
    
    var cost:Double {
        return weapon.cost + armorItem.cost + rings.0.cost + rings.1.cost
    }
    
    var damage:Double {
        return weapon.damage + armorItem.damage + rings.0.damage + rings.1.damage
    }
    
    var armor:Double {
        return weapon.armor + armorItem.armor + rings.0.armor + rings.1.armor
    }
}

extension PlayerOne: Hashable {
    var hashValue: Int {
        return name.hashValue ^ hitPoints.hashValue ^ weapon.hashValue ^ armorItem.hashValue ^ rings.0.hashValue ^ rings.1.hashValue
    }
}

private func ==(lhs: PlayerOne, rhs: PlayerOne) -> Bool {
    return lhs.name == rhs.name && lhs.hitPoints == rhs.hitPoints && lhs.weapon == rhs.weapon && lhs.armorItem == rhs.armorItem && lhs.rings.0 == rhs.rings.0 && lhs.rings.1 == rhs.rings.1
}

private struct Item {
    var name:String
    var cost:Double
    var damage:Double
    var armor:Double
}

extension Item: Hashable {
    var hashValue: Int {
        return name.hashValue ^ cost.hashValue ^ damage.hashValue ^ armor.hashValue
    }
}

private func ==(lhs: Item, rhs: Item) -> Bool {
    return lhs.name == rhs.name && lhs.cost == rhs.cost && lhs.damage == rhs.damage && lhs.armor == rhs.armor
}

private func getPlayerCombinations() -> [PlayerOne] {
    let weapons:[Item] = [Item(name: "Dagger", cost: 8, damage: 4, armor: 0),
                            Item(name: "Shortsword", cost: 10, damage: 5, armor: 0),
                            Item(name: "Warhammer", cost: 25, damage: 6, armor: 0),
                            Item(name: "Longsword", cost: 40, damage: 7, armor: 0),
                            Item(name: "Greataxe", cost: 74, damage: 8, armor: 0)]
    
    let armor:[Item] = [Item(name: "None", cost: 0, damage: 0, armor: 0),
                        Item(name: "Leather", cost: 13, damage: 0, armor: 1),
                        Item(name: "Chainmail", cost: 31, damage: 0, armor: 2),
                        Item(name: "Splitmail", cost: 53, damage: 0, armor: 3),
                        Item(name: "Bandedmail", cost: 75, damage: 0, armor: 4),
                        Item(name: "Platemail", cost: 102, damage: 0, armor: 5)]
    
    let rings:[Item] = [Item(name: "None1", cost: 0, damage: 0, armor: 0),
                        Item(name: "None2", cost: 0, damage: 0, armor: 0),
                        Item(name: "Damage +1", cost: 25, damage: 1, armor: 0),
                        Item(name: "Damage +2", cost: 50, damage: 2, armor: 0),
                        Item(name: "Damage +3", cost: 100, damage: 3, armor: 0),
                        Item(name: "Defence +1", cost: 20, damage: 0, armor: 1),
                        Item(name: "Defence +2", cost: 40, damage: 0, armor: 2),
                        Item(name: "Defence +3", cost: 80, damage: 0, armor: 3)]
    
    var playerCombinations:Set<PlayerOne> = Set()
    
    for weapon in weapons {
        for armor in armor {
            for ring1 in rings {
                for ring2 in rings where ring1 != ring2 {
                    playerCombinations.insert(PlayerOne(weapon: weapon, armorItem: armor, rings: (ring1, ring2)))
                }
            }
        }
    }
    
    return Array(playerCombinations)
}

private extension PlayerOne {

    func battle(boss:Boss) -> Bool {
        let numberOfPlayerTurns = ceil(boss.hitPoints / Swift.max(self.damage - boss.armor, 1))
        let numberOfBossTurns = ceil(self.hitPoints / Swift.max(boss.damage - self.armor, 1))
        
        return numberOfPlayerTurns <= numberOfBossTurns
    }
    
}

func day21Part1() -> Int {
    var minimumCost = Int.max
    let boss = Boss(name: "Boss", hitPoints: 109.0, damage: 8, armor: 2)
    
    for player in getPlayerCombinations() {
        if player.battle(boss) {
            minimumCost = Swift.min(minimumCost, Int(player.cost))
        }

    }
    
    return minimumCost
}

func day21Part2() -> Int {
    var maximumCost = 0
    let boss = Boss(name: "Boss", hitPoints: 109.0, damage: 8, armor: 2)
    
    for player in getPlayerCombinations() {
        if player.battle(boss) == false {
            maximumCost = Swift.max(maximumCost, Int(player.cost))
        }
        
    }
    
    return maximumCost
}
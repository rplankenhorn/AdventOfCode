//
//  day22.swift
//  AdventOfCode
//
//  Created by Robbie Plankenhorn on 5/11/16.
//  Copyright © 2016 Plankenhorn.net. All rights reserved.
//

import Foundation

private extension Array {
    func randomItem() -> Element? {
        if self.count == 0 {
            return nil
        } else {
            let index = Int(arc4random_uniform(UInt32(self.count)))
            return self[index]
        }
    }
}

private struct Spell {
    let name:String
    let cost:Int
    let damage:Int
    let heal:Int
    let armor:Int
    let manaGained:Int
    var numberOfTurns:Int
    
    static func magicMissile() -> Spell {
        return Spell(name: "Magic Missile", cost: 53, damage: 4, heal: 0, armor: 0, manaGained: 0, numberOfTurns: 0)
    }
    
    static func drain() -> Spell {
        return Spell(name: "Drain", cost: 73, damage: 2, heal: 2, armor: 0, manaGained: 0, numberOfTurns: 0)
    }
    
    static func shield() -> Spell {
        return Spell(name: "Shield", cost: 113, damage: 0, heal: 0, armor: 7, manaGained: 0, numberOfTurns: 6)
    }
    
    static func poison() -> Spell {
        return Spell(name: "Poison", cost: 173, damage: 3, heal: 0, armor: 0, manaGained: 0, numberOfTurns: 6)
    }
    
    static func recharge() -> Spell {
        return Spell(name: "Recharge", cost: 229, damage: 0, heal: 0, armor: 0, manaGained: 101, numberOfTurns: 5)
    }
}

extension Spell: Hashable {
    var hashValue:Int {
        return name.hashValue ^ cost.hashValue ^ damage.hashValue ^ heal.hashValue ^ armor.hashValue ^ manaGained.hashValue
    }
}

private func ==(lhs: Spell, rhs: Spell) -> Bool {
    return lhs.cost == rhs.cost && lhs.damage == rhs.damage && lhs.heal == rhs.heal && lhs.armor == rhs.armor && lhs.manaGained == rhs.manaGained
}

private struct Wizard {
    var hitPoints = 50
    var armor = 0
    var manaPoints = 500
    var effects:[Spell] = []
    
    mutating func applyEffect(spell:Spell) {
        if spell.armor > 0 {
            armor = spell.armor
        } else if spell.heal > 0 {
            hitPoints += spell.heal
        } else if spell.manaGained > 0 {
            manaPoints += spell.manaGained
        }
    }
}

private struct Boss {
    var hitPoints = 55
    var damage = 8
    var effects:[Spell] = []
    
    mutating func applyEffect(spell:Spell) {
        if spell.damage > 0 {
            hitPoints -= spell.damage
        }
    }
}

private func battle(decrementWizardHealth:Bool = false) -> Int {
    var wizard = Wizard()
    var boss = Boss()
    var manaSpent = 0
    
    var currentEffects:[Spell] = []
    
    while wizard.hitPoints > 0 && wizard.manaPoints > 0 {
        if decrementWizardHealth {
            wizard.hitPoints -= 1
        }
        
        for i in 0..<currentEffects.count {
            wizard.applyEffect(currentEffects[i])
            boss.applyEffect(currentEffects[i])
            currentEffects[i].numberOfTurns -= 1
        }
        
        if let _ = currentEffects.filter( { $0.numberOfTurns == 0 && $0.name == "Shield" }).first {
            wizard.armor = 0
        }
        
        currentEffects = currentEffects.filter { $0.numberOfTurns > 0 }
        
        // Wizard turn
        
        let currentEffectsSet = Set(currentEffects)
        
        let possibleSpells:[Spell] = [Spell.magicMissile(), Spell.drain(), Spell.shield(), Spell.poison(), Spell.recharge()].filter { currentEffectsSet.contains($0) == false && $0.cost <= wizard.manaPoints }
        
        if possibleSpells.count == 0 {
            wizard.hitPoints = 0
            break
        }
        
        let spell = possibleSpells.randomItem()!
        
        wizard.manaPoints -= spell.cost
        
        if spell.name != "Recharge" && spell.name != "Poison" {
            wizard.applyEffect(spell)
            boss.applyEffect(spell)
        }
        
        if spell.numberOfTurns > 0 {
            currentEffects.append(spell)
        }
        
        manaSpent += spell.cost
        
        if boss.hitPoints <= 0 {
            break
        }
        
        // Boss turn
        
        for i in 0..<currentEffects.count {
            wizard.applyEffect(currentEffects[i])
            boss.applyEffect(currentEffects[i])
            currentEffects[i].numberOfTurns -= 1
        }
        
        if boss.hitPoints <= 0 {
            break
        }
        
        let bossAttack = Swift.max(boss.damage - wizard.armor, 1)
        
        wizard.hitPoints -= bossAttack
        
        if let _ = currentEffects.filter( { $0.numberOfTurns == 0 && $0.name == "Shield" }).first {
            wizard.armor = 0
        }
        
        currentEffects = currentEffects.filter { $0.numberOfTurns > 0 }
    }
    
    return wizard.hitPoints > 0 ? manaSpent : Int.max
}

func day22Part1() -> Int {
    var minimumManaSpent = Int.max
    
    for _ in 1...4000 {
        minimumManaSpent = Swift.min(minimumManaSpent, battle())
    }
    
    return minimumManaSpent
}

func day22Part2() -> Int {
    var minimumManaSpent = Int.max
    
    for _ in 1...10000 {
        minimumManaSpent = Swift.min(minimumManaSpent, battle(true))
    }
    
    return minimumManaSpent
}
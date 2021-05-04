//
//  AllAmiibo.swift
//  Amiibo_iOS
//
//  Created by Celia Herrera Ferreira on 03/05/2021.
//
import Foundation

public class AllAmiibo: Codable {
    let amiibo: [Amiibo]?

    init(amiibo: [Amiibo]?) {
        self.amiibo = amiibo
    }
}

// MARK: - Amiibo
public class Amiibo: Codable {
    let amiiboSeries: AmiiboSeries?
    let character, gameSeries, head: String?
    let image: String?
    let name: String?
    let release: Release?
    let tail: String?
    let type: String?

    init(amiiboSeries: AmiiboSeries? = nil, character: String? = nil, gameSeries: String? = nil, head: String? = nil, image: String?, name: String?, release: Release? = nil, tail: String? = nil, type: String?) {
        self.amiiboSeries = amiiboSeries
        self.character = character
        self.gameSeries = gameSeries
        self.head = head
        self.image = image
        self.name = name
        self.release = release
        self.tail = tail
        self.type = type
    }
}

enum AmiiboSeries: String, Codable {
    case animalCrossing = "Animal Crossing"
    case boxBoy = "BoxBoy!"
    case chibiRobo = "Chibi-Robo!"
    case diablo = "Diablo"
    case fireEmblem = "Fire Emblem"
    case kirby = "Kirby"
    case legendOfZelda = "Legend Of Zelda"
    case marioSportsSuperstars = "Mario Sports Superstars"
    case megaMan = "Mega Man"
    case metroid = "Metroid"
    case monsterHunter = "Monster Hunter"
    case monsterHunterRise = "Monster Hunter Rise"
    case others = "Others"
    case pikmin = "Pikmin"
    case pokemon = "Pokemon"
    case powerPros = "Power Pros"
    case shovelKnight = "Shovel Knight"
    case skylanders = "Skylanders"
    case splatoon = "Splatoon"
    case superMarioBros = "Super Mario Bros."
    case superNintendoWorld = "Super Nintendo World"
    case superSmashBros = "Super Smash Bros."
    case the8BitMario = "8-bit Mario"
    case yoshiSWoollyWorld = "Yoshi's Woolly World"
}

// MARK: - Release
class Release: Codable {
    let au, eu, jp, na: String?

    init(au: String?, eu: String?, jp: String?, na: String?) {
        self.au = au
        self.eu = eu
        self.jp = jp
        self.na = na
    }
}

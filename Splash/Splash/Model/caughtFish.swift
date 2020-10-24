//
//  caughtFish.swift
//  Splash
//
//  Created by Ben Lapidus on 12/1/19.
//  Copyright © 2019 Ben Lapidus. All rights reserved.
//

import Foundation

class caughtFish {
    
   var fishArray = ["Acadian Redfish", "Alaska Pollock", "Alaska Snow Crab", "American Lobster", "Arrowtooth Flounder", "Atlantic Bigeye Tuna", "Atlantic Blacktip Shark", "Atlantic Cod", "Atlantic Common Thresher Shark", "Atlantic Halibut", "Atlantic Herring", "Atlantic Mackerel", "Atlantic Mahimahi", "Atlantic Northern Shrimp", "Atlantic Pollock", "Atlantic Salmon", "Atlantic Salmon Farmed", "Atlantic Sea Scallop", "Atlantic Sharpnose Shark", "Atlantic Shortfin Mako Shark", "Atlantic Skipjack Tuna", "Atlantic Spiny Dogfish", "Atlantic Striped Bass", "Atlantic Surfclam", "Atlantic Wahoo", "Atlantic Yellowfin Tuna", "Black Grouper", "Black Sea Bass", "Bluefish", "Blueline Tilefish", "Bocaccio", "Brown Rock Shrimp", "Brown Shrimp", "Butterfish", "California Market Squid", "Canary Rockfish", "Caribbean Spiny Lobster", "Chinook Salmon", "Chum Salmon", "Cobia", "Coho Salmon", "Dover Sole", "English Sole", "Flathead Sole", "Gag Grouper", "Gray Triggerfish", "Greater Amberjack", "Greenland Turbot", "Haddock", "King Mackerel", "Lingcod", "Longfin Inshore Squid", "Monkfish", "North Atlantic Albacore Tuna", "North Atlantic Swordfish", "North Pacific Swordfish", "Northern Anchovy", "Ocean Quahog", "Opah", "Pacific Albacore Tuna", "Pacific Bigeye Tuna", "Pacific Blue Marlin", "Pacific Bluefin Tuna", "Pacific Cod", "Pacific Common Thresher Shark", "Pacific Halibut", "Pacific Mackerel", "Pacific Mahimahi", "Pacific Ocean Perch", "Pacific Sardine", "Pacific Shortfin Mako Shark", "Pacific Skipjack Tuna", "Pacific Spiny Dogfish", "Pacific Wahoo", "Pacific Whiting", "Pacific Yellowfin Tuna", "Petrale Sole", "Pink Salmon", "Pink Shrimp", "Queen Conch", "Red Grouper", "Red Hake", "Red King Crab", "Red Snapper", "Rex Sole", "Rock Sole", "Sablefish", "Scup", "Shortfin Squid", "Shortspine Thornyhead", "Silver Hake", "Sockeye Salmon", "Spanish Mackerel", "Striped Marlin", "Summer Flounder", "Tilefish", "Vermilion Snapper", "Western Atlantic Bluefin Tuna", "White Shrimp", "Widow Rockfish", "Winter Flounder", "Winter Skate", "Wreckfish", "Yellowfin Sole", "Yellowtail Flounder", "Yellowtail rockfish"]
    
    func randomFishSelection() -> String {
         return fishArray[Int.random(in: 0...fishArray.count)]
    }
}

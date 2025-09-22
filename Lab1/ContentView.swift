//
//  ContentView.swift
//  Group #5
//  Lab1
//  Created by David Deng & Joshua Holmberg on 9/11/25.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
    // Dog names array (matching image file names)
    let dogNames = ["Airedale Terrier", "American Foxhound", "Dutch Shepherd", "Havanese", "Leonberger", "Mudi", "Norwegian Lundehund", "Pharaoh Hound", "Scottish Terrier", "Tosa"]
    
    // Dog descriptions array (from dog_data.txt)
    let dogDescriptions = ["The Airedale stands among the world's most versatile dog breeds and has distinguished himself as hunter, athlete, and companion.",
    "American Foxhounds are good-natured, low-maintenance hounds who get on well with kids, dogs, even cats, but come with special considerations for prospective owners.",
    "The Dutch Shepherd is a lively, athletic, alert and intelligent breed, and has retained its herding instinct for which it was originally developed.",
    "Havanese, the only dog breed native to Cuba, are vivacious and sociable companions and are especially popular with American city dwellers.",
    "The Leonberger is a lush-coated giant of German origin. They have a gentle nature and serene patience and they relish the companionship of the whole family.",
    "The Mudi is an extremely versatile, intelligent, alert, agile, all-purpose Hungarian farm dog. The breed is a loyal protector of property and family members without being overly aggressive.",
    "From Norway's rocky island of Vaeroy, the uniquely constructed Norwegian Lundehund is the only dog breed created for the job of puffin hunting. With puffins now a protected species, today's Lundehund is a friendly, athletic companion.",
    "The Pharaoh Hound, ancient \"Blushing Dog\" of Malta, is an elegant but rugged sprinting hound bred to course small game over punishing terrain. Quick and tenacious on scent, these friendly, affectionate hounds settle down nicely at home.",
    "A solidly compact dog of vivid personality, the Scottish Terrier is an independent, confident companion of high spirits. Scotties have a dignified, almost-human character.",
    "The Tosa's temperament is marked by patience, composure, boldness and courage. He is normally a tranquil, quiet, and obedient dog, with a calm but vigilant demeanor."]
    
    // Create dictionary combining names and descriptions
    var dogDict: [String: String] {
        Dictionary(uniqueKeysWithValues: zip(dogNames, dogDescriptions))
    }
    
    // State property to track selected dog
    @State private var selectedDog: String? = nil
    
    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                // Instruction text
                Text("Tap on a dog to learn more!")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding(.top, 10)
                    .padding(.horizontal)
                
                // Dog images in a 3-column grid
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 15) {
                    ForEach(dogNames, id: \.self) { dog in
                        VStack(spacing: 5) {
                            Image(dog)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 80)
                                .cornerRadius(8)
                                .shadow(radius: 3)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(selectedDog == dog ? Color.blue : Color.clear, lineWidth: 2)
                                )
                            
                            Text(dog)
                                .font(.caption2)
                                .fontWeight(.medium)
                                .multilineTextAlignment(.center)
                                .lineLimit(2)
                                .frame(width: 80)
                        }
                        .onTapGesture {
                            selectedDog = dog
                        }
                    }
                }
                .padding(.horizontal)
                
                // Description of selected dog
                if let selectedDog = selectedDog, let description = dogDict[selectedDog] {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(selectedDog)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                        
                        Text(description)
                            .font(.body)
                            .lineSpacing(4)
                    }
                    .padding()
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    .transition(.opacity)
                } else {
                    Text("Select a dog breed to see its description")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .italic()
                        .padding()
                }
                
                Spacer()
            }
        }
        .animation(.easeInOut(duration: 0.3), value: selectedDog)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

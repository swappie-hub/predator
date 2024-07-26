//
//  ContentView.swift
//  JPApexPredators
//
//  Created by Swapnil Chatterjee on 24/07/24.
//

import SwiftUI
import MapKit
struct ContentView: View {
   
    @State var searchText = ""
    @State var aphabetical = false
    @State var currentSelection = PredatorType.all
    
    
    let predators = Predators()
    var filteredDinos:[ApexPredator]{
        predators.filter(by: currentSelection)
        predators.sort(by: aphabetical)
        return predators.search(for: searchText)
    }
    var body: some View {
        NavigationStack{
            
            List(filteredDinos) {
                predator in
                NavigationLink {
                    
                    PredatorDetail(predator: predator, position: MapCameraPosition.camera(MapCamera(centerCoordinate: predator.location, distance: 30000)))
                    
                }label: {
                    
                    
                    HStack{
                        //Dinosaur image
                        Image(predator.image).resizable().scaledToFit()
                            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/,height: 100).shadow(color:.white, radius:1)
                        VStack(alignment:.leading) {
                            
                            // Name
                            Text(predator.name).fontWeight(.bold)
                            // Type
                            Text(predator.type.rawValue.capitalized).font(.subheadline).fontWeight(.semibold).padding(.horizontal,13).padding(.vertical,5).background(predator.type.background).clipShape(.capsule)
                            
                        }
                    }
                }
            }
            .navigationTitle("Apex Predatiors")
            .searchable(text: $searchText)
            .autocorrectionDisabled()
            .animation(.spring, value : searchText)
            .toolbar{
                ToolbarItem(placement: .topBarLeading ) {
                    Button{
                        withAnimation {
                            aphabetical.toggle()
                        }
                    }label: {
                        
                        Image(systemName:  aphabetical  ? "film"  : "textformat" )
                            .symbolEffect(.variableColor, value: aphabetical)
                       
                        
                    }
                }
                ToolbarItem(placement: .topBarTrailing ) {
                    Menu{
                        Picker("Filter", selection: $currentSelection.animation(.bouncy)){
                            ForEach(PredatorType.allCases) { type in
                                Label(type.rawValue.capitalized,systemImage: type.icon
                                )
                            }
                        }
                    }label: {
                        
                        Image(systemName:  "slider.horizontal.3" )
                    }
                }
                
            }
        } .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    ContentView()
}

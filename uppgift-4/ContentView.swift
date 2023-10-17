//
//  ContentView.swift
//  uppgift-4
//
//  Created by Hendrik on 2023-10-16.
//

/**
 Skapa nytt projekt i Xcode. DONE
 Hitta två bilder på nätet med bilder på två olika djur. DONE
 Ta färdig modell för bildigenkänning på https://developer.apple.com/machine-learning/models/
 I projektet lägg in två knappar. Klicka på de olika knappar tar de bilder som du tagit på nätet och använder i modellen. DONE
 Skriv ut resultatet i större text under knapparna. DONE
 Lägg up projektet publikt på github och klista in länk nedan. DONE
 https://github.com/HendrikRuijter/publik-uppgift-4/tree/main
 */

import SwiftUI

struct ContentView: View {
    @State var result = ""
    
    var body: some View {
        VStack {
            Text("MobileNet v2 Model")
            Spacer()
            Button(action: {
                let mobile_net_model = MobileNetModel()
                result = mobile_net_model.predictImage(image_name: "dog1")
            }) {
                Text("One dog")
                    .font(.title2)
                    .padding()
            }
            Button(action: {
                let mobile_net_model = MobileNetModel()
                result = mobile_net_model.predictImage( image_name: "dog2")
            }) {
                Text("Another dog")
                    .font(.title2)
                    .padding()
            }
            Spacer()
            Text(result)
                .font(.title)
                .multilineTextAlignment(.center)
        }
        .padding()
        /** TODO Remove
        .onAppear() {
            let mobile_net_model = MobileNetModel()
            mobile_net_model.predictImage()
        }
         */
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

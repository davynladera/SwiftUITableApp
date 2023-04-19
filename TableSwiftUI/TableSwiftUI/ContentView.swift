//
//  ContentView.swift
//  TableSwiftUI
//
//  Created by Ladera, Davyn B on 4/12/23.
//

import SwiftUI

import MapKit

let data = [
    Item(name: "Starry Night", artist: "Vincent Van Gogh", desc: "Van Gogh's famous 'Starry Night' features an abstraction of the night's landscape. Layers of blue and yellow oil paint swirl into one another creating a mystical image of the night sky. Of Van Gogh's many works, this is considered his most infamous piece.", lat: 40.7614, long: -73.9776, imageName: "starry", medium: "Oil paint on canvas", year: "1889", museum: "MoMa (Museum of Modern Art)"),
    Item(name: "Hang Onto the Wind and Trust", artist: "Don Reitz", desc: "Reitz focuses on pushing narrative as each of his pieces tells a story. He utilizes the surface of each piece exentuating tears and groves to create highly textured and decorated works. Even the firing process altered the clay's form through wood firing.", lat: 34.0612, long: -117.7508, imageName: "hang", medium: "Vitreous Engobes, Clay", year: "1984", museum: "AMOCA (The American Museum of Ceramic Art)"),
    Item(name: "Horse's Skull with Pink Rose", artist: "Georgia O'Keefe", desc: "Georgia O'Keefe is well-known for her use of skeletal or floral subjects in her paintings. 'Horse Skull with Rose'  is known as one of her most mystiying pieces.While, critics saw a morbid fascination for death, O'Keefe always insisted on her work acting as a celebration of life.", lat: 34.0639, long: -118.3592, imageName: "okeefe", medium: "Oil paint on canvas", year: "1931", museum: "LACMA (Los Angeles County Museum of Art)"),
    Item(name: "Back of the Neck", artist: "Jean-Michel Basquiat", desc: "Back of the Neck' is one of Basquiat's few screenprints. It features Basquiat's trademarked three-point crown and his intrigue into anatomy. It also alludes to his love of Leonardo de Vinci as if creating a study of anatomical arms in his own right.", lat: 40.7830, long: -73.9590, imageName: "neck", medium: "Screen print with hand-coloring on paper", year: "1983", museum: "The Guggenheim Museum"),
    Item(name: "Medea's Hypostases lll", artist: "Geta Brătescu", desc: "Geta Brătescu was a Romanian artist that utilized various mediums throughout her career and was awarded an honorary doctorate for her contributions to Romanian conteporary art. Many of her works criticized the censorship of her society and eventually focused on topics of self-identity and dematerialisation as well. It was in the 1980's that she began her textile work where she would 'draw with a sewing machine.'", lat: 40.7614, long: -73.9776, imageName: "geta", medium: "Drawing with sewing machine on textile", year: "1980", museum: "MoMa (Museum of Modern Art)")
   
]

struct Item: Identifiable {
        let id = UUID()
        let name: String
        let artist: String
        let desc: String
        let lat: Double
        let long: Double
        let imageName: String
        let medium: String
        let year: String
        let museum: String
    }

struct DetailView: View {
    @State private var region: MKCoordinateRegion
    
    init(item: Item) {
        self.item = item
        _region = State(initialValue: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long), span: MKCoordinateSpan(latitudeDelta: 0.20, longitudeDelta: 0.20)))
    }
    
    let item: Item
            
    var body: some View {
        VStack {
            Image(item.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 200)
            Text("Artist: \(item.artist)")
                .font(.subheadline)
            Text("Medium: \(item.medium)")
                .font(.subheadline)
            Text("Year: \(item.year)")
                .font(.subheadline)
            Text("Museum: \(item.museum)")
                .font(.subheadline)
            Text("Description: \(item.desc)")
                .font(.subheadline)
                .padding(10)
            Map(coordinateRegion: $region, annotationItems: [item]) { item in
                    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)) {
                        Image(systemName: "mappin.circle.fill")
                            .foregroundColor(.red)
                            .font(.title)
                            .overlay(
                                Text(item.name)
                                    .font(.subheadline)
                                    .foregroundColor(.black)
                                    .fixedSize(horizontal: true, vertical: false)
                                    .offset(y: 25)
                            )
                    }
                }
                    .frame(height: 300)
                    .padding(.bottom, -30)
            }
             .navigationTitle(item.name)
             Spacer()
            
        }
  }

struct ContentView: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40.0, longitude: -97.726220), span: MKCoordinateSpan(latitudeDelta: 30.0, longitudeDelta: 30.0))
    var body: some View {
        NavigationView {
            VStack {
                List(data, id: \.name) { item in
                    NavigationLink(destination: DetailView(item: item)) {
                            HStack {
                                Image(item.imageName)
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(10)
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                    Text(item.artist)
                                        .font(.subheadline)
                                    Text(item.museum)
                                        .font(.subheadline)
                                }
                            }

                        // make sure you add the additional curly brace to close the Navigation Link
                        }
                    }
                .listStyle(PlainListStyle())
                .navigationTitle("US Art Pieces")
                Map(coordinateRegion: $region, annotationItems: data) { item in
                                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)) {
                                    Image(systemName: "mappin.circle.fill")
                                        .foregroundColor(.red)
                                        .font(.title)
                                        .overlay(
                                            Text(item.name)
                                                .font(.subheadline)
                                                .foregroundColor(.black)
                                                .fixedSize(horizontal: true, vertical: false)
                                                .offset(y: 25)
                                        )
                                }
                            }
                            .frame(height: 250)
                            .padding(.bottom, -30)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

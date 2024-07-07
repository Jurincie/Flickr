//
//  ContentView.swift
//  FlickrItem
//
//  Created by Ron Jurincie on 7/7/24
//

import SwiftUI

struct ContentView: View {
    @FocusState private var focused: Bool
    @State private var welcome: Welcome? = nil
    @State private var searchTerms = ""
    @State private var searchString = "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&tags="
    var columns = Array(repeating: GridItem(.flexible()),
                        count: 2)

    var body: some View {
        GeometryReader { proxy in
            NavigationStack {
                VStack {
                    VStack(spacing: 0) {
                        Text("Enter Flickr Search terms Below:")
                        TextField("Search Terms", text: $searchTerms)
                            .focused(self.$focused)
                            .onAppear {
                                self.focused = true
                            }
                            .frame(height: 36)
                            .padding(EdgeInsets(top: 0, 
                                                leading: 10,
                                                bottom: 0,
                                                trailing: 6))
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(lineWidth: 2.0)
                            )
                            .onChange(of: searchTerms, perform: { newValue in
                                Task {
                                    do {
                                        if searchTerms.count > 0 {
                                            let endpoint = searchString + searchTerms
                                            welcome = try await DownloadManager.fetch(from: endpoint)
                                        } else {
                                            welcome = nil
                                        }
                                    } catch {
                                        print(error.localizedDescription)
                                    }
                                }
                            })
                        .textFieldStyle(.automatic)
                    }
                    .padding()
                    ScrollView {
                        LazyVGrid(columns:columns) {
                            if let myWelcome = welcome {
                                ForEach(myWelcome.items, id: \.self) { item in
                                    NavigationLink {
                                        DetailView(item: item)
                                    } label: {
                                        AsyncImage(
                                            url: URL(string: item.media.m)!,
                                            transaction: Transaction(
                                                animation: .spring(
                                                    response: 0.5,
                                                    dampingFraction: 0.65,
                                                    blendDuration: 0.025)
                                            )
                                        ){ phase in
                                            switch phase {
                                            case .success(let image):
                                                image
                                                    .resizable()
                                                    .frame(width: proxy.size.width / 2 - 5,
                                                           height: proxy.size.width / 2 - 5)
                                                    .scaledToFill()
                                                    .transition(.scale)
                                            case .failure(_):
                                                ProgressView()
                                            case .empty:
                                                ProgressView()
                                            @unknown default:
                                                ProgressView()
                                            }
                                        }
                                        .navigationTitle("Flickr Search Engine")
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Flickr Search")
        .padding()
    }
}

#Preview {
    ContentView()
}

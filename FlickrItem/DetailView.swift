//
//  DetailView.swift
//  FlickrItem
//
//  Created by Ron Jurincie on 7/7/24.
//

import SwiftUI

struct DetailView: View {
    var item: Item
    var url: URL? {
        URL(string: item.link)
    }
    
    var body: some View {
        VStack {
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
                        .scaledToFit()
                        .transition(.scale)
                    
                case .failure(_):
                    Image(systemName: "photo.circle.fill.red")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 128)
                        .foregroundColor(.teal)
                        .opacity(0.6)
                    
                case .empty:
                    Image(systemName: "photo.circle.fill.red")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 128)
                        .foregroundColor(.teal)
                        .opacity(0.6)
                    
                @unknown default:
                    ProgressView()
                }
            }
            .padding(10)
            ViewThatFits {
                VStack(alignment: .leading) {
                    Text("Author: \(item.author)")
                        .font(.title)
                    Text("Title: \(item.title)")
                        .font(.title)
                    HStack(spacing: 2) {
                        Text("Date:")
                        Text(item.published, style: .date)
                    }
                    .font(.title)
                    .padding(.bottom)
                    VStack {
                        Text("Description:")
                        Text(item.description.stripHTML)
                    }
                    .frame(alignment: .leading)
                    .font(.title)
                }
                VStack(alignment: .leading) {
                    Text("Author: \(item.author)")
                        .font(.headline)
                    Text("Title: \(item.title)")
                        .font(.headline)
                    HStack(spacing: 2) {
                        Text("Date:")
                        Text(item.published, style: .date)
                    }
                    .font(.headline)
                    .padding(.bottom)
                    VStack {
                        Text("Description:")
                        Text(item.description.stripHTML)
                    }
                    .frame(alignment: .leading)
                    .font(.headline)
                }
                VStack(alignment: .leading) {
                    Text("Author: \(item.author)")
                        .font(.caption)
                    Text("Title: \(item.title)")
                        .font(.caption)
                    HStack(spacing: 2) {
                        Text("Date:")
                        Text(item.published, style: .date)
                    }
                    .font(.caption)
                    .padding(.bottom)
                    VStack {
                        Text("Description:")
                        Text(item.description.stripHTML)
                    }
                    .frame(alignment: .leading)
                    .font(.caption)
                }
            }
        }
    }
}

extension String {
    var stripHTML: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
    }
}

//#Preview {
//    DetailView(item: <#Item#>)
//}

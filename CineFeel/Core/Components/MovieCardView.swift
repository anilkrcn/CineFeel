//
//  MovieCardView.swift
//  CineFeel
//
//  Created by Anıl Karacan on 8.05.2026.
//

import SwiftUI

struct MovieCardView: View {

    let movie: Movie

    var body: some View {

        HStack(spacing: 16) {

            AsyncImage(url: movie.posterURL) { image in

                image
                    .resizable()
                    .scaledToFill()

            } placeholder: {

                ProgressView()
            }
            .frame(width: 80, height: 120)
            .clipShape(RoundedRectangle(cornerRadius: 12))

            VStack(alignment: .leading, spacing: 8) {

                Text(movie.title)
                    .font(.headline)
                    .lineLimit(2)

                Text(movie.overview)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(3)
            }

            Spacer()
        }
        .padding(.vertical, 8)
    }
}



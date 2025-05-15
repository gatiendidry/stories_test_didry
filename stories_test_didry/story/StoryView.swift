//
//  StoryView.swift
//  stories_test_didry
//
//  Created by Gatien DIDRY on 15/05/2025.
//

import SwiftUI

struct StoryView: View {

    let username: String

    var story: Story

    var dismiss: () -> Void

    var updateStoryLikeStatus: (Bool) -> Void

    @State var progress: CGFloat = 0

    func manageTime() {
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) {  timer in
            print("Timer fired!")
            if progress == 300 {
                dismiss()
            }
            withAnimation {
                progress += 3
            }
        }
    }

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: story.pictureUrl)!) { content in
                content
                    .resizable()
                    .frame(width: 300, height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            } placeholder: {
                ProgressView()
                    .frame(width: 100)
            }

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
        .overlay(alignment: .top, content: {
            VStack(alignment: .leading) {
                HStack {
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 300, height: 5)

                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: progress, height: 5)
                            .foregroundStyle(.blue)
                    }

                    Spacer()

                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 20, height: 20)
                    }
                }
                Text(username)
            }
            .padding()
        })
        .overlay(alignment: .bottomLeading, content: {

            Image(systemName: story.isLiked ?? false ? "heart.fill" : "heart")
                .onTapGesture {
                    print("ici")
                    updateStoryLikeStatus(true)
                    
                }
                .padding()


        })
        .transition(
            AsymmetricTransition(
                insertion: .scale.animation(.easeInOut)
                , removal: .blurReplace.animation(.linear)))
        .onAppear {
            manageTime()
        }
    }
}

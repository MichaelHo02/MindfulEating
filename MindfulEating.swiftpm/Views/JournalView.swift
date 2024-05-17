//
//  JournalView.swift
//
//
//  Created by Ho Le Minh Thach on 25/02/2024.
//

import SwiftUI
import SwiftData
import Charts

struct JournalView: View {

    @Environment(\.modelContext) var modelContext

    @Query private var sessions: [EatingSessionData]

    @State private var showConcludeSheet: Bool = true

    @Binding var currentView: ContentView.DisplayView

    var body: some View {
        NavigationStack {
            List {
                ForEach(sessions) { session in
                    NavigationLink {
                        ScrollView {
                            VStack(alignment: .leading, spacing: 16) {
                                Text(session.name)
                                    .font(.largeTitle)
                                    .foregroundStyle(Color.accentColor)
                                Text(session.date.formatted(date: .long, time: .shortened))
                                    .font(.callout)
                                    .padding(.bottom)


                                Text("Your reflection")
                                    .font(.headline)
                                Text(session.reflection)

                                Text("Your total dining time: \(timeFormat(session: session))")
                                    .padding(.top)

                                Chart(session.chewPerBite) {
                                    BarMark(
                                        x: .value("Bite", $0.biteId),
                                        y: .value("Chew", $0.chewQty),
                                        width: .automatic
                                    )
                                }
                                .chartXVisibleDomain(length: 3)
                                .chartXScale(domain: .automatic(includesZero: false, reversed: false))
                                .padding(32)

                                Spacer()
                            }
                        }
                        .padding(32)
                    } label: {
                        VStack(alignment: .leading) {
                            Text(session.name)
                                .font(.headline)
                            Text(session.date.formatted(date: .long, time: .shortened))
                        }
                    }
                }
                .onDelete(perform: deleteSessions)
            }
            .navigationTitle("Your Journal")
            .navigationViewStyle(.stack)
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button("Homepage") {
                        currentView = .onboard
                    }
                }
            }
        }
        .sheet(isPresented: $showConcludeSheet) {
            VStack(spacing: 16) {
                Text("Journey's End: Yet, More Awaits!")
                    .font(.largeTitle)
                    .foregroundStyle(Color.accentColor)

                VStack(alignment: .leading) {
                    Text("Thank you for your time! We hope you enjoy using this app. If you have a moment, check out the history list to revisit your past dining experiences.")
                }

                Button {
                    showConcludeSheet = false
                } label: {
                    Label("Close", systemImage: "heart.fill")
                }
                .modifier(FaceTrackingButtonModifier())

                Image("OnboardAuthor")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 400)

                Text("Developed by Ho Le Minh Thach.")
                    .modifier(QuoteAuthorModifier())

                Text(
"""
Credit: Otjánbird Pt. I by Spheriá | https://soundcloud.com/spheriamusic
Music promoted by https://www.chosic.com/free-music/all/
Creative Commons CC BY-SA 3.0
https://creativecommons.org/licenses/by-sa/3.0/
"""
                )
                .font(.footnote)
            }
            .padding(32)
        }
    }

    func deleteSessions(_ indexSet: IndexSet) {
        for index in indexSet {
            let session = sessions[index]
            modelContext.delete(session)
        }
    }

    private func timeFormat(session: EatingSessionData) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .short

        let formattedString = formatter.string(from: TimeInterval(session.totalEatingTime))!
        return formattedString
    }

}

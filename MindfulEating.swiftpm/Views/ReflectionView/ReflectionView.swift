//
//  ReflectionView.swift
//
//
//  Created by Ho Le Minh Thach on 25/02/2024.
//

import SwiftUI
import AudioToolbox

struct ReflectionView: View {

    struct Line {
        var points = [CGPoint]()
        var color: Color = .red
        var lineWidth: Double = 1.0
    }

    @Environment(\.modelContext) var modelContext

    @Binding var currentView: ContentView.DisplayView

    @State private var session: EatingSessionData

    @State private var currentLine = Line()
    @State private var lines: [Line] = []
    @State private var thickness: Double = 2.0

    init(session: EatingSessionData, currentView: Binding<ContentView.DisplayView>) {
        _session = State(initialValue: session)
        _currentView = currentView
    }

    var body: some View {
        GeometryReader { proxy in
            let layout = proxy.size.width > proxy.size.height ? AnyLayout(HStackLayout()) : AnyLayout(VStackLayout())
            layout {
                Form {
                    VStack(alignment: .leading) {
                        Text("Reflection")
                            .foregroundStyle(Color.accentColor)
                            .font(.system(.largeTitle, design: .monospaced))

                        Text("How are you feeling now that you've finished your meal?")
                            .font(.title3)

                        Text("Your total dining time: \(timeFormat())")
                            .padding(.top)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .listRowInsets(EdgeInsets())
                    .background(Color(UIColor.systemGroupedBackground))

                    Section {
                        TextField("The dining name", text: $session.name)
                    } header: {
                        Text("Make your dining memorable with a name")
                    }

                    Section {
                        TextEditor(text: $session.reflection)
                    } header: {
                        Text("Reflection Textbox")
                    } footer: {
                        Text("Write your thought on today mindful eating session")
                    }
                }

                paint
            }
            .overlay(alignment: .bottom) {
                HStack {
                    ColorPickerView(selectedColor: $currentLine.color)
                        .padding()
                        .onChange(of: currentLine.color) { _, newColor in
                            currentLine.color = newColor
                        }
                    Button {
                        let render = ImageRenderer(content: paint.frame(width: 800, height: 800))
                        if let image = render.uiImage {
                            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                            AudioServicesPlaySystemSound(SystemSoundID(1108))
                        }

                        modelContext.insert(session)
                        currentView = .journal
                    } label: {
                        Label("Submit", systemImage: "checkmark.circle.fill")
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.extraLarge)
                    .padding()
                }
                .background(.bar)
                .clipShape(Capsule())
                .shadow(color: .gray.opacity(0.4), radius: 8)
                .padding()
            }
        }
    }

    var paint: some View {
        GeometryReader { proxy in
            Canvas { context, size in
                for line in lines {
                    var path = Path()
                    path.addLines(line.points)
                    context.stroke(path, with: .color(line.color), lineWidth: line.lineWidth)
                }
            }
            .background(Color(uiColor: .tertiarySystemBackground))
            .frame(width: proxy.size.width, height: proxy.size.height)
            .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                .onChanged { value in
                    let newPoint = value.location
                    currentLine.points.append(newPoint)
                    self.lines.append(currentLine)
                }
                .onEnded{ value in
                    self.lines.append(currentLine)
                    self.currentLine = Line(points: [], color: currentLine.color, lineWidth: thickness)
                }
            )
            .overlay(alignment: .top) {
                VStack {
                    Text("This drawing area is for you to express love, gratitude, or jot down any thoughts or feelings you have. We will saved it to your photo library")
                        .font(.callout)
                }
            }
        }
    }

    private func timeFormat() -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .short

        let formattedString = formatter.string(from: TimeInterval(session.totalEatingTime))!
        return formattedString
    }

}

struct ColorPickerView: View {

    let colors = [Color.red, Color.orange, Color.green, Color.blue, Color.purple]
    @Binding var selectedColor: Color

    var body: some View {
        HStack(spacing: 32) {
            ForEach(colors, id: \.self) { color in
                Image(systemName: selectedColor == color ? "record.circle.fill" : "circle.inset.filled")
                    .foregroundColor(color)
                    .font(.largeTitle)
                    .clipShape(Circle())
                    .onTapGesture { selectedColor = color }
            }
        }
    }

}

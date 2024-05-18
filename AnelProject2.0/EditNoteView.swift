import SwiftUI

extension RandomAccessCollection {
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}

struct EditNoteView: View {
    @ObservedObject var notebook: Notebook
    var selectedNoteIndex: Int
    @Binding var newTitle: String
    @Binding var newText: String
    
    var body: some View {
        VStack {
            TextField("Название", text: $newTitle)
                .padding()
            TextField("Текст", text: $newText)
                .padding()
            
            Button(action: {
                if let event = notebook.events[safe: selectedNoteIndex] {
                    let updatedEvent = event
                    updatedEvent.title = newTitle
                    updatedEvent.text = newText
                    notebook.editEvent(event: updatedEvent)
                    notebook.loadEvents()
                }
            }) {
                Text("Сохранить")
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .navigationBarTitle("Редактировать заметку")
    }
}



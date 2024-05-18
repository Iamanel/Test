import SwiftUI
struct CreateNoteView: View {
    @ObservedObject var notebook: Notebook
    @State private var title = ""
    @State private var text = ""
    
    var body: some View {
        VStack {
            TextField("Название", text: $title)
                .padding()
            TextField("Текст", text: $text)
                .padding()
            
            Button(action: {
                let newEvent = Event(title: title, text: text) // Создаем новое событие без указания UUID и creationDate
                notebook.saveEvent(event: newEvent) // Сохраняем событие
                title = ""
                text = ""
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
        .navigationBarTitle("Создать заметку")
    }
}




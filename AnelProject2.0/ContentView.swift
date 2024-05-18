import SwiftUI

struct ContentView: View {
    @StateObject private var notebook: Notebook = {
        let notebook = Notebook()
        notebook.loadEvents()
        return notebook
    }()
    
    @StateObject private var reminderManager = ReminderManager()
    
    @State private var isShowingCreateNoteView = false
    @State private var isShowingEditNoteView = false
    @State private var selectedNoteIndex: Int?
    @State private var newTitle = ""
    @State private var newText = ""
    @Environment(\.presentationMode) private var presentationMode
    @State private var selectedEvent: Event?
    @State private var selectedEventReminderSettingsIndex: Int?

    
    var body: some View {
        let events = notebook.events
        
        NavigationView {
            VStack {
                List {
                    ForEach(events) { event in
                        VStack(alignment: .leading) {
                            Text(event.title)
                                .font(.headline)
                            Text("Created: \(event.creationDate), Text: \(event.text)")
                                .font(.subheadline)
                        }
                        .contextMenu {
                            Button(action: {
                                notebook.deleteEvent(event: event)
                            }) {
                                Text("Удалить")
                            }
                            Button(action: {
                                if let index = events.firstIndex(of: event) {
                                    selectedNoteIndex = index
                                    newTitle = event.title
                                    newText = event.text
                                    isShowingEditNoteView.toggle()
                                }
                            }) {
                                Text("Редактировать")
                            }
                            Button(action: {
                                if let index = events.firstIndex(of: event) {
                                    selectedEvent = event
                                    selectedEventReminderSettingsIndex = index
                                    reminderManager.isShowingSettingsView = true // Показываем настройки уведомлений
                                }
                            }) {
                                Text("Настройки напоминания")
                            }

                        }
                    }
                }
                
                Spacer()
                
                Button(action: {
                    isShowingCreateNoteView.toggle()
                }) {
                    Text("Создать")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()
                .sheet(isPresented: $isShowingCreateNoteView) {
                    CreateNoteView(notebook: notebook)
                }
            }
            .navigationBarTitle("Мои события")
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "arrow.left")
            })
            .sheet(isPresented: $isShowingEditNoteView) {
                EditNoteView(notebook: notebook, selectedNoteIndex: selectedNoteIndex ?? 0, newTitle: $newTitle, newText: $newText)
            }
            .sheet(isPresented: $reminderManager.isShowingSettingsView) {
                if let unwrappedEvent = selectedEvent {
                    ReminderSettingsView(event: unwrappedEvent, notificationScheduled: $reminderManager.notificationScheduled)
                        .environmentObject(reminderManager)
                }

            }
        }
    }
}


#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}


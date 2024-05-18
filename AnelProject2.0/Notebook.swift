import Foundation

class Notebook: ObservableObject {
    @Published var events: [Event] = []
    private let eventsFileName = "events.json"

    // Метод для сохранения события
    func saveEvent(event: Event) {
        events.append(event)
        saveEventsToFile()
    }

    // Метод для загрузки событий
    func loadEvents() {
        if let data = FileManager.default.contents(atPath: eventsFilePath) {
            do {
                let decoder = JSONDecoder()
                events = try decoder.decode([Event].self, from: data)
            } catch {
                print("Error decoding events: \(error)")
            }
        }
    }

    // Метод для редактирования события
    func editEvent(event: Event) {
        guard let index = events.firstIndex(where: { $0.id == event.id }) else { return }
        events[index].title = event.title
        events[index].text = event.text
        
        saveEventsToFile()
    }


    // Метод для удаления события
    func deleteEvent(event: Event) {
        if let index = events.firstIndex(where: { $0.id == event.id }) {
            events.remove(at: index)
            saveEventsToFile()
        }
    }

    // Приватный метод для сохранения событий в файл JSON
    private func saveEventsToFile() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(events)
            try data.write(to: URL(fileURLWithPath: eventsFilePath))
        } catch {
            print("Error encoding or writing events: \(error)")
        }
    }

    // Приватное вычисляемое свойство для пути к файлу JSON с событиями
    private var eventsFilePath: String {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return documentsDirectory.appendingPathComponent(eventsFileName).path
    }
}



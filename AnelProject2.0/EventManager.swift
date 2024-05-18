import Foundation

class EventManager {
    private let fileName = "events.json"
    
    // Путь к файлу JSON
    private var filePath: URL {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDirectory.appendingPathComponent(fileName)
    }
    
    // Загрузка событий из файла
    func loadEvents() -> [Event] {
        guard let data = try? Data(contentsOf: filePath) else { return [] }
        guard let events = try? JSONDecoder().decode([Event].self, from: data) else { return [] }
        return events
    }
    
    // Сохранение событий в файл
    func saveEvents(_ events: [Event]) {
        guard let data = try? JSONEncoder().encode(events) else { return }
        try? data.write(to: filePath)
    }
}

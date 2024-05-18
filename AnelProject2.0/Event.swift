import Foundation

class Event: Identifiable, Codable {
    var id = UUID()
    var title: String
    var creationDate = Date()
    var text: String
    var reminderSettings = ReminderSettings() // Настройки напоминания для каждого события
    
    init(title: String, text: String) {
        self.title = title
        self.text = text
    }
    
    // Реализация протоколов Codable
    enum CodingKeys: String, CodingKey {
        case id, title, creationDate, text, reminderSettings
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        creationDate = try container.decode(Date.self, forKey: .creationDate)
        text = try container.decode(String.self, forKey: .text)
        reminderSettings = try container.decode(ReminderSettings.self, forKey: .reminderSettings)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(creationDate, forKey: .creationDate)
        try container.encode(text, forKey: .text)
        try container.encode(reminderSettings, forKey: .reminderSettings)
    }
}
extension Event: Equatable {
    static func == (lhs: Event, rhs: Event) -> Bool {
        return lhs.id == rhs.id // Используйте любые критерии сравнения, которые вам нужны
    }
}

struct ReminderSettings: Codable {
    var reminderTime = Date()
    var reminderType: String = ReminderType.message.rawValue // Используем строку для типа напоминания
    var notificationScheduled = false
    
    // Реализация протоколов Codable
    enum CodingKeys: String, CodingKey {
        case reminderTime, reminderType, notificationScheduled
    }
    
    init() {} // Добавлен инициализатор по умолчанию
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        reminderTime = try container.decode(Date.self, forKey: .reminderTime)
        reminderType = try container.decode(String.self, forKey: .reminderType)
        notificationScheduled = try container.decode(Bool.self, forKey: .notificationScheduled)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(reminderTime, forKey: .reminderTime)
        try container.encode(reminderType, forKey: .reminderType) // Используем строку для типа напоминания
        try container.encode(notificationScheduled, forKey: .notificationScheduled)
    }
}



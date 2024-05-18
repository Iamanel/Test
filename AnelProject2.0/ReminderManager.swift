import SwiftUI
import UserNotifications

enum ReminderType: String, CaseIterable {
    case message = "Сообщение"
    case alarm = "Звонок будильника"
}

class ReminderManager: ObservableObject {
    @Published var isShowingSettingsView = false
    @Published var reminderTime = Date()
    @Published var reminderType: ReminderType = .message // Установим значение по умолчанию
    @Published var notificationScheduled = false
    @Published var showAlert = false
    
    func scheduleReminder(for event: Event) {
        isShowingSettingsView = true
    }
    
    func createNotification(for event: Event) {
        // Создать контент уведомления
        let content = UNMutableNotificationContent()
        content.title = "Напоминание"
        content.body = event.title
        content.sound = reminderType == .alarm ? UNNotificationSound.defaultCritical : UNNotificationSound.default
        
        // Создать триггер для уведомления с указанной датой и временем
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: reminderTime)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        
        // Создать запрос на уведомление с контентом и триггером
        let request = UNNotificationRequest(identifier: "\(event.id)", content: content, trigger: trigger)
        
        // Запланировать уведомление
        UNUserNotificationCenter.current().add(request) { error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error scheduling notification: \(error.localizedDescription)")
                } else {
                    print("Notification scheduled successfully")
                    self.notificationScheduled = true
                    self.showAlert = true
                }
            }
        }
    }
}


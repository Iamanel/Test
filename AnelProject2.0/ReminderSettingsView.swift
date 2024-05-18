import SwiftUI

struct ReminderSettingsView: View {
    @EnvironmentObject var reminderManager: ReminderManager
    var event: Event
    @Binding var notificationScheduled: Bool
    
    var body: some View {
        VStack {
            DatePicker("Выберите дату и время", selection: $reminderManager.reminderTime, displayedComponents: [.date, .hourAndMinute])
                .labelsHidden()
                .datePickerStyle(GraphicalDatePickerStyle())
            
            Picker("Тип уведомления", selection: $reminderManager.reminderType) {
                ForEach(ReminderType.allCases, id: \.self) { type in
                    Text(type.rawValue).tag(type)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            Button("Сохранить") {
                reminderManager.createNotification(for: event)
            }
            .padding()
        }
        .padding()
        .alert(isPresented: $reminderManager.showAlert) {
                    Alert(
                        title: Text("Уведомление настроено"),
                        message: Text("Уведомление успешно запланировано."),
                        dismissButton: .default(Text("OK"))
                    )
                }
    }
}











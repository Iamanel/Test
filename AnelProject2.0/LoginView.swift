import SwiftUI
import CoreData
struct LoginView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \User.entity, ascending: true)], animation: .easeInOut)
    private var users: FetchedResults<User>
    
    @State private var email = ""
    @State private var password = ""
    @State private var isLoggedIn = false
    @State private var isRegistering = false
    @State private var errorMessage = ""
    
    var body: some View {
        VStack {
            Text("Вход")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            TextField("Почта", text: $email)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            SecureField("Пароль", text: $password)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Text(errorMessage)
                .foregroundColor(.red)
                .padding()
            
            Button(action: {
                guard !email.isEmpty && !password.isEmpty else {
                    errorMessage = "Please fill in all fields"
                    return
                }

                // Поиск пользователя по введенному email
                if let user = users.first(where: { $0.email == email }) {
                    // Проверка совпадения пароля
                    if user.password == password {
                        isLoggedIn = true // Вход успешен
                        print("User is logged in: \(isLoggedIn)")
                    } else {
                        errorMessage = "Invalid email or password"
                    }
                } else {
                    errorMessage = "User not found"
                }
            }) {
                Text("Войти")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
            
            Button(action: {
                isRegistering = true
            }) {
                Text("Регистрация")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .cornerRadius(10)
            }
            .padding()
            
            Spacer()
        }
        .padding()
        .sheet(isPresented: $isRegistering) {
            RegistrationView()
        }
        // Отображаем ContentView после успешного входа
        .fullScreenCover(isPresented: $isLoggedIn) {
            ContentView()
        }
    }
}



struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}





import SwiftUI

struct RegistrationView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var registrationCompleted = false
    @State private var errorMessage = ""

    var body: some View {
        VStack {
            Text("Registration")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            TextField("Имя", text: $firstName)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Фамилия", text: $lastName)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            TextField("Почта", text: $email)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            SecureField("Пароль", text: $password)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button(action: {
                guard !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty && !password.isEmpty else {
                    errorMessage = "Please fill in all fields"
                    return
                }

                let newUser = User(context: viewContext)
                newUser.firstName = firstName
                newUser.lastName = lastName
                newUser.email = email
                newUser.password = password
                
                do {
                    try viewContext.save()
                    registrationCompleted = true
                } catch {
                    print("Error saving user: \(error)")
                }
            }) {
                Text("Зарегистриловаться")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
            
            Spacer()
        }
        .padding()
        .alert(isPresented: $registrationCompleted) {
            Alert(title: Text("Success"), message: Text("Registration completed"), dismissButton: .default(Text("OK")))
        }
    }
}

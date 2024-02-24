
import SwiftUI

struct ContentView: View {
    @State private var  email = ""
    @State private var password = ""
    @State private var wrongUsername: Float = 0
    @State private var wrongPassword: Float  = 0
    @State private var showingLoginScreen = false
    @EnvironmentObject var vm : regvm
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.blue
                    .ignoresSafeArea()
                Circle()
                    .scale(1.7)
                    .foregroundColor(.white.opacity(0.15))
                Circle()
                    .scale(1.35)
                    .foregroundColor(.white)

                VStack {
                    Text("Login")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    
                    TextField("email", text: $email)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(.red, width: CGFloat(wrongUsername))
                        
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(.red, width: CGFloat(wrongPassword))
                    
                    Button("Login") {
                        if (vm.authenticateUser(email: email, password: password))
                        {
                            showingLoginScreen=true
                            email=""
                            password=""
                        }
                            else
                        {
                                showingLoginScreen=false
                                wrongUsername=2
                                wrongPassword=2
                        }
                        }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
                    
                    Text("New around here?")
                    NavigationLink("Create An Account", destination:RegisterView())
                    //****
                    NavigationLink(destination: todo(), isActive: $showingLoginScreen) {
                        
                    EmptyView()
                    }
                }
            }.navigationBarHidden(true)
            .accentColor(.black)
           
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



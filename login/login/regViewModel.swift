import Foundation
import SwiftUI
import CoreData

class regvm : ObservableObject {
    
    let container : NSPersistentContainer
    let context : NSManagedObjectContext
    
    init(){
        container = NSPersistentContainer(name: "") // Provide your model name here
        container.loadPersistentStores { descriptor, error in
            if error != nil {
                print("Error loading coreData")
            }
        }
        context = container.viewContext
    }
    
    
    //add user
    
    
    func addUser(name: String, password: String, email: String) -> Bool {
        // Validate email format
        guard isValidEmail(email) else {
            print("Invalid email format.")
            return false
        }
        
        let userDetails = UserDetails(context: context)
        userDetails.username = name
        userDetails.email = email
        userDetails.password = password
        
        do {
            try context.save()
            return true
        } catch {
            print("User saving error:", error)
            return false
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        // Regular expression pattern for email validation
        let emailRegex = #"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"#
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    
    //login
    
    
    func authenticateUser(email: String, password: String) -> Bool {
        guard !email.isEmpty, !password.isEmpty else {
            print("Email or password cannot be empty.")
            return false
        }
        
        let fetchRequest: NSFetchRequest<UserDetails> = UserDetails.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@ AND password == %@", email, password)
        
        do {
            let users = try context.fetch(fetchRequest)
            if let _ = users.first {
                return true
            } else {
                return false
            }
        } catch {
            print("Error in fetching data: \(error)")
            return false
        }
    }
    
    func saveData() {
        do {
            try context.save()
        } catch {
            print("Error Saving...")
        }
    }
}


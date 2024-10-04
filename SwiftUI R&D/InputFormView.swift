//
//  InputFormView.swift
//  SwiftUI R&D
//
//  Created by Rezaul Islam on 4/10/24.
//

import SwiftUI

struct InputFormView: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var fullName: String = ""
    @State private var phoneNumber: String = ""
    @State private var email: String = ""
    @State private var bio: String = ""
    @State private var details: String = ""
    @State private var details2: String = ""
    
    @FocusState private var focusedField: Field?

    var body: some View {
        ScrollViewReader { sp in
            VStack {
                ScrollView {
                    VStack(spacing: 12) {
                        Image(systemName: "scribble.variable")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .padding(32)
                            .background(.green)
                            .clipShape(Circle())
                            .padding()
                        
                        VStack {
                            TextField("First Name", text: $firstName)
                                .focused($focusedField, equals: .firstName)
                                .textFieldStyle()
                            
                            TextField("Last Name", text: $lastName)
                                .focused($focusedField, equals: .lastName)
                                .textFieldStyle()
                            
                            TextField("Full Name", text: $fullName)
                                .focused($focusedField, equals: .fullName)
                                .textFieldStyle()
                            
                            TextField("Email", text: $email)
                                .focused($focusedField, equals: .email)
                                .textFieldStyle()
                            
                            TextField("Phone number", text: $phoneNumber)
                                .focused($focusedField, equals: .phoneNumber)
                                .textFieldStyle()
                            
                            TextField("Bio", text: $bio, axis: .vertical)
                                .focused($focusedField, equals: .bio)
                                .keyboardAwarePadding(text: $bio, id: "bio", sp: sp)
                                .textFieldStyle()
                            
                            TextField("Enter details", text: $details, axis: .vertical)
                                .focused($focusedField, equals: .details)
                                .keyboardAwarePadding(text: $details, id: "details", sp: sp)
                                .textFieldStyle()
                            
                            TextField("What's on your mind", text: $details2, axis: .vertical)
                                .focused($focusedField, equals: .details2)
                                .keyboardAwarePadding(text: $details2, id: "onMind", sp: sp)
                                .textFieldStyle()
                        }
                    }
                    .font(.system(size: 14, weight: .regular, design: .rounded))
                    .padding(.horizontal)
                }
                
                Button {
                    // Save action
                } label: {
                    Text("Save")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(.green)
                        .cornerRadius(30)
                }
                .padding(.horizontal)
            }
            .onChange(of: focusedField) { newValue in
                if newValue == .details {
                    details = ""
                }
                if newValue == .details2 {
                    details2 = ""
                }
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Button("Previous") {
                    switchToPreviousField()
                }
                .disabled(focusedField == .firstName)
                
                Button("Next") {
                    switchToNextField()
                    if focusedField == .bio{
                        details = " "
                    }
                    if focusedField == .details{
                        details2 = " "
                    }
                }
                .disabled(focusedField == .details2)
                
                Spacer()
                
                Button("Done") {
                    focusedField = nil
                }
            }
        }
    }
    
    private func switchToPreviousField() {
        withAnimation {
            focusedField = focusedField?.previous
        }
    }
    
    private func switchToNextField() {
        withAnimation {
            focusedField = focusedField?.next
        }
    }
    
    // Enum for each field
    private enum Field: Hashable {
        case firstName, lastName, fullName, email, phoneNumber, bio, details, details2

        var next: Field? {
            switch self {
            case .firstName: return .lastName
            case .lastName: return .fullName
            case .fullName: return .email
            case .email: return .phoneNumber
            case .phoneNumber: return .bio
            case .bio: return .details
            case .details: return .details2
            case .details2: return nil
            }
        }

        var previous: Field? {
            switch self {
            case .firstName: return nil
            case .lastName: return .firstName
            case .fullName: return .lastName
            case .email: return .fullName
            case .phoneNumber: return .email
            case .bio: return .phoneNumber
            case .details: return .bio
            case .details2: return .details
            }
        }
    }
}

// Modifier for styling text fields
extension View {
    func textFieldStyle() -> some View {
        self.padding()
            .background(Color.green.opacity(0.1))
            .cornerRadius(16)
    }
}


#Preview {
    InputFormView()
}

 


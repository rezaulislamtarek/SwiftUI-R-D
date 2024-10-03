//
//  InputFormView.swift
//  SwiftUI R&D
//
//  Created by Rezaul Islam on 4/10/24.
//

import SwiftUI

struct InputFormView: View {
    @State private var firstName : String = ""
    @State private var lastName : String = ""
    @State private var fullName : String = ""
    @State private var phoneNumber : String = ""
    @State private var email : String = ""
    @State private var bio : String = ""
    @State private var details : String = ""
    @State private var details2 : String = ""
    var body: some View {
        ScrollViewReader { sp in
            VStack{
                ScrollView {
                    VStack(spacing: 12){
                        Image(systemName: "scribble.variable")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .padding(32)
                            .background(.green)
                            .clipShape(Circle())
                            .padding()
                        
                        VStack{
                           // Section{
                                TextField("First Name", text: $firstName)
                                .padding()
                                .background(Color.green.opacity(0.1))
                                .cornerRadius(16)
                            
                                TextField("Last Name", text: $lastName)
                                .padding()
                                .background(Color.green.opacity(0.1))
                                .cornerRadius(16)
                            
                                TextField("Full Name", text: $fullName)
                                .padding()
                                .background(Color.green.opacity(0.1))
                                .cornerRadius(16)
                            
                            //}
                           // Section{
                                TextField("Email", text: $email)
                                .padding()
                                .background(Color.green.opacity(0.1))
                                .cornerRadius(16)
                            
                                TextField("Phone number", text: $phoneNumber)
                                .padding()
                                .background(Color.green.opacity(0.1))
                                .cornerRadius(16)
                          //  }
                          //  Section{
                                TextField("Bio", text: $bio, axis: .vertical)
                                .padding()
                                .background(Color.green.opacity(0.1))
                                .cornerRadius(16)
                                .keyboardAwarePadding(text: $bio, id: "bio", sp: sp)
                                 
                            
                            
                            TextField("Enter details", text: $details, axis: .vertical)
                                                    .padding()
                                                    .background(Color.green.opacity(0.1))
                                                    .cornerRadius(16)
                                                    .keyboardAwarePadding(text: $details, id: "details", sp: sp)
                                                    
                            
                             
                            
                            TextField("Whats on your mind", text: $details2, axis: .vertical)
                                .padding()
                                .background(Color.green.opacity(0.1))
                                .cornerRadius(16)
                                .keyboardAwarePadding(text: $details2, id: "onMind", sp: sp)
                                      
                            
                        }
                        
                    }
                    .font(.system(size: 14, weight: .regular, design: .rounded))
                    .padding(.horizontal)
                }
                
                Button {
                    
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
        }
          
    }
}

#Preview {
    InputFormView()
}

 

// Custom ViewModifier for reusable behavior
struct KeyboardAwareModifier: ViewModifier {
    
    @Binding var text: String
    let id: String
    let sp: ScrollViewProxy
    
    func body(content: Content) -> some View {
        content
            .id(id)
            .onChange(of: text) { _ in
                withAnimation(.easeOut(duration: 0.3)) {
                    sp.scrollTo(id, anchor: .bottom)
                }
            }
    }
}

// A convenience method to apply the modifier
extension View {
    func keyboardAwarePadding(  text: Binding<String>, id: String, sp: ScrollViewProxy) -> some View {
        self.modifier(KeyboardAwareModifier(  text: text, id: id, sp: sp))
    }
}

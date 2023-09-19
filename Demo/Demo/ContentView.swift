//
//  ContentView.swift
//  Demo
//
//  Created by Darvish Kamalia on 9/13/23.
//

import SwiftUI

struct ContentView: View {
    var privateKey = "private key here"
    var feeRecord = """
        fee record here 
    """

    @State var shouldCacheKeys = false
    
    @State var programName = ""
    @State var functionName = ""
    
    @State var inputValues: [String] = ["", ""]
    
    @State var outputFieldText = ""
    
    var body: some View {
        VStack {
            TextInput(placeholder: "Program name", text: $programName)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
            
            TextInput(placeholder: "Function name", text: $functionName)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
            
            HStack {
                Text("Inputs")
                Spacer()
                Button {
                    inputValues.append("")
                } label: {
                    Image(systemName: "plus")
                }
                Button {
                    inputValues.removeLast()
                } label: {
                    Image(systemName: "minus")
                }
            }
            ForEach(0 ..< inputValues.count, id: \.self) { index in
                TextField("Input \(index)", text: $inputValues[index])
                    .padding(8)
                    .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(.black, style: StrokeStyle(lineWidth: 1.0)))
            }
            
            Toggle("Cache proving/verifying keys", isOn: $shouldCacheKeys)

            Button("Run program") {
                Task {
                    do {
                        let programText = try await request(endpoint: "program/\(programName)", isPost: false, params: nil)
                        
                        let result = try await executeProgram(
                            privateKeyString: privateKey,
                            program: programText,
                            function: functionName,
                            inputs: inputValues,
                            feeCredits: 1.0,
                            feeRecord: feeRecord,
                            url: "https://vm.aleo.org/api",
                            cache: shouldCacheKeys
                        )
                        print ("Successfully executed program")
                        outputFieldText = result
                        
                        print ("Broadcasting transaction")
                        
                        let transactionId = try await request(endpoint: "transaction/broadcast", isPost: true, params: result)
                        
                        outputFieldText  = "Successfully broadcast transaction \(transactionId)"
                        
                        print("Successfully broadcast transation \(transactionId)")
                    } catch(let error) {
                        print ("Error \n\(error)")
                        outputFieldText = error.localizedDescription
                    }
                }
            }
            
            Text(outputFieldText)
        }
        .padding()
    }
}

private func request(endpoint: String, isPost: Bool, params: String?) async throws -> String {
    var request = URLRequest(url: URL(string: "https://vm.aleo.org/api/testnet3/\(endpoint)")!, cachePolicy: .reloadIgnoringLocalCacheData)

    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
    if isPost, let params = params {
        request.httpBody = params.data(using: .utf8)
    }

    request.httpMethod = isPost ? "POST" : "GET"

    let (data, response) = try await URLSession.shared.data(for: request)
    
    if let urlResponse = response as? HTTPURLResponse, urlResponse.statusCode != 200 {
        print("Error broadcasting transaction")
        
    }
    
    return try JSONDecoder().decode(String.self, from: data)
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

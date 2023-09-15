//
//  ContentView.swift
//  Demo
//
//  Created by Darvish Kamalia on 9/13/23.
//

import SwiftUI

struct ContentView: View {
    var privateKey = "APrivateKey1zkp8vyGbEch6sLZMzqju1YcoZwoW38J9GSANbbrLsiNWUSP"
    var feeRecord = """
       {owner:aleo1a3g7pavunw5nwwx433lhq04jmks6wkvxsdeqw3gn6h8kdrj7wsps3qf90w.private,microcredits:45987280u64.private,_nonce:1250401054121131963735862795638259572533351746000593644303469830546926936712group.public}
    """
    @State var shouldCacheKeys = false
    
    @State var programName = "puzzlecalculator.aleo"
    @State var functionName = "multiply"
    
    @State var inputValues: [String] = ["10i32", "8i32"]
    
    @State var outputFieldText = ""
    
    var body: some View {
        VStack {
            TextField("Program name", text: $programName)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
            
            TextField("Function name", text: $functionName)
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
                        
                        print ("Successfully broadcast transaction \(transactionId)")
                    } catch(let error) {
                        print ("Error executing program\n\(error)")
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
    return try JSONDecoder().decode(String.self, from: data)
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

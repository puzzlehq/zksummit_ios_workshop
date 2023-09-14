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
    
    @State var selectedProgram: Program = .auctionTesting
    @State var inputValues: [String] = ["", ""]
    
    @State var outputFieldText = ""
    
    var body: some View {
        VStack {
            Picker("Choose program", selection: $selectedProgram) {
                Text("Auction Testing").tag(Program.auctionTesting)
                Text("Calculator").tag(Program.calculator)
            }
            
            Text("Function: \(selectedProgram.functionName)")
            
            ForEach(selectedProgram.inputs.indices, id: \.self) { index in
                TextField(selectedProgram.inputs[index], text: $inputValues[index])
            }
            
            Toggle("Cache proving/verifying keys", isOn: $shouldCacheKeys)

            Button("Run program") {
                Task {
                    do {
                        let result = try await executeProgram(
                            privateKeyString: privateKey,
                            program: selectedProgram.programText,
                            function: selectedProgram.functionName,
                            inputs: inputValues,
                            feeCredits: 1.0,
                            feeRecord: feeRecord,
                            url: "https://vm.aleo.org/api",
                            cache: shouldCacheKeys
                        )
                        print ("Successfully executed program")
                        outputFieldText = result
                    } catch(let error) {
                        print ("Error executing program\n\(error)")
                        outputFieldText = error.localizedDescription
                    }
                }
            }
            
            Text(outputFieldText)
        }
        .onChange(of: selectedProgram, perform: { newValue in
            inputValues = Array(repeating: "", count: newValue.inputs.count)
        })
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

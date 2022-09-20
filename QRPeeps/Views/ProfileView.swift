//
//  ProfileView.swift
//  QRPeeps
//
//  Created by William Dupont on 15/09/2022.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct ProfileView: View {
    @State private var name = ""
    @State private var emailAddress = ""
    @State private var qrCode = UIImage()
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    func generateQRCode(from string: String) -> UIImage {
        filter.message = Data(string.utf8)
        
        if let outputImage = filter.outputImage {
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }
        
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    
    func updateQRCode() {
        qrCode = generateQRCode(from: "\(name)\n\(emailAddress)")
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section("Name") {
                    HStack {
                        TextField("Your name...", text: $name)
                            .textContentType(.name)
                            .textInputAutocapitalization(.words)
                            .disableAutocorrection(true)
                        Image(systemName: "person")
                            .foregroundColor(.blue)
                    }
                }
                
                Section("Your email address...") {
                    HStack {
                        TextField("Email address", text: $emailAddress)
                            .textContentType(.emailAddress)
                            .disableAutocorrection(true)
                        Image(systemName: "envelope")
                            .foregroundColor(.blue)
                    }
                }
                
                Section("Your QR code") {
                    HStack {
                        Spacer()
                        Image(uiImage: qrCode)
                            .interpolation(.none)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .padding()
                            .contextMenu {
                                Button {
                                    let imageSaver = ImageSaver()
                                    imageSaver.writeToPhotoAlbum(image: qrCode)
                                } label: {
                                    Label("Save to Photos", systemImage: "square.and.arrow.down")
                                }
                            }
                        Spacer()
                    }
                }
            }
            .navigationTitle("Profile")
            .onAppear(perform: updateQRCode)
            .onChange(of: name) { _ in updateQRCode() }
            .onChange(of: emailAddress) { _ in updateQRCode() }
            
        }
    }
}

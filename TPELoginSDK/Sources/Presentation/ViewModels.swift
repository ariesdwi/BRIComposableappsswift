
import Foundation
import Combine

public class LoginViewModel: ObservableObject {
    @Published public var isLoading: Bool = false
    @Published public var errorMessage: String?
    
    private let loginUseCase: LoginUseCase
    private let config: LoginConfig
    
    public init(loginUseCase: LoginUseCase, config: LoginConfig) {
        self.loginUseCase = loginUseCase
        self.config = config
    }
    
    public func login() {
        isLoading = true
        errorMessage = nil
        
        loginUseCase.executeLogin { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success:
                    // Handle successful login
                    break
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    public func register() {
        isLoading = true
        errorMessage = nil
        
        loginUseCase.executeRegister { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success:
                    // Handle successful registration
                    break
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}

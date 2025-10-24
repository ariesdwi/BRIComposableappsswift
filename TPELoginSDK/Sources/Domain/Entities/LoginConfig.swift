
public struct LoginConfig {
    public let backgroundUrl: String?
    public let backgroundColorHex: String?
    public let title: String
    public let subtitle: String
    public let loginText: String

    public init(
        backgroundUrl: String? = nil,
        backgroundColorHex: String? = nil,   
        title: String,
        subtitle: String,
        loginText: String
    ) {
        self.backgroundUrl = backgroundUrl
        self.backgroundColorHex = backgroundColorHex
        self.title = title
        self.subtitle = subtitle
        self.loginText = loginText
    }
}

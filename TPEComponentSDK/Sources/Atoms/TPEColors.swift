
import SwiftUI


public struct TPEColors {
    // ===== NEUTRAL COLOR =====
    public static let black = Color(red: 0.0, green: 0.0, blue: 0.0)
    public static let white = Color(red: 1.0, green: 1.0, blue: 1.0)
    public static let light10 = Color(red: 0.973, green: 0.976, blue: 0.976)  // #F8F9F9
    public static let light20 = Color(red: 0.918, green: 0.922, blue: 0.922)  // #EAEBEB
    public static let light30 = Color(red: 0.827, green: 0.831, blue: 0.831)  // #D3D4D4
    public static let light40 = Color(red: 0.710, green: 0.714, blue: 0.714)  // #B5B6B6
    public static let light50 = Color(red: 0.639, green: 0.639, blue: 0.639)  // #A3A3A3
    public static let light60 = Color(red: 0.573, green: 0.576, blue: 0.576)  // #929393
    public static let light70 = Color(red: 0.518, green: 0.518, blue: 0.518)  // #848484
    public static let light80 = Color(red: 0.467, green: 0.467, blue: 0.467)  // #777777

    public static let dark10 = Color(red: 0.4, green: 0.4, blue: 0.4)        // #666666
    public static let dark20 = Color(red: 0.322, green: 0.322, blue: 0.322)  // #525252
    public static let dark30 = Color(red: 0.239, green: 0.239, blue: 0.239)  // #3D3D3D
    public static let dark40 = Color(red: 0.161, green: 0.161, blue: 0.161)  // #292929

    public static let primaryColor = Color(red: 0.063, green: 0.471, blue: 0.792)  // #1078CA
    public static let secondaryColor = Color(red: 0.412, green: 0.114, blue: 0.004)  // #691D01E7
    public static let primaryBlue = Color(red: 0.0, green: 0.424, blue: 0.78)       // #006CC7

    // ==== BLUE ====
    public static let blue10 = Color(red: 0.878, green: 0.945, blue: 1.0)    // #E0F1FF
    public static let blue20 = Color(red: 0.651, green: 0.839, blue: 1.0)    // #A6D6FF
    public static let blue30 = Color(red: 0.478, green: 0.761, blue: 1.0)    // #7AC2FF
    public static let blue40 = Color(red: 0.302, green: 0.682, blue: 1.0)    // #4DAEFF
    public static let blue50 = Color(red: 0.129, green: 0.6, blue: 1.0)      // #2199FF
    public static let blue60 = Color(red: 0.0, green: 0.518, blue: 0.956)    // #0084F4
    public static let blue70 = Color(red: 0.0, green: 0.424, blue: 0.78)     // #006CC7
    public static let blue80 = Color(red: 0.0, green: 0.329, blue: 0.608)    // #00549B
    public static let blue90 = Color(red: 0.055, green: 0.412, blue: 0.694)  // #0E69B1
    public static let blue100 = Color(red: 0.0, green: 0.196, blue: 0.361)   // #00325C

    // === YELLOW ===
    public static let yellow10 = Color(red: 1.0, green: 0.996, blue: 0.98)   // #FFFEFA
    public static let yellow20 = Color(red: 0.988, green: 0.949, blue: 0.824) // #FCF2D2
    public static let yellow30 = Color(red: 0.98, green: 0.922, blue: 0.737) // #FAEBBC
    public static let yellow40 = Color(red: 0.976, green: 0.894, blue: 0.651) // #F9E4A6
    public static let yellow50 = Color(red: 0.969, green: 0.867, blue: 0.561) // #F7DD8F
    public static let yellow60 = Color(red: 0.961, green: 0.839, blue: 0.475) // #F5D679
    public static let yellow70 = Color(red: 0.957, green: 0.816, blue: 0.384) // #F4D062
    public static let yellow80 = Color(red: 0.949, green: 0.788, blue: 0.298) // #F2C94C
    public static let yellow90 = Color(red: 0.929, green: 0.722, blue: 0.071) // #EDB812
    public static let yellow100 = Color(red: 0.804, green: 0.62, blue: 0.059) // #CD9E0F

    // === ORANGE ===
    public static let orange10 = Color(red: 1.0, green: 0.976, blue: 0.961)  // #FFF9F5
    public static let orange20 = Color(red: 0.996, green: 0.863, blue: 0.753) // #FEDCC0
    public static let orange30 = Color(red: 0.992, green: 0.792, blue: 0.627) // #FDCAA0
    public static let orange40 = Color(red: 0.992, green: 0.725, blue: 0.502) // #FDB980
    public static let orange50 = Color(red: 0.988, green: 0.655, blue: 0.376) // #FCA760
    public static let orange60 = Color(red: 0.988, green: 0.588, blue: 0.255) // #FC9641
    public static let orange70 = Color(red: 0.984, green: 0.518, blue: 0.129) // #FB8421
    public static let orange80 = Color(red: 0.973, green: 0.451, blue: 0.016) // #F87304
    public static let orange90 = Color(red: 1.0, green: 0.443, blue: 0.016)   // #FF7104
    public static let orange100 = Color(red: 0.745, green: 0.345, blue: 0.016) // #BE5804

    // === GREEN ===
    public static let green10 = Color(red: 0.953, green: 0.988, blue: 0.969)  // #F3FCF7
    public static let green20 = Color(red: 0.761, green: 0.945, blue: 0.839)  // #C2F1D6
    public static let green30 = Color(red: 0.643, green: 0.922, blue: 0.761)  // #A4EBC2
    public static let green40 = Color(red: 0.525, green: 0.894, blue: 0.678)  // #86E4AD
    public static let green50 = Color(red: 0.404, green: 0.867, blue: 0.6)    // #67DD99
    public static let green60 = Color(red: 0.286, green: 0.839, blue: 0.522)  // #49D685
    public static let green70 = Color(red: 0.18, green: 0.8, blue: 0.443)     // #2ECC71
    public static let green80 = Color(red: 0.153, green: 0.682, blue: 0.376)  // #27AE60
    public static let green90 = Color(red: 0.133, green: 0.596, blue: 0.329)  // #229854
    public static let green100 = Color(red: 0.098, green: 0.443, blue: 0.243) // #19713E

    // === RED ===
    public static let red10 = Color(red: 0.988, green: 0.906, blue: 0.906)    // #FCE7E7
    public static let red20 = Color(red: 0.976, green: 0.812, blue: 0.812)    // #F9CFCF
    public static let red30 = Color(red: 0.965, green: 0.718, blue: 0.718)    // #F6B7B7
    public static let red40 = Color(red: 0.957, green: 0.624, blue: 0.624)    // #F49F9F
    public static let red50 = Color(red: 0.945, green: 0.533, blue: 0.533)    // #F18888
    public static let red60 = Color(red: 0.933, green: 0.439, blue: 0.439)    // #EE7070
    public static let red70 = Color(red: 0.922, green: 0.345, blue: 0.345)    // #EB5858
    public static let red80 = Color(red: 0.91, green: 0.251, blue: 0.251)     // #E84040
    public static let red90 = Color(red: 0.894, green: 0.122, blue: 0.122)    // #E41F1F
    public static let red100 = Color(red: 0.984, green: 0.38, blue: 0.086)    // #FB61616 (corrected)

    // === OTHERS ===
    public static let transparent = Color.clear
}

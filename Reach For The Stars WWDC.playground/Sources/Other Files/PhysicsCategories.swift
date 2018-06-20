import Foundation

struct PhysicsCategory {
    static let None   : UInt32 = 0
    static let All    : UInt32 = UInt32.max
    static let Planet : UInt32 = 0b001
    static let Rocket : UInt32 = 0b010
    static let Star   : UInt32 = 0b011
    static let Gravity: UInt32 = 0b100
    static let Edge   : UInt32 = 0b101
}

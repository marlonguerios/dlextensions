import Foundation
import SwiftUI
import UIKit

extension Color {
    static let sunrise = Color(red: 255/255, green: 207/255, blue: 15/255)
    static let sunset = Color(red: 209/255, green: 114/255, blue: 6/255)
    static let lightBorderColor = Color(red: 230/255, green: 230/255, blue: 230/255)
    static let superLightGray = Color(red: 245/255, green: 245/255, blue: 245/255)
    static let darkBorderColor = Color(red: 50/255, green: 50/255, blue: 50/255)
    static let tagBorderColor = Color(red: 191/255, green: 3/255, blue: 3/255)
    static let tagBgColor = Color(red: 247/255, green: 230/255, blue: 230/255)
    static let tagFgColor = Color(red: 142/255, green: 2/255, blue: 2/255)
    #if os(iOS)
        static let buttonFgColor = Color.init(UIColor.systemRed)
    #endif
    static let nameFgColorLight = Color.black
    static let nameFgColorDark = Color.white
    static let doneGreen = UIColor(red: 35/255, green: 120/255, blue: 53/255, alpha: 1)
    static let contactName = Color(red: 46/255, green: 80/255, blue: 143/255)
    static let offWhite = Color(red: 240 / 255, green: 240 / 255, blue: 240 / 255)
    static let nowEvent = Color(red: 255 / 255, green: 234 / 255, blue: 234 / 255)
    
    static let lightGray = Color("lightGray")
    
    static func getNameColor(colorScheme: ColorScheme) -> Color {
        if colorScheme == ColorScheme.light {
            return Color.nameFgColorLight
        } else {
            return Color.nameFgColorDark
        }
    }
    
    static func getListBorderColor(colorScheme: ColorScheme) -> Color {
        if colorScheme == ColorScheme.light {
            return Color.lightBorderColor
        } else {
            return Color.darkBorderColor
        }
    }
    
    static func getStartGradientColor(colorScheme: ColorScheme) -> Color {
        if colorScheme == ColorScheme.light {
            return Color.lightBorderColor
        } else {
            return Color.darkBorderColor
        }
    }
    
    static func getEndGradientColor(colorScheme: ColorScheme) -> Color {
        if colorScheme == ColorScheme.light {
            return Color.white
        } else {
            return Color.black
        }
    }
    
    static func getBorderColor(colorScheme: ColorScheme) -> Color {
        if colorScheme == ColorScheme.light {
            return Color.lightBorderColor
        } else {
            return Color.darkBorderColor
        }
    }
}

extension Date {
    
    public var startOfYesterday: Date {
        var components = DateComponents()
        components.day = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }
    
    public var endOfYesterday: Date {
        var components = DateComponents()
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }
    
    public var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    public var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }
    
    public var startOfTomorrow: Date {
        var components = DateComponents()
        components.second = 1
        return Calendar.current.date(byAdding: components, to: endOfDay)!
    }
    
    public var endOfTomorrow: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfTomorrow)!
    }
    
    public var startOfMonth: Date {
        let components = Calendar.current.dateComponents([.year, .month], from: startOfDay)
        return Calendar.current.date(from: components)!
    }

    public var endOfMonth: Date {
        var components = DateComponents()
        components.month = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfMonth)!
    }
    
    public var startOfWeek: Date {
        let components = Calendar.current.dateComponents([.yearForWeekOfYear, .weekOfYear], from: startOfDay)
        return Calendar.current.date(from: components)!
    }
    
    public var startOfYear: Date {
        let components = Calendar.current.dateComponents([.year], from: startOfDay)
        return Calendar.current.date(from: components)!
    }
    
    func getDay() -> Int {
        return Calendar.current.component(.day, from: self)
    }

    func getYesterdayDay() -> Int {
        var comp = DateComponents()
        comp.day = -1
        return Calendar.current.component(.day, from: Calendar.current.date(byAdding: comp, to: self)!)
    }

    func getTomorrowDay() -> Int {
        var comp = DateComponents()
        comp.day = 1
        return Calendar.current.component(.day, from: Calendar.current.date(byAdding: comp, to: self)!)
    }
    
    func getHour() -> Int {
        return Calendar.current.component(.hour, from: self)
    }
    
    func getMinute() -> Int {
        return Calendar.current.component(.minute, from: self)
    }
    
    func getDecimalTime() -> CGFloat {
        return CGFloat(getHour() + (getMinute()/60))
    }
    
    func dateWithTime(hour: Int, minute: Int) -> Date {
        return Calendar.current.date(bySettingHour: hour, minute: minute, second: 0, of: self)!
    }
}

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}

extension UIImage {

    func colorized(color : UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height);
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0);
        
        let context = UIGraphicsGetCurrentContext();
        context!.translateBy(x: 0, y: self.size.height)
        context!.scaleBy(x: 1.0, y: -1.0)
        context!.draw(self.cgImage!, in: rect)
        context!.clip(to: rect, mask: self.cgImage!)
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let colorizedImage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        return colorizedImage!
    }
}

extension View {
    func border(width: CGFloat, edge: Edge, color: Color) -> some View {
        ZStack {
            self
            EdgeBorder(width: width, edge: edge)
                .foregroundColor(color)
        }
    }
}

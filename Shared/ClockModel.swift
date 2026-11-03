import Foundation
import SwiftUI

// MARK: - Offices

struct Office: Identifiable {
    let id: String
    let name: String
    let timeZone: TimeZone

    static let all: [Office] = [
        Office(id: "cph", name: "Copenhagen",    timeZone: TimeZone(identifier: "Europe/Copenhagen")!),
        Office(id: "tyo", name: "Tokyo",         timeZone: TimeZone(identifier: "Asia/Tokyo")!),
        Office(id: "sfo", name: "San Francisco", timeZone: TimeZone(identifier: "America/Los_Angeles")!),
        Office(id: "nyc", name: "New York",      timeZone: TimeZone(identifier: "America/New_York")!),
    ]
}

// MARK: - Activities (what the cat is doing)

enum Activity: String {
    case sleep, wake, breakfast, sleepyPC, focusedPC, lunch, meeting
    case coffeeBreak, leaving, dinner, relaxing, bedtime, weekend

    var imageName: String {
        switch self {
        case .sleep:       "cat_sleep"
        case .wake:        "cat_wake"
        case .breakfast:   "cat_breakfast"
        case .sleepyPC:    "cat_sleepy_pc"
        case .focusedPC:   "cat_focused_pc"
        case .lunch:       "cat_lunch"
        case .meeting:     "cat_meeting"
        case .coffeeBreak: "cat_coffee_break"
        case .leaving:     "cat_leaving"
        case .dinner:      "cat_dinner"
        case .relaxing:    "cat_relaxing"
        case .bedtime:     "cat_bedtime"
        case .weekend:     "cat_weekend"
        }
    }

    var labelImageName: String { imageName.replacingOccurrences(of: "cat_", with: "label_") }

    var label: String {
        switch self {
        case .sleep:       "Sleeping"
        case .wake:        "Waking up"
        case .breakfast:   "Breakfast"
        case .sleepyPC:    "Warming up"
        case .focusedPC:   "Focused"
        case .lunch:       "Lunch"
        case .meeting:     "Meetings"
        case .coffeeBreak: "Tea break"
        case .leaving:     "Signing off"
        case .dinner:      "Dinner"
        case .relaxing:    "Off duty"
        case .bedtime:     "Bedtime"
        case .weekend:     "Reading"
        }
    }

    var isWorking: Bool {
        [.sleepyPC, .focusedPC, .meeting, .coffeeBreak].contains(self)
    }

    /// Weekday schedule, indexed by local hour (0–23). Office hours: 9:00–17:00.
    private static let weekday: [Activity] = [
        .sleep, .sleep, .sleep, .sleep, .sleep, .sleep, .sleep,     // 0–6
        .wake,                                                      // 7
        .breakfast,                                                 // 8
        .sleepyPC,                                                  // 9
        .focusedPC, .focusedPC,                                     // 10–11
        .lunch,                                                     // 12
        .meeting, .meeting,                                         // 13–14
        .coffeeBreak,                                               // 15
        .focusedPC,                                                 // 16
        .leaving,                                                   // 17
        .relaxing,                                                  // 18
        .dinner,                                                    // 19
        .relaxing, .relaxing,                                       // 20–21
        .bedtime,                                                   // 22
        .sleep,                                                     // 23
    ]

    /// Weekend schedule: lie-in, lazy day.
    private static let weekendSchedule: [Activity] = [
        .sleep, .sleep, .sleep, .sleep, .sleep, .sleep, .sleep, .sleep, .sleep, // 0–8
        .wake,                                                      // 9
        .breakfast,                                                 // 10
        .weekend,                                                   // 11
        .lunch,                                                     // 12
        .weekend, .weekend, .weekend, .weekend,                     // 13–16
        .relaxing, .relaxing,                                       // 17–18
        .dinner,                                                    // 19
        .relaxing, .relaxing,                                       // 20–21
        .bedtime,                                                   // 22
        .sleep,                                                     // 23
    ]

    static func at(hour: Int, isWeekend: Bool) -> Activity {
        (isWeekend ? weekendSchedule : weekday)[hour]
    }
}

// MARK: - Per-office snapshot

struct OfficeState {
    let office: Office
    let date: Date
    let hour: Int
    let minute: Int
    let weekdaySymbol: String
    let dayOffset: Int        // relative to the viewer's local date
    let activity: Activity

    init(office: Office, date: Date) {
        var cal = Calendar(identifier: .gregorian)
        cal.timeZone = office.timeZone
        let c = cal.dateComponents([.hour, .minute, .weekday, .year, .month, .day], from: date)
        self.office = office
        self.date = date
        hour = c.hour ?? 0
        minute = c.minute ?? 0
        let weekday = c.weekday ?? 2
        weekdaySymbol = cal.shortWeekdaySymbols[weekday - 1]
        activity = Activity.at(hour: hour, isWeekend: weekday == 1 || weekday == 7)

        // Day offset relative to the viewer's own calendar date.
        var localCal = Calendar(identifier: .gregorian)
        localCal.timeZone = .current
        let local = localCal.dateComponents([.year, .month, .day], from: date)
        let gmt = TimeZone(identifier: "GMT")!
        var g = Calendar(identifier: .gregorian); g.timeZone = gmt
        if let a = g.date(from: DateComponents(year: c.year, month: c.month, day: c.day)),
           let b = g.date(from: DateComponents(year: local.year, month: local.month, day: local.day)) {
            dayOffset = g.dateComponents([.day], from: b, to: a).day ?? 0
        } else {
            dayOffset = 0
        }
    }

    var timeString: String { String(format: "%d:%02d", hour, minute) }

    /// Fractional hour, used for the sky gradient.
    var hourFraction: Double { Double(hour) + Double(minute) / 60 }
}

// MARK: - Sky (rough day/night, no seasonal variation)

enum Sky {
    // Keyframes: (hour, top color, bottom color)
    private static let keys: [(Double, RGB, RGB)] = [
        (0.0,  RGB(0x0B1026), RGB(0x1B2250)),   // deep night
        (4.5,  RGB(0x0B1026), RGB(0x1B2250)),
        (6.0,  RGB(0x3B3F7A), RGB(0xF29E6D)),   // dawn
        (7.5,  RGB(0x5FA8E8), RGB(0xBFE3F7)),   // morning
        (12.0, RGB(0x3D8FE0), RGB(0xA8D8F5)),   // noon
        (16.5, RGB(0x5B9BD8), RGB(0xC9E2F0)),   // afternoon
        (18.0, RGB(0x6A5A9E), RGB(0xF2955E)),   // sunset
        (19.5, RGB(0x1E2457), RGB(0x4A3E78)),   // dusk
        (21.0, RGB(0x0B1026), RGB(0x1B2250)),   // night
        (24.0, RGB(0x0B1026), RGB(0x1B2250)),
    ]

    static func colors(at h: Double) -> (Color, Color) {
        for i in 0..<(keys.count - 1) where h >= keys[i].0 && h <= keys[i + 1].0 {
            let (h0, t0, b0) = keys[i], (h1, t1, b1) = keys[i + 1]
            let t = (h - h0) / (h1 - h0)
            return (t0.mix(t1, t).color, b0.mix(b1, t).color)
        }
        return (keys[0].1.color, keys[0].2.color)
    }

    static func isDark(at h: Double) -> Bool { h < 6.3 || h > 18.3 }
}

struct RGB {
    let r, g, b: Double
    init(_ hex: Int) {
        r = Double((hex >> 16) & 0xFF) / 255
        g = Double((hex >> 8) & 0xFF) / 255
        b = Double(hex & 0xFF) / 255
    }
    init(r: Double, g: Double, b: Double) { self.r = r; self.g = g; self.b = b }
    func mix(_ o: RGB, _ t: Double) -> RGB {
        RGB(r: r + (o.r - r) * t, g: g + (o.g - g) * t, b: b + (o.b - b) * t)
    }
    var color: Color { Color(red: r, green: g, blue: b) }
}

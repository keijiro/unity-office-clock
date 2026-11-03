import SwiftUI
import WidgetKit

struct ClockEntry: TimelineEntry {
    let date: Date
}

struct ClockProvider: TimelineProvider {
    func placeholder(in context: Context) -> ClockEntry { ClockEntry(date: .now) }

    func getSnapshot(in context: Context, completion: @escaping (ClockEntry) -> Void) {
        completion(ClockEntry(date: .now))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<ClockEntry>) -> Void) {
        // One entry per minute, aligned to minute boundaries, for the next two hours.
        let now = Date.now
        let start = Calendar.current.dateInterval(of: .minute, for: now)?.start ?? now
        let entries = (0..<120).map { ClockEntry(date: start.addingTimeInterval(Double($0) * 60)) }
        completion(Timeline(entries: entries, policy: .atEnd))
    }
}

struct OfficeClockWidgetView: View {
    let entry: ClockEntry

    var body: some View {
        ClockRow(date: entry.date)
            .containerBackground(for: .widget) { Color.black }
    }
}

@main
struct OfficeClockWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "OfficeClockWidget", provider: ClockProvider()) {
            OfficeClockWidgetView(entry: $0)
        }
        .configurationDisplayName("Unity Office Clock")
        .description("Copenhagen, Tokyo, San Francisco and New York — with a cat showing what everyone's up to.")
        .supportedFamilies([.systemExtraLarge])
        .contentMarginsDisabled()
    }
}

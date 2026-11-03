import SwiftUI
import WidgetKit

@main
struct OfficeClockApp: App {
    init() { PreviewRenderer.runIfRequested() }

    var body: some Scene {
        WindowGroup("Office Clock") {
            ContentView()
        }
        .windowResizability(.contentSize)
    }
}

struct ContentView: View {
    @State private var offset: Double = 0   // hours, for scrubbing the preview

    var body: some View {
        TimelineView(.everyMinute) { context in
            let date = context.date.addingTimeInterval(offset * 3600)
            VStack(spacing: 20) {
                ClockRow(date: date)
                    .frame(width: 715, height: 354)
                    .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
                VStack(spacing: 4) {
                    Slider(value: $offset, in: -12...12, step: 0.25) {
                        Text("Preview offset")
                    }
                    Text(offset == 0 ? "Now" : String(format: "%+.2f h", offset))
                        .font(.caption).monospacedDigit().foregroundStyle(.secondary)
                }
                .frame(width: 500)
                Text("Add the widget from the desktop: right-click → Edit Widgets… → Unity Office Clock (extra large)")
                    .font(.footnote).foregroundStyle(.secondary)
            }
            .padding(24)
        }
    }
}

// Debug helper: `OfficeClock --render <hour>` writes a preview PNG of the widget
// at the given local hour (today) to stdout and exits.
enum PreviewRenderer {
    @MainActor static func runIfRequested() {
        let args = CommandLine.arguments
        guard let i = args.firstIndex(of: "--render"), i + 1 < args.count,
              let hour = Double(args[i + 1]) else { return }
        let mode: WidgetRenderingMode = args.contains("--vibrant") ? .vibrant : args.contains("--accented") ? .accented : .fullColor
        let date = Calendar.current.startOfDay(for: .now).addingTimeInterval(hour * 3600)
        let widget = ClockRow(date: date)
            .frame(width: 715, height: 354)
            .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
            .environment(\.clockPreviewMode, mode)
        // --screenshot: transparent background with a desktop-widget-like shadow (for README).
        let view = args.contains("--screenshot")
            ? AnyView(widget
                .shadow(color: .black.opacity(0.18), radius: 2, y: 1)
                .shadow(color: .black.opacity(0.25), radius: 14, y: 6)
                .padding(32))
            : AnyView(widget.padding(10).background(mode == .fullColor ? Color.gray : Color.black))
        let r = ImageRenderer(content: view)
        r.scale = 2
        if let tiff = r.nsImage?.tiffRepresentation,
           let png = NSBitmapImageRep(data: tiff)?.representation(using: .png, properties: [:]) {
            FileHandle.standardOutput.write(png)
        }
        exit(0)
    }
}

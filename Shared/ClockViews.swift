import AppKit
import SwiftUI
import WidgetKit

private struct ClockPreviewModeKey: EnvironmentKey {
    static let defaultValue: WidgetRenderingMode? = nil
}

extension EnvironmentValues {
    var clockPreviewMode: WidgetRenderingMode? {
        get { self[ClockPreviewModeKey.self] }
        set { self[ClockPreviewModeKey.self] = newValue }
    }
}

/// Characters share one continuous sky instead of sitting inside individual cards.
struct ClockRow: View {
    let date: Date
    @Environment(\.widgetRenderingMode) private var systemRenderingMode
    @Environment(\.clockPreviewMode) private var previewMode
    private var renderingMode: WidgetRenderingMode { previewMode ?? systemRenderingMode }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if renderingMode == .fullColor {
                    Color(red: 0.09, green: 0.08, blue: 0.17)
                    HStack(spacing: 0) {
                        ForEach(Office.all) { office in
                            let state = OfficeState(office: office, date: date)
                            let (top, bottom) = Sky.colors(at: state.hourFraction)
                            LinearGradient(colors: [top, bottom.opacity(0.65)], startPoint: .top, endPoint: .bottom)
                        }
                    }
                    .blur(radius: 35)
                    .padding(-35)
                    LinearGradient(colors: [.black.opacity(0.12), .clear, .black.opacity(0.4)], startPoint: .top, endPoint: .bottom)
                }
                HStack(spacing: 0) {
                    ForEach(Office.all) { office in
                        OfficeTile(state: OfficeState(office: office, date: date))
                            .frame(width: geometry.size.width / 4)
                    }
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .clipped()
        }
    }
}

struct OfficeTile: View {
    let state: OfficeState
    @Environment(\.widgetRenderingMode) private var systemRenderingMode
    @Environment(\.clockPreviewMode) private var previewMode
    private var renderingMode: WidgetRenderingMode { previewMode ?? systemRenderingMode }
    private var reduced: Bool { renderingMode != .fullColor }
    private var dark: Bool { Sky.isDark(at: state.hourFraction) }

    var body: some View {
        VStack(spacing: 0) {
            Text(state.office.name)
                .font(.custom("Noteworthy-Bold", size: 19))
                .lineLimit(1)
                .minimumScaleFactor(0.7)
                .padding(.top, 14)
            HStack(spacing: 4) {
                Image(systemName: dark ? "moon.stars.fill" : "sun.max.fill")
                    .font(.system(size: 9))
                Text(dayText)
            }
            .font(.system(size: 11, weight: .medium, design: .rounded))
            .opacity(0.75)
            GeometryReader { geometry in
                ZStack(alignment: .top) {
                    // The character overlaps the lower part of the digits.
                    // The font size is fitted to a two-digit-hour template so that
                    // single-digit hours keep the same height (only narrower).
                    Text(state.timeString)
                        .font(.system(size: Self.timeFontSize(forWidth: geometry.size.width * 0.9),
                                      weight: .semibold).width(.compressed))
                        .monospacedDigit()
                        .lineLimit(1)
                        .minimumScaleFactor(0.9)
                        .tracking(-2)
                        .frame(width: geometry.size.width * 0.9)
                        .scaleEffect(x: 1, y: 1.25, anchor: .top)
                        .padding(.top, -20)
                    ZStack(alignment: .bottom) {
                        artwork(state.activity.imageName)
                            .scaledToFit()
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                            .padding(.bottom, 22)
                        artwork(state.activity.labelImageName)
                            .scaledToFit()
                            .frame(width: geometry.size.width * 0.94, height: 58, alignment: .bottom)
                    }
                    .shadow(color: .black.opacity(reduced ? 0 : 0.22), radius: 5, y: 5)
                    .padding(.top, 44)
                }
            }
                .padding(.horizontal, 3)
                .padding(.bottom, 18)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .foregroundStyle(.white)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("\(state.office.name), \(state.timeString), \(dayText), \(state.activity.label)")
    }

    @ViewBuilder private func artwork(_ name: String) -> some View {
        let image = Image(name).resizable().interpolation(.high)
        if previewMode != nil {
            // ImageRenderer cannot reproduce WidgetKit's compositing pass.
            image.saturation(reduced ? 0 : 1)
        } else {
            image.widgetAccentedRenderingMode(.desaturated)
        }
    }

    /// Font size at which the widest time string ("00:00") fits the given width.
    private static func timeFontSize(forWidth width: CGFloat) -> CGFloat {
        let base: CGFloat = 100
        let font = NSFont.systemFont(ofSize: base, weight: .semibold, width: .compressed)
        let monospaced = font.fontDescriptor.addingAttributes([
            .featureSettings: [[
                NSFontDescriptor.FeatureKey.typeIdentifier: kNumberSpacingType,
                NSFontDescriptor.FeatureKey.selectorIdentifier: kMonospacedNumbersSelector,
            ]],
        ])
        let measured = NSFont(descriptor: monospaced, size: base) ?? font
        let templateWidth = ("00:00" as NSString)
            .size(withAttributes: [.font: measured, .kern: -2]).width
        guard templateWidth > 0 else { return base }
        // Small margin so the two-digit case never hits minimumScaleFactor.
        return base * min(1, max(0.6, width * 0.98 / templateWidth))
    }

    private var dayText: String {
        switch state.dayOffset {
        case 1: "\(state.weekdaySymbol) +1"
        case -1: "\(state.weekdaySymbol) −1"
        default: state.weekdaySymbol
        }
    }
}

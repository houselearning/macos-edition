import SwiftUI
import AppKit

struct HouseLearningFeature: Identifiable {
    let id = UUID()
    let emoji: String
    let title: String
    let detail: String
}

let houseLearningFeatures: [HouseLearningFeature] = [
    HouseLearningFeature(emoji: "📐", title: "Math learning", detail: "Interactive lessons, number games, and practice routines."),
    HouseLearningFeature(emoji: "🔬", title: "Science exploration", detail: "Curiosity-driven learning across biology, physics, and more."),
    HouseLearningFeature(emoji: "💻", title: "Coding challenges", detail: "Beginner-friendly programming with logic and problem solving."),
    HouseLearningFeature(emoji: "🧠", title: "SafeAI tutor", detail: "Age-appropriate study support for classroom and home learning."),
    HouseLearningFeature(emoji: "📚", title: "Teacher tools", detail: "Progress tracking, assignments, and simplified class workflows."),
    HouseLearningFeature(emoji: "🎯", title: "Mac-friendly layout", detail: "Clean desktop navigation built for focus and fast access."),
]

struct ContentView: View {
    var body: some View {
        TabView {
            DashboardView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }

            LearningView()
                .tabItem {
                    Label("Learning", systemImage: "book.fill")
                }

            SafeAIDashboardView()
                .tabItem {
                    Label("SafeAI", systemImage: "sparkles")
                }

            TeacherToolsView()
                .tabItem {
                    Label("Teacher", systemImage: "person.badge.shield.checkmark")
                }
        }
        .frame(minWidth: 1100, minHeight: 760)
        .background(Color(nsColor: NSColor.controlBackgroundColor))
    }
}

struct DashboardView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 22) {
                HeaderCard()

                HStack(spacing: 18) {
                    StatCard(label: "Streak", value: "7 days")
                    StatCard(label: "XP", value: "1,240")
                    StatCard(label: "Completed", value: "18 lessons")
                    StatCard(label: "SafeAI", value: "On")
                }

                VStack(alignment: .leading, spacing: 14) {
                    Text("Featured activities")
                        .font(.title2)
                        .bold()

                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ForEach(houseLearningFeatures.prefix(3)) { feature in
                            FeatureTile(feature: feature)
                        }
                    }
                }

                HStack(alignment: .top, spacing: 18) {
                    RoundedPanel(title: "Recommended next steps") {
                        VStack(alignment: .leading, spacing: 12) {
                            LessonRow(title: "Counting & Numbers", subtitle: "Warm-up practice", time: "12 min")
                            LessonRow(title: "Fractions in Action", subtitle: "Visual math examples", time: "18 min")
                            LessonRow(title: "Intro to Coding", subtitle: "Logic and patterns", time: "20 min")
                        }
                    }

                    RoundedPanel(title: "Quick actions") {
                        VStack(alignment: .leading, spacing: 12) {
                            ActionButton(title: "Open website", icon: "globe", action: {
                                if let url = URL(string: "https://www.houselearning.org/home/houselearning-for-mac.html") {
                                    NSWorkspace.shared.open(url)
                                }
                            })
                            ActionButton(title: "Download request", icon: "arrow.down.circle", action: {
                                if let url = URL(string: "mailto:hello@houselearning.org?subject=HouseLearning%20for%20Mac%20Download%20Request") {
                                    NSWorkspace.shared.open(url)
                                }
                            })
                            ActionButton(title: "SafeAI chat", icon: "sparkles", action: {
                                if let url = URL(string: "https://www.houselearning.org/") {
                                    NSWorkspace.shared.open(url)
                                }
                            })
                        }
                    }
                }
            }
            .padding(24)
        }
    }
}

struct LearningView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Learning library")
                    .font(.title)
                    .bold()

                VStack(alignment: .leading, spacing: 14) {
                    LessonCard(title: "Math", subtitle: "Arithmetic, fractions, geometry, and number fluency", tag: "Core")
                    LessonCard(title: "Science", subtitle: "Hands-on discovery and natural world exploration", tag: "Explore")
                    LessonCard(title: "Coding", subtitle: "Logic building, problem solving, and beginner coding", tag: "Build")
                    LessonCard(title: "Study skills", subtitle: "Better habits, focus, and learning routines", tag: "Growth")
                }
            }
            .padding(24)
        }
    }
}

struct SafeAIDashboardView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                HeaderSmall(title: "SafeAI", subtitle: "Guided educational support")

                RoundedPanel(title: "SafeAI for HouseLearning") {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("SafeAI is the educational assistant for HouseLearning.org and the HouseLearning desktop experience.")
                            .font(.body)
                        Text("It supports math, science, reading, writing, coding, study help, and safe age-appropriate learning questions.")
                            .font(.body)
                        Text("Available in the desktop app and on the website, SafeAI helps learners stay focused and supported without leaving the HouseLearning experience.")
                            .font(.body)
                    }
                }

                RoundedPanel(title: "Common helpers") {
                    VStack(alignment: .leading, spacing: 10) {
                        SafetyRow(label: "Math help", detail: "Step-by-step guidance and practice")
                        SafetyRow(label: "Science prompts", detail: "Concept review and curiosity questions")
                        SafetyRow(label: "Coding guidance", detail: "Logic-based problem solving")
                        SafetyRow(label: "Study planning", detail: "Daily routines and study habits")
                    }
                }
            }
            .padding(24)
        }
    }
}

struct TeacherToolsView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                HeaderSmall(title: "Teacher tools", subtitle: "Classroom oversight and learning flow")

                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    TeacherStat(label: "Students", value: "128")
                    TeacherStat(label: "Assignments", value: "14")
                    TeacherStat(label: "Avg. score", value: "88%")
                    TeacherStat(label: "Needs review", value: "7")
                }

                RoundedPanel(title: "Improved classroom workflow") {
                    VStack(alignment: .leading, spacing: 12) {
                        ToolRow(title: "Assignment builder", detail: "Create quick targeted practice sets")
                        ToolRow(title: "Progress tracker", detail: "Monitor completion and mastery trends")
                        ToolRow(title: "Parent updates", detail: "Share checkpoints and summaries")
                    }
                }
            }
            .padding(24)
        }
    }
}

struct HeaderCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("HouseLearning")
                .font(.largeTitle)
                .bold()
            Text("A desktop learning app for Mac with math, science, coding, and SafeAI support.")
                .foregroundColor(.secondary)
        }
        .padding(22)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(LinearGradient(colors: [.yellow, .orange.opacity(0.75)], startPoint: .leading, endPoint: .trailing))
        .cornerRadius(20)
    }
}

struct HeaderSmall: View {
    let title: String
    let subtitle: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.title)
                .bold()
            Text(subtitle)
                .foregroundColor(.secondary)
        }
    }
}

struct StatCard: View {
    let label: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(label)
                .foregroundColor(.secondary)
            Text(value)
                .font(.title3)
                .bold()
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(nsColor: NSColor.controlBackgroundColor))
        .cornerRadius(16)
        .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray.opacity(0.25), lineWidth: 1))
    }
}

struct FeatureTile: View {
    let feature: HouseLearningFeature

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(feature.emoji)
                .font(.system(size: 28))
            Text(feature.title)
                .font(.title3)
                .bold()
            Text(feature.detail)
                .foregroundColor(.secondary)
        }
        .padding(18)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(nsColor: NSColor.windowBackgroundColor))
        .cornerRadius(18)
        .overlay(RoundedRectangle(cornerRadius: 18).stroke(Color.gray.opacity(0.2), lineWidth: 1))
    }
}

struct RoundedPanel<Content: View>: View {
    let title: String
    @ViewBuilder let content: () -> Content

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.headline)
            content()
        }
        .padding(18)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(nsColor: NSColor.windowBackgroundColor))
        .cornerRadius(18)
        .overlay(RoundedRectangle(cornerRadius: 18).stroke(Color.gray.opacity(0.2), lineWidth: 1))
    }
}

struct LessonRow: View {
    let title: String
    let subtitle: String
    let time: String

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
            Text(time)
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(Color.yellow.opacity(0.2))
                .cornerRadius(999)
        }
    }
}

struct LessonCard: View {
    let title: String
    let subtitle: String
    let tag: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(title)
                    .font(.headline)
                Spacer()
                Text(tag)
                    .font(.caption)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.blue.opacity(0.12))
                    .cornerRadius(999)
            }
            Text(subtitle)
                .foregroundColor(.secondary)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(nsColor: NSColor.windowBackgroundColor))
        .cornerRadius(16)
        .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray.opacity(0.2), lineWidth: 1))
    }
}

struct SafetyRow: View {
    let label: String
    let detail: String

    var body: some View {
        HStack {
            Image(systemName: "checkmark.seal.fill")
                .foregroundColor(.blue)
            VStack(alignment: .leading, spacing: 2) {
                Text(label)
                    .font(.headline)
                Text(detail)
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct ToolRow: View {
    let title: String
    let detail: String

    var body: some View {
        HStack {
            Image(systemName: "sparkles")
                .foregroundColor(.orange)
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.headline)
                Text(detail)
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct ActionButton: View {
    let title: String
    let icon: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Label(title, systemImage: icon)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .buttonStyle(.bordered)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

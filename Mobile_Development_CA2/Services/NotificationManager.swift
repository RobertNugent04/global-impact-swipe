//
//  NotificationManager.swift
//  Mobile_Development_CA2
//
//  Created by Patrick Orjieh on 27/04/2025.
//

import UserNotifications
import SwiftData

@MainActor
final class NotificationManager {

    static let shared = NotificationManager()

    // MARK: – Ask for permission once
    func requestAuthorization() async {
        let center = UNUserNotificationCenter.current()
        let granted = try? await center.requestAuthorization(
             options: [.alert, .badge, .sound])
        print("🔔 notification permission granted? \(granted ?? false)")
    }

    // MARK: – This is to Schedule a “Project liked” notification
    func scheduleLike(for project: ProjectDTO,
                      inSeconds delay: TimeInterval = 30,
                      context: ModelContext) {

        let content       = UNMutableNotificationContent()
        content.title     = "You liked \(project.title)"
        content.body      = "Check funding progress or share it with friends!"
        content.sound     = .default

        content.userInfo  = ["projectID": project.id]

        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: delay, repeats: false)

        let reqID    = "like-\(project.id)"
        let request  = UNNotificationRequest(
            identifier: reqID, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request)

        let note = AppNotification(
            title: content.title,
            body:  content.body,
            projectID: project.id)
        context.insert(note)
        try? context.save()
    }
}

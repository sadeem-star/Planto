import UserNotifications


final class NotificationManager: NSObject, UNUserNotificationCenterDelegate {
    static let shared = NotificationManager()
    private let center = UNUserNotificationCenter.current()
    
    static let testMode = false

    override init() {
        super.init()
        center.delegate = self
    }

    // نطلب إذن المستخدم"Allow Notifications")
    func requestPermission() {
        center.requestAuthorization(options: [.alert, .sound, .badge]) { _, _ in }
    }

    
    func schedule(for plant: Plant) {
        let content = UNMutableNotificationContent()
        content.title = "Planto"
        content.body = "Hey! let's water your plant"
        content.sound = .default

        // وضع التجربة: 10 ثواني وما يتكرر.
        let seconds: TimeInterval = NotificationManager.testMode
            ? 10
            : TimeInterval(plant.wateringDays.days * 24 * 60 * 60)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds,
                                                        repeats: !NotificationManager.testMode)

        // نفس الـ id يستبدل القديم (مفيد وقت التعديل)
        let request = UNNotificationRequest(identifier: plant.id.uuidString,
                                            content: content, trigger: trigger)
        center.add(request)
    }

    //3) نلغي إشعار النبتة (وقت الحذف)
    func cancel(for plant: Plant) {
        center.removePendingNotificationRequests(withIdentifiers: [plant.id.uuidString])
    }

    // يظهر الإشعار حتى لو التطبيق مفتوح
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification) async
                                -> UNNotificationPresentationOptions {
        [.banner, .sound]
    }
}

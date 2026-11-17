import SwiftUI   // المكتبة اللي نبني فيها الشاشات (لازم تكون أول سطر)

// struct = قالب شاشة. اسمها SetReminderView وهي من نوع View (يعني شاشة)
struct SetReminderView: View {
    var viewModel: PlantsViewModel
    var plantToEdit: Plant? = nil
    @Environment(\.dismiss) var dismiss

    // @State = صندوق يحفظ اللي تكتبه في الخانة
    // plantName اسم الصندوق، و "" يعني فاضي في البداية
    @State private var plantName: String
    init(viewModel: PlantsViewModel, plantToEdit: Plant? = nil) {
            self.viewModel = viewModel
            self.plantToEdit = plantToEdit
            _plantName = State(initialValue: plantToEdit?.name ?? "")
        }

    // body = هنا نكتب شكل الشاشة كله
    var body: some View {

        // ZStack = نحط الأشياء فوق بعض بالعمق
        // هنا: الخلفية السوداء تحت، وكل شيء ثاني فوقها
        ZStack {

            // الخلفية السوداء. ignoresSafeArea تخليها تغطي الشاشة للأطراف
            Color(white: 0.1).ignoresSafeArea()

            // VStack = نرتب الأشياء من فوق لتحت
            VStack(spacing: 10) {

                // ========== القطعة 1: الهيدر ==========
                // HStack = نرتب الأشياء جنب بعض (أفقي)
                HStack {

                    // زر X (أيقونة من أيقونات آبل)
                    Button {
                        dismiss()                                 // يقفل الورقة
                    } label: {
                        Image(systemName: "xmark")
                            .padding(12)
                            .background(Color.gray.opacity(0.3))
                            .clipShape(Circle())
                    }                      // نقصها على شكل دائرة

                    Spacer()   // مساحة فاضية تدفع زر X لليسار

                    Text("Set Reminder")   // عنوان الشاشة

                    Spacer()   // مساحة فاضية تدفع العنوان للنص

                    // زر ✓ الأخضر
                    Button {
                        if let plant = plantToEdit {
                                viewModel.updatePlant(plant, name: plantName)
                            } else {
                                viewModel.addPlant(name: plantName)
                            }
                            dismiss()
                                                         
                    } label: {
                        Image(systemName: "checkmark")
                            .padding(12)
                            .background(Color(red: 0.24, green: 0.55, blue: 0.43))
                            .clipShape(Circle())
                    }
                }
                .foregroundStyle(.white)   // كل اللي داخل الـ HStack يصير أبيض
                .padding()                 // مسافة حول الهيدر كله

                // ========== القطعة 2: خانة اسم النبتة ==========
                HStack {
                    Text("Plant Name")
                        .foregroundStyle(.white)

                    // خانة الكتابة. "Pothos" الكلام الباهت داخلها
                    // $plantName = اربط الخانة بالصندوق عشان يحفظ اللي تكتبه
                    TextField("Pothos", text: $plantName)
                }
                .padding()                                // مسافة داخل الخانة
                .background(Color.gray.opacity(0.2))      // خلفية رمادية
                .clipShape(Capsule())                     // أطراف بيضاوية
                .padding(.horizontal)                     // مسافة من اليمين واليسار

                // ========== القطعة 3: القائمة الأولى (Room و Light) ==========
                List {
                    // Label = أيقونة مع نص
                    Label("Room", systemImage: "location")
                        .badge("Bedroom")                              // القيمة على اليمين
                        .listRowBackground(Color.gray.opacity(0.2))    // لون خلفية الصف

                    Label("Light", systemImage: "sun.max")
                        .badge("Full sun")
                        .listRowBackground(Color.gray.opacity(0.2))
                }
                .scrollContentBackground(.hidden)   // نشيل الخلفية الافتراضية للقائمة
                .scrollDisabled(true)               // نمنع التمرير لأن الصفوف قليلة
                .frame(height: 160)
                .foregroundStyle(.white)
                
                // ========== القطعة 4: القائمة الثانية (Watering و Water) ==========
                List {
                    Label("Watering Day", systemImage: "drop")
                        .badge("Every day")//هو تعديل جاهز من آبل يحط نص صغير على أقصى يمين الصف داخل الـ List. يعني بدل ما نسوي HStack
                        .listRowBackground(Color.gray.opacity(0.2))

                    Label("Water", systemImage: "drop")
                        .badge("20-50 ml")
                        .listRowBackground(Color.gray.opacity(0.2))
                }
                .scrollContentBackground(.hidden)
                .scrollDisabled(true)
                .frame(height: 160)
                .foregroundStyle(.white)

                // Spacer في آخر الـ VStack يدفع كل شيء لفوق
                
                if let plant = plantToEdit {
                    Button {
                        viewModel.deletePlant(plant)
                        dismiss()
                    } label: {
                        Text("Delete Reminder")
                            .font(.system(size: 15, weight: .medium))
                            .foregroundStyle(.red)
                            .frame(maxWidth: .infinity)
                            .frame(height: 44)
                            .background(Color.gray.opacity(0.2))
                            .clipShape(Capsule())
                    }
                    .padding(.horizontal)
                    .padding(.top, 12)
                }
                Spacer()
            }
        }
    }
}

// الـ Preview هو اللي يعرض الشاشة على اليمين في Xcode وأنت تكتب
#Preview {
    SetReminderView(viewModel: PlantsViewModel())
}

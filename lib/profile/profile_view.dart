import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swimcalculator/profile/profile_view_model.dart';
import 'package:swimcalculator/shared/widgets/app_button.dart';
import 'package:swimcalculator/shared/widgets/app_button_nav_bar.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

@override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileViewModel()..getProfile(),
      child: const _ProfileView(),
    );
  }

}

class _ProfileView extends StatelessWidget {
  const _ProfileView();
  
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ProfileViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: vm.isLoading
      ? const Center(child: CircularProgressIndicator(color: Color(0xFF1A6BFF),),)
      : Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 24,),
            CircleAvatar(
              radius: 40,
              backgroundColor: const Color(0xFF1A6BFF),
              child: Text(
                vm.profile?.name.substring(0, 1).toUpperCase() ?? '?',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10,),
            Text(
              vm.profile?.name ?? 'Not Found',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
            ),
            Text(
              vm.profile?.email ?? 'Email Not Found',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 24,),
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Account Information",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 12,),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(117, 68, 137, 255),
                          borderRadius: BorderRadius.circular(5)
                        ),
                        child: const Icon(Icons.person_2_outlined, color: Colors.blueAccent,),
                      ),
                      const SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Name", style: TextStyle(color: Colors.grey)),
                          Text(vm.profile?.name ?? "Not Found"),
                        ],
                      )
                    ],
                  ),
                  const Divider(height: 24, color: Color.fromARGB(66, 158, 158, 158),),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(117, 68, 137, 255),
                          borderRadius: BorderRadius.circular(5)
                        ),
                        child: const Icon(Icons.email_outlined, color: Colors.blueAccent,),
                      ),
                      const SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Email", style: TextStyle(color: Colors.grey)),
                          Text(vm.profile?.email ?? "Not Found"),
                        ],
                      )
                    ],
                  ),
                  const Divider(height: 24, color: Color.fromARGB(66, 158, 158, 158),),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(117, 68, 137, 255),
                          borderRadius: BorderRadius.circular(5)
                        ),
                        child: const Icon(Icons.date_range_outlined, color: Colors.blueAccent,),
                      ),
                      const SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Account created in", style: TextStyle(color: Colors.grey)),
                          Text(vm.profile?.createdAt ?? "Not Found"),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ), 
            Padding(
              padding: const EdgeInsets.all(12),
              child: AppButton(
                text: "Edit Profile", 
                icon: Icons.mode_edit_outlined, 
                onPressed:() {
                        
              },),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: ElevatedButton(
                onPressed:() {
                  
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(12),
                    side: const BorderSide(color: Colors.red, width: 1)
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16)
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout, color: Colors.red,),
                    SizedBox(width: 8,),
                    Text(
                      "Logout",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                      ),
                    )
                  ],
                )
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: ButtonNavBar(
        indiceAtual: 2,
        onTap: (indice) {
          switch(indice) {
            case 0:
              Navigator.pushNamed(context, '/home');
              break;
            case 1:
              Navigator.pushNamed(context, '/save');
              break;
            case 2:
              Navigator.pushNamed(context, '/profile');
              break;
            case 3:
              Navigator.pushNamed(context, '/help');
              break;
          }
        }
      ),
    );
  }
}
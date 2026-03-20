import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swimcalculator/profile/editProfile/editprofile_view_model.dart';
import 'package:swimcalculator/shared/widgets/app_button.dart';

class EditprofileView extends StatelessWidget{
  
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EditprofileViewModel()..carregarPerfil(), 
      child: _EditProfileView(),
    );
  }
}

class _EditProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<EditprofileViewModel>();

    return Scaffold(
      appBar: AppBar(title : Text("Editar Perfil")),
      body: vm.isLoading
      ? const Center(child: CircularProgressIndicator(color: Color(0xFF1A6BFF)),)
      : Center (
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              margin: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Edite seus dados",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(height: 12,),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Nome",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                            fontWeight: FontWeight.w400
                          ),
                        ),
                        const SizedBox(height: 5,),
                        TextField(
                          controller: vm.name,
                          decoration: const InputDecoration(
                            hintText: "Nome",
                            prefixIcon: Icon(Icons.person_2_outlined, color: Colors.grey),
                            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF1A6BFF)))
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24,),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Email",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                            fontWeight: FontWeight.w400
                          ),
                        ),
                        const SizedBox(height: 5,),
                        TextField(
                          controller: vm.email,
                          decoration: const InputDecoration(
                            hintText: "Email",
                            prefixIcon: Icon(Icons.email_outlined, color: Colors.grey),
                            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF1A6BFF)))
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: AppButton(
                text: "Salvar", 
                icon: Icons.save_alt_outlined, 
                onPressed:() {
                  vm.salvarPerfil(context);
                  
                },
              ),
            ),
                        Padding(
              padding: const EdgeInsets.all(12),
              child: ElevatedButton(
                onPressed:() => Navigator.pushNamed(context, "/profile"),
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
                      "Sair",
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
        )
      ),
    );
  }

} 
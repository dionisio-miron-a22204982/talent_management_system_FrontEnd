import 'package:flutter/material.dart';
import '../../models/private_user_model.dart';

import 'package:tfc_versaofinal/users/private/models/private_experiences_model.dart';
import 'package:tfc_versaofinal/users/private/widgets/home/widgets/private_experience_page.dart';
import '../../../../features/authentication/screens/login/login.dart';



class PrivateHomeScreen extends StatefulWidget {
  PrivateHomeScreen({Key? key, required this.user}) : super(key: key);

  final PrivateUser user;

  @override
  _PrivateHomeScreenState createState() => _PrivateHomeScreenState();
}

class _PrivateHomeScreenState extends State<PrivateHomeScreen> {
  late List<PrivateExperiences> experiences;

  @override
  void initState() {
    super.initState();
    experiences = widget.user.experiences!;
  }

  void _addExperience(PrivateExperiences newExperience) {
    setState(() {
      experiences.add(PrivateExperiences(name: newExperience.name, company: newExperience.company, description: '', date: DateTime.now()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[600],
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  // Welcome and leave button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Username
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.user.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            widget.user.job,
                            style: const TextStyle(color: Colors.white54),
                          ),
                        ],
                      ),

                      // Leave Icon
                      TextButton(
                        onPressed: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginScreen())),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blue[400],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.all(19),
                          child: const Icon(
                            Icons.exit_to_app,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            const SizedBox(height: 5),

            // Divider
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(25),
                color: Colors.grey[300],
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Experiencias',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewPrivateExperienceScreen(_addExperience)));
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            child: const Icon(
                              Icons.add,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // List of Experiences
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey[300],
                        ),
                        padding: const EdgeInsets.all(15),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: experiences.length,
                          itemBuilder: (context, index) => ListTile(
                            contentPadding: const EdgeInsets.all(8.0),
                            title: Text(
                              experiences[index].name,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  experiences[index].company,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                            ),
                            leading: const Icon(
                              Icons.workspace_premium,
                              color: Colors.black,
                            ),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => PrivateExperiencePage(experience: experiences, user: widget.user)));
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewPrivateExperienceScreen extends StatefulWidget {
  final Function(PrivateExperiences) addExperience;

  const NewPrivateExperienceScreen(this.addExperience);

  @override
  _NewExperienceScreenState createState() => _NewExperienceScreenState();
}

class _NewExperienceScreenState extends State<NewPrivateExperienceScreen> {
  late String _name;
  late String _company;
  late String _description;

  @override
  void initState() {
    super.initState();
    _name = '';
    _company = '';
    _description = '';
  }

  void _submitExperience() {
    widget.addExperience(PrivateExperiences(name: _name, company: _company, description: _description, date: DateTime.now()));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar nova Experiência'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              onChanged: (value) => setState(() => _name = value),
              decoration: const InputDecoration(labelText: 'Nome'),
            ),
            const SizedBox(height: 16),
            TextField(
              onChanged: (value) => setState(() => _company = value),
              decoration: const InputDecoration(labelText: 'Empresa'),
            ),
            const SizedBox(height: 16),
            TextField(
              onChanged: (value) => setState(() => _description = value),
              decoration: const InputDecoration(labelText: 'Descrição'),
            ),
            ElevatedButton(
              onPressed: _submitExperience,
              child: const Text('Adicionar'),
            ),
          ],
        ),
      ),
    );
  }
}

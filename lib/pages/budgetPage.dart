
import 'package:app_wedding_yours/modeles/budget.dart';
import 'package:app_wedding_yours/modeles/depense.dart';
import 'package:app_wedding_yours/services/budgetService.dart';
import 'package:app_wedding_yours/services/depenseService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class BudgetPage extends StatefulWidget {
  final Budget nouveauBudget;
  final mariageId;

  BudgetPage({Key? key, required this.nouveauBudget, required this.mariageId})
      : super(key: key);

  @override
  State<BudgetPage> createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  final _formkey = GlobalKey<FormState>();
  late DepenseService depenseService;
late BudgetService budgetService;
  @override
  void initState() {
    super.initState();
    depenseService = DepenseService();
    budgetService = BudgetService();
    depenseService.fetchDepensesList(); // Appeler pour initialiser la liste au début
  }
  final descriptionController = TextEditingController();
  final depensesMontantController = TextEditingController();
  final budgetMontantController = TextEditingController();
//============================================================
 int calculateTotalExpenses(List<Depense> expenses) {
  int total = 0;
  for (var expense in expenses) {
    total += expense.depensesMontant;
  }
  return total;
}

  @override
  Widget build(BuildContext context) {
    final Budget budget = widget.nouveauBudget;

    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Mon Budget',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            height: 180,
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        SizedBox(height: 8,),
                        Container(
                          width: 70,
                          height: 70,
                          padding: EdgeInsets.all(10.0),
                          child: Image.asset(
                            "assets/images/cochon.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                        Text('MONTANT ESTIMÉ'),
                        //SizedBox(height: 2,),
                        Text(
                          '${budget.budgetMontant} FCFA',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4,),

                        GestureDetector(
                          onTap: () {
                            depenseService.fetchDepensesList();
                             showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Modification'),
          content: TextField (
            controller: budgetMontantController,
            decoration: InputDecoration(labelText: 'Montant'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
              // final mariageId = mariageId;
                 final montant = budgetMontantController.text;

                            // instance de Tache avec les modifications
                            final nouveauBudget = Budget(
                              budgetId: budget.budgetId,// Use the correct field name
                              budgetMontant: int.parse(montant),
                              mariageId: widget.mariageId
                                        );
                                        budgetService.update(nouveauBudget);
               // Ferme la boîte de dialogue après la suppression
                setState(() {
                        widget.nouveauBudget.budgetMontant = int.parse(montant);
                      });
                      depenseService.fetchDepensesList();
               FocusScope.of(context).requestFocus(FocusNode());
               Navigator.of(context).pop();
              },
              child: Text('Valider', 
                  style: TextStyle(
                        color: Colors.pinkAccent,
                      ),
                  ),
            ),
          ],
        );
                },
              );
                          },
                          child: Text(
                            'Modifier',
                            style: TextStyle(
                              color: Color.fromRGBO(253, 139, 139, 1),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  VerticalDivider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        SizedBox(height: 12,),
                        Container(
                          width: 70,
                          height: 70,
                          padding: EdgeInsets.all(10.0),
                          child: Image.asset(
                            "assets/images/depense2.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                        Text('COUT FINAL'),
                        SizedBox(height: 5,),
                        FutureBuilder<List<Depense>>(
        future: depenseService.depensesStream.first,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Text('Aucune dépense trouvée.');
          } else {
            List<Depense> expenses = snapshot.data!;
            int totalExpenses = calculateTotalExpenses(expenses);

            return Text(
              '$totalExpenses FCFA',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
            );
            }
          
            }
                    )],
                    ),
                  ),
                ],
              ),
            ),
          ),

          FutureBuilder<List<Depense>>(
            future: depenseService.depensesStream.first,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No expenses found.'));
              } else {
                List<Depense> expenses = snapshot.data!;

                return Expanded(
                  child: ListView.builder(
                    itemCount: expenses.length,
                    itemBuilder: (context, index) {
                      final expense = expenses[index];
                      return Card(
                        child: ListTile(
                          leading: Icon(Icons.money),
                          title: Text(expense.description),
                          subtitle: Text('${expense.depensesMontant} FCFA'),
                        ),
                      );
                    },
                  ),
                );
              }
            },
          ),

          Divider(
            color: Colors.grey[400],
            thickness: 1,
          ),

          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    height: 400,
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Form(
                          key: _formkey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Center(
                                child: Text(
                                  'Nouvelle Dépense',
                                  style: GoogleFonts.inter(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 300,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color:  Color(0xFFFC8B8B)),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      labelText: 'Montant',
                                      labelStyle: TextStyle(color:  Colors.black),
                                      hintText: 'Montant',
                                      hintStyle: TextStyle(color:  Colors.black)
                                    ),
                                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                                    ],
                                    validator: (value){
                                      if(value == null || value.isEmpty){
                                        return "Veuillez compléter le champ";
                                      }
                                      return null;
                                    },
                                    controller: depensesMontantController,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 300,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color:  Color(0xFFFC8B8B)),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      labelText: 'Description',
                                      hintText: 'Description',
                                    ),
                                    validator: (value){
                                      if(value == null || value.isEmpty){
                                        return "Veuillez compléter le champ";
                                      }
                                      return null;
                                    },
                                    controller: descriptionController,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                width: 300,
                                height: 40,
                                margin: const EdgeInsets.only(top: 8, bottom: 8),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                      Color.fromRGBO(253, 139, 139, 1),
                                    ),
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    if(_formkey.currentState!.validate()){
                                      final depensesMontant = int.parse(depensesMontantController.text);
                                      final description = descriptionController.text;

                                      final dd = Depense(
                                        depenseId: '',
                                        depensesMontant: depensesMontant,
                                        description: description,
                                        budgetId: budget.budgetId ?? '',
                                      );

                                      depenseService.createDepense(dd);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text("Envoi en cours ...")),
                                      );
                                      setState(() {
                        widget.nouveauBudget.budgetMontant = int.parse(budget.budgetMontant as String);
                      });
                      depenseService.fetchDepensesList();
                                      FocusScope.of(context).requestFocus(FocusNode());
                                    }
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'Ajouter',
                                    style: GoogleFonts.inter(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.add_circled,
                      color: Color.fromRGBO(253, 139, 139, 1),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Ajouter',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(253, 139, 139, 1),
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: Colors.grey[400],
                  thickness: 1,
                ),
              ],
            ),
          ),
          SizedBox(height: 3),
        ],
      ),
    );
  }
  @override
  void dispose() {
    depenseService.dispose(); // Fermer le StreamController lorsque le widget est détruit
    super.dispose();
    depensesMontantController.dispose();
    descriptionController.dispose();
  }
}

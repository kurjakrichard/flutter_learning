import 'package:flutter/material.dart';
import 'package:flutter_learning/l10n/app_localizations.dart';
import '../models/category.dart';
import '../utils/category_service.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  TextEditingController _categoryController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  Category _category = Category('', '');
  final CategoryService _categoryService = CategoryService();
  List<Category>? _categoryList;

  @override
  void initState() {
    super.initState();
    getCategories();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.categories),
      ),
      body: ListView.builder(
          itemCount: _categoryList?.length,
          itemBuilder: ((context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 4.0, left: 8.0, right: 8.0),
              child: Card(
                elevation: 8.0,
                child: ListTile(
                  leading: IconButton(
                      onPressed: () async {
                        _showFormDialog(
                            context, l10n.editCategory, _categoryList![index]);
                      },
                      icon: const Icon(Icons.edit)),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(_categoryList?.length != null
                          ? _categoryList![index].name
                          : ''),
                      IconButton(
                          icon: const Icon(Icons.delete),
                          color: Colors.red,
                          onPressed: () {})
                    ],
                  ),
                  subtitle: Text(_categoryList?.length != null
                      ? _categoryList![index].description
                      : ''),
                ),
              ),
            );
          })),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          _showFormDialog(context, l10n.newCategory, _category);
          getCategories();
        },
      ),
    );
  }

  void getCategories() async {
    _categoryList = await _categoryService.readCategories('categories', 'name');

    setState(() {
      _categoryList;
    });
  }

  // ignore: unused_element
  Future<void> _editCategories(
      BuildContext context, String table, Category category) async {
    await _categoryService.readCategoriesById(table, category);
    setState(() {});
  }

  Future _showFormDialog(
      BuildContext context, String title, Category category) {
    _categoryController.text = category.name ?? '';
    _descriptionController.text = category.description ?? '';
    final l10n = AppLocalizations.of(context);
    return showDialog(
        context: context,
        builder: (value) {
          return AlertDialog(
            actions: [
              TextButton(
                onPressed: () async {
                  category.name = _categoryController.text;
                  category.description = _descriptionController.text;
                  if (category.name != '') {
                    if (category.id != null) {
                      await _categoryService.readCategoriesById(
                          'categories', category);
                    } else {
                      await _categoryService.addCategory(
                          'categories', category);
                    }
                    setState(() {
                      getCategories();
                    });
                    _categoryController = TextEditingController();
                    _descriptionController = TextEditingController();
                    _category = Category('', '');
                  }

                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.resolveWith(
                        (state) => Colors.blue)),
                child: Text(l10n.save,
                    style: const TextStyle(color: Colors.white)),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.resolveWith((state) => Colors.red)),
                child: Text(
                  l10n.cancel,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
            title: Text(title),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _categoryController,
                    decoration: InputDecoration(
                        hintText: l10n.categoryHint, labelText: l10n.category),
                  ),
                  TextField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                        hintText: l10n.descriptionHint,
                        labelText: l10n.description),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

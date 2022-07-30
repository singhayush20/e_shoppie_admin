import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shoppie_admin/database/product.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import '../database/category.dart';
import '../database/brand.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'dart:io';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);
  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController productQuantityController = TextEditingController();
  TextEditingController typeAheadController = TextEditingController();
  TextEditingController productNameController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  List<DocumentSnapshot> brands = <DocumentSnapshot>[];
  List<DocumentSnapshot> categories = <DocumentSnapshot>[];
  List<DropdownMenuItem<String>> categoriesListItems =
      <DropdownMenuItem<String>>[];
  List<DropdownMenuItem<String>> brandsListItems = <DropdownMenuItem<String>>[];
  String? _currentCategory = '';
  String? _currentBrand = '';
  CategoryService _categoryService = CategoryService();
  BrandService _brandService = BrandService();
  ProductService productService = ProductService();
  List<String> availableSizes =
      <String>[]; //will all the selected sizes for our product

  //-------------------------------------------\\
  ImagePicker imagePicker = ImagePicker();
  late File? _fileImage1 = null;
  late File? _fileImage2 = null;
  late File? _fileImage3 = null;
  bool isLoading = false;
  @override
  void initState() {
    _getCategories();
    _getBrands();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Add Products'),
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      body: Form(
        key: _formKey,
        child: isLoading == true
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.05,
                          vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                _selectImage(1);
                              },
                              child: _displayChild(1),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                _selectImage(2);
                              },
                              child: _displayChild(2),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                _selectImage(3);
                              },
                              child: _displayChild(3),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'Enter the Product Name',
                      textAlign: TextAlign.start,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.03,
                          vertical: 5),

                      //====SELECT CATEGORY====
                      // Visibility(
                      //   child: Material(
                      //       borderRadius: BorderRadius.circular(20),
                      //       color: Colors.red,
                      //       child: Row(
                      //         children: [
                      //           Expanded(
                      //             child: Text('$_currentCategory'),
                      //           ),
                      //           IconButton(
                      //               onPressed: () {
                      //                 setState(() {
                      //                   _currentCategory = '';
                      //                 });
                      //               },
                      //               icon: Icon(Icons.close))
                      //         ],
                      //       )),
                      //   visible: _currentCategory != null || _currentCategory != '',
                      // ),
                      // TypeAheadFormField(
                      //   textFieldConfiguration: TextFieldConfiguration(
                      //       autofocus: false,
                      //       controller: typeAheadController,
                      //       decoration: InputDecoration(labelText: 'Category')),
                      //   suggestionsCallback: (pattern) async {
                      //     return await _categoryService.getSuggestion(pattern);
                      //   },
                      //   itemBuilder: (context, suggestion) {
                      //     return ListTile(
                      //       leading: Icon(Icons.category),
                      //       title: Text(
                      //           '${suggestion.toString()}'), //["categoryName"] not working
                      //     );
                      //   },
                      //   transitionBuilder: (context, suggestionsBox, controller) {
                      //     return suggestionsBox;
                      //   },
                      //   onSuggestionSelected: (suggestion) {
                      //     debugPrint(suggestion.toString());
                      //     // typeAheadController.text = suggestion;
                      //     setState(() {
                      //       // _currentCategory=suggestion['categoryName'];
                      //     });
                      //   },
                      //   validator: (value) {
                      //     if (value!.isEmpty) {
                      //       return 'Please select a category to add product';
                      //     }
                      //   },
                      //   //onSaved: (value) => this._selectedCity = value,
                      // ),
                      //====SELECT BRAND====
                      // Visibility(
                      //   child: Material(
                      //       borderRadius: BorderRadius.circular(20),
                      //       color: Colors.red,
                      //       child: Row(
                      //         children: [
                      //           Expanded(
                      //             child: Text('$_currentBrand'),
                      //           ),
                      //           IconButton(
                      //               onPressed: () {
                      //                 setState(() {
                      //                   _currentBrand = '';
                      //                 });
                      //               },
                      //               icon: Icon(Icons.close))
                      //         ],
                      //       )),
                      //   visible: _currentBrand != null || _currentBrand != '',
                      // ),
                      // TypeAheadFormField(
                      //   textFieldConfiguration: TextFieldConfiguration(
                      //       autofocus: false,
                      //       controller: typeAheadController,
                      //       decoration: InputDecoration(labelText: 'Brand')),
                      //   suggestionsCallback: (pattern) async {
                      //     return await _brandService.getSuggestion(pattern);
                      //   },
                      //   itemBuilder: (context, suggestion) {
                      //     return ListTile(
                      //       leading: Icon(Icons.branding_watermark),
                      //       title: Text(
                      //           '${suggestion.toString()}'), //["brandName"] not working
                      //     );
                      //   },
                      //   transitionBuilder: (context, suggestionsBox, controller) {
                      //     return suggestionsBox;
                      //   },
                      //   onSuggestionSelected: (suggestion) {
                      //     debugPrint(suggestion.toString());
                      //     // typeAheadController.text = suggestion;
                      //     setState(() {
                      //       // _currentBrand = suggestion['brandName'];
                      //     });
                      //   },
                      //   validator: (value) {
                      //     if (value!.isEmpty) {
                      //       return 'Please select a category to add product';
                      //     }
                      //   },
                      //   //onSaved: (value) => this._selectedCity = value,
                      // ),
                      child: TextFormField(
                        initialValue: null,
                        controller: productNameController,
                        decoration: InputDecoration(
                          hintText: 'Product Name',
                        ),
                        validator: (value) {
                          print('Name: $value');
                          if (value == null || value.trim().isEmpty) {
                            return 'Product Name cannot be empty';
                          } else if (value.length > 10) {
                            return 'Product Name should not be more than 10 characters';
                          } else
                            return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.03,
                          vertical: 5),
                      child: TextFormField(
                        initialValue: null,
                        keyboardType: TextInputType.numberWithOptions(
                            signed: false, decimal: false),
                        controller: productQuantityController,
                        decoration: InputDecoration(
                          hintText: 'Quantity',
                        ),
                        validator: (value) {
                          print('Quantity: $value');
                          if (value == null || value.trim().isEmpty) {
                            return 'Product Quantity cannot be empty';
                          } else if (num.parse(value) > 0 &&
                              (num.parse(value) is int ||
                                  num.parse(value).roundToDouble() ==
                                      num.parse(value))) {
                            return 'Value should not be a fraction/negative integer';
                          } else
                            return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.03,
                          vertical: 5),
                      child: TextFormField(
                        initialValue: null,
                        keyboardType: TextInputType.numberWithOptions(
                            signed: false, decimal: false),
                        controller: productPriceController,
                        decoration: InputDecoration(
                          hintText: 'Product Price (in numbers)',
                        ),
                        validator: (value) {
                          print('Price: $value');
                          if (value == null || value.trim().isEmpty) {
                            return 'Product Price cannot be empty';
                          } else if (num.parse(value) > 0 &&
                              (num.parse(value) is int ||
                                  num.parse(value).roundToDouble() ==
                                      num.parse(value))) {
                            return 'Value should not be a fraction/negative integer';
                          } else
                            return null;
                        },
                      ),
                    ),
                    DropdownButton(
                        value: _currentCategory,
                        items: categoriesListItems,
                        onChanged: (String? selectedCategory) {
                          setState(() {
                            _currentCategory = selectedCategory;
                          });
                        }),
                    DropdownButton(
                        value: _currentBrand,
                        items: brandsListItems,
                        onChanged: (String? selectedBrand) {
                          setState(() {
                            _currentBrand = selectedBrand;
                          });
                        }),
                    Column(
                      children: [
                        Checkbox(
                            value: availableSizes.contains('S'),
                            onChanged: (value) =>
                                changeSelectedSize(value ?? false, 'S')),
                        Text('S'),
                        Checkbox(
                            value: availableSizes.contains('M'),
                            onChanged: (value) =>
                                changeSelectedSize(value ?? false, 'M')),
                        Text('M'),
                        Checkbox(
                            value: availableSizes.contains('L'),
                            onChanged: (value) =>
                                changeSelectedSize(value ?? false, 'L')),
                        Text('L'),
                        Checkbox(
                            value: availableSizes.contains('XL'),
                            onChanged: (value) =>
                                changeSelectedSize(value ?? false, 'XL')),
                        Text('XL'),
                        Checkbox(
                            value: availableSizes.contains('XXL'),
                            onChanged: (value) =>
                                changeSelectedSize(value ?? false, 'XXL')),
                        Text('XXL'),
                        Checkbox(
                            value: availableSizes.contains('XXXL'),
                            onChanged: (value) =>
                                changeSelectedSize(value ?? false, 'XXXL')),
                        Text('XXXL'),
                      ],
                    ),
                    Column(
                      children: [
                        Checkbox(value: false, onChanged: null),
                        Text('28'),
                        Checkbox(value: false, onChanged: null),
                        Text('30'),
                        Checkbox(value: false, onChanged: null),
                        Text('32'),
                        Checkbox(value: false, onChanged: null),
                        Text('34'),
                        Checkbox(value: false, onChanged: null),
                        Text('36'),
                        Checkbox(value: false, onChanged: null),
                        Text('38'),
                        Checkbox(value: false, onChanged: null),
                        Text('40'),
                        Checkbox(value: false, onChanged: null),
                        Text('42'),
                        Checkbox(value: false, onChanged: null),
                        Text('44'),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState!.validate()) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                          setState(() {
                            isLoading = true;
                          });
                          validateAndUploadData();
                        } else {
                          Fluttertoast.showToast(
                              msg: 'Invalid Product details');
                          setState(() {
                            isLoading = false;
                          });
                        }
                      },
                      child: Text('Add Product'),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  List<DropdownMenuItem<String>> getCategoriesDropDown() {
    List<DropdownMenuItem<String>> items = <DropdownMenuItem<String>>[];
    for (DocumentSnapshot category in categories) {
      items.add(
        DropdownMenuItem(
          child: Text(category.get('categoryName').toString().toUpperCase()),
          value: category.get('categoryName'),
        ),
      );
    }
    print('Category dropdown items: $items');
    return items;
  }

  List<DropdownMenuItem<String>> getBrandsDropDown() {
    List<DropdownMenuItem<String>> items = <DropdownMenuItem<String>>[];
    for (DocumentSnapshot category in brands) {
      items.add(
        DropdownMenuItem(
          child: Text(category.get('brandName').toString().toUpperCase()),
          value: category.get('brandName'),
        ),
      );
    }
    print('Category dropdown items: $items');
    return items;
  }

  Future<void> _getCategories() async {
    List<DocumentSnapshot> data = await _categoryService.getCategories();
    print('category data.length: ${data.length}');

    setState(() {
      categories = data;
      categoriesListItems = getCategoriesDropDown();
      _currentCategory = categoriesListItems[0].value;
    });
  }

  Future<void> _getBrands() async {
    List<DocumentSnapshot> data = await _brandService.getBrands();
    print('brand data.length: ${data.length}');
    setState(() {
      brands = data;
      brandsListItems = getBrandsDropDown();
      _currentBrand = brandsListItems[0].value;
    });
  }

  void changeSelectedSize(bool value, String size) {
    if (availableSizes.contains(size)) {
      setState(() {
        availableSizes.remove(size);
      });
    } else
      setState(() {
        availableSizes.add(size);
      });
  }

  void _selectImage(int imageNumber) async {
    File? temp =
        File((await imagePicker.pickImage(source: ImageSource.gallery))!.path);
    switch (imageNumber) {
      case 1:
        setState(() {
          _fileImage1 = temp;
        });
        break;
      case 2:
        setState(() {
          _fileImage2 = temp;
        });
        break;
      case 3:
        setState(() {
          _fileImage3 = temp;
        });
    }
  }

  _displayChild(int i) {
    switch (i) {
      case 1:
        if (_fileImage1 == null)
          return Icon(
            Icons.add,
            color: Colors.grey,
            size: 100,
          );
        else
          return Image.file(_fileImage1!);
        break;
      case 2:
        if (_fileImage2 == null)
          return Icon(
            Icons.add,
            color: Colors.grey,
            size: 100,
          );
        else
          return Image.file(_fileImage2!);
        break;
      case 3:
        if (_fileImage3 == null)
          return Icon(
            Icons.add,
            color: Colors.grey,
            size: 100,
          );
        else
          return Image.file(_fileImage3!);
        break;
    }
  }

  void validateAndUploadData() async {
    if (_fileImage1 != null && _fileImage2 != null && _fileImage3 != null) {
      if (!availableSizes.isEmpty) {
        final String picture1 =
            "${DateTime.now().microsecondsSinceEpoch.toString()}.jpg";
        final String picture2 =
            "${DateTime.now().microsecondsSinceEpoch.toString()}.jpg";
        final String picture3 =
            "${DateTime.now().microsecondsSinceEpoch.toString()}.jpg";
        final FirebaseStorage storage = FirebaseStorage.instance;
        // TaskSnapshot taskSnapshot1 =
        //     await storage.ref().child(picture1).putFile(_fileImage1!);
        // TaskSnapshot taskSnapshot2 =
        //     await storage.ref().child(picture2).putFile(_fileImage2!);
        // TaskSnapshot taskSnapshot3 =
        //     await storage.ref().child(picture3).putFile(_fileImage3!);

        //Create a storage reference from app
        final storageRef = storage.ref();
        //Create a reference to image 1
        final image1Ref = storageRef.child(picture1);
        //Create a reference to image 2
        final image2Ref = storageRef.child(picture2);
        //Create a reference to image 3
        final image3Ref = storageRef.child(picture3);
        try {
          await image1Ref.putFile(_fileImage1!);
          await image2Ref.putFile(_fileImage2!);
          await image3Ref.putFile(_fileImage3!);

          //Now get the download urls to add them to our database
          String imageUrl1 = await image1Ref.getDownloadURL();
          String imageUrl2 = await image2Ref.getDownloadURL();
          String imageUrl3 = await image3Ref.getDownloadURL();
          List<String> images = [imageUrl1, imageUrl2, imageUrl3];
          productService.uploadProduct(
              productNameController.text.trim(),
              _currentBrand!.trim(),
              _currentCategory!.trim(),
              availableSizes,
              images,
              int.parse(productPriceController.text.trim()),
              int.parse(productQuantityController.text.trim()));
          _formKey.currentState!.reset();
          setState(() {
            isLoading = false;
          });
        } on FirebaseException catch (e) {
          setState(() {
            isLoading = false;
          });
          Fluttertoast.showToast(msg: 'Failed to upload images!');
          print('Some error occurred while uploading images! $e');
        }
        Fluttertoast.showToast(msg: 'Product Added');
        Navigator.pop(context); //navigate back
      } else {
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(msg: 'Select at least one size');
      }
    } else {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(msg: 'Image/Images required!');
    }
  }
}

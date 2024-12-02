import 'dart:developer';
import 'dart:io';

import 'package:cnfaceattendance/model/getusermodel.dart';
import 'package:cnfaceattendance/utils/backgrounddecoration.dart';
import 'package:cnfaceattendance/utils/customborderradius.dart';
import 'package:cnfaceattendance/view/employeeregisterscreen/editemployeescreen/editemployeecontroller.dart';
import 'package:cnfaceattendance/view/employeeregisterscreen/newemployeescreen/widget/datepicker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_dropdown/multi_dropdown.dart';

import '../../../utils/image.dart';
import '../../login_screen/widget/custombutton_widget.dart';
import '../../login_screen/widget/customtextformfield_widget.dart';

class EditEmployeeScreen extends StatefulWidget {
  const EditEmployeeScreen({super.key});

  @override
  State<EditEmployeeScreen> createState() => _EditEmployeeScreenState();
}

class _EditEmployeeScreenState extends State<EditEmployeeScreen> {
  @override
  Widget build(BuildContext context) {
    final model = Get.put(EditEmployeeController());

    return Container(
      decoration: backgroundDecoration(),
      child: Form(
        key: model.formkey1,
        child: Scaffold(
            bottomNavigationBar: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: CustomButtonWidget(
                    text: 'Save Employee',
                    callback: () {
                      model.saveEditCliked(
                          model.nameController.text,
                          model.dobController.text,
                          model.emailController.text,
                          model.mobileNoController.text,
                          model.addressController.text);
                    }),
              ),
            ),
            appBar: AppBar(
              elevation: 0,
              title: const Text(
                'Edit Employee',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Center(
                      child: Obx(
                        () => InkWell(
                            onTap: () {
                              model.getImageFromCamera();
                            },
                            borderRadius: BorderRadius.circular(75),
                            child: Stack(children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(70),
                                child: model.cameraImage.value.isEmpty
                                    ? Image.network(
                                        model.image.value,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return const CustomImage(size: 120);
                                        },
                                        fit: BoxFit.cover,
                                        width: 120,
                                        height: 120,
                                      )
                                    : Image.file(
                                        File(
                                            model.cameraImage.value.toString()),
                                        fit: BoxFit.cover,
                                        width: 120,
                                        height: 120,
                                      ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 80, left: 80),
                                child: Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    color: Colors.lightBlue,
                                  ),
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              )
                            ])),
                      ),
                    ),
                    CustomTextFormFieldWidget(
                      controller: model.nameController,
                      labeltext: 'Employee name',
                      isObsure: false,
                      type: InputTextType.name,
                    ),
                    DatePickerWidget(
                        labeltext: 'yyyy-mm-dd',
                        controller: model.dobController),
                    CustomTextFormFieldWidget(
                        controller: model.emailController,
                        labeltext: 'Email',
                        isObsure: false,
                        type: InputTextType.emailaddress),
                    CustomTextFormFieldWidget(
                        controller: model.mobileNoController,
                        labeltext: 'Mobile Number',
                        isObsure: false,
                        type: InputTextType.number),
                    CustomTextFormFieldWidget(
                        controller: model.addressController,
                        labeltext: 'Address',
                        isObsure: false,
                        type: InputTextType.streetAddress),
                    const SizedBox(
                      height: 18,
                    ),
                    MultiDropdown<ShiftsModel>(
                      controller: model.controller,
                      items: model.getshift
                          .map((item) =>
                              DropdownItem(label: item.shiftName!, value: item))
                          .toList(),
                      enabled: true,
                      searchEnabled: true,
                      chipDecoration: const ChipDecoration(
                        backgroundColor: Colors.blue,
                        wrap: true,
                        runSpacing: 2,
                        spacing: 10,
                      ),
                      fieldDecoration: const FieldDecoration(
                        backgroundColor: Colors.white,
                        hintText: 'Select shift',
                        hintStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        showClearIcon: false,
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(0),
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(
                              10,
                            ),
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(0),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(10))),
                        errorBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(0),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(10))),
                      ),
                      dropdownDecoration: const DropdownDecoration(
                        marginTop: 2,
                        maxHeight: 500,
                        header: Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            'Select shift from the list',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      dropdownItemDecoration: DropdownItemDecoration(
                        selectedIcon:
                            const Icon(Icons.check_box, color: Colors.blue),
                        disabledIcon:
                            Icon(Icons.lock, color: Colors.grey.shade300),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a shift';
                        }
                        return null;
                      },
                      onSelectionChange: (selectedItems) {
                        model.selectedValue.value = selectedItems
                            .map(
                              (e) => e.shiftId!,
                            )
                            .toList();
                        log("OnSelectionChange: $selectedItems");
                      },
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Obx(
                      () => DropdownButtonFormField2(
                        isExpanded: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 16),
                          border:
                              OutlineInputBorder(borderRadius: borderRadius()),
                        ),
                        items: model.getDepartment
                            .map((item) => DropdownMenuItem(
                                  value: item.departmentname.toString(),
                                  child: Text(
                                    item.departmentname.toString(),
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ))
                            .toList(),
                        value: model.selectedDepartmentValue.value,
                        onChanged: (value) {
                          model.selectedDepartmentValue.value = value!;
                        },
                        // dropdownDecoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(15)),
                        // icon: const Padding(
                        //   padding: EdgeInsets.only(right: 20),
                        //   child: Icon(
                        //     Icons.arrow_forward_ios,
                        //     size: 20,
                        //   ),
                        // ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}

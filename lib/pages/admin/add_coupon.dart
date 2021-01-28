import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ollie_photo_social/components/bottom_next.dart';
import 'package:ollie_photo_social/components/dialog_box.dart';
import 'package:ollie_photo_social/components/responsive_scaffold.dart';
import 'package:ollie_photo_social/constants.dart';
import 'package:ollie_photo_social/components/polling_back_icon.dart';
import 'package:ollie_photo_social/pages/gallery.dart';
import 'package:photo_manager/photo_manager.dart';

class AddCouponPage extends StatefulWidget {
  AddCouponPage({Key key, this.couponLogo}) : super(key: key);
  final String couponLogo;

  @override
  _AddCouponPageState createState() => _AddCouponPageState();
}

class _AddCouponPageState extends State<AddCouponPage> {
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  TextEditingController startDtController = TextEditingController();
  TextEditingController endDtController = TextEditingController();
  String couponImage;

  void createCoupon() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogBox.createSuccess(
          context,
          'Your coupon has been added.',
          () => Navigator.pop(context),
        );
      },
    );
  }

  void _openGallery() async {
    final permitted = await PhotoManager.requestPermission();
    if (!permitted) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => GalleryPage(
          couponPage: true,
          couponImage: this.couponImage,
        ),
      ),
    );
  }

  @override
  void initState() {
    startDtController.text = DateFormat('yyyy/M/d').format(startDate);
    endDtController.text = DateFormat('yyyy/M/d').format(endDate);
    if (widget.couponLogo != null) print('coupon logo ${widget.couponLogo}');
    super.initState();
  }

  void _selectDate(BuildContext context, bool isThis) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: isThis ? startDate : endDate, // Refer step 1
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != (isThis ? startDate : endDate))
      setState(() {
        if (isThis) {
          startDate = picked;
          startDtController.text = DateFormat('yyyy/M/d').format(startDate);
        } else {
          endDate = picked;
          endDtController.text = DateFormat('yyyy/M/d').format(endDate);
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ResponsiveScaffold(
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            width: size.width,
            height: size.height,
            child: Image(
              image: AssetImage('assets/images/layout/new_polling_topbar.png'),
              fit: BoxFit.cover,
            ),
          ),
          Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                PollingBackIcon(
                  title: 'Add Coupon',
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: appPadding * 1.5,
                      horizontal: appPadding,
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Store Name',
                                  style: TextStyle(color: white)),
                              SizedBox(height: appPadding / 4),
                              TextFormField(
                                textAlign: TextAlign.left,
                                decoration: inputDecoration('Store Name'),
                              ),
                              SizedBox(height: appPadding / 2),
                              Text('Offer', style: TextStyle(color: white)),
                              SizedBox(height: appPadding / 4),
                              TextFormField(
                                textAlign: TextAlign.left,
                                decoration: inputDecoration('Offer'),
                              ),
                              SizedBox(height: appPadding / 2),
                              Text('Header', style: TextStyle(color: white)),
                              SizedBox(height: appPadding / 4),
                              TextFormField(
                                textAlign: TextAlign.left,
                                decoration: inputDecoration('Header'),
                              ),
                              SizedBox(height: appPadding / 2),
                              Text('Conditions',
                                  style: TextStyle(color: white)),
                              SizedBox(height: appPadding / 4),
                              TextFormField(
                                textAlign: TextAlign.left,
                                keyboardType: TextInputType.multiline,
                                minLines: 3,
                                maxLines: 3,
                                decoration: inputDecoration('Conditions'),
                              ),
                              SizedBox(height: appPadding / 2),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Start Date',
                                            style: TextStyle(color: white)),
                                        SizedBox(height: appPadding / 4),
                                        TextFormField(
                                          textAlign: TextAlign.left,
                                          keyboardType: TextInputType.datetime,
                                          controller: startDtController,
                                          showCursor: true,
                                          readOnly: true,
                                          onTap: () =>
                                              _selectDate(context, true),
                                          decoration:
                                              inputDecoration('Start Date'),
                                        ),
                                        SizedBox(height: appPadding / 2),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: appPadding * 2.4),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('End Date',
                                            style: TextStyle(color: white)),
                                        SizedBox(height: appPadding / 4),
                                        TextFormField(
                                          textAlign: TextAlign.left,
                                          keyboardType: TextInputType.datetime,
                                          controller: endDtController,
                                          showCursor: true,
                                          readOnly: true,
                                          onTap: () =>
                                              _selectDate(context, false),
                                          decoration:
                                              inputDecoration('End Date'),
                                        ),
                                        SizedBox(height: appPadding / 2),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Terms of Usage',
                                            style: TextStyle(color: white)),
                                        SizedBox(height: appPadding / 4),
                                        TextFormField(
                                          textAlign: TextAlign.left,
                                          keyboardType: TextInputType.datetime,
                                          decoration: inputDecoration('Usage'),
                                        ),
                                        SizedBox(height: appPadding / 2),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: appPadding * 2.4),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Points with',
                                            style: TextStyle(color: white)),
                                        SizedBox(height: appPadding / 4),
                                        TextFormField(
                                          textAlign: TextAlign.left,
                                          keyboardType: TextInputType.datetime,
                                          decoration: inputDecoration('Points'),
                                        ),
                                        SizedBox(height: appPadding / 2),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () => _openGallery(),
                            child: Text(
                              '+ Add Logo',
                              style: TextStyle(color: yellowColor),
                            ),
                          ),
                        ]),
                  ),
                ),
              ],
            ),
          ),
          BottomNextIcon(
            nextAction: createCoupon,
          ),
        ],
      ),
    );
  }
}

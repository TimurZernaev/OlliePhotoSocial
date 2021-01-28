import 'package:flutter/material.dart';
import 'package:ollie_photo_social/components/bottom_next.dart';
import 'package:ollie_photo_social/components/responsive_scaffold.dart';
import 'package:ollie_photo_social/constants.dart';
import 'package:ollie_photo_social/components/polling_back_icon.dart';

class AddCouponPage extends StatefulWidget {
  AddCouponPage({Key key}) : super(key: key);

  @override
  _AddCouponPageState createState() => _AddCouponPageState();
}

class _AddCouponPageState extends State<AddCouponPage> {
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
                    // margin: EdgeInsets.only(top: appPadding),
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
                                decoration: new InputDecoration(
                                    hintText: 'Costa Coffee',
                                    border: new OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                        const Radius.circular(8),
                                      ),
                                      borderSide: new BorderSide(
                                        color: primaryColor,
                                        width: 1.0,
                                      ),
                                    ),
                                    fillColor: white,
                                    filled: true),
                              ),
                              SizedBox(height: appPadding / 2),
                              Text('Offer', style: TextStyle(color: white)),
                              SizedBox(height: appPadding / 4),
                              TextFormField(
                                textAlign: TextAlign.left,
                                decoration: new InputDecoration(
                                    hintText: '10% or 5K.D',
                                    border: new OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                        const Radius.circular(8),
                                      ),
                                      borderSide: new BorderSide(
                                        color: primaryColor,
                                        width: 1.0,
                                      ),
                                    ),
                                    fillColor: white,
                                    filled: true),
                              ),
                              SizedBox(height: appPadding / 2),
                              Text('Header', style: TextStyle(color: white)),
                              SizedBox(height: appPadding / 4),
                              TextFormField(
                                textAlign: TextAlign.left,
                                decoration: new InputDecoration(
                                    hintText:
                                        'Purchase anything from store and get the ...',
                                    border: new OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                        const Radius.circular(8),
                                      ),
                                      borderSide: new BorderSide(
                                        color: primaryColor,
                                        width: 1.0,
                                      ),
                                    ),
                                    fillColor: white,
                                    filled: true),
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
                                decoration: new InputDecoration(
                                    hintText:
                                        'only for 10 k.d products and up does not include sweets',
                                    border: new OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                        const Radius.circular(8),
                                      ),
                                      borderSide: new BorderSide(
                                        color: primaryColor,
                                        width: 1.0,
                                      ),
                                    ),
                                    fillColor: white,
                                    filled: true),
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
                                          decoration: new InputDecoration(
                                              hintText: '2021 / 3 / 22',
                                              border: new OutlineInputBorder(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  const Radius.circular(8),
                                                ),
                                                borderSide: new BorderSide(
                                                  color: primaryColor,
                                                  width: 1.0,
                                                ),
                                              ),
                                              fillColor: white,
                                              filled: true),
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
                                        Text('Start Date',
                                            style: TextStyle(color: white)),
                                        SizedBox(height: appPadding / 4),
                                        TextFormField(
                                          textAlign: TextAlign.left,
                                          keyboardType: TextInputType.datetime,
                                          decoration: new InputDecoration(
                                              hintText: '2021 / 4 / 22',
                                              border: new OutlineInputBorder(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  const Radius.circular(8),
                                                ),
                                                borderSide: new BorderSide(
                                                  color: primaryColor,
                                                  width: 1.0,
                                                ),
                                              ),
                                              fillColor: white,
                                              filled: true),
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
                                          decoration: new InputDecoration(
                                              hintText: '50',
                                              border: new OutlineInputBorder(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  const Radius.circular(8),
                                                ),
                                                borderSide: new BorderSide(
                                                  color: primaryColor,
                                                  width: 1.0,
                                                ),
                                              ),
                                              fillColor: white,
                                              filled: true),
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
                                          decoration: new InputDecoration(
                                              hintText: '50',
                                              border: new OutlineInputBorder(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  const Radius.circular(8),
                                                ),
                                                borderSide: new BorderSide(
                                                  color: primaryColor,
                                                  width: 1.0,
                                                ),
                                              ),
                                              fillColor: white,
                                              filled: true),
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
                            onTap: () => {},
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
          BottomNextIcon(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_manager/constants/colors.dart';
import 'package:shop_manager/constants/fonts.dart';
import 'package:shop_manager/models/requisition.dart';

class RecievedGoodsDetail extends StatelessWidget {
  final Requisition? requisition;
  final VoidCallback onCloseTap;
  const RecievedGoodsDetail(
      {super.key, required this.requisition, required this.onCloseTap});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        margin: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                height: 70,
                child: Stack(
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              requisition!.description!,
                              style: const TextStyle(
                                  color: AppColors.crudTextColor,
                                  fontFamily: AppFonts.poppinsMedium,
                                  fontSize: 18),
                            ),
                            Text(
                              requisition!.user!.name!,
                              style: const TextStyle(
                                color: AppColors.crudTextColor,
                              ),
                            ),
                            Text(
                              DateFormat.yMMMd()
                                  .format(requisition!.dateAdded!),
                              style: const TextStyle(
                                color: AppColors.crudTextColor,
                              ),
                            )
                          ],
                        )),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Material(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                        color: AppColors.primaryColor,
                        elevation: 2,
                        child: InkWell(
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration:
                                const BoxDecoration(shape: BoxShape.circle),
                            child: const Center(
                              child: Icon(
                                Icons.clear,
                                color: Colors.white,
                                size: 12,
                              ),
                            ),
                          ),
                          onTap: () {
                            onCloseTap();
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Products",
                style: TextStyle(color: AppColors.crudTextColor),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                height: 40,
                decoration: const BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))),
                child: const Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 50,
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Name",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Selling Price",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Quantity",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Value",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                  itemCount: requisition!.receivedGoods!.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      width: double.infinity,
                      height: 40,
                      color: index % 2 == 0 ? Colors.white : Colors.grey[100],
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: 50,
                              child: Center(
                                child: Text(
                                  "${index + 1}",
                                  style: const TextStyle(
                                      color: AppColors.crudTextColor),
                                ),
                              )),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                requisition!
                                    .receivedGoods![index].product!.name!,
                                style: const TextStyle(
                                    color: AppColors.crudTextColor),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "GHS ${requisition!.receivedGoods![index].product!.sellingPrice}",
                                style: const TextStyle(
                                    color: AppColors.crudTextColor),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "${requisition!.receivedGoods![index].quantity}",
                                style: const TextStyle(
                                    color: AppColors.crudTextColor),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "GHS ${requisition!.receivedGoods![index].quantity! * requisition!.receivedGoods![index].product!.sellingPrice!}",
                                style: const TextStyle(
                                    color: AppColors.crudTextColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 50,
                    ),
                    Expanded(
                      child: SizedBox(),
                    ),
                    Expanded(
                      child: SizedBox(),
                    ),
                    Expanded(
                      child: SizedBox(),
                    ),
                    Expanded(
                      child: Container(
                          color: AppColors.primaryColor,
                          child: Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              textBaseline: TextBaseline.alphabetic,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              children: [
                                const Text(
                                  "Total:",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "GHS ${requisition!.total}",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontFamily: AppFonts.poppinsMedium),
                                ),
                              ],
                            ),
                          )),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

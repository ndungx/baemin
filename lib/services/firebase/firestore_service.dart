import 'package:baemin/models/category.dart';
import 'package:baemin/models/dish.dart';
import 'package:baemin/models/event_details.dart';
import 'package:baemin/models/mailbox.dart';
import 'package:baemin/models/order.dart';
import 'package:baemin/models/order_details.dart';
import 'package:baemin/models/shop.dart';
import 'package:baemin/models/shop_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireStoreDB {
  late FirebaseFirestore firestore;
  initialize() => firestore = FirebaseFirestore.instance;

  Future<List> getAdvertisementCarouselDoc() async {
    QuerySnapshot querySnapshot;
    List docs = [];

    try {
      querySnapshot = await firestore
          .collection('advertisement_carousel')
          .orderBy('timestamp')
          .limit(6)
          .get();

      if (!querySnapshot.docs.isNotEmpty) return [];

      for (var doc in querySnapshot.docs.toList()) {
        Map adCarousel = {"image": doc['image']};
        docs.add(adCarousel);
      }

      return docs;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List> getCategoryDoc() async {
    QuerySnapshot querySnapshot;
    List<CategoryModel> docs = [];

    try {
      querySnapshot =
          await firestore.collection('category').orderBy('id').limit(8).get();

      if (!querySnapshot.docs.isNotEmpty) return [];

      for (var doc in querySnapshot.docs.toList()) {
        CategoryModel categoryModel = CategoryModel(
          id: doc['id'],
          image: doc['image'],
          text: doc['text'],
        );
        docs.add(categoryModel);
      }

      return docs;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future getEvent({required String eventName}) async {
    DocumentSnapshot documentSnapshot;

    try {
      documentSnapshot =
          await firestore.collection('events').doc(eventName).get();

      if (documentSnapshot.data() == null) return;

      if (documentSnapshot['isCoverImage'] == true) {
        Map event = {
          "title": documentSnapshot['title'],
          "list_event": documentSnapshot['list_event']
        };
        return event;
      } else {
        Map shop = {
          "title": documentSnapshot['title'],
          "subtitle": documentSnapshot['subtitle'],
          "list_shop": documentSnapshot['list_shop']
        };
        return shop;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<ShopModel>> getShops(
      {required List listDocID, bool? isLimit}) async {
    DocumentSnapshot documentSnapshot;
    List<ShopModel> docs = [];

    try {
      if (isLimit == true) {
        for (var docID in listDocID) {
          if (docs.length == 6) return docs;

          documentSnapshot =
              await firestore.collection('shops').doc(docID).get();

          if (!documentSnapshot.exists) continue;

          if (documentSnapshot['isActive'] == true) {
            ShopModel shopModel = ShopModel(
              shopID: documentSnapshot.id,
              shopName: documentSnapshot['shopName'],
              shopCoverImage: documentSnapshot['shopCoverImage'],
              isParner: documentSnapshot['isPartner'],
              isPromo: documentSnapshot['isPromo'],
              shopRating: documentSnapshot['shopRating'],
              ratingCount: documentSnapshot['ratingCount'],
            );
            docs.add(shopModel);
          }
        }
      } else {
        for (var docID in listDocID) {
          documentSnapshot =
              await firestore.collection('shops').doc(docID).get();

          if (!documentSnapshot.exists) continue;

          if (documentSnapshot['isActive'] == true) {
            ShopModel shopModel = ShopModel(
              shopID: documentSnapshot.id,
              shopName: documentSnapshot['shopName'],
              shopCoverImage: documentSnapshot['shopCoverImage'],
              isParner: documentSnapshot['isPartner'],
              isPromo: documentSnapshot['isPromo'],
              shopRating: documentSnapshot['shopRating'],
              ratingCount: documentSnapshot['ratingCount'],
            );
            docs.add(shopModel);
          }
        }
      }
      return docs;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future getShopDetails({required String shopID}) async {
    DocumentSnapshot documentSnapshot;

    try {
      documentSnapshot = await firestore.collection('shops').doc(shopID).get();

      if (!documentSnapshot.exists) return;

      if (documentSnapshot['isActive'] == true) {
        return ShopDetailsModel(
          shopID: documentSnapshot.id,
          shopName: documentSnapshot['shopName'],
          shopLocation: documentSnapshot['shopLocation'],
          shopMenu: documentSnapshot['shopMenu'],
          shopCoverImage: documentSnapshot['shopCoverImage'],
          isParner: documentSnapshot['isPartner'],
          isPromo: documentSnapshot['isPromo'],
          shopRating: documentSnapshot['shopRating'],
          ratingCount: documentSnapshot['ratingCount'],
          shopVouchersID: documentSnapshot['shopVouchersID'],
          businessHours: documentSnapshot['businessHours'],
          latitude: documentSnapshot['latitude'],
          longitude: documentSnapshot['longitude'],
        );
      }
    } catch (e) {
      print(e);
    }
  }

  Future<List> getLovedShopID() async {
    return await firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((value) => value['lovedShopID']);
  }

  addToLovedShop(String shopID) {
    try {
      firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .update({
        'lovedShopID': FieldValue.arrayUnion([shopID])
      });
    } catch (e) {
      print(e);
    }
  }

  removeFromLovedShop(String shopID) {
    try {
      firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .update({
        'lovedShopID': FieldValue.arrayRemove([shopID])
      });
    } catch (e) {
      print(e);
    }
  }

  Future<List<ShopModel>> getLovedShops({required List listLovedShopID}) async {
    DocumentSnapshot documentSnapshot;
    List<ShopModel> docs = [];

    try {
      for (var shopID in listLovedShopID) {
        documentSnapshot =
            await firestore.collection('shops').doc(shopID).get();

        if (documentSnapshot['isActive'] == true) {
          ShopModel shopModel = ShopModel(
            shopID: documentSnapshot.id,
            shopName: documentSnapshot['shopName'],
            shopCoverImage: documentSnapshot['shopCoverImage'],
            isParner: documentSnapshot['isPartner'],
            isPromo: documentSnapshot['isPromo'],
            shopRating: documentSnapshot['shopRating'],
            ratingCount: documentSnapshot['ratingCount'],
          );
          docs.add(shopModel);
        }
      }
      return docs;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<EventDetailsModel>> getEventsDetails(
      {required List listDocID}) async {
    DocumentSnapshot documentSnapshot;
    List<EventDetailsModel> docs = [];

    try {
      for (var docID in listDocID) {
        documentSnapshot =
            await firestore.collection('event_details').doc(docID).get();

        if (!documentSnapshot.exists) continue;

        if (documentSnapshot['isActive'] == true) {
          EventDetailsModel eventModel = EventDetailsModel(
            image: documentSnapshot['image'],
            eventTitle: documentSnapshot['eventTitle'],
            eventDescription: documentSnapshot['eventDescription'],
          );
          docs.add(eventModel);
        }
      }
      return docs;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future getMenu({required List listMenu}) async {
    DocumentSnapshot documentSnapshot;
    List menuList = [];

    try {
      for (var menu in listMenu) {
        documentSnapshot = await firestore.collection('menus').doc(menu).get();

        if (!documentSnapshot.exists) continue;

        Map menuMap = {
          "title": documentSnapshot['title'],
          "listDish": documentSnapshot['listDish'],
        };

        menuList.add(menuMap);
      }
      return menuList;
    } catch (e) {
      print(e);
    }
  }

  Future getDish({required List listDish}) async {
    DocumentSnapshot documentSnapshot;
    List<DishModel> dishList = [];

    try {
      for (var dish in listDish) {
        documentSnapshot = await firestore.collection('dish').doc(dish).get();

        if (!documentSnapshot.exists) continue;

        DishModel dishModel;

        if (documentSnapshot['haveSize'] == true) {
          dishModel = DishModel(
            dishName: documentSnapshot['dishName'],
            dishPrice: documentSnapshot['dishPrice'],
            dishImage: documentSnapshot['dishImage'],
            size: documentSnapshot['size'] ?? '',
          );
        } else {
          dishModel = DishModel(
            dishName: documentSnapshot['dishName'],
            dishPrice: documentSnapshot['dishPrice'],
            dishImage: documentSnapshot['dishImage'],
          );
        }

        dishList.add(dishModel);
      }
      return dishList;
    } catch (e) {
      print(e);
    }
  }

  Future<String> get email async {
    return await firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((value) => value['email']);
  }

  Future<String> get userName async {
    return await firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((value) => value['name']);
  }

  Future<String> get phoneNumber async {
    return await firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((value) => value['phoneNumber']);
  }

  Future<bool> checkAccountExists(String email) async {
    QuerySnapshot querySnapshot;

    try {
      querySnapshot = await firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      if (querySnapshot.docs.isNotEmpty) return true; // account exists

      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<List<String>> getmailIDList() async {
    DocumentSnapshot documentSnapshot;
    List<String> docs = [];

    try {
      documentSnapshot = await firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get();
      if (documentSnapshot.get('mailboxID') != null) {
        documentSnapshot.get('mailboxID').forEach((value) => docs.add(value));
      }
      return docs;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<MailboxModel>> getMailbox(List<String> listMailID) async {
    DocumentSnapshot documentSnapshot;
    List<MailboxModel> docs = [];

    try {
      for (var mailID in listMailID) {
        documentSnapshot =
            await firestore.collection('mailbox').doc(mailID).get();
        if (documentSnapshot.exists) {
          MailboxModel mailboxModel = MailboxModel(
            id: documentSnapshot.id,
            title: documentSnapshot['title'],
            content: documentSnapshot['content'],
            timestamp: documentSnapshot['timestamp'],
            isRead: documentSnapshot['isRead'],
          );
          docs.add(mailboxModel);
        }
      }
      return docs;
    } catch (e) {
      print(e);
      return [];
    }
  }

  updateMailboxReadStatus(String mailID) {
    try {
      firestore.collection('mailbox').doc(mailID).update({'isRead': true});
    } catch (e) {
      print(e);
    }
  }

  Future<bool> checkReadStatus(List<String> listMailID) async {
    DocumentSnapshot documentSnapshot;

    try {
      for (var mailID in listMailID) {
        documentSnapshot =
            await firestore.collection('mailbox').doc(mailID).get();
        if (documentSnapshot['isRead'] == false) return false;
      }
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<String> getShopName({required String shopID}) async {
    return await firestore
        .collection('shops')
        .doc(shopID)
        .get()
        .then((value) => value['shopName']);
  }

  Future<List> get listOrderID async {
    return await firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((value) => value['orderID']);
  }

  Future<List<OrderModel>> getOrder(List listOrderID) async {
    DocumentSnapshot documentSnapshot;
    List<OrderModel> docs = [];

    try {
      for (var mailID in listOrderID) {
        documentSnapshot =
            await firestore.collection('orders').doc(mailID).get();
        if (documentSnapshot.exists) {
          OrderModel orderModel = OrderModel(
            orderID: documentSnapshot.id,
            shopName: documentSnapshot['shopName'],
            dishQuantity: documentSnapshot['dishes'].length,
            totalPrice: documentSnapshot['totalPrice'],
            isDelivered: documentSnapshot['isDelivered'],
            paymentType: documentSnapshot['paymentType'],
            timestamp: documentSnapshot['timestamp'],
          );
          docs.add(orderModel);
        }
      }
      return docs;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future getOrderDetails({required String orderID}) async {
    DocumentSnapshot documentSnapshot;

    try {
      documentSnapshot =
          await firestore.collection('orders').doc(orderID).get();

      if (documentSnapshot.exists) {
        return OrderDetailsModel(
          orderID: documentSnapshot.id,
          shopName: documentSnapshot['shopName'],
          dishQuantity: documentSnapshot['dishes'].length,
          totalPrice: documentSnapshot['totalPrice'],
          isDelivered: documentSnapshot['isDelivered'],
          paymentType: documentSnapshot['paymentType'],
          timestamp: documentSnapshot['timestamp'],
          discountPrice: documentSnapshot['discountPrice'],
          dishes: documentSnapshot['dishes'],
          haveVoucher: documentSnapshot['haveVoucher'],
          ordererAddress: documentSnapshot['ordererAddress'],
          ordererName: documentSnapshot['ordererName'],
          ordererPhoneNumber: documentSnapshot['ordererPhoneNumber'],
          shippingFee: documentSnapshot['shippingFee'],
          minimumOrderFee: documentSnapshot['minimumOrderFee'],
          serviceFee: documentSnapshot['serviceFee'],
          shippingDistance: documentSnapshot['shippingDistance'],
          shopID: documentSnapshot['shopID'],
        );
      }
    } catch (e) {
      print(e);
      return;
    }
  }
}

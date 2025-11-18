import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../models/cart_item_model.dart';

class CartProvider extends GetxService {
  static const String boxName = 'cart';
  Box<CartItemModel>? _box;

  Future<CartProvider> init() async {
    if (!Hive.isBoxOpen(boxName)) {
      _box = await Hive.openBox<CartItemModel>(boxName);
    } else {
      _box = Hive.box<CartItemModel>(boxName);
    }
    return this;
  }

  Box<CartItemModel> get _safeBox {
    if (_box == null) {
      throw HiveError('Box not found. Did you forget to call Hive.openBox()?');
    }
    return _box!;
  }
  
  Box<CartItemModel> get box => _safeBox;

  /// PERBAIKAN — getAll harus async
  Future<List<CartItemModel>> getAll() async {
    if (!Hive.isBoxOpen(boxName)) {
      await init();
    }
    return _safeBox.values.toList();
  }

  Future<void> addItem(CartItemModel item) async {
    try {
      if (!Hive.isBoxOpen(boxName)) await init();

      if (_safeBox.containsKey(item.menuId)) {
        final existing = _safeBox.get(item.menuId)!;
        existing.quantity = existing.quantity + item.quantity;
        await existing.save();
      } else {
        await _safeBox.put(item.menuId, item);
      }
    } catch (e) {
      debugPrint('CartProvider.addItem error: $e');
      rethrow;
    }
  }

  Future<void> addToCart(CartItemModel item) => addItem(item);

  Future<void> removeItem(String menuId) async {
    try {
      if (!Hive.isBoxOpen(boxName)) await init();
      await _safeBox.delete(menuId);
    } catch (e) {
      debugPrint('CartProvider.removeItem error: $e');
      rethrow;
    }
  }

  Future<void> updateItem(CartItemModel item) async {
    try {
      if (!Hive.isBoxOpen(boxName)) await init();
      await _safeBox.put(item.menuId, item);
    } catch (e) {
      debugPrint('CartProvider.updateItem error: $e');
      rethrow;
    }
  }

  Future<void> decrementItem(String menuId) async {
    if (!Hive.isBoxOpen(boxName)) await init();

    final it = _safeBox.get(menuId);
    if (it == null) return;

    if (it.quantity <= 1) {
      await _safeBox.delete(menuId);
    } else {
      it.quantity = it.quantity - 1;
      await it.save();
    }
  }

  Future<void> clear() async {
    if (!Hive.isBoxOpen(boxName)) await init();
    await _safeBox.clear();
  }
}

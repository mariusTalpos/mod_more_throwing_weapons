// ::ModMoreThrowingWeapons.HooksMod.hook("scripts/items/item_container", function(q) {
// 	q.equip = @(__original) function(_item) {
// 		// if (_item.m.ID == "weapon.chakram") {
// 		// 	// Use proper methods to check equipped items
// 		// 	local mainhandItem = this.getItemAtSlot(this.Const.ItemSlot.Mainhand);
// 		// 	local offhandItem = this.getItemAtSlot(this.Const.ItemSlot.Offhand);

// 		// 	::logInfo("Mainhand item: " + mainhandItem);
// 		// 	::logInfo("Offhand item: " + offhandItem);

// 		// 	// Prefer offhand if mainhand is occupied, otherwise use mainhand
// 		// 	if (mainhandItem != null && offhandItem == null) {
// 		// 		::logInfo("Mainhand occupied, offhand empty - assigning chakram to offhand");
// 		// 		_item.m.SlotType = this.Const.ItemSlot.Offhand;
// 		// 	} else {
// 		// 		::logInfo("Assigning chakram to mainhand (default behavior)");
// 		// 		_item.m.SlotType = this.Const.ItemSlot.Mainhand;
// 		// 	}
// 		// }

// 		__original(_item);
// 	}

// 	q.swap = @(__original) function(_itemA, _itemB) {
// 		::logInfo("Swapping items: " + _itemA.m.ID + " <-> " + _itemB.m.ID);
// 		// if (_itemA.m.ID == "weapon.chakram" || _itemB.m.ID == "weapon.chakram") {
// 		// 	// After swapping, ensure chakram has correct SlotType
// 		// 	local chakramItem = (_itemA.m.ID == "weapon.chakram") ? _itemA : _itemB;

// 		// 	// Use proper methods to check equipped items
// 		// 	local mainhandItem = this.getItemAtSlot(this.Const.ItemSlot.Mainhand);
// 		// 	local offhandItem = this.getItemAtSlot(this.Const.ItemSlot.Offhand);

// 		// 	::logInfo("After swap - Mainhand item: " + mainhandItem);
// 		// 	::logInfo("After swap - Offhand item: " + offhandItem);

// 		// 	// Prefer offhand if mainhand is occupied, otherwise use mainhand
// 		// 	if (mainhandItem != null && offhandItem == null) {
// 		// 		::logInfo("After swap - Mainhand occupied, offhand empty - assigning chakram to offhand");
// 		// 		chakramItem.m.SlotType = this.Const.ItemSlot.Offhand;
// 		// 	} else {
// 		// 		::logInfo("After swap - Assigning chakram to mainhand (default behavior)");
// 		// 		chakramItem.m.SlotType = this.Const.ItemSlot.Mainhand;
// 		// 	}
// 		// }

// 		__original(_itemA, _itemB);
// 	}

// });

// Dual Weilding is in hold
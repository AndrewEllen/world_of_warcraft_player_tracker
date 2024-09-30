class Player {
  String name;
  String classType;
  String role;
  int itemLevel;
  List<Gear> equippedGear;
  bool isOnline;
  bool isAvailableForRaid;

  Player({
    required this.name,
    required this.classType,
    required this.role,
    required this.itemLevel,
    required this.equippedGear,
    this.isOnline = false,
    this.isAvailableForRaid = false,
  });
}

class Gear {
  String itemName;
  String itemType;  // e.g., Helmet, Chest, etc.
  int itemLevel;
  String upgradeTrack;  // e.g., Mythic, Heroic
  bool isTierPiece;

  Gear({
    required this.itemName,
    required this.itemType,
    required this.itemLevel,
    required this.upgradeTrack,
    this.isTierPiece = false,
  });
}

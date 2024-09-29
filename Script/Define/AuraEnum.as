
enum EPlayerModule {
	None = 0,
	Gas  = 1,
}

enum EItemID {
	None          = 0,
	HealthPotion  = 1,
	ManaPotion    = 2,
	HealthCrystal = 3,
	ManaCrystal   = 4,
}

enum ECharacterClass {
	None    = 0,
	Warrior = 1,
	Archer  = 2,
	Mage    = 3,
}

enum ETickerFuncType {
	None = 0,

	BodyDissolve   = 1,
	WeaponDissolve = 2,
}

enum EDamageType {
	None = 0,
	Miss = 1,
	Lucky = 2,
	Critical = 3,
}

// Enum Alias
namespace AuraEnum {
	const ECollisionChannel ECC_Projectile = ECollisionChannel::ECC_GameTraceChannel1;
}

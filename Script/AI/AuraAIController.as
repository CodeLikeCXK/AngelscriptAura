
class AAuraAIController : AAIController {
	UPROPERTY(DefaultComponent)
	UBehaviorTreeComponent BehaviorTreeComponent;

	AAuraCharacter OwnerCharacter;

	UFUNCTION(BlueprintOverride)
	void BeginPlay()
	{
		OwnerCharacter = Cast<AAuraCharacter>(ControlledPawn);
	}


	UFUNCTION()
	void Aura_JumpToDestination(float EndPosX,float EndPosY, float EndPosZ)
	{
		FVector StartPosition = OwnerCharacter.GetActorLocation();
		FVector EndPosition = FVector(EndPosX,EndPosY,EndPosZ);
		FVector OutLaunchVelocity;
		Gameplay::SuggestProjectileVelocity_CustomArc(OutLaunchVelocity,StartPosition,EndPosition);
		Print("OutLaunchVelocity" + OutLaunchVelocity,5.f,FLinearColor::Red);
		OwnerCharacter.LaunchCharacter(OutLaunchVelocity,true,true);
	}

}

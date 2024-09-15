
class UAGA_FireBolt : UAuraGameplayAbility
{
	UPROPERTY()
	TSubclassOf<AAuraProjectile> ProjectileClass;

	UPROPERTY()
	UAnimMontage AM_FireBolt;

	UFUNCTION(BlueprintOverride)
	void ActivateAbility()
	{
		if (!HasAuthority()) {
			return;
		}

		auto MontagePlayTask = AngelscriptAbilityTask::PlayMontageAndWait(this, n"FireBolt", AM_FireBolt);
		// MontagePlayTask.OnCompleted.AddUFunction(this, n"OnFireBoltMontageCompleted"); // 改到 AnimNotify 里触发了，这里触发效果不对
		MontagePlayTask.ReadyForActivation();

		UAbilityTask_WaitGameplayEvent WaitGameplayEvent = AngelscriptAbilityTask::WaitGameplayEvent(this, GameplayTags::Event_Montage_FireBolt);
		WaitGameplayEvent.EventReceived.AddUFunction(this, n"SpawnFireBoltProjectile");
		WaitGameplayEvent.ReadyForActivation();

		UAAT_TargetDataUnderMouse TargetDataUnderMouse = Cast<UAAT_TargetDataUnderMouse>(UAngelscriptAbilityTask::CreateAbilityTask(UAAT_TargetDataUnderMouse, this));
		TargetDataUnderMouse.OnMouseTargetData.BindUFunction(this, n"OnMouseTargetData");
		TargetDataUnderMouse.ReadyForActivation();
	}

	UFUNCTION()
	private void SpawnFireBoltProjectile(FGameplayEventData Payload)
	{
		AAuraCharacterBase AvatarActor = Cast<AAuraCharacterBase>(GetAvatarActorFromActorInfo());
		if (AvatarActor != nullptr) {
			AActor ProjectileActor = SpawnActor(ProjectileClass, AvatarActor.GetWeaponSocketLocation(), FRotator::ZeroRotator, n"FireBolt", true);
			if (ProjectileActor != nullptr) {
				FinishSpawningActor(ProjectileActor);
			}
		}
		EndAbility();
	}

	UFUNCTION()
	private void OnMouseTargetData(const FVector& Data)
	{
		Print(f"OnMouseTargetData {Data}");
	}
}
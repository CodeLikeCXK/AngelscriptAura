
class UAGA_SpellBase : UAuraGameplayAbility
{
	// -------------------- Properties --------------------
	UPROPERTY(Category = "Aura")
	UAnimMontage AnimMontage;

	UPROPERTY(Category = "Aura")
	FGameplayTag EventTag;

	// -------------------- Varibles --------------------
	protected FVector TargetLocation;

	// -------------------- Functions --------------------
	UFUNCTION(BlueprintOverride)
	void ActivateAbility()
	{
		if (!HasAuthority()) {
			return;
		}

		UAbilityTask_PlayMontageAndWait MontagePlayTask = AngelscriptAbilityTask::PlayMontageAndWait(this, n"AnimMontage", AnimMontage);
		// Also can be triggered with OnCompleted, but this is not the effect we want. So we use AnimNotify instead.
		// MontagePlayTask.OnCompleted.AddUFunction(this, n"SpawnFireBoltProjectile");
		MontagePlayTask.ReadyForActivation();

		UAbilityTask_WaitGameplayEvent WaitGameplayEvent = AngelscriptAbilityTask::WaitGameplayEvent(this, EventTag);
		WaitGameplayEvent.EventReceived.AddUFunction(this, n"OnGameplayEventReceived");
		WaitGameplayEvent.ReadyForActivation();

		UAAT_TargetDataUnderMouse TargetDataUnderMouse = Cast<UAAT_TargetDataUnderMouse>(UAngelscriptAbilityTask::CreateAbilityTask(UAAT_TargetDataUnderMouse, this));
		TargetDataUnderMouse.OnMouseTargetData.BindUFunction(this, n"OnMouseTargetData");
		TargetDataUnderMouse.ReadyForActivation();
	}

	UFUNCTION()
	protected void OnGameplayEventReceived(FGameplayEventData Payload)
	{// virtual empty
	}

	UFUNCTION()
	private void OnMouseTargetData(const FVector& Data)
	{
		// Print(f"OnMouseTargetData {Data}");
		TargetLocation = Data;
	}
}

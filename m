From: Vijay Viswanath <vviswana@codeaurora.org>
Subject: Re: [PATCH v2 4/4] mmc: sdhci-msm: Add sdhci msm register write APIs
 which wait for pwr irq
Date: Wed, 30 May 2018 12:41:00 +0530
Message-ID: <6c84f6fc-270c-d826-6d87-7f9f6fc5015f@codeaurora.org>
References: <1506490483-46871-1-git-send-email-vviswana@codeaurora.org>
 <1506490483-46871-5-git-send-email-vviswana@codeaurora.org>
 <74a4fe0e-7ae8-9f49-5614-1e01ae977475@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <74a4fe0e-7ae8-9f49-5614-1e01ae977475@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Georgi Djakov <georgi.djakov@linaro.org>
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org, will.deacon@arm.com, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, asutoshd@codeaurora.org, stummala@codeaurora.org, riteshh@codeaurora.org, subhashj@codeaurora.org, Bjorn Andersson <bjorn.andersson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi Georgi,

Thanks for testing the patch on 8096 and pointing out this issue.
The issue is coming because, when card is removed, the HOST_CONTROL2 
register is retaining the 1.8V Signalling enable bit till SDHCI reset 
happens after a new card is inserted.

Adding the change you suggested can avoid this wait, but I feel a better 
solution is to clear the 1.8V signalling bit when the card is removed. 
When a new card is inserted, we shouldn't be keeping the 1.8V bit set 
until we send cmd11 to the SD card. A new SD card should start with 3V.

One solution is to explicitly clear the HOST_CONTROL2 register when card 
is removed.

Other way is to revert the commit: 
9718f84b85396e090ca42fafa730410d286d61e3 "mmc: sdhci-msm: Do not reset 
the controller if no card in the slot"

The sdhci-msm doesn't require "SDHCI_QUIRK_NO_CARD_NO_RESET". The issue 
which above commit is trying to avoid is fixed by the pwr-irq patches. 
Resetting the controller will clear the HOST_CONTROL2 register and avoid 
this issue.

Can you please try this ? I tested reverting the QUIRK on two platforms: 
db410c(8916) and sdm845. SD card insert/remove worked fine after that 
and I didn't get any "Reset 0x1 never completed" error during card 
insert/remove or shutdown.

Thanks,
Vijay

On 5/29/2018 5:49 PM, Georgi Djakov wrote:
> Hello Vijay,
> 
> On 09/27/2017 08:34 AM, Vijay Viswanath wrote:
>> Register writes which change voltage of IO lines or turn the IO bus
>> on/off require controller to be ready before progressing further. When
>> the controller is ready, it will generate a power irq which needs to be
>> handled. The thread which initiated the register write should wait for
>> power irq to complete. This will be done through the new sdhc msm write
>> APIs which will check whether the particular write can trigger a power
>> irq and wait for it with a timeout if it is expected.
>> The SDHC core power control IRQ gets triggered when -
>> * There is a state change in power control bit (bit 0)
>>    of SDHCI_POWER_CONTROL register.
>> * There is a state change in 1.8V enable bit (bit 3) of
>>    SDHCI_HOST_CONTROL2 register.
>> * Bit 1 of SDHCI_SOFTWARE_RESET is set.
>>
>> Also add support APIs which are used by sdhc msm write APIs to check
>> if power irq is expected to be generated and wait for the power irq
>> to come and complete if the irq is expected.
>>
>> This patch requires CONFIG_MMC_SDHCI_IO_ACCESSORS to be enabled.
>>
>> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
>> Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
>> ---
>>   drivers/mmc/host/sdhci-msm.c | 173 ++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 171 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> 
> [..]
> 
>> +/*
>> + * sdhci_msm_check_power_status API should be called when registers writes
>> + * which can toggle sdhci IO bus ON/OFF or change IO lines HIGH/LOW happens.
>> + * To what state the register writes will change the IO lines should be passed
>> + * as the argument req_type. This API will check whether the IO line's state
>> + * is already the expected state and will wait for power irq only if
>> + * power irq is expected to be trigerred based on the current IO line state
>> + * and expected IO line state.
>> + */
>> +static void sdhci_msm_check_power_status(struct sdhci_host *host, u32 req_type)
>> +{
>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
>> +	bool done = false;
>> +
>> +	pr_debug("%s: %s: request %d curr_pwr_state %x curr_io_level %x\n",
>> +			mmc_hostname(host->mmc), __func__, req_type,
>> +			msm_host->curr_pwr_state, msm_host->curr_io_level);
>> +
>> +	/*
>> +	 * The IRQ for request type IO High/LOW will be generated when -
>> +	 * there is a state change in 1.8V enable bit (bit 3) of
>> +	 * SDHCI_HOST_CONTROL2 register. The reset state of that bit is 0
>> +	 * which indicates 3.3V IO voltage. So, when MMC core layer tries
>> +	 * to set it to 3.3V before card detection happens, the
>> +	 * IRQ doesn't get triggered as there is no state change in this bit.
>> +	 * The driver already handles this case by changing the IO voltage
>> +	 * level to high as part of controller power up sequence. Hence, check
>> +	 * for host->pwr to handle a case where IO voltage high request is
>> +	 * issued even before controller power up.
>> +	 */
>> +	if ((req_type & REQ_IO_HIGH) && !host->pwr) {
>> +		pr_debug("%s: do not wait for power IRQ that never comes, req_type: %d\n",
>> +				mmc_hostname(host->mmc), req_type);
>> +		return;
>> +	}
>> +	if ((req_type & msm_host->curr_pwr_state) ||
>> +			(req_type & msm_host->curr_io_level))
>> +		done = true;
>> +	/*
>> +	 * This is needed here to handle cases where register writes will
>> +	 * not change the current bus state or io level of the controller.
>> +	 * In this case, no power irq will be triggerred and we should
>> +	 * not wait.
>> +	 */
>> +	if (!done) {
>> +		if (!wait_event_timeout(msm_host->pwr_irq_wait,
>> +				msm_host->pwr_irq_flag,
>> +				msecs_to_jiffies(MSM_PWR_IRQ_TIMEOUT_MS)))
>> +			__WARN_printf("%s: pwr_irq for req: (%d) timed out\n",
>> +					mmc_hostname(host->mmc), req_type);
> 
> I am seeing the above error message on a db820c device (apq8096). When i
> unplug the SD card and then plug it back in, there is a 5 sec card
> detection delay and a timeout. Here is a log:
> 
> [   50.253997] mmc0: card 59b4 removed
> [   50.381874] mmc0: sdhci_msm_check_power_status: request 1
> curr_pwr_state 2 curr_io_level 4 sdhci_host_ctrl2 b
> [   50.382656] mmc0: sdhci_msm_check_power_status: request 1 done
> [   50.392493] mmc0: sdhci_msm_check_power_status: request 4
> curr_pwr_state 1 curr_io_level 4 sdhci_host_ctrl2 b
> [   50.398258] mmc0: sdhci_msm_check_power_status: request 4 done
> [   50.408728] mmc0: sdhci_msm_check_power_status: request 4
> curr_pwr_state 1 curr_io_level 4 sdhci_host_ctrl2 8
> [   50.413865] mmc0: sdhci_msm_check_power_status: request 4 done
> [   54.966316] mmc0: sdhci_msm_check_power_status: request 2
> curr_pwr_state 1 curr_io_level 4 sdhci_host_ctrl2 8  <-- card is plugged
> [   54.967756] mmc0: sdhci_msm_check_power_status: request 2 done
> [   54.976822] mmc0: sdhci_msm_check_power_status: request 4
> curr_pwr_state 2 curr_io_level 8 sdhci_host_ctrl2 8
> [   60.132253] sdhci_msm 74a4900.sdhci: mmc0: pwr_irq for req: (4) timed out
> [   60.132782] mmc0: sdhci_msm_check_power_status: request 4 done
> [   60.139888] mmc0: sdhci_msm_check_power_status: request 4
> curr_pwr_state 2 curr_io_level 8 sdhci_host_ctrl2 8
> [   65.252497] sdhci_msm 74a4900.sdhci: mmc0: pwr_irq for req: (4) timed out
> 
> The following patch seem to "fix" it.
> 
> -- >8 --
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index b2d875afae5f..ca8ad4edcf80 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -1049,6 +1049,11 @@ static void sdhci_msm_check_power_status(struct
> sdhci_host *host, u32 req_type)
>                  return;
>          }
> 
> +       if (req_type & REQ_IO_LOW &&
> +           msm_host->curr_pwr_state & REQ_BUS_ON &&
> +           msm_host->curr_io_level & REQ_IO_HIGH &&
> +           !host->pwr)
> +               done = true;
>          /*
>           * The IRQ for request type IO High/LOW will be generated when -
>           * there is a state change in 1.8V enable bit (bit 3) of
> -- >8 --
> 
> Reverting this patch series or applying the above patch makes the issue
> go away. According to the log, there is no change in the
> sdhci_host_ctrl2 register. What do you think?
> 
> Thanks,
> Georgi
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

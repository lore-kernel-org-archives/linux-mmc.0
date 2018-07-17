From: Vijay Viswanath <vviswana@codeaurora.org>
Subject: Re: [PATCH RFC 1/2] mmc: sdhci: Allow platform controlled voltage
 switching
Date: Tue, 17 Jul 2018 15:15:12 +0530
Message-ID: <8c4fb768-3d4f-da45-3115-30bc5c1058a6@codeaurora.org>
References: <1529583826-42020-1-git-send-email-vviswana@codeaurora.org>
 <1529583826-42020-2-git-send-email-vviswana@codeaurora.org>
 <53c6d61f-47f5-2e4e-8280-6f76f707799e@intel.com>
 <0d9b1934-d80d-a726-8094-688c97474afa@codeaurora.org>
 <78dfa5db-712b-bb0c-ad03-761371beef10@intel.com>
 <c721395a-0198-d533-5e40-42e4856f34e5@codeaurora.org>
 <6e8c713f-6569-25f3-dec5-f08001b3c6f3@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6e8c713f-6569-25f3-dec5-f08001b3c6f3@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, devicetree@vger.kernel.org, asutoshd@codeaurora.org, stummala@codeaurora.org, venkatg@codeaurora.org, jeremymc@redhat.com, bjorn.andersson@linaro.org, riteshh@codeaurora.org, vbadigan@codeaurora.org, dianders@google.com, sayalil@codeaurora.org, Evan Green <evgreen@chromium.org>
List-Id: linux-mmc@vger.kernel.org



On 7/17/2018 2:12 PM, Adrian Hunter wrote:
> On 17/07/18 11:40, Vijay Viswanath wrote:
>>
>>
>> On 7/17/2018 1:00 PM, Adrian Hunter wrote:
>>> On 17/07/18 08:14, Vijay Viswanath wrote:
>>>>
>>>>
>>>> On 7/10/2018 4:37 PM, Adrian Hunter wrote:
>>>>> On 21/06/18 15:23, Vijay Viswanath wrote:
>>>>>> Some controllers can have internal mechanism to inform the SW that it
>>>>>> is ready for voltage switching. For such controllers, changing voltage
>>>>>> before the HW is ready can result in various issues.
>>>>>>
>>>>>> Add a quirk, which can be used by drivers of such controllers.
>>>>>>
>>>>>> Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
>>>>>> ---
>>>>>>     drivers/mmc/host/sdhci.c | 20 +++++++++++++++-----
>>>>>>     drivers/mmc/host/sdhci.h |  2 ++
>>>>>>     2 files changed, 17 insertions(+), 5 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>>>>> index 1c828e0..f0346d4 100644
>>>>>> --- a/drivers/mmc/host/sdhci.c
>>>>>> +++ b/drivers/mmc/host/sdhci.c
>>>>>> @@ -1615,7 +1615,8 @@ void sdhci_set_power_noreg(struct sdhci_host *host,
>>>>>> unsigned char mode,
>>>>>>     void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
>>>>>>                  unsigned short vdd)
>>>>>>     {
>>>>>> -    if (IS_ERR(host->mmc->supply.vmmc))
>>>>>> +    if (IS_ERR(host->mmc->supply.vmmc) ||
>>>>>> +            (host->quirks2 & SDHCI_QUIRK2_INTERNAL_PWR_CTL))
>>>>>
>>>>> I think you should provide your own ->set_power() instead of this
>>>>>
>>>>
>>>> will do
>>>>
>>>>>>             sdhci_set_power_noreg(host, mode, vdd);
>>>>>>         else
>>>>>>             sdhci_set_power_reg(host, mode, vdd);
>>>>>> @@ -2009,7 +2010,9 @@ int sdhci_start_signal_voltage_switch(struct
>>>>>> mmc_host *mmc,
>>>>>>             ctrl &= ~SDHCI_CTRL_VDD_180;
>>>>>>             sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
>>>>>>     -        if (!IS_ERR(mmc->supply.vqmmc)) {
>>>>>> +        if (!IS_ERR(mmc->supply.vqmmc) &&
>>>>>> +                !(host->quirks2 &
>>>>>> +                    SDHCI_QUIRK2_INTERNAL_PWR_CTL)) {
>>>>>
>>>>> And your own ->start_signal_voltage_switch()
>>>>>
>>>>
>>>> sdhci_msm_start_signal_voltage_switch() would be an exact copy of
>>>> sdhci_start_signal_voltage_switch()..... will incorporate this if not using
>>>> quirk.
>>>>
>>>>>>                 ret = mmc_regulator_set_vqmmc(mmc, ios);
>>>>>>                 if (ret) {
>>>>>>                     pr_warn("%s: Switching to 3.3V signalling voltage
>>>>>> failed\n",
>>>>>> @@ -2032,7 +2035,8 @@ int sdhci_start_signal_voltage_switch(struct
>>>>>> mmc_host *mmc,
>>>>>>         case MMC_SIGNAL_VOLTAGE_180:
>>>>>>             if (!(host->flags & SDHCI_SIGNALING_180))
>>>>>>                 return -EINVAL;
>>>>>> -        if (!IS_ERR(mmc->supply.vqmmc)) {
>>>>>> +        if (!IS_ERR(mmc->supply.vqmmc) &&
>>>>>> +            !(host->quirks2 & SDHCI_QUIRK2_INTERNAL_PWR_CTL)) {
>>>>>>                 ret = mmc_regulator_set_vqmmc(mmc, ios);
>>>>>>                 if (ret) {
>>>>>>                     pr_warn("%s: Switching to 1.8V signalling voltage
>>>>>> failed\n",
>>>>>> @@ -3485,7 +3489,10 @@ int sdhci_setup_host(struct sdhci_host *host)
>>>>>>          * the host can take the appropriate action if regulators are not
>>>>>>          * available.
>>>>>>          */
>>>>>> -    ret = mmc_regulator_get_supply(mmc);
>>>>>> +    if (!(host->quirks2 & SDHCI_QUIRK2_INTERNAL_PWR_CTL))
>>>>>
>>>>> Since we expect mmc_regulator_get_supply() to have been called, this could
>>>>> be:
>>>>>
>>>>>       if (!mmc->supply.vmmc) {
>>>>>           ret = mmc_regulator_get_supply(mmc);
>>>>>           enable_vqmmc = true;
>>>>>       } else {
>>>>>           ret = 0;
>>>>>       }
>>>>>>> +        ret = mmc_regulator_get_supply(mmc);
>>>>>> +    else
>>>>>> +        ret = 0;
>>>>>>         if (ret)
>>>>>>             return ret;
>>>>>>     @@ -3736,7 +3743,10 @@ int sdhci_setup_host(struct sdhci_host *host)
>>>>>>           /* If vqmmc regulator and no 1.8V signalling, then there's no
>>>>>> UHS */
>>>>>>         if (!IS_ERR(mmc->supply.vqmmc)) {
>>>>>> -        ret = regulator_enable(mmc->supply.vqmmc);
>>>>>> +        if (!(host->quirks2 & SDHCI_QUIRK2_INTERNAL_PWR_CTL))
>>>>>
>>>>> And this could be:
>>>>>
>>>>>           if (enable_vqmmc)
>>>>>               ret = regulator_enable(mmc->supply.vqmmc);
>>>>>           else
>>>>>               ret = 0;
>>>>>    > However, you still need to ensure
>>>>> regulator_disable(mmc->supply.vqmmc) is
>>>>> only called if regulator_enable() was called.
>>>> I missed this. Will cover it.
>>>>
>>>> Also I missed one more place where we are doing regulator_disable. During
>>>> sdhci-msm unbinding, we would end up doing an extra regulator disable
>>>> (thanks Evan for pointing it out) in sdhci_remove_host.
>>>>
>>>> To avoid the quirk( or having any flag), it would require copying the code
>>>> of sdhci_start_signal_voltage_switch() and sdhci_remove_host() and creating
>>>
>>> You do not need to duplicate sdhci_remove_host(), just change it so that it
>>> only  disables what was enabled i.e.
>>>
>>>      if (host->vqmmc_enabled)
>>>          regulator_disable(mmc->supply.vqmmc);
>>>
>>
>> Ok, so we will be adding a new flag "vqmmc_enabled" in sdhci_host, ryt ?
> 
> Yes
> 

Ok.
Any particular reason why we are avoiding quirk and instead adding a new 
flag ?

>> Just wanted to clarify
>>
>>>> 2 new functions in sdhci_msm layer which would do the exact same as above,
>>>> with just the regulator parts removed.
>>>>
>>>> This looks messy (considering any future changes to the 2 sdhci API will
>>>> need to be copied to their duplicate sdhci_msm API) and a bit overkill to
>>>> avoid quirk. At the same time, I don't know how useful such a quirk would be
>>>> to other platform drivers.
>>>>
>>>> Please let me know your view/suggestions.
>>>
>>> Let's try without the quirk.
>>>
>>>>>
>>>>>> +            ret = regulator_enable(mmc->supply.vqmmc);
>>>>>> +        else
>>>>>> +            ret = 0;
>>>>>>             if (!regulator_is_supported_voltage(mmc->supply.vqmmc, 1700000,
>>>>>>                                 1950000))
>>>>>>                 host->caps1 &= ~(SDHCI_SUPPORT_SDR104 |
>>>>>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>>>>>> index 23966f8..3b0c97a 100644
>>>>>> --- a/drivers/mmc/host/sdhci.h
>>>>>> +++ b/drivers/mmc/host/sdhci.h
>>>>>> @@ -450,6 +450,8 @@ struct sdhci_host {
>>>>>>      * obtainable timeout.
>>>>>>      */
>>>>>>     #define SDHCI_QUIRK2_DISABLE_HW_TIMEOUT            (1<<17)
>>>>>> +/* Regulator voltage changes are being done from platform layer */
>>>>>> +#define SDHCI_QUIRK2_INTERNAL_PWR_CTL                (1<<18)
>>>>>
>>>>> So maybe the quirk is not needed.
>>>>>
>>>>>>           int irq;        /* Device IRQ */
>>>>>>         void __iomem *ioaddr;    /* Mapped address */
>>>>>>
>>>>>
>>>>
>>>> Thanks for the review & suggestions!
>>>> Vijay
>>>>
>>>
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

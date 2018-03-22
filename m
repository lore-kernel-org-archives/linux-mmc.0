From: Jeremy McNicoll <jmcnicol@redhat.com>
Subject: Re: [PATCH V2 1/2] mmc: sdhci-msm: Add support to store supported
 vdd-io voltages
Date: Thu, 22 Mar 2018 01:04:07 -0700
Message-ID: <89a4b917-09ad-07e9-c935-96a073de4a6f@redhat.com>
References: <1518415278-59062-1-git-send-email-vviswana@codeaurora.org>
 <1518415278-59062-2-git-send-email-vviswana@codeaurora.org>
 <CAD=FV=VZVcN+47=KVkjDsoMtEaznDrNQSOj_iOdVpXDN8NURig@mail.gmail.com>
 <19cc8cdf-3c75-5bde-08b2-34c4f4a2d5fa@redhat.com>
 <ab80d114-9060-1fd0-dc42-6319a4e50d61@codeaurora.org>
 <CAD=FV=WyEa1sVcU1N2ZkxUfE5VHcA-RpS=9031miGieanrxm8A@mail.gmail.com>
 <3446c68e-17fd-8454-92c7-71d37598a914@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3446c68e-17fd-8454-92c7-71d37598a914@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vijay Viswanath <vviswana@codeaurora.org>, Doug Anderson <dianders@chromium.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, asutoshd@codeaurora.org, stummala@codeaurora.org, venkatg@codeaurora.org, pramod.gurav@linaro.org, jeremymc@redhat.com, evgreen@chromium.org
List-Id: linux-mmc@vger.kernel.org

On 2018-03-19 5:32 AM, Vijay Viswanath wrote:
> 
> 
> On 3/7/2018 9:42 PM, Doug Anderson wrote:
>> Hi,
>>
>> On Tue, Mar 6, 2018 at 11:13 PM, Vijay Viswanath
>> <vviswana@codeaurora.org> wrote:
>>> Hi Dough, Jeremy,
>>>
>>>
>>> On 3/3/2018 4:38 AM, Jeremy McNicoll wrote:
>>>>
>>>> On 2018-03-02 10:23 AM, Doug Anderson wrote:
>>>>>
>>>>> Hi,
>>>>>
>>>>> On Sun, Feb 11, 2018 at 10:01 PM, Vijay Viswanath
>>>>> <vviswana@codeaurora.org> wrote:
>>>>>>
>>>>>> During probe check whether the vdd-io regulator of sdhc platform 
>>>>>> device
>>>>>> can support 1.8V and 3V and store this information as a capability of
>>>>>> platform device.
>>>>>>
>>>>>> Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
>>>>>> ---
>>>>>>    drivers/mmc/host/sdhci-msm.c | 38
>>>>>> ++++++++++++++++++++++++++++++++++++++
>>>>>>    1 file changed, 38 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/mmc/host/sdhci-msm.c 
>>>>>> b/drivers/mmc/host/sdhci-msm.c
>>>>>> index c283291..5c23e92 100644
>>>>>> --- a/drivers/mmc/host/sdhci-msm.c
>>>>>> +++ b/drivers/mmc/host/sdhci-msm.c
>>>>>> @@ -23,6 +23,7 @@
>>>>>>    #include <linux/iopoll.h>
>>>>>>
>>>>>>    #include "sdhci-pltfm.h"
>>>>>> +#include <linux/regulator/consumer.h>
>>>>>
>>>>>
>>>>> This is a strange sort order for this include file.  Why is it after
>>>>> the local include?
>>>>>
>>>>>
>>>>>>    #define CORE_MCI_VERSION               0x50
>>>>>>    #define CORE_VERSION_MAJOR_SHIFT       28
>>>>>> @@ -81,6 +82,9 @@
>>>>>>    #define CORE_HC_SELECT_IN_HS400        (6 << 19)
>>>>>>    #define CORE_HC_SELECT_IN_MASK (7 << 19)
>>>>>>
>>>>>> +#define CORE_3_0V_SUPPORT      (1 << 25)
>>>>>> +#define CORE_1_8V_SUPPORT      (1 << 26)
>>>>>> +
>>>>>
>>>>>
>>>>> Is there something magical about 25 and 26?  This is a new caps field,
>>>>> so I'd have expected 0 and 1.
>>>>>
>>>>>
>>>
>>> Yes, these bits are the same corresponding to the capabilities in the
>>> Capabilities Register (offset 0x40). The bit positions become 
>>> important when
>>> capabilities register doesn't show support to some voltages, but we can
>>> support those voltages. At that time, we will have to fake 
>>> capabilities. The
>>> changes for those are currently not yet pushed up.
>>>
>>>
>>>>>>    #define CORE_CSR_CDC_CTLR_CFG0         0x130
>>>>>>    #define CORE_SW_TRIG_FULL_CALIB                BIT(16)
>>>>>>    #define CORE_HW_AUTOCAL_ENA            BIT(17)
>>>>>> @@ -148,6 +152,7 @@ struct sdhci_msm_host {
>>>>>>           u32 curr_io_level;
>>>>>>           wait_queue_head_t pwr_irq_wait;
>>>>>>           bool pwr_irq_flag;
>>>>>> +       u32 caps_0;
>>>>>>    };
>>>>>>
>>>>>>    static unsigned int msm_get_clock_rate_for_bus_mode(struct 
>>>>>> sdhci_host
>>>>>> *host,
>>>>>> @@ -1313,6 +1318,35 @@ static void sdhci_msm_writeb(struct sdhci_host
>>>>>> *host, u8 val, int reg)
>>>>>>                   sdhci_msm_check_power_status(host, req_type);
>>>>>>    }
>>>>>>
>>>>>> +static int sdhci_msm_set_regulator_caps(struct sdhci_msm_host
>>>>>> *msm_host)
>>>>>> +{
>>>>>> +       struct mmc_host *mmc = msm_host->mmc;
>>>>>> +       struct regulator *supply = mmc->supply.vqmmc;
>>>>>> +       int i, count;
>>>>>> +       u32 caps = 0, vdd_uV;
>>>>>> +
>>>>>> +       if (!IS_ERR(mmc->supply.vqmmc)) {
>>>>>> +               count = regulator_count_voltages(supply);
>>>>>> +               if (count < 0)
>>>>>> +                       return count;
>>>>>> +               for (i = 0; i < count; i++) {
>>>>>> +                       vdd_uV = regulator_list_voltage(supply, i);
>>>>>> +                       if (vdd_uV <= 0)
>>>>>> +                               continue;
>>>>>> +                       if (vdd_uV > 2700000)
>>>>>> +                               caps |= CORE_3_0V_SUPPORT;
>>>>>> +                       if (vdd_uV < 1950000)
>>>>>> +                               caps |= CORE_1_8V_SUPPORT;
>>>>>> +               }
>>>>>
>>>>>
>>>>> Shouldn't you be using regulator_is_supported_voltage() rather than
>>>>> open coding?  Also: I've never personally worked on a device where it
>>>>> was used, but there is definitely a concept floating about of a
>>>>> voltage level of 1.2V.  Maybe should copy the ranges from
>>>>> mmc_regulator_set_vqmmc()?
>>>>>
>>>>>
>>>
>>> regulator_is_supported_voltage() checks for a range and it also uses
>>> regulator_list_voltage() internally. regulator_list_voltage() is also an
>>> exported API for use by drivers AFAIK. Please correct if it is not.
>>
>> Sure, regulator_list_voltage() is valid to call.  I'm not saying that
>> your code is wrong or violates abstractions, just that it's
>> essentially re-implementing regulator_is_supported_voltage() for very
>> little gain.  Calling regulator_is_supported_voltage() is better
>> because:
>>
>> 1. In theory, it should generate less code.  Sure, it might loop twice
>> with the current implementation of regulator_is_supported_voltage(),
>> but for a non-time-critical section like this smaller code is likely
>> better than faster code (decreases kernel size / uses up less cache
>> space, etc).
>>
>> 2. If regulator_is_supported_voltage() is ever improved to be more
>> efficient you'll get that improvement automatically.  If someone
>> happened to source vqmmc from a PWM regulator, for instance, trying to
>> enumerate all voltages like this would be a disaster.
>>
>> 3. Code will be simpler to understand.
>>
>> You can replace your whole loop with:
>>
>> if (regulator_is_supported_voltage(mmc->supply.vqmmc, 1700000, 1950000))
>>    caps |= CORE_1_8V_SUPPORT
>> if (regulator_is_supported_voltage(mmc->supply.vqmmc, 2700000, 3600000))
>>    caps |= CORE_3_0V_SUPPORT
>>
>>
>>>>> Also: seems like you should have some way to deal with "caps" ending
>>>>> up w/ no bits set.  IIRC you can have a regulator that can be enabled
>>>>> / disabled but doesn't list a voltage, so if someone messed up their
>>>>> device tree you could end up in this case.  Should you print a
>>>>> warning?  ...or treat it as if we support "3.0V"?  ...or ?  I guess it
>>>>> depends on how do you want patch #2 to behave in that case.
>>>>
>>>>
>>>> Both, initialize it to sane value and print something.  This way at
>>>> least you have a good chance of booting and not hard hanging and you
>>>> are given a reasonable message indicating what needs to be fixed.
>>>>
>>>> -jeremy
>>>>
> 
> Its good to add a warning, but initializing it to some value might not 
> be appropriate. It will be better to leave it blank and if caps doesn't 
> have any of 1.8V/3V, better to not enable IO_PAD_PWR_SWITCH_EN.
> 

That makes sense, this way if someone messes up their dts they will at
least get a message and we won't set the voltage to something that could
potentially destroy / harm the hardware.

-jeremy

>>>>>
>>>>>
>>>>>> +       }
>>>>>
>>>>>
>>>>> How should things behave if vqmmc is an error?  In that case is it
>>>>> important to not set "CORE_IO_PAD_PWR_SWITCH_EN" in patch set #2?
>>>>> ...or should you set "CORE_IO_PAD_PWR_SWITCH_EN" but then make sure
>>>>> you don't set "CORE_IO_PAD_PWR_SWITCH"?
>>>>>
>>>>>
>>>
>>> Thanks for the suggestion. If the regulators exit and doesn't list the
>>> voltages, then I believe initialization itself will not happen. We 
>>> will not
>>> have any available ocr and in sdhci_setup_host it should fail.
>>> But these enhancements can be incorporated. Since this patch is already
>>> acknowledged, I will incorporate these changes in a subsequent patch.
>>
>> It's already acknowledged?  I saw that your RFC was acknowledged by
>> Adrian Hunter but then you didn't include that tag in the posting of
>> v2, so I assumed for some reason it no longer applied.  If you're
>> thinking that Ulf would be the one to apply this patch, he probably
>> doesn't know that it's Acked either.
>>
>> Perhaps Adrian or Ulf can give direction for how they see this patch 
>> proceeding.
>>
>>
> 
> Since I put up V2 anyway, I will include your suggestions and put V3. My 
> mistake, I didn't notice the ACK was for RFC.
> 
>>>>>> +       msm_host->caps_0 |= caps;
>>>>>> +       pr_debug("%s: %s: supported caps: 0x%08x\n", 
>>>>>> mmc_hostname(mmc),
>>>>>> +                       __func__, caps);
>>>>>> +
>>>>>> +       return 0;
>>>>>> +}
>>>>>> +
>>>>>> +
>>>>>>    static const struct of_device_id sdhci_msm_dt_match[] = {
>>>>>>           { .compatible = "qcom,sdhci-msm-v4" },
>>>>>>           {},
>>>>>> @@ -1530,6 +1564,10 @@ static int sdhci_msm_probe(struct 
>>>>>> platform_device
>>>>>> *pdev)
>>>>>>           ret = sdhci_add_host(host);
>>>>>>           if (ret)
>>>>>>                   goto pm_runtime_disable;
>>>>>> +       ret = sdhci_msm_set_regulator_caps(msm_host);
>>>>>> +       if (ret)
>>>>>> +               dev_err(&pdev->dev, "%s: Failed to set regulator 
>>>>>> caps:
>>>>>> %d\n",
>>>>>> +                               __func__, ret);
>>>>>
>>>>>
>>>>> Why do you need __func__ here?  You're already using dev_err(), that
>>>>> gives an idea of where we are.
>>>>>
>>>
>>> dev_err() doesn't give information of where it is getting called.
>>
>> It gives you the driver and the error message should be unique to the
>> driver and easy to find.  Including "__func__ in messages like this is
>> discouraged unless you are in a context where you somehow can't get
>> access to the device pointer.  I suppose ultimately it's up the the
>> maintainer for individual cases but overall I've seen this to be a
>> consistently applied rule in the kernel.
>>
>> In any case, why would this particular print be special that it should
>> include __func__ but all others (in this file, or in dev_err in
>> general) shouldn't?
>>
>>
>>>>>>           pm_runtime_mark_last_busy(&pdev->dev);
>>>>>>           pm_runtime_put_autosuspend(&pdev->dev);
>>>>>> -- 
>>>>>>    Qualcomm India Private Limited, on behalf of Qualcomm Innovation
>>>>>> Center, Inc.
>>>>>> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a
>>>>>> Linux Foundation Collaborative Project.
>>>>>>
>>>>>> -- 
>>>>>> To unsubscribe from this list: send the line "unsubscribe 
>>>>>> linux-mmc" in
>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>>
>>>> -- 
>>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>>> Thanks,
>>> Vijay
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 
> Thanks,
> Vijay
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

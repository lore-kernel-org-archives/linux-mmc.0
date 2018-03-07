From: Vijay Viswanath <vviswana@codeaurora.org>
Subject: Re: [PATCH V2 1/2] mmc: sdhci-msm: Add support to store supported
 vdd-io voltages
Date: Wed, 7 Mar 2018 12:43:02 +0530
Message-ID: <ab80d114-9060-1fd0-dc42-6319a4e50d61@codeaurora.org>
References: <1518415278-59062-1-git-send-email-vviswana@codeaurora.org>
 <1518415278-59062-2-git-send-email-vviswana@codeaurora.org>
 <CAD=FV=VZVcN+47=KVkjDsoMtEaznDrNQSOj_iOdVpXDN8NURig@mail.gmail.com>
 <19cc8cdf-3c75-5bde-08b2-34c4f4a2d5fa@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <19cc8cdf-3c75-5bde-08b2-34c4f4a2d5fa@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy McNicoll <jmcnicol@redhat.com>, Doug Anderson <dianders@chromium.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, asutoshd@codeaurora.org, stummala@codeaurora.org, venkatg@codeaurora.org, pramod.gurav@linaro.org, jeremymc@redhat.com, evgreen@chromium.org
List-Id: linux-mmc@vger.kernel.org

Hi Dough, Jeremy,

On 3/3/2018 4:38 AM, Jeremy McNicoll wrote:
> On 2018-03-02 10:23 AM, Doug Anderson wrote:
>> Hi,
>>
>> On Sun, Feb 11, 2018 at 10:01 PM, Vijay Viswanath
>> <vviswana@codeaurora.org> wrote:
>>> During probe check whether the vdd-io regulator of sdhc platform device
>>> can support 1.8V and 3V and store this information as a capability of
>>> platform device.
>>>
>>> Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
>>> ---
>>>   drivers/mmc/host/sdhci-msm.c | 38 
>>> ++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 38 insertions(+)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
>>> index c283291..5c23e92 100644
>>> --- a/drivers/mmc/host/sdhci-msm.c
>>> +++ b/drivers/mmc/host/sdhci-msm.c
>>> @@ -23,6 +23,7 @@
>>>   #include <linux/iopoll.h>
>>>
>>>   #include "sdhci-pltfm.h"
>>> +#include <linux/regulator/consumer.h>
>>
>> This is a strange sort order for this include file.  Why is it after
>> the local include?
>>
>>
>>>   #define CORE_MCI_VERSION               0x50
>>>   #define CORE_VERSION_MAJOR_SHIFT       28
>>> @@ -81,6 +82,9 @@
>>>   #define CORE_HC_SELECT_IN_HS400        (6 << 19)
>>>   #define CORE_HC_SELECT_IN_MASK (7 << 19)
>>>
>>> +#define CORE_3_0V_SUPPORT      (1 << 25)
>>> +#define CORE_1_8V_SUPPORT      (1 << 26)
>>> +
>>
>> Is there something magical about 25 and 26?  This is a new caps field,
>> so I'd have expected 0 and 1.
>>
>>

Yes, these bits are the same corresponding to the capabilities in the 
Capabilities Register (offset 0x40). The bit positions become important 
when capabilities register doesn't show support to some voltages, but we 
can support those voltages. At that time, we will have to fake 
capabilities. The changes for those are currently not yet pushed up.

>>>   #define CORE_CSR_CDC_CTLR_CFG0         0x130
>>>   #define CORE_SW_TRIG_FULL_CALIB                BIT(16)
>>>   #define CORE_HW_AUTOCAL_ENA            BIT(17)
>>> @@ -148,6 +152,7 @@ struct sdhci_msm_host {
>>>          u32 curr_io_level;
>>>          wait_queue_head_t pwr_irq_wait;
>>>          bool pwr_irq_flag;
>>> +       u32 caps_0;
>>>   };
>>>
>>>   static unsigned int msm_get_clock_rate_for_bus_mode(struct 
>>> sdhci_host *host,
>>> @@ -1313,6 +1318,35 @@ static void sdhci_msm_writeb(struct sdhci_host 
>>> *host, u8 val, int reg)
>>>                  sdhci_msm_check_power_status(host, req_type);
>>>   }
>>>
>>> +static int sdhci_msm_set_regulator_caps(struct sdhci_msm_host 
>>> *msm_host)
>>> +{
>>> +       struct mmc_host *mmc = msm_host->mmc;
>>> +       struct regulator *supply = mmc->supply.vqmmc;
>>> +       int i, count;
>>> +       u32 caps = 0, vdd_uV;
>>> +
>>> +       if (!IS_ERR(mmc->supply.vqmmc)) {
>>> +               count = regulator_count_voltages(supply);
>>> +               if (count < 0)
>>> +                       return count;
>>> +               for (i = 0; i < count; i++) {
>>> +                       vdd_uV = regulator_list_voltage(supply, i);
>>> +                       if (vdd_uV <= 0)
>>> +                               continue;
>>> +                       if (vdd_uV > 2700000)
>>> +                               caps |= CORE_3_0V_SUPPORT;
>>> +                       if (vdd_uV < 1950000)
>>> +                               caps |= CORE_1_8V_SUPPORT;
>>> +               }
>>
>> Shouldn't you be using regulator_is_supported_voltage() rather than
>> open coding?  Also: I've never personally worked on a device where it
>> was used, but there is definitely a concept floating about of a
>> voltage level of 1.2V.  Maybe should copy the ranges from
>> mmc_regulator_set_vqmmc()?
>>
>>

regulator_is_supported_voltage() checks for a range and it also uses 
regulator_list_voltage() internally. regulator_list_voltage() is also an 
exported API for use by drivers AFAIK. Please correct if it is not.

>> Also: seems like you should have some way to deal with "caps" ending
>> up w/ no bits set.  IIRC you can have a regulator that can be enabled
>> / disabled but doesn't list a voltage, so if someone messed up their
>> device tree you could end up in this case.  Should you print a
>> warning?  ...or treat it as if we support "3.0V"?  ...or ?  I guess it
>> depends on how do you want patch #2 to behave in that case.
> 
> Both, initialize it to sane value and print something.  This way at
> least you have a good chance of booting and not hard hanging and you
> are given a reasonable message indicating what needs to be fixed.
> 
> -jeremy
> 
>>
>>
>>> +       }
>>
>> How should things behave if vqmmc is an error?  In that case is it
>> important to not set "CORE_IO_PAD_PWR_SWITCH_EN" in patch set #2?
>> ...or should you set "CORE_IO_PAD_PWR_SWITCH_EN" but then make sure
>> you don't set "CORE_IO_PAD_PWR_SWITCH"?
>>
>>

Thanks for the suggestion. If the regulators exit and doesn't list the 
voltages, then I believe initialization itself will not happen. We will 
not have any available ocr and in sdhci_setup_host it should fail.
But these enhancements can be incorporated. Since this patch is already 
acknowledged, I will incorporate these changes in a subsequent patch.

>>> +       msm_host->caps_0 |= caps;
>>> +       pr_debug("%s: %s: supported caps: 0x%08x\n", mmc_hostname(mmc),
>>> +                       __func__, caps);
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +
>>>   static const struct of_device_id sdhci_msm_dt_match[] = {
>>>          { .compatible = "qcom,sdhci-msm-v4" },
>>>          {},
>>> @@ -1530,6 +1564,10 @@ static int sdhci_msm_probe(struct 
>>> platform_device *pdev)
>>>          ret = sdhci_add_host(host);
>>>          if (ret)
>>>                  goto pm_runtime_disable;
>>> +       ret = sdhci_msm_set_regulator_caps(msm_host);
>>> +       if (ret)
>>> +               dev_err(&pdev->dev, "%s: Failed to set regulator 
>>> caps: %d\n",
>>> +                               __func__, ret);
>>
>> Why do you need __func__ here?  You're already using dev_err(), that
>> gives an idea of where we are.
>>

dev_err() doesn't give information of where it is getting called.

>>
>>>
>>>          pm_runtime_mark_last_busy(&pdev->dev);
>>>          pm_runtime_put_autosuspend(&pdev->dev);
>>> -- 
>>>   Qualcomm India Private Limited, on behalf of Qualcomm Innovation 
>>> Center, Inc.
>>> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a 
>>> Linux Foundation Collaborative Project.
>>>
>>> -- 
>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Thanks,
Vijay

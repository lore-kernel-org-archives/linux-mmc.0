From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RFC] mmc: core: add the capability for broken voltage
Date: Thu, 19 Jan 2012 16:08:50 +0200
Message-ID: <4F1823F2.4020808@intel.com>
References: <4F13E47D.8040505@samsung.com> <4F152A8F.5070506@intel.com> <CAH9JG2W2wF7a+eM_zXPBWn7XXuWDQkgwCOggJH4cEgKaCe3HMA@mail.gmail.com> <4F15415C.6020205@intel.com> <CAH9JG2Vuchz8smONKV4amJPOqFLkJgK=DhN-tTf-2cjCK=eD6Q@mail.gmail.com> <4F155FCD.2000703@intel.com> <CAH9JG2U_itybtYhCMH18f+4FGpbFEoSw0AE8=Vi5RvJBogY7NQ@mail.gmail.com> <4F167C64.6040609@intel.com> <CAH9JG2V=EH1gBx3yvkMmTRM4dy5zU46kt2OZsYab2nb2M28AHA@mail.gmail.com> <4F16892C.4040907@intel.com> <CAH9JG2Xj7_D45mt-BXFsikNcESG225=msuOact7zagXO=OMbEA@mail.gmail.com> <4F17ED1F.9020507@intel.com> <CAH9JG2XYWxwkMFmPnYX_ZmQ_xSysGanqnQFnk9bWh7vya2NTGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:52881 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751567Ab2ASOIu (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 19 Jan 2012 09:08:50 -0500
In-Reply-To: <CAH9JG2XYWxwkMFmPnYX_ZmQ_xSysGanqnQFnk9bWh7vya2NTGQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kyungmin Park <kmpark@infradead.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>

On 19/01/12 12:40, Kyungmin Park wrote:
> On 1/19/12, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> On 18/01/12 15:03, Kyungmin Park wrote:
>>> On Wed, Jan 18, 2012 at 5:56 PM, Adrian Hunter <adrian.hunter@intel.com>
>>> wrote:
>>>> On 18/01/12 10:13, Kyungmin Park wrote:
>>>>> On 1/18/12, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>>> On 18/01/12 01:58, Kyungmin Park wrote:
>>>>>>> On 1/17/12, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>>>>> On 17/01/12 11:53, Kyungmin Park wrote:
>>>>>>>>> On 1/17/12, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>>>>>>> On 17/01/12 11:05, Kyungmin Park wrote:
>>>>>>>>>>> On 1/17/12, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>>>>>>>>> On 16/01/12 10:49, Jaehoon Chung wrote:
>>>>>>>>>>>>> This patch is added the MMC_CAP2_BROKEN_VOLTAGE.
>>>>>>>>>>>>>
>>>>>>>>>>>>> if the voltage didn't satisfy between min_uV and max_uV,
>>>>>>>>>>>>
>>>>>>>>>>>> Why is the fixed voltage not in the acceptable range for the
>>>>>>>>>>>> card?
>>>>>>>>>>>> Doesn't that risk breaking the card?
>>>>>>>>>>> Hi Adrian,
>>>>>>>>>>>
>>>>>>>>>>> I don't know, they uses the not supported voltage. but it's worked
>>>>>>>>>>> properly for long time.
>>>>>>>>>>
>>>>>>>>>> I wonder if there is a generic problem here that this fix hides.
>>>>>>>>>> It would be nice to have an explanation.  Do you know:
>>>>>>>>>>  - what is the fixed voltage?
>>>>>>>>> Now 2.8V is supplied by gpio so make it fixed regulator
>>>>>>>>>>  - is it supplying VCC or VCCQ?
>>>>>>>>> VDD in our schematic.
>>>>>>>>
>>>>>>>> Is it the NAND core voltage or the I/O voltage?
>>>>>>> In case of eMMC v4.41, it uses the same voltage, VDD is used for MMC
>>>>>>> I/O block and controller and another VDDF is used for flash.
>>>>>>
>>>>>> It seems to me you just need to override the value of
>>>>>> mmc->ocr_avail_mmc
>>>>>> calculated in sdhci_add_host() in sdhci.c to reflect the fact that the
>>>>>> only
>>>>>> voltage available is 2.8V.
>>>>>
>>>>> current sdhci ocr_avail is 0x300080 and wanted ocr is 0x10000 so it
>>>>> doesn't support it.
>>>>>
>>>>> [    0.984754] sdhci_add_host[2888] ocr_avail 0x300080
>>>>> [    0.989909] sdhci_add_host[2889] host->ocr_avail_mmc 0x10000
>>>>
>>>> Yes because sdhci_add_host() ANDs the values i.e.
>>>>
>>>>        if (host->ocr_avail_mmc)
>>>>                mmc->ocr_avail_mmc &= host->ocr_avail_mmc;
>>> Right, so it's meaningless set the host->ocr_avail_mmc. basically
>>> sdhci doesn't support this voltage.
>>
>> That is not entirely true.  SD and MMC define voltage thresholds in such a
>> way that a 2.7V card is within the thresholds of a 3.0V host controller.
>> And a 3.6V card is within the thresholds of a 3.3V host controller.
>>
>> I would do something like below.  If you agree, I will send a patch.
> Now it's has only (caps[0] & SDHCI_CAN_VDD_330) and don't have SDHCI_CAN_VDD_300
> it doesn't support the 2.8V.

2.8V card with 3.3V host controller does violate the SD/MMC specifications
slightly i.e. max voltage is VDD + 0.3 but 3.3 > 2.8 + 0.3.  The other
thresholds are tight but not invalid.

However expanding the SDHCI_QUIRK2_LAX_VOLTAGE idea to cope adds too much
code for no benefit.  Jaehoon Chung's patch is much simpler.

Sorry for the noise.

>From my point of view the following could be added at the start of the
commit message.

"There is an understood mismatch between the voltage the host controller is
set to and the voltage supplied to the card by a fixed voltage regulator.
Teaching the driver to accept the mismatch is overly complicated.  Instead
just accept the regulator's voltage."

And FWIW:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> 
> sdhci_add_host[2917] ocr_avail_mmc 0xf80080.
> 
> Thank you,
> Kyungmin Park
> 
> Note that. maybe MAX_VOLTAGE instead of LAX_VOLTAGE.
>>
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 8d66706..a7cb3f2 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -1179,20 +1179,43 @@ static int sdhci_set_power(struct sdhci_host *host,
>> unsigned short power)
>>         u8 pwr = 0;
>>
>>         if (power != (unsigned short)-1) {
>> -               switch (1 << power) {
>> -               case MMC_VDD_165_195:
>> -                       pwr = SDHCI_POWER_180;
>> -                       break;
>> -               case MMC_VDD_29_30:
>> -               case MMC_VDD_30_31:
>> -                       pwr = SDHCI_POWER_300;
>> -                       break;
>> -               case MMC_VDD_32_33:
>> -               case MMC_VDD_33_34:
>> -                       pwr = SDHCI_POWER_330;
>> -                       break;
>> -               default:
>> -                       BUG();
>> +               if (host->quirks2 & SDHCI_QUIRK2_LAX_VOLTAGE) {
>> +                       switch (1 << power) {
>> +                       case MMC_VDD_165_195:
>> +                               pwr = SDHCI_POWER_180;
>> +                               break;
>> +                       case MMC_VDD_27_28:
>> +                       case MMC_VDD_28_29:
>> +                       case MMC_VDD_29_30:
>> +                       case MMC_VDD_30_31:
>> +                               pwr = SDHCI_POWER_300;
>> +                               break;
>> +                       case MMC_VDD_31_32:
>> +                       case MMC_VDD_32_33:
>> +                       case MMC_VDD_33_34:
>> +                       case MMC_VDD_34_35:
>> +                       case MMC_VDD_35_36:
>> +                               pwr = SDHCI_POWER_330;
>> +                               break;
>> +                       default:
>> +                               BUG();
>> +                       }
>> +               } else {
>> +                       switch (1 << power) {
>> +                       case MMC_VDD_165_195:
>> +                               pwr = SDHCI_POWER_180;
>> +                               break;
>> +                       case MMC_VDD_29_30:
>> +                       case MMC_VDD_30_31:
>> +                               pwr = SDHCI_POWER_300;
>> +                               break;
>> +                       case MMC_VDD_32_33:
>> +                       case MMC_VDD_33_34:
>> +                               pwr = SDHCI_POWER_330;
>> +                               break;
>> +                       default:
>> +                               BUG();
>> +                       }
>>                 }
>>         }
>>
>> @@ -2829,6 +2852,9 @@ int sdhci_add_host(struct sdhci_host *host)
>>                 int max_current_330;
>>
>>                 ocr_avail |= MMC_VDD_32_33 | MMC_VDD_33_34;
>> +               if (host->quirks2 & SDHCI_QUIRK2_LAX_VOLTAGE)
>> +                       ocr_avail |= MMC_VDD_31_32 | MMC_VDD_34_35 |
>> +                                    MMC_VDD_35_36;
>>
>>                 max_current_330 = ((max_current_caps &
>>                                    SDHCI_MAX_CURRENT_330_MASK) >>
>> @@ -2842,6 +2868,8 @@ int sdhci_add_host(struct sdhci_host *host)
>>                 int max_current_300;
>>
>>                 ocr_avail |= MMC_VDD_29_30 | MMC_VDD_30_31;
>> +               if (host->quirks2 & SDHCI_QUIRK2_LAX_VOLTAGE)
>> +                       ocr_avail |= MMC_VDD_27_28 | MMC_VDD_28_29;
>>
>>                 max_current_300 = ((max_current_caps &
>>                                    SDHCI_MAX_CURRENT_300_MASK) >>
>> diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
>> index c750f85..a03d613 100644
>> --- a/include/linux/mmc/sdhci.h
>> +++ b/include/linux/mmc/sdhci.h
>> @@ -90,6 +90,9 @@ struct sdhci_host {
>>
>>         unsigned int quirks2;   /* More deviations from spec. */
>>
>> +/* Allow a wider range of voltages */
>> +#define SDHCI_QUIRK2_LAX_VOLTAGE                       (1<<0)
>> +
>>         int irq;                /* Device IRQ */
>>         void __iomem *ioaddr;   /* Mapped address */
>>
>>
>>
>>
>>>>
>>>> You will have to add a new quirk or callback e.g.
>>> That's reason add new quirk. MMC_CAP2_BROKEN_VOLTAGE.
>>>>
>>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>>> index 8d66706..b8a04e3 100644
>>>> --- a/drivers/mmc/host/sdhci.c
>>>> +++ b/drivers/mmc/host/sdhci.c
>>>> @@ -2980,6 +2980,12 @@ int sdhci_add_host(struct sdhci_host *host)
>>>>                host->vmmc = NULL;
>>>>        }
>>>>
>>>> +       if (host->ops->fixup_host) {
>>>> +               ret = host->ops->fixup_host(host);
>>>> +               if (ret)
>>>> +                       goto regput;
>>>> +       }
>>>> +
>>>>        sdhci_init(host, 0);
>>>>
>>>>  #ifdef CONFIG_MMC_DEBUG
>>>> @@ -3012,6 +3018,9 @@ int sdhci_add_host(struct sdhci_host *host)
>>>>
>>>>        return 0;
>>>>
>>>> +regput:
>>>> +       if (host->vmmc)
>>>> +               regulator_put(host->vmmc);
>>>>  #ifdef SDHCI_USE_LEDS_CLASS
>>>>  reset:
>>>>        sdhci_reset(host, SDHCI_RESET_ALL);
>>>>
>>>>
>>>> Then implement ->fixup_host() to make the change.
>>>>
>>>> Note that this is for I/O voltage or single voltage supply.  If there is
>>>> a
>>>> need to control 2 separate voltages (e.g. VDD, VDDF or VCCQ, VCC as JEDEC
>>>> calls them) it is more challenging because mmc core does not support it.
>>> New H/W has different voltage for eMMC v4.5. but it's covered by PMIC.
>>> It can be switches on/off by gpio then PMIC turn on/off each LDOs for
>>> eMMC properly.
>>>
>>> Thank you,
>>> Kyungmin Park
>>>>
>>>>>
>>>>> Thank you,
>>>>> Kyungmin Park
>>>>>>
>>>>>>>>
>>>>>>>>>>  - what is the contents of the OCR register?
>>>>>>>>> In sdhci_set_power(). it returns SDHCI_POWER_180, SDHCI_POWER_300,
>>>>>>>>> and
>>>>>>>>> SDHCI_POWER_330.
>>>>>>>>> In probe time, it return the SDHCI_POWER_330, and but fixed
>>>>>>>>> regulator
>>>>>>>>> returns the 2.8V so it calls regulator_set_voltage. and return
>>>>>>>>> -EINVAL
>>>>>>>>> since it's fixed regulator.
>>>>>>>>>
>>>>>>>>> Of course we can make workaround, set fixed regulator voltage as
>>>>>>>>> 3.3V.
>>>>>>>>> Even though actual voltage is 2.8V. so it's ambiguous.
>>>>>>>>>
>>>>>>>>> that's reason introduces the new quirk.
>>>>>>>>>
>>>>>>>>> Thank you,
>>>>>>>>> Kyungmin Park
>>>>>>>>>>
>>>>>>>>>>> Galaxy S2 also uses the same voltage as ours.
>>>>>>>>>>>
>>>>>>>>>>> I also think the modify the regulator framework to support voltage
>>>>>>>>>>> change at fixed regulator. but it's not good idea and doesn't
>>>>>>>>>>> match
>>>>>>>>>>> the regulator concept. so modify the sdhci codes to support our
>>>>>>>>>>> boards.
>>>>>>>>>>>
>>>>>>>>>>> Thank you,
>>>>>>>>>>> Kyungmin Park
>>>>>>>>>>>>
>>>>>>>>>>>>> try to change the voltage in core.c.
>>>>>>>>>>>>> When change the voltage, maybe use the regulator_set_voltage().
>>>>>>>>>>>>>
>>>>>>>>>>>>> In regulator_set_voltage(), check the below condition.
>>>>>>>>>>>>>
>>>>>>>>>>>>>       /* sanity check */
>>>>>>>>>>>>>       if (!rdev->desc->ops->set_voltage &&
>>>>>>>>>>>>>           !rdev->desc->ops->set_voltage_sel) {
>>>>>>>>>>>>>               ret = -EINVAL;
>>>>>>>>>>>>>               goto out;
>>>>>>>>>>>>>       }
>>>>>>>>>>>>>
>>>>>>>>>>>>> If Some-board should use the fixed-regulator, always return
>>>>>>>>>>>>> -EINVAL.
>>>>>>>>>>>>> Then, eMMC didn't initialize always.
>>>>>>>>>>>>>
>>>>>>>>>>>>> So if use the fixed-regulator or etc, we need to add the
>>>>>>>>>>>>> MMC_CAP2_BROKEN_VOLTAGE.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>>>>>>>>>>>>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>>>>>>>>>>>>> ---
>>>>>>>>>>>>>  drivers/mmc/core/core.c  |    4 ++++
>>>>>>>>>>>>>  include/linux/mmc/host.h |    1 +
>>>>>>>>>>>>>  2 files changed, 5 insertions(+), 0 deletions(-)
>>>>>>>>>>>>>
>>>>>>>>>>>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>>>>>>>>>>>> index bec0bf2..6848789 100644
>>>>>>>>>>>>> --- a/drivers/mmc/core/core.c
>>>>>>>>>>>>> +++ b/drivers/mmc/core/core.c
>>>>>>>>>>>>> @@ -1121,6 +1121,10 @@ int mmc_regulator_set_ocr(struct mmc_host
>>>>>>>>>>>>> *mmc,
>>>>>>>>>>>>>                * might not allow this operation
>>>>>>>>>>>>>                */
>>>>>>>>>>>>>               voltage = regulator_get_voltage(supply);
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +             if (mmc->caps2 & MMC_CAP2_BROKEN_VOLTAGE)
>>>>>>>>>>>>> +                     min_uV = max_uV = voltage;
>>>>>>>>>>>>> +
>>>>>>>>>>>>>               if (voltage < 0)
>>>>>>>>>>>>>                       result = voltage;
>>>>>>>>>>>>>               else if (voltage < min_uV || voltage > max_uV)
>>>>>>>>>>>>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>>>>>>>>>>>>> index dd13e05..5659aee 100644
>>>>>>>>>>>>> --- a/include/linux/mmc/host.h
>>>>>>>>>>>>> +++ b/include/linux/mmc/host.h
>>>>>>>>>>>>> @@ -257,6 +257,7 @@ struct mmc_host {
>>>>>>>>>>>>>  #define MMC_CAP2_HS200_1_2V_SDR      (1 << 6)        /* can
>>>>>>>>>>>>> support */
>>>>>>>>>>>>>  #define MMC_CAP2_HS200               (MMC_CAP2_HS200_1_8V_SDR |
>>>>>>>>>>>>> \
>>>>>>>>>>>>>                                MMC_CAP2_HS200_1_2V_SDR)
>>>>>>>>>>>>> +#define MMC_CAP2_BROKEN_VOLTAGE      (1 << 7)        /* Use the
>>>>>>>>>>>>> broken voltage
>>>>>>>>>>>>> */
>>>>>>>>>>>>>
>>>>>>>>>>>>>       mmc_pm_flag_t           pm_caps;        /* supported pm
>>>>>>>>>>>>> features */
>>>>>>>>>>>>>       unsigned int        power_notify_type;
>>>>>>>>>>>>> --
>>>>>>>>>>>>> To unsubscribe from this list: send the line "unsubscribe
>>>>>>>>>>>>> linux-mmc"
>>>>>>>>>>>>> in
>>>>>>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>>>>>>> More majordomo info at
>>>>>>>>>>>>> http://vger.kernel.org/majordomo-info.html
>>>>>>>>>>>>
>>>>>>>>>>>> --
>>>>>>>>>>>> To unsubscribe from this list: send the line "unsubscribe
>>>>>>>>>>>> linux-mmc"
>>>>>>>>>>>> in
>>>>>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>>>>>> More majordomo info at
>>>>>>>>>>>> http://vger.kernel.org/majordomo-info.html
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> --
>>>>>>>>>> To unsubscribe from this list: send the line "unsubscribe
>>>>>>>>>> linux-mmc" in
>>>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>
>>>>>>>> --
>>>>>>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"
>>>>>>>> in
>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>>>>
>>>>>>>
>>>>>>
>>>>>> --
>>>>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>>
>>>>>
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 


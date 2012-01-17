From: Kyungmin Park <kyungmin.park@samsung.com>
Subject: Re: [RFC] mmc: core: add the capability for broken voltage
Date: Tue, 17 Jan 2012 18:53:03 +0900
Message-ID: <CAH9JG2Vuchz8smONKV4amJPOqFLkJgK=DhN-tTf-2cjCK=eD6Q@mail.gmail.com>
References: <4F13E47D.8040505@samsung.com>
	<4F152A8F.5070506@intel.com>
	<CAH9JG2W2wF7a+eM_zXPBWn7XXuWDQkgwCOggJH4cEgKaCe3HMA@mail.gmail.com>
	<4F15415C.6020205@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:47182 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751255Ab2AQJxE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Jan 2012 04:53:04 -0500
Received: by qadc10 with SMTP id c10so667902qad.19
        for <linux-mmc@vger.kernel.org>; Tue, 17 Jan 2012 01:53:03 -0800 (PST)
In-Reply-To: <4F15415C.6020205@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>

On 1/17/12, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 17/01/12 11:05, Kyungmin Park wrote:
>> On 1/17/12, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>> On 16/01/12 10:49, Jaehoon Chung wrote:
>>>> This patch is added the MMC_CAP2_BROKEN_VOLTAGE.
>>>>
>>>> if the voltage didn't satisfy between min_uV and max_uV,
>>>
>>> Why is the fixed voltage not in the acceptable range for the card?
>>> Doesn't that risk breaking the card?
>> Hi Adrian,
>>
>> I don't know, they uses the not supported voltage. but it's worked
>> properly for long time.
>
> I wonder if there is a generic problem here that this fix hides.
> It would be nice to have an explanation.  Do you know:
> 	- what is the fixed voltage?
Now 2.8V is supplied by gpio so make it fixed regulator
> 	- is it supplying VCC or VCCQ?
VDD in our schematic.
> 	- what is the contents of the OCR register?
In sdhci_set_power(). it returns SDHCI_POWER_180, SDHCI_POWER_300, and
SDHCI_POWER_330.
In probe time, it return the SDHCI_POWER_330, and but fixed regulator
returns the 2.8V so it calls regulator_set_voltage. and return -EINVAL
since it's fixed regulator.

Of course we can make workaround, set fixed regulator voltage as 3.3V.
Even though actual voltage is 2.8V. so it's ambiguous.

that's reason introduces the new quirk.

Thank you,
Kyungmin Park
>
>> Galaxy S2 also uses the same voltage as ours.
>>
>> I also think the modify the regulator framework to support voltage
>> change at fixed regulator. but it's not good idea and doesn't match
>> the regulator concept. so modify the sdhci codes to support our
>> boards.
>>
>> Thank you,
>> Kyungmin Park
>>>
>>>> try to change the voltage in core.c.
>>>> When change the voltage, maybe use the regulator_set_voltage().
>>>>
>>>> In regulator_set_voltage(), check the below condition.
>>>>
>>>> 	/* sanity check */
>>>> 	if (!rdev->desc->ops->set_voltage &&
>>>> 	    !rdev->desc->ops->set_voltage_sel) {
>>>> 		ret = -EINVAL;
>>>> 		goto out;
>>>> 	}
>>>>
>>>> If Some-board should use the fixed-regulator, always return -EINVAL.
>>>> Then, eMMC didn't initialize always.
>>>>
>>>> So if use the fixed-regulator or etc, we need to add the
>>>> MMC_CAP2_BROKEN_VOLTAGE.
>>>>
>>>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>>>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>>>> ---
>>>>  drivers/mmc/core/core.c  |    4 ++++
>>>>  include/linux/mmc/host.h |    1 +
>>>>  2 files changed, 5 insertions(+), 0 deletions(-)
>>>>
>>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>>> index bec0bf2..6848789 100644
>>>> --- a/drivers/mmc/core/core.c
>>>> +++ b/drivers/mmc/core/core.c
>>>> @@ -1121,6 +1121,10 @@ int mmc_regulator_set_ocr(struct mmc_host *mmc,
>>>>  		 * might not allow this operation
>>>>  		 */
>>>>  		voltage = regulator_get_voltage(supply);
>>>> +
>>>> +		if (mmc->caps2 & MMC_CAP2_BROKEN_VOLTAGE)
>>>> +			min_uV = max_uV = voltage;
>>>> +
>>>>  		if (voltage < 0)
>>>>  			result = voltage;
>>>>  		else if (voltage < min_uV || voltage > max_uV)
>>>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>>>> index dd13e05..5659aee 100644
>>>> --- a/include/linux/mmc/host.h
>>>> +++ b/include/linux/mmc/host.h
>>>> @@ -257,6 +257,7 @@ struct mmc_host {
>>>>  #define MMC_CAP2_HS200_1_2V_SDR	(1 << 6)        /* can support */
>>>>  #define MMC_CAP2_HS200		(MMC_CAP2_HS200_1_8V_SDR | \
>>>>  				 MMC_CAP2_HS200_1_2V_SDR)
>>>> +#define MMC_CAP2_BROKEN_VOLTAGE	(1 << 7)	/* Use the broken voltage */
>>>>
>>>>  	mmc_pm_flag_t		pm_caps;	/* supported pm features */
>>>>  	unsigned int        power_notify_type;
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

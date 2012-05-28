From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 4/5 v3] mmc: add a function to get a regulator, supplying
 card's Vdd
Date: Mon, 28 May 2012 11:12:18 +0300
Message-ID: <4FC33362.4010806@intel.com>
References: <Pine.LNX.4.64.1205251045490.13353@axis700.grange> <Pine.LNX.4.64.1205251208440.13353@axis700.grange> <Pine.LNX.4.64.1205251230540.13353@axis700.grange> <CAPDyKFrrxyk-JpLFge5+0xbYjJ=-24avWn8Optfg88-i006-Ng@mail.gmail.com> <1925406B-D680-40BB-890A-78447EEB4583@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:26897 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751076Ab2E1IMa (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 28 May 2012 04:12:30 -0400
In-Reply-To: <1925406B-D680-40BB-890A-78447EEB4583@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>

On 28/05/12 06:32, Philip Rakity wrote:
> 
> 
> I have started looking at this area and I am rather confused.  It seems to me two "dedicated" regulators are required.

It probably pays not to assume too much about regulators.  For example:

Sometimes vccq is always on, so there may be just 1 regulator for vcc.

wl12xx/SDIO is setup with a fake regulator that actually controls
the enable line.

There is a case where power is supplied at a different voltage than
spec'ed i.e. commit 6e8201f57c9359c9c5dc8f9805c15a4392492a10

> One regulator controls VDD (vcc) and this is the regulator called vmmc.  This regulator MAY support the ability to switch voltages and MAY support the ability to be turned on and off.
> The other regulator supports signal voltage (vccq) for UHS and SDXC cards.  Currently this is not in sdhci.c (I have a patch for this in preparation).  Use of this regulator requires that the VDD regulator be capable of being set to 1.8 or 3.3v and be capable of being turned on/off.  on/off support is needed is the switch to 1.8v signaling fails for any reason.
> 
> 
> 
> On May 27, 2012, at 8:20 PM, Ulf Hansson wrote:
> 
>> Hi Guennadi,
>>
>> On 25 May 2012 17:14, Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
>>> Add a function to get a regulator, supplying card's Vdd on a specific host.
>>> If such a regulator is found, the function checks, whether a valid OCR mask
>>> can be obtained from this regulator.
>>>
>>> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>>> ---
>>>
>>> v3: remove bogus attempts to ignore the dummy regulator, drop the check
>>> for whether the regulator can change status, do not assign
>>> MMC_CAP_POWER_OFF_CARD automatically. Thanks to Mark and Magnus for
>>> comments.
>>>
>>>  drivers/mmc/core/core.c  |   17 +++++++++++++++++
>>>  include/linux/mmc/host.h |    6 ++++++
>>>  2 files changed, 23 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>> index 0b6141d..0f92ec0 100644
>>> --- a/drivers/mmc/core/core.c
>>> +++ b/drivers/mmc/core/core.c
>>> @@ -1013,6 +1013,23 @@ int mmc_regulator_set_ocr(struct mmc_host *mmc,
>>>  }
>>>  EXPORT_SYMBOL(mmc_regulator_set_ocr);
>>>
>>> +struct regulator *mmc_regulator_get_vmmc(struct mmc_host *mmc)
>>> +{
>>> +       struct device *dev = mmc_dev(mmc);
>>> +       struct regulator *supply = devm_regulator_get(dev, "vmmc");
>>> +       int ret;
>>> +
>>> +       if (IS_ERR(supply))
>>> +               return NULL;
>>> +
>>> +       ret = mmc_regulator_get_ocrmask(supply);
>>> +       if (ret > 0)
>>
>> Could we have an "else" were a dev_warn prints some info and as well
>> the "ret" maybe?
>>
>>> +               mmc->ocr_avail = ret;
>>> +
>>> +       return supply;
>>> +}
>>> +EXPORT_SYMBOL(mmc_regulator_get_vmmc);
>>> +
>>>  #endif /* CONFIG_REGULATOR */
>>>
>>>  /*
>>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>>> index 0707d22..368b317 100644
>>> --- a/include/linux/mmc/host.h
>>> +++ b/include/linux/mmc/host.h
>>> @@ -364,6 +364,7 @@ int mmc_regulator_get_ocrmask(struct regulator *supply);
>>>  int mmc_regulator_set_ocr(struct mmc_host *mmc,
>>>                        struct regulator *supply,
>>>                        unsigned short vdd_bit);
>>> +struct regulator *mmc_regulator_get_vmmc(struct mmc_host *mmc);
>>>  #else
>>>  static inline int mmc_regulator_get_ocrmask(struct regulator *supply)
>>>  {
>>> @@ -376,6 +377,11 @@ static inline int mmc_regulator_set_ocr(struct mmc_host *mmc,
>>>  {
>>>        return 0;
>>>  }
>>> +
>>> +static inline struct regulator *mmc_regulator_get_vmmc(struct mmc_host *mmc)
>>> +{
>>> +       return NULL;
>>> +}
>>>  #endif
>>>
>>
>> Some follow-up thoughts, if mmc_regulator_get_vmmc is supposed to be
>> used from the host drivers, the mmc_regulator_get_ocrmask function do
>> no longer have to be an exported function, but instead a static
>> function on core.c I suppose this can be fixed in separate patch,
>> where we also add mmc_regulator_get_vmmc for all host drivers?
> 
> 
>  have started looking at this area and I am rather confused.  It seems to me two "dedicated" regulators are required.
> One regulator controls VDD (vcc) and this is the regulator called vmmc.  This regulator MAY support the ability to switch voltages and MAY support the ability to be turned on and off.  The main sdhci.c code needs to check the voltages supported by the regulator against the voltages that the host controller supports and adjust the  mmc capabilities to the common set.  I don't think we do this at the moment.
> 
> The other regulator supports signal voltage (vccq) for UHS and SDXC cards.  Currently this is not in sdhci.c (I have a patch for this in preparation).  Use of this regulator requires that the vccq regulator be capable of being set to 1.8 or 3.3v and the VDD (vmmc) regulator be capable of being turned on/off.  on/off support is needed is the switch to 1.8v signaling fails for any reason.
> 
> 
> 
>>
>> Kind regards
>> Ulf Hansson
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


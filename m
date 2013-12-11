From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC PATCH v3 2/8] mmc: omap_hsmmc: handle vcc and vcc_aux independently
Date: Wed, 11 Dec 2013 12:21:11 +0100
Message-ID: <CAPDyKFpERuDx_9qdbuC5z7NGbt-BEydR=qxiPrS2Qdvapd-0pw@mail.gmail.com>
References: <20130613174554.GB1403@sirena.org.uk>
	<1385043627-30439-1-git-send-email-balajitk@ti.com>
	<1385043627-30439-3-git-send-email-balajitk@ti.com>
	<CAPDyKFqAT+Zd4LmAJ91g603LXx2rAfoRhF1UK4XNzSUVNS0X9w@mail.gmail.com>
	<52A6FF84.40901@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <52A6FF84.40901@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Benoit Cousson <bcousson@baylibre.com>, devicetree@vger.kernel.org, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Mark Brown <broonie@kernel.org>, Tony Lindgren <tony@atomide.com>
List-Id: linux-mmc@vger.kernel.org

On 10 December 2013 12:48, Balaji T K <balajitk@ti.com> wrote:
> On Tuesday 10 December 2013 04:39 PM, Ulf Hansson wrote:
>>
>> On 21 November 2013 15:20, Balaji T K <balajitk@ti.com> wrote:
>>>
>>> handle vcc and vcc_aux independently to reduce indent.
>>>
>>> Signed-off-by: Balaji T K <balajitk@ti.com>
>>> ---
>>>   drivers/mmc/host/omap_hsmmc.c |   54
>>> +++++++++++++++++++----------------------
>>>   1 files changed, 25 insertions(+), 29 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/omap_hsmmc.c
>>> b/drivers/mmc/host/omap_hsmmc.c
>>> index 1eb4350..342be25 100644
>>> --- a/drivers/mmc/host/omap_hsmmc.c
>>> +++ b/drivers/mmc/host/omap_hsmmc.c
>>> @@ -286,11 +286,12 @@ static int omap_hsmmc_set_power(struct device *dev,
>>> int slot, int power_on,
>>>           * chips/cards need an interface voltage rail too.
>>>           */
>>>          if (power_on) {
>>> -               ret = mmc_regulator_set_ocr(host->mmc, host->vcc, vdd);
>>> +               if (host->vcc)
>>> +                       ret = mmc_regulator_set_ocr(host->mmc, host->vcc,
>>> vdd);
>>>                  /* Enable interface voltage rail, if needed */
>>>                  if (ret == 0 && host->vcc_aux) {
>>>                          ret = regulator_enable(host->vcc_aux);
>>> -                       if (ret < 0)
>>> +                       if (ret < 0 && host->vcc)
>>>                                  ret = mmc_regulator_set_ocr(host->mmc,
>>>                                                          host->vcc, 0);
>>>                  }
>>> @@ -298,7 +299,7 @@ static int omap_hsmmc_set_power(struct device *dev,
>>> int slot, int power_on,
>>>                  /* Shut down the rail */
>>>                  if (host->vcc_aux)
>>>                          ret = regulator_disable(host->vcc_aux);
>>> -               if (!ret) {
>>> +               if (host->vcc) {
>>>                          /* Then proceed to shut down the local regulator
>>> */
>>>                          ret = mmc_regulator_set_ocr(host->mmc,
>>>                                                  host->vcc, 0);
>>> @@ -318,10 +319,10 @@ static int omap_hsmmc_reg_get(struct
>>> omap_hsmmc_host *host)
>>>
>>>          reg = devm_regulator_get(host->dev, "vmmc");
>>>          if (IS_ERR(reg)) {
>>> -               dev_err(host->dev, "vmmc regulator missing\n");
>>> +               dev_err(host->dev, "unable to get vmmc regulator %ld\n",
>>> +                       PTR_ERR(reg));
>>>                  return PTR_ERR(reg);
>>>          } else {
>>> -               mmc_slot(host).set_power = omap_hsmmc_set_power;
>>>                  host->vcc = reg;
>>>                  ocr_value = mmc_regulator_get_ocrmask(reg);
>>>                  if (!mmc_slot(host).ocr_mask) {
>>> @@ -334,31 +335,26 @@ static int omap_hsmmc_reg_get(struct
>>> omap_hsmmc_host *host)
>>>                                  return -EINVAL;
>>>                          }
>>>                  }
>>> +       }
>>> +       mmc_slot(host).set_power = omap_hsmmc_set_power;
>>>
>>> -               /* Allow an aux regulator */
>>> -               reg = devm_regulator_get_optional(host->dev, "vmmc_aux");
>>> -               host->vcc_aux = IS_ERR(reg) ? NULL : reg;
>>> +       /* Allow an aux regulator */
>>> +       reg = devm_regulator_get_optional(host->dev, "vmmc_aux");
>>> +       host->vcc_aux = IS_ERR(reg) ? NULL : reg;
>>>
>>> -               /* For eMMC do not power off when not in sleep state */
>>> -               if (mmc_slot(host).no_regulator_off_init)
>>> -                       return 0;
>>> -               /*
>>> -               * UGLY HACK:  workaround regulator framework bugs.
>>> -               * When the bootloader leaves a supply active, it's
>>> -               * initialized with zero usecount ... and we can't
>>> -               * disable it without first enabling it.  Until the
>>> -               * framework is fixed, we need a workaround like this
>>> -               * (which is safe for MMC, but not in general).
>>> -               */
>>
>>
>> The above problem is handled by the mmc core layer. I certainly think
>> you shall adopt your code to it.
>
> Hi Ulf,
>
> how about optional vqmmc, omap_hsmmc does call mmc_regulator_set_ocr for
> vmmc
> Am I missing something?

Hi Balaji,

Sorry for being to vague, let me elaborate.

1. Before omap_hsmmc_probe returns, it invokes mmc_add_host().

2. mmc_add_host() -> mmc_start_host() -> > mmc_power_up().

3. mmc_power_up() invokes the host driver's .set_ios() callback, to
makes sure boot-on regulators are kept enabled. Otherwise the
late_initcall, regulator_init_complete() will potentially cut power
for unused regulators.

This is important because there are SoCs that are only capable of
power cycling the VCC regulator but not VCCQ. According to the eMMC
spec, we must not cut VCC without sending the SLEEP cmd first.
Obviously, since we prevent VCC from being cut, we need to prevent
VCCQ from being cut as well.

Normally a .set_ios() function's invokes mmc_regulator_set_ocr() for
the VCC regulator. VCCQ ("vmmc_aux") is handled by directly using the
regulator API (I guess we could invent an API similar to
mmc_regulator_set_ocr() but for VCCQ, but that is a future task).

So, from a host driver perspective you could add a local variable to
cache the "enabled" state of the VCCQ regulator. By leaving the
default state to "disabled", you will trigger it to be enabled once
mmc_power_up() invokes your .set_ios() callback. Vice verse will then
happen when mmc_power_off gets invoked.

Finally, don't forget to enable MMC_CAP2_FULL_PWR_CYCLE, if your SoC
can cut both VCC and VCCQ for your eMMC slots. For SD cards only VCC
should be needed to enable MMC_CAP2_FULL_PWR_CYCLE.

Kind regards
Ulf Hansson


>
>
>>
>> Kind regards
>> Ulf Hansson
>>
>>> -               if (regulator_is_enabled(host->vcc) > 0 ||
>>> -                   (host->vcc_aux &&
>>> regulator_is_enabled(host->vcc_aux))) {
>>> -                       int vdd = ffs(mmc_slot(host).ocr_mask) - 1;
>>> +       /* For eMMC do not power off when not in sleep state */
>>> +       if (mmc_slot(host).no_regulator_off_init)
>>> +               return 0;
>>> +       /*
>>> +        * To disable boot_on regulator, enable regulator
>>> +        * to increase usecount and then disable it.
>>> +        */
>>> +       if ((host->vcc && regulator_is_enabled(host->vcc) > 0) ||
>>> +           (host->vcc_aux && regulator_is_enabled(host->vcc_aux))) {
>>> +               int vdd = ffs(mmc_slot(host).ocr_mask) - 1;
>>>
>>> -                       mmc_slot(host).set_power(host->dev,
>>> host->slot_id,
>>> -                                                1, vdd);
>>> -                       mmc_slot(host).set_power(host->dev,
>>> host->slot_id,
>>> -                                                0, 0);
>>> -               }
>>> +               mmc_slot(host).set_power(host->dev, host->slot_id, 1,
>>> vdd);
>>> +               mmc_slot(host).set_power(host->dev, host->slot_id, 0, 0);
>>>          }
>>>
>>>          return 0;
>>> --
>>> 1.7.5.4
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>

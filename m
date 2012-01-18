From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [RFC] mmc: core: add the capability for broken voltage
Date: Wed, 18 Jan 2012 22:03:43 +0900
Message-ID: <CAH9JG2Xj7_D45mt-BXFsikNcESG225=msuOact7zagXO=OMbEA@mail.gmail.com>
References: <4F13E47D.8040505@samsung.com>
	<4F152A8F.5070506@intel.com>
	<CAH9JG2W2wF7a+eM_zXPBWn7XXuWDQkgwCOggJH4cEgKaCe3HMA@mail.gmail.com>
	<4F15415C.6020205@intel.com>
	<CAH9JG2Vuchz8smONKV4amJPOqFLkJgK=DhN-tTf-2cjCK=eD6Q@mail.gmail.com>
	<4F155FCD.2000703@intel.com>
	<CAH9JG2U_itybtYhCMH18f+4FGpbFEoSw0AE8=Vi5RvJBogY7NQ@mail.gmail.com>
	<4F167C64.6040609@intel.com>
	<CAH9JG2V=EH1gBx3yvkMmTRM4dy5zU46kt2OZsYab2nb2M28AHA@mail.gmail.com>
	<4F16892C.4040907@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f53.google.com ([209.85.216.53]:55480 "EHLO
	mail-qw0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757397Ab2ARNDo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Jan 2012 08:03:44 -0500
Received: by qabg24 with SMTP id g24so156759qab.19
        for <linux-mmc@vger.kernel.org>; Wed, 18 Jan 2012 05:03:43 -0800 (PST)
In-Reply-To: <4F16892C.4040907@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>

On Wed, Jan 18, 2012 at 5:56 PM, Adrian Hunter <adrian.hunter@intel.com=
> wrote:
> On 18/01/12 10:13, Kyungmin Park wrote:
>> On 1/18/12, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>> On 18/01/12 01:58, Kyungmin Park wrote:
>>>> On 1/17/12, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>> On 17/01/12 11:53, Kyungmin Park wrote:
>>>>>> On 1/17/12, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>>>> On 17/01/12 11:05, Kyungmin Park wrote:
>>>>>>>> On 1/17/12, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>>>>>> On 16/01/12 10:49, Jaehoon Chung wrote:
>>>>>>>>>> This patch is added the MMC_CAP2_BROKEN_VOLTAGE.
>>>>>>>>>>
>>>>>>>>>> if the voltage didn't satisfy between min_uV and max_uV,
>>>>>>>>>
>>>>>>>>> Why is the fixed voltage not in the acceptable range for the =
card?
>>>>>>>>> Doesn't that risk breaking the card?
>>>>>>>> Hi Adrian,
>>>>>>>>
>>>>>>>> I don't know, they uses the not supported voltage. but it's wo=
rked
>>>>>>>> properly for long time.
>>>>>>>
>>>>>>> I wonder if there is a generic problem here that this fix hides=
=2E
>>>>>>> It would be nice to have an explanation. =A0Do you know:
>>>>>>> =A0- what is the fixed voltage?
>>>>>> Now 2.8V is supplied by gpio so make it fixed regulator
>>>>>>> =A0- is it supplying VCC or VCCQ?
>>>>>> VDD in our schematic.
>>>>>
>>>>> Is it the NAND core voltage or the I/O voltage?
>>>> In case of eMMC v4.41, it uses the same voltage, VDD is used for M=
MC
>>>> I/O block and controller and another VDDF is used for flash.
>>>
>>> It seems to me you just need to override the value of mmc->ocr_avai=
l_mmc
>>> calculated in sdhci_add_host() in sdhci.c to reflect the fact that =
the only
>>> voltage available is 2.8V.
>>
>> current sdhci ocr_avail is 0x300080 and wanted ocr is 0x10000 so it
>> doesn't support it.
>>
>> [ =A0 =A00.984754] sdhci_add_host[2888] ocr_avail 0x300080
>> [ =A0 =A00.989909] sdhci_add_host[2889] host->ocr_avail_mmc 0x10000
>
> Yes because sdhci_add_host() ANDs the values i.e.
>
> =A0 =A0 =A0 =A0if (host->ocr_avail_mmc)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->ocr_avail_mmc &=3D host->ocr_avai=
l_mmc;
Right, so it's meaningless set the host->ocr_avail_mmc. basically
sdhci doesn't support this voltage.
>
> You will have to add a new quirk or callback e.g.
That's reason add new quirk. MMC_CAP2_BROKEN_VOLTAGE.
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 8d66706..b8a04e3 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2980,6 +2980,12 @@ int sdhci_add_host(struct sdhci_host *host)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->vmmc =3D NULL;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 if (host->ops->fixup_host) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D host->ops->fixup_host(host);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto regput;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0sdhci_init(host, 0);
>
> =A0#ifdef CONFIG_MMC_DEBUG
> @@ -3012,6 +3018,9 @@ int sdhci_add_host(struct sdhci_host *host)
>
> =A0 =A0 =A0 =A0return 0;
>
> +regput:
> + =A0 =A0 =A0 if (host->vmmc)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 regulator_put(host->vmmc);
> =A0#ifdef SDHCI_USE_LEDS_CLASS
> =A0reset:
> =A0 =A0 =A0 =A0sdhci_reset(host, SDHCI_RESET_ALL);
>
>
> Then implement ->fixup_host() to make the change.
>
> Note that this is for I/O voltage or single voltage supply. =A0If the=
re is a
> need to control 2 separate voltages (e.g. VDD, VDDF or VCCQ, VCC as J=
EDEC
> calls them) it is more challenging because mmc core does not support =
it.
New H/W has different voltage for eMMC v4.5. but it's covered by PMIC.
It can be switches on/off by gpio then PMIC turn on/off each LDOs for
eMMC properly.

Thank you,
Kyungmin Park
>
>>
>> Thank you,
>> Kyungmin Park
>>>
>>>>>
>>>>>>> =A0- what is the contents of the OCR register?
>>>>>> In sdhci_set_power(). it returns SDHCI_POWER_180, SDHCI_POWER_30=
0, and
>>>>>> SDHCI_POWER_330.
>>>>>> In probe time, it return the SDHCI_POWER_330, and but fixed regu=
lator
>>>>>> returns the 2.8V so it calls regulator_set_voltage. and return -=
EINVAL
>>>>>> since it's fixed regulator.
>>>>>>
>>>>>> Of course we can make workaround, set fixed regulator voltage as=
 3.3V.
>>>>>> Even though actual voltage is 2.8V. so it's ambiguous.
>>>>>>
>>>>>> that's reason introduces the new quirk.
>>>>>>
>>>>>> Thank you,
>>>>>> Kyungmin Park
>>>>>>>
>>>>>>>> Galaxy S2 also uses the same voltage as ours.
>>>>>>>>
>>>>>>>> I also think the modify the regulator framework to support vol=
tage
>>>>>>>> change at fixed regulator. but it's not good idea and doesn't =
match
>>>>>>>> the regulator concept. so modify the sdhci codes to support ou=
r
>>>>>>>> boards.
>>>>>>>>
>>>>>>>> Thank you,
>>>>>>>> Kyungmin Park
>>>>>>>>>
>>>>>>>>>> try to change the voltage in core.c.
>>>>>>>>>> When change the voltage, maybe use the regulator_set_voltage=
().
>>>>>>>>>>
>>>>>>>>>> In regulator_set_voltage(), check the below condition.
>>>>>>>>>>
>>>>>>>>>> =A0 =A0 =A0 /* sanity check */
>>>>>>>>>> =A0 =A0 =A0 if (!rdev->desc->ops->set_voltage &&
>>>>>>>>>> =A0 =A0 =A0 =A0 =A0 !rdev->desc->ops->set_voltage_sel) {
>>>>>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
>>>>>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>>>>>>>>>> =A0 =A0 =A0 }
>>>>>>>>>>
>>>>>>>>>> If Some-board should use the fixed-regulator, always return =
-EINVAL.
>>>>>>>>>> Then, eMMC didn't initialize always.
>>>>>>>>>>
>>>>>>>>>> So if use the fixed-regulator or etc, we need to add the
>>>>>>>>>> MMC_CAP2_BROKEN_VOLTAGE.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>>>>>>>>>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>>>>>>>>>> ---
>>>>>>>>>> =A0drivers/mmc/core/core.c =A0| =A0 =A04 ++++
>>>>>>>>>> =A0include/linux/mmc/host.h | =A0 =A01 +
>>>>>>>>>> =A02 files changed, 5 insertions(+), 0 deletions(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core=
=2Ec
>>>>>>>>>> index bec0bf2..6848789 100644
>>>>>>>>>> --- a/drivers/mmc/core/core.c
>>>>>>>>>> +++ b/drivers/mmc/core/core.c
>>>>>>>>>> @@ -1121,6 +1121,10 @@ int mmc_regulator_set_ocr(struct mmc_=
host
>>>>>>>>>> *mmc,
>>>>>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* might not allow this operat=
ion
>>>>>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>>>>>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 voltage =3D regulator_get_voltag=
e(supply);
>>>>>>>>>> +
>>>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 if (mmc->caps2 & MMC_CAP2_BROKEN_V=
OLTAGE)
>>>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 min_uV =3D max_uV =
=3D voltage;
>>>>>>>>>> +
>>>>>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (voltage < 0)
>>>>>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 result =3D volta=
ge;
>>>>>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (voltage < min_uV || vol=
tage > max_uV)
>>>>>>>>>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/ho=
st.h
>>>>>>>>>> index dd13e05..5659aee 100644
>>>>>>>>>> --- a/include/linux/mmc/host.h
>>>>>>>>>> +++ b/include/linux/mmc/host.h
>>>>>>>>>> @@ -257,6 +257,7 @@ struct mmc_host {
>>>>>>>>>> =A0#define MMC_CAP2_HS200_1_2V_SDR =A0 =A0 =A0(1 << 6) =A0 =A0=
 =A0 =A0/* can support */
>>>>>>>>>> =A0#define MMC_CAP2_HS200 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (MMC_C=
AP2_HS200_1_8V_SDR | \
>>>>>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0MMC_CAP2_HS200_1_2V_SDR)
>>>>>>>>>> +#define MMC_CAP2_BROKEN_VOLTAGE =A0 =A0 =A0(1 << 7) =A0 =A0=
 =A0 =A0/* Use the broken voltage
>>>>>>>>>> */
>>>>>>>>>>
>>>>>>>>>> =A0 =A0 =A0 mmc_pm_flag_t =A0 =A0 =A0 =A0 =A0 pm_caps; =A0 =A0=
 =A0 =A0/* supported pm features */
>>>>>>>>>> =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0power_notify_type;
>>>>>>>>>> --
>>>>>>>>>> To unsubscribe from this list: send the line "unsubscribe li=
nux-mmc"
>>>>>>>>>> in
>>>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>>>> More majordomo info at =A0http://vger.kernel.org/majordomo-i=
nfo.html
>>>>>>>>>
>>>>>>>>> --
>>>>>>>>> To unsubscribe from this list: send the line "unsubscribe lin=
ux-mmc"
>>>>>>>>> in
>>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>>> More majordomo info at =A0http://vger.kernel.org/majordomo-in=
fo.html
>>>>>>>>>
>>>>>>>>
>>>>>>>
>>>>>>> --
>>>>>>> To unsubscribe from this list: send the line "unsubscribe linux=
-mmc" in
>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info=
=2Ehtml
>>>>>>>
>>>>>>
>>>>>
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe linux-m=
mc" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.h=
tml
>>>>>
>>>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc=
" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
>>>
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html

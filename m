From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] mmc: esdhc: add quirk to support 3.3v for T4240
Date: Thu, 4 Jun 2015 13:36:06 +0200
Message-ID: <CAPDyKFoo+iejT2S8EQ2hgVQxd3Bj7geYPE_JqHkZ5WK0xKmxxA@mail.gmail.com>
References: <1433228991-24324-1-git-send-email-yangbo.lu@freescale.com>
	<CAPDyKFp7=2L2_Vt1ha3jcFV=P2EDHEg0UwpcRu_t8r+ED-jDdA@mail.gmail.com>
	<BY1PR0301MB1192D4F50E8155073F771DC5F2B30@BY1PR0301MB1192.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f172.google.com ([209.85.220.172]:34896 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753404AbbFDLgH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Jun 2015 07:36:07 -0400
Received: by qkhq76 with SMTP id q76so22005687qkh.2
        for <linux-mmc@vger.kernel.org>; Thu, 04 Jun 2015 04:36:06 -0700 (PDT)
In-Reply-To: <BY1PR0301MB1192D4F50E8155073F771DC5F2B30@BY1PR0301MB1192.namprd03.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Lu Y.B." <yangbo.lu@freescale.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chrisball@gmail.com>

On 4 June 2015 at 11:56, Lu Y.B. <yangbo.lu@freescale.com> wrote:
> Pls see my comments below.
>
>> -----Original Message-----
>> From: Ulf Hansson [mailto:ulf.hansson@linaro.org]
>> Sent: Thursday, June 04, 2015 3:51 PM
>> To: Lu Yangbo-B47093
>> Cc: linux-mmc; Chris Ball
>> Subject: Re: [PATCH 2/2] mmc: esdhc: add quirk to support 3.3v for T4240
>>
>> On 2 June 2015 at 09:09, Yangbo Lu <yangbo.lu@freescale.com> wrote:
>> > Add SDHCI_QUIRK2_CIRCUIT_SUPPORT_VS33 for T4240
>> >
>> > Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
>> > ---
>> >  drivers/mmc/host/sdhci-of-esdhc.c | 3 +++
>> >  1 file changed, 3 insertions(+)
>> >
>> > diff --git a/drivers/mmc/host/sdhci-of-esdhc.c
>> b/drivers/mmc/host/sdhci-of-esdhc.c
>> > index 22e9111..4f5fe42 100644
>> > --- a/drivers/mmc/host/sdhci-of-esdhc.c
>> > +++ b/drivers/mmc/host/sdhci-of-esdhc.c
>> > @@ -369,6 +369,9 @@ static int sdhci_esdhc_probe(struct platform_device
>> *pdev)
>> >                 host->quirks2 |= SDHCI_QUIRK2_BROKEN_HOST_CONTROL;
>> >         }
>> >
>> > +       if (of_device_is_compatible(np, "fsl,t4240-esdhc"))
>> > +               host->quirks2 |= SDHCI_QUIRK2_CIRCUIT_SUPPORT_VS33;
>> > +
>>
>> Instead of checking the compatible, could you check the "ocr_avail"
>> mask which mmc_of_parse() create from the vmmc regulator?
>
> It could get ocr_mask value supporting 3.3v from dts, and get ocr_avail not supporting 3.3v from capability register.
> But in sdhci.c, the ocr_avail will "&" the ocr_mask value, this makes 3.3v supporting bit cleaned.
>
> if (host->ocr_mask)
>         ocr_avail &= host->ocr_mask;

I have to admit that this looks a bit odd...

Anyway, as long as you don't specify the "host->ocr_mask" the above
"if" will not change the ocr_avail mask.

Looking a bit further up in the code in sdhci_add_host(), you will
find that the ocr_avail mask is created by calling
mmc_regulator_get_supply() (and not mmc_of_parse() as told you
before). If there are external regulators, the ocr_avail mask will
then override the values from SDHCI's caps register.

Anyway, as this patch seems to intended fixing something related to
the IO voltage, it all looks wrong.

[...]

Kind regards
Uffe

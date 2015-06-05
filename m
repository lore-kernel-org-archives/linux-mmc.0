From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] mmc: esdhc: add quirk to support 3.3v for T4240
Date: Fri, 5 Jun 2015 10:16:10 +0200
Message-ID: <CAPDyKFqHmspn5E_TN8A8FxGWu=em4X++K-7Xrp+GzZSk=NPfkQ@mail.gmail.com>
References: <1433228991-24324-1-git-send-email-yangbo.lu@freescale.com>
	<CAPDyKFp7=2L2_Vt1ha3jcFV=P2EDHEg0UwpcRu_t8r+ED-jDdA@mail.gmail.com>
	<BY1PR0301MB1192D4F50E8155073F771DC5F2B30@BY1PR0301MB1192.namprd03.prod.outlook.com>
	<CAPDyKFoo+iejT2S8EQ2hgVQxd3Bj7geYPE_JqHkZ5WK0xKmxxA@mail.gmail.com>
	<BN3PR0301MB11880D7C297EE4636D9E721CF2B20@BN3PR0301MB1188.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:36402 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751285AbbFEIQL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Jun 2015 04:16:11 -0400
Received: by qcxw10 with SMTP id w10so27329926qcx.3
        for <linux-mmc@vger.kernel.org>; Fri, 05 Jun 2015 01:16:10 -0700 (PDT)
In-Reply-To: <BN3PR0301MB11880D7C297EE4636D9E721CF2B20@BN3PR0301MB1188.namprd03.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Lu Y.B." <yangbo.lu@freescale.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Haijun Zhang <Haijun.Zhang@freescale.com>

On 5 June 2015 at 09:10, Lu Y.B. <yangbo.lu@freescale.com> wrote:
> Thanks a lot, see my comments.
>
>> -----Original Message-----
>> From: Ulf Hansson [mailto:ulf.hansson@linaro.org]
>> Sent: Thursday, June 04, 2015 7:36 PM
>> To: Lu Yangbo-B47093
>> Cc: linux-mmc; Chris Ball
>> Subject: Re: [PATCH 2/2] mmc: esdhc: add quirk to support 3.3v for T4240
>>
>> On 4 June 2015 at 11:56, Lu Y.B. <yangbo.lu@freescale.com> wrote:
>> > Pls see my comments below.
>> >
>> >> -----Original Message-----
>> >> From: Ulf Hansson [mailto:ulf.hansson@linaro.org]
>> >> Sent: Thursday, June 04, 2015 3:51 PM
>> >> To: Lu Yangbo-B47093
>> >> Cc: linux-mmc; Chris Ball
>> >> Subject: Re: [PATCH 2/2] mmc: esdhc: add quirk to support 3.3v for
>> >> T4240
>> >>
>> >> On 2 June 2015 at 09:09, Yangbo Lu <yangbo.lu@freescale.com> wrote:
>> >> > Add SDHCI_QUIRK2_CIRCUIT_SUPPORT_VS33 for T4240
>> >> >
>> >> > Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
>> >> > ---
>> >> >  drivers/mmc/host/sdhci-of-esdhc.c | 3 +++
>> >> >  1 file changed, 3 insertions(+)
>> >> >
>> >> > diff --git a/drivers/mmc/host/sdhci-of-esdhc.c
>> >> b/drivers/mmc/host/sdhci-of-esdhc.c
>> >> > index 22e9111..4f5fe42 100644
>> >> > --- a/drivers/mmc/host/sdhci-of-esdhc.c
>> >> > +++ b/drivers/mmc/host/sdhci-of-esdhc.c
>> >> > @@ -369,6 +369,9 @@ static int sdhci_esdhc_probe(struct
>> >> > platform_device
>> >> *pdev)
>> >> >                 host->quirks2 |= SDHCI_QUIRK2_BROKEN_HOST_CONTROL;
>> >> >         }
>> >> >
>> >> > +       if (of_device_is_compatible(np, "fsl,t4240-esdhc"))
>> >> > +               host->quirks2 |= SDHCI_QUIRK2_CIRCUIT_SUPPORT_VS33;
>> >> > +
>> >>
>> >> Instead of checking the compatible, could you check the "ocr_avail"
>> >> mask which mmc_of_parse() create from the vmmc regulator?
>> >
>> > It could get ocr_mask value supporting 3.3v from dts, and get ocr_avail
>> not supporting 3.3v from capability register.
>> > But in sdhci.c, the ocr_avail will "&" the ocr_mask value, this makes
>> 3.3v supporting bit cleaned.
>> >
>> > if (host->ocr_mask)
>> >         ocr_avail &= host->ocr_mask;
>>
>> I have to admit that this looks a bit odd...
>>
>> Anyway, as long as you don't specify the "host->ocr_mask" the above "if"
>> will not change the ocr_avail mask.
>
> Actually the sdhci-of-esdhc driver would set host->ocr_mask when it probes.
> mmc_of_parse_voltage(np, &host->ocr_mask);

Okay, got it - thanks!

So I tried to understand when the voltage-range binding should be
used, but the DT documentation is quite poor for it.

Anyway, I assumes the binding is there to describe internal HW
characteristics of the what regulator levels the mmc controller can
support. And the regulator levels are for the power to the card, *not*
for the IO voltage.

So, is this according to what you expects as well, especially since
you were aiming to fix something for the IO voltage in patch1?

>
> But the "&" operation will make host->ocr_mask to have no use for other voltage supporting.
> I think using "|" instead or just assigning host->ocr_mask to ocr_avail should be ok.
> If so, there is no need to add this quirk.

This is kind of a policy change for how to treat the configuration
from DT. I have cc:ed Haijun Zhang, which invented the binding to see
if we can get some feeback from him.

The commit is: 6e9e318b304fd7373a0754805a76a02ddbc69a41 ("mmc: core:
parse voltage from device-tree")

>
>>
>> Looking a bit further up in the code in sdhci_add_host(), you will find
>> that the ocr_avail mask is created by calling
>> mmc_regulator_get_supply() (and not mmc_of_parse() as told you before).
>> If there are external regulators, the ocr_avail mask will then override
>> the values from SDHCI's caps register.
>
> But there is no external regulator on boards that using eSDHC...
>

Quoted from your response in patch1:
"Although the controller only supports 1.8v, the hardware circuit has
a level translator for supporting 3.3v".

Again, that seems to concern the IO voltage, but if not - could it be
modelled as regulator and thus used to fetch the ocr mask from?

It's quite common that we use GPIO regulators in the mmc subsystem for
this matter.

Kind regards
Uffe

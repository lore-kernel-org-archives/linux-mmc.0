From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] mmc: esdhc: add quirk to support 3.3v for T4240
Date: Fri, 5 Jun 2015 11:38:29 +0200
Message-ID: <CAPDyKFqO7rPbp61wKWTGSxox0Poix6zD_B8wZS+NZRUVm=MswQ@mail.gmail.com>
References: <1433228991-24324-1-git-send-email-yangbo.lu@freescale.com>
	<CAPDyKFp7=2L2_Vt1ha3jcFV=P2EDHEg0UwpcRu_t8r+ED-jDdA@mail.gmail.com>
	<BY1PR0301MB1192D4F50E8155073F771DC5F2B30@BY1PR0301MB1192.namprd03.prod.outlook.com>
	<CAPDyKFoo+iejT2S8EQ2hgVQxd3Bj7geYPE_JqHkZ5WK0xKmxxA@mail.gmail.com>
	<BN3PR0301MB11880D7C297EE4636D9E721CF2B20@BN3PR0301MB1188.namprd03.prod.outlook.com>
	<CAPDyKFqHmspn5E_TN8A8FxGWu=em4X++K-7Xrp+GzZSk=NPfkQ@mail.gmail.com>
	<BN3PR0301MB118815B464D4ECAB2987F565F2B20@BN3PR0301MB1188.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f44.google.com ([209.85.192.44]:33132 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751223AbbFEJia convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Jun 2015 05:38:30 -0400
Received: by qgh96 with SMTP id 96so75948qgh.0
        for <linux-mmc@vger.kernel.org>; Fri, 05 Jun 2015 02:38:29 -0700 (PDT)
In-Reply-To: <BN3PR0301MB118815B464D4ECAB2987F565F2B20@BN3PR0301MB1188.namprd03.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Lu Y.B." <yangbo.lu@freescale.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Haijun Zhang <Haijun.Zhang@freescale.com>

[...]

>> > Actually the sdhci-of-esdhc driver would set host->ocr_mask when i=
t
>> probes.
>> > mmc_of_parse_voltage(np, &host->ocr_mask);
>>
>> Okay, got it - thanks!
>>
>> So I tried to understand when the voltage-range binding should be us=
ed,
>> but the DT documentation is quite poor for it.
>>
>> Anyway, I assumes the binding is there to describe internal HW
>> characteristics of the what regulator levels the mmc controller can
>> support. And the regulator levels are for the power to the card, *no=
t*
>> for the IO voltage.
>>
>> So, is this according to what you expects as well, especially since =
you
>> were aiming to fix something for the IO voltage in patch1?
>>
>> >
>> > But the "&" operation will make host->ocr_mask to have no use for =
other
>> voltage supporting.
>> > I think using "|" instead or just assigning host->ocr_mask to ocr_=
avail
>> should be ok.
>> > If so, there is no need to add this quirk.
>>
>> This is kind of a policy change for how to treat the configuration f=
rom
>> DT. I have cc:ed Haijun Zhang, which invented the binding to see if =
we
>> can get some feeback from him.
>>
>> The commit is: 6e9e318b304fd7373a0754805a76a02ddbc69a41 ("mmc: core:
>> parse voltage from device-tree")
>
> Haijun Zhang had left his job. And I have worked instead of him recen=
tly.
> I have new find about this.
>
> commit c0b887b66c95fe5abaac071b8332b8c21113d84b
> Author: Haijun Zhang <Haijun.Zhang@freescale.com>
> Date:   Mon Aug 26 09:19:23 2013 +0800
>
>     mmc: sdhci: get voltage from sdhc host
>
>     We use host->ocr_mask to hold the voltage get from device-tree
>     node, In case host->ocr_mask was available, we use host->ocr_mask
>     as the final available voltage can be used by MMC/SD/SDIO card.
>
>     Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
>     Reviewed-by: Anton Vorontsov <anton@enomsg.org>
>     Signed-off-by: Chris Ball <cjb@laptop.org>
>
> This was change by commit 3a48edc4bd68f841c07c7bc86358d2f02133f247.
> But I didn=E2=80=99t see the reason.

Oh, that's unfortunate. I think it shouldn't have done that.

>
>>
>> >
>> >>
>> >> Looking a bit further up in the code in sdhci_add_host(), you wil=
l
>> >> find that the ocr_avail mask is created by calling
>> >> mmc_regulator_get_supply() (and not mmc_of_parse() as told you be=
fore).
>> >> If there are external regulators, the ocr_avail mask will then
>> >> override the values from SDHCI's caps register.
>> >
>> > But there is no external regulator on boards that using eSDHC...
>> >
>>
>> Quoted from your response in patch1:
>> "Although the controller only supports 1.8v, the hardware circuit ha=
s a
>> level translator for supporting 3.3v".
>>
>> Again, that seems to concern the IO voltage, but if not - could it b=
e
>> modelled as regulator and thus used to fetch the ocr mask from?
>>
>> It's quite common that we use GPIO regulators in the mmc subsystem f=
or
>> this matter.
>>
> I am afraid not.
> Such as, some boards only support 1.8v, but we used adapter card that=
 makes sd work on 3.3v power voltage and 3.3v IO voltage.
> And some boards may be integrated the level translator on the board t=
o make sd card work on 3.3v power and 3.3v IO voltage.
>
>

I believe am starting to understand the problem now. You are likely
suffering from the change in 3a48edc4bd68f841c07c7bc86358d2f02133f247.
I will cook a patch for you that you can test.

Kind regards
Uffe

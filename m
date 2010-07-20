From: kishore kadiyala <kishorek.kadiyala@gmail.com>
Subject: Re: [PATCH] omap: hsmmc funtionality breaks when CONFIG_PM not define
Date: Tue, 20 Jul 2010 19:36:43 +0530
Message-ID: <AANLkTilDOxmuOKnC0WpKdmkdRid_MLbiXiRhM5U5pFMX@mail.gmail.com>
References: <1279607878-2405-1-git-send-email-s-ghorai@ti.com>
	<4C454B99.7090705@nokia.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B030E3107D8@dbde02.ent.ti.com>
	<4C4559E5.7090004@nokia.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B030E310805@dbde02.ent.ti.com>
	<4C4560EB.8070702@nokia.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B030E31084E@dbde02.ent.ti.com>
	<4C4568C6.9050705@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:64834 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752373Ab0GTOGo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Jul 2010 10:06:44 -0400
In-Reply-To: <4C4568C6.9050705@nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: "Ghorai, Sukumar" <s-ghorai@ti.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, Andrew Morton <akpm@linux-foundation.org>

Hi Adrian,

Is there any use case or a valid scenario  whether to use
omap_hsmmc_ps_ops or omap_hsmmc_ops ?
I meant using power_saving option and without power_saving option

Ideally I feel having omap_hsmmc_ps_ops as default with or without
CONFIG_PM would be better as it internally has a state handling.

Regards,
Kishore

On Tue, Jul 20, 2010 at 2:43 PM, Adrian Hunter <adrian.hunter@nokia.com=
> wrote:
> Ghorai, Sukumar wrote:
>>
>>> -----Original Message-----
>>> From: Adrian Hunter [mailto:adrian.hunter@nokia.com]
>>> Sent: Tuesday, July 20, 2010 2:10 PM
>>> To: Ghorai, Sukumar
>>> Cc: linux-mmc@vger.kernel.org; linux-omap@vger.kernel.org; Shilimka=
r,
>>> Santosh; Chikkature Rajashekar, Madhusudhan; Andrew Morton
>>> Subject: Re: [PATCH] omap: hsmmc funtionality breaks when CONFIG_PM=
 not
>>> define
>>>
>>> Ghorai, Sukumar wrote:
>>>>
>>>> Adrian,
>>>>
>>>>> -----Original Message-----
>>>>> From: Adrian Hunter [mailto:adrian.hunter@nokia.com]
>>>>> Sent: Tuesday, July 20, 2010 1:40 PM
>>>>> To: Ghorai, Sukumar
>>>>> Cc: linux-mmc@vger.kernel.org; linux-omap@vger.kernel.org; Shilim=
kar,
>>>>> Santosh; Chikkature Rajashekar, Madhusudhan; Andrew Morton
>>>>> Subject: Re: [PATCH] omap: hsmmc funtionality breaks when CONFIG_=
PM not
>>>>> define
>>>>>
>>>>> Ghorai, Sukumar wrote:
>>>>>>>
>>>>>>> -----Original Message-----
>>>>>>> From: Adrian Hunter [mailto:adrian.hunter@nokia.com]
>>>>>>> Sent: Tuesday, July 20, 2010 12:39 PM
>>>>>>> To: Ghorai, Sukumar
>>>>>>> Cc: linux-mmc@vger.kernel.org; linux-omap@vger.kernel.org; Shil=
imkar,
>>>>>>> Santosh; Chikkature Rajashekar, Madhusudhan; Andrew Morton
>>>>>>> Subject: Re: [PATCH] omap: hsmmc funtionality breaks when CONFI=
G_PM
>>>
>>> not
>>>>>>>
>>>>>>> define
>>>>>>>
>>>>>>> Sukumar Ghorai wrote:
>>>>>>>>
>>>>>>>> =A0 =A0Issue if power_saving option passed from board file and
>>>
>>> CONFIG_PM
>>>>>>>
>>>>>>> not define.
>>>>>>>>
>>>>>>>> =A0 =A0This is because hosts refer to wrong operation table an=
d that
>>>
>>> try
>>>>>
>>>>> to
>>>>>>>
>>>>>>> power save.
>>>>>>>
>>>>>>> power_saving is not related to power management. =A0It should w=
ork with
>>>>>
>>>>> or
>>>>>>>
>>>>>>> without
>>>>>>> CONFIG_PM. =A0What problem are you seeing?
>>>>>>
>>>>>> [Ghorai] when CONFIG_PM is not defined but power_saving flag is =
TRUE,
>>>>>
>>>>> then host operation table point to table which handles in state m=
achine
>>>>> as: ENABLE -> CARDSLEEP -> REGSLEEP -> DISABLED for power/clock c=
ut.
>>>
>>> And
>>>>>
>>>>> do the reverse for the enable clock/power.
>>>>>>
>>>>>> And power saving is not required and wont work when CONFIG_PM is=
 not
>>>>>
>>>>> enabled.
>>>>>
>>>>> How is that a problem? =A0It would be useful to know what you nee=
d?
>>>>
>>>> [Ghorai] do men when CONFIG_PM is not enabled still we should do p=
ower
>>>
>>> saving in mmc?
>>>
>>> Why not?
>>>
>>> Because issue is iclk/fclk is quite depended on PRCM framework when=
 we
>>> are
>>> using omap_hsmmc_ps_ops operation table.
>>>
>>> iclk is left alone.
>>>
>>> fclk is manipulated with or without power_saving.
>>>
>>> I still do not understand your problem sorry :-(
>>
>> [Ghorai] thanks and need input again, =A0we have two tables -
>> 1. static const struct mmc_host_ops omap_hsmmc_ops =3D {
>> }
>> --> This is without CONFIG_PM, assumed.
>
> No it is independent of CONFIG_PM
>
> With CONFIG_PM
> =A0 =A0 =A0 =A0- the driver will restore registers if the host contro=
ller
> =A0 =A0 =A0 =A0has been powered off / on by PRCM
> =A0 =A0 =A0 =A0- suspend / resume can be used
>
>>
>> 2. static const struct mmc_host_ops omap_hsmmc_ps_ops =3D {
>> }
>> -> this with CONFIG_PM, assumed.
>
> No it is independent of CONFIG_PM
>
> Without CONFIG_PM
> =A0 =A0 =A0 =A0- card will be put to sleep after 1 second
> =A0 =A0 =A0 =A0- card will be powered off after another 8 seconds
>
>>
>> a. And you feel we should remove #1
>
> Nothing should need to be removed.
>
>> b. use omap_hsmmc_ps_ops default.
>
> With power_saving it is yes.
>
>> c. And it should work in all case?
>
> It should work in all cases.
>
>>
>>>>>> So if CONFIG_PM is not enable, then it should do simple clock
>>>>>
>>>>> disable/enable, and not via the power state machine.
>>>>>
>>>>> If that is what you want, simply change your board file:
>>>>>
>>>>> #if CONFIG_PM
>>>>> =A0 =A0 =A0 =A0.power_saving =3D true,
>>>>> #else
>>>>> =A0 =A0 =A0 =A0.power_saving =3D false,
>>>>> #end
>>>>
>>>> [Ghorai] the fix I send is to guard in MMC/SD host driver to avoid
>>>
>>> mistake in board file(s). And this file is used for multiple omap3,=
 omap4
>>> boards.
>>>>>>>>
>>>>>>>> Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>
>>>>>>>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>>>>>>> CC: Madhusudhan Chikkature <madhu.cr@ti.com>
>>>>>>>> CC: Andrew Morton <akpm@linux-foundation.org>
>>>>>>>> ---
>>>>>>>> =A0Tested on omap3, omap4430 ES2.0
>>>>>>>>
>>>>>>>> =A0drivers/mmc/host/omap_hsmmc.c | =A0 =A02 ++
>>>>>>>> =A01 files changed, 2 insertions(+), 0 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/mmc/host/omap_hsmmc.c
>>>>>>>
>>>>>>> b/drivers/mmc/host/omap_hsmmc.c
>>>>>>>>
>>>>>>>> index b032828..f84eed0 100644
>>>>>>>> --- a/drivers/mmc/host/omap_hsmmc.c
>>>>>>>> +++ b/drivers/mmc/host/omap_hsmmc.c
>>>>>>>> @@ -2015,9 +2015,11 @@ static int __init omap_hsmmc_probe(stru=
ct
>>>>>>>
>>>>>>> platform_device *pdev)
>>>>>>>>
>>>>>>>> =A0 =A0 =A0 =A0platform_set_drvdata(pdev, host);
>>>>>>>> =A0 =A0 =A0 =A0INIT_WORK(&host->mmc_carddetect_work, omap_hsmm=
c_detect);
>>>>>>>>
>>>>>>>> +#ifdef CONFIG_PM
>>>>>>>> =A0 =A0 =A0 =A0if (mmc_slot(host).power_saving)
>>>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->ops =A0 =A0 =A0 =A0=3D &om=
ap_hsmmc_ps_ops;
>>>>>>>> =A0 =A0 =A0 =A0else
>>>>>>>> +#endif
>>>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->ops =A0 =A0 =A0 =A0=3D &om=
ap_hsmmc_ops;
>>>>>>>>
>>>>>>>> =A0 =A0 =A0 =A0/*
>>>>>>>> --
>>>>>>>> To unsubscribe from this list: send the line "unsubscribe linu=
x-mmc"
>>>>>
>>>>> in
>>>>>>>>
>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>> More majordomo info at =A0http://vger.kernel.org/majordomo-inf=
o.html
>>>>>>>>
>>>>>> Regards,
>>>>>> Ghorai
>>>>>> --
>>>>>> To unsubscribe from this list: send the line "unsubscribe linux-=
mmc"
>>>
>>> in
>>>>>>
>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.=
html
>>>>>>
>>>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>

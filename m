From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: Re: [PATCH] omap: hsmmc funtionality breaks when CONFIG_PM not define
Date: Tue, 20 Jul 2010 12:13:42 +0300
Message-ID: <4C4568C6.9050705@nokia.com>
References: <1279607878-2405-1-git-send-email-s-ghorai@ti.com> <4C454B99.7090705@nokia.com> <2A3DCF3DA181AD40BDE86A3150B27B6B030E3107D8@dbde02.ent.ti.com> <4C4559E5.7090004@nokia.com> <2A3DCF3DA181AD40BDE86A3150B27B6B030E310805@dbde02.ent.ti.com> <4C4560EB.8070702@nokia.com> <2A3DCF3DA181AD40BDE86A3150B27B6B030E31084E@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:44452 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758398Ab0GTJOm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Jul 2010 05:14:42 -0400
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B030E31084E@dbde02.ent.ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Ghorai, Sukumar" <s-ghorai@ti.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, Andrew Morton <akpm@linux-foundation.org>

Ghorai, Sukumar wrote:
> 
>> -----Original Message-----
>> From: Adrian Hunter [mailto:adrian.hunter@nokia.com]
>> Sent: Tuesday, July 20, 2010 2:10 PM
>> To: Ghorai, Sukumar
>> Cc: linux-mmc@vger.kernel.org; linux-omap@vger.kernel.org; Shilimkar,
>> Santosh; Chikkature Rajashekar, Madhusudhan; Andrew Morton
>> Subject: Re: [PATCH] omap: hsmmc funtionality breaks when CONFIG_PM not
>> define
>>
>> Ghorai, Sukumar wrote:
>>> Adrian,
>>>
>>>> -----Original Message-----
>>>> From: Adrian Hunter [mailto:adrian.hunter@nokia.com]
>>>> Sent: Tuesday, July 20, 2010 1:40 PM
>>>> To: Ghorai, Sukumar
>>>> Cc: linux-mmc@vger.kernel.org; linux-omap@vger.kernel.org; Shilimkar,
>>>> Santosh; Chikkature Rajashekar, Madhusudhan; Andrew Morton
>>>> Subject: Re: [PATCH] omap: hsmmc funtionality breaks when CONFIG_PM not
>>>> define
>>>>
>>>> Ghorai, Sukumar wrote:
>>>>>> -----Original Message-----
>>>>>> From: Adrian Hunter [mailto:adrian.hunter@nokia.com]
>>>>>> Sent: Tuesday, July 20, 2010 12:39 PM
>>>>>> To: Ghorai, Sukumar
>>>>>> Cc: linux-mmc@vger.kernel.org; linux-omap@vger.kernel.org; Shilimkar,
>>>>>> Santosh; Chikkature Rajashekar, Madhusudhan; Andrew Morton
>>>>>> Subject: Re: [PATCH] omap: hsmmc funtionality breaks when CONFIG_PM
>> not
>>>>>> define
>>>>>>
>>>>>> Sukumar Ghorai wrote:
>>>>>>>     Issue if power_saving option passed from board file and
>> CONFIG_PM
>>>>>> not define.
>>>>>>>     This is because hosts refer to wrong operation table and that
>> try
>>>> to
>>>>>> power save.
>>>>>>
>>>>>> power_saving is not related to power management.  It should work with
>>>> or
>>>>>> without
>>>>>> CONFIG_PM.  What problem are you seeing?
>>>>> [Ghorai] when CONFIG_PM is not defined but power_saving flag is TRUE,
>>>> then host operation table point to table which handles in state machine
>>>> as: ENABLE -> CARDSLEEP -> REGSLEEP -> DISABLED for power/clock cut.
>> And
>>>> do the reverse for the enable clock/power.
>>>>> And power saving is not required and wont work when CONFIG_PM is not
>>>> enabled.
>>>>
>>>> How is that a problem?  It would be useful to know what you need?
>>> [Ghorai] do men when CONFIG_PM is not enabled still we should do power
>> saving in mmc?
>>
>> Why not?
>>
>> Because issue is iclk/fclk is quite depended on PRCM framework when we are
>> using omap_hsmmc_ps_ops operation table.
>>
>> iclk is left alone.
>>
>> fclk is manipulated with or without power_saving.
>>
>> I still do not understand your problem sorry :-(
> [Ghorai] thanks and need input again,  
> we have two tables -
> 1. static const struct mmc_host_ops omap_hsmmc_ops = {
> }
> --> This is without CONFIG_PM, assumed.

No it is independent of CONFIG_PM

With CONFIG_PM
	- the driver will restore registers if the host controller
	has been powered off / on by PRCM
	- suspend / resume can be used

> 
> 2. static const struct mmc_host_ops omap_hsmmc_ps_ops = {
> }
> -> this with CONFIG_PM, assumed.

No it is independent of CONFIG_PM

Without CONFIG_PM
	- card will be put to sleep after 1 second
	- card will be powered off after another 8 seconds

> 
> a. And you feel we should remove #1 

Nothing should need to be removed.

> b. use omap_hsmmc_ps_ops default. 

With power_saving it is yes.

> c. And it should work in all case? 

It should work in all cases.

> 
>>>>> So if CONFIG_PM is not enable, then it should do simple clock
>>>> disable/enable, and not via the power state machine.
>>>>
>>>> If that is what you want, simply change your board file:
>>>>
>>>> #if CONFIG_PM
>>>> 	.power_saving = true,
>>>> #else
>>>> 	.power_saving = false,
>>>> #end
>>> [Ghorai] the fix I send is to guard in MMC/SD host driver to avoid
>> mistake in board file(s). And this file is used for multiple omap3, omap4
>> boards.
>>>>>>> Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>
>>>>>>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>>>>>> CC: Madhusudhan Chikkature <madhu.cr@ti.com>
>>>>>>> CC: Andrew Morton <akpm@linux-foundation.org>
>>>>>>> ---
>>>>>>>  Tested on omap3, omap4430 ES2.0
>>>>>>>
>>>>>>>  drivers/mmc/host/omap_hsmmc.c |    2 ++
>>>>>>>  1 files changed, 2 insertions(+), 0 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/mmc/host/omap_hsmmc.c
>>>>>> b/drivers/mmc/host/omap_hsmmc.c
>>>>>>> index b032828..f84eed0 100644
>>>>>>> --- a/drivers/mmc/host/omap_hsmmc.c
>>>>>>> +++ b/drivers/mmc/host/omap_hsmmc.c
>>>>>>> @@ -2015,9 +2015,11 @@ static int __init omap_hsmmc_probe(struct
>>>>>> platform_device *pdev)
>>>>>>>  	platform_set_drvdata(pdev, host);
>>>>>>>  	INIT_WORK(&host->mmc_carddetect_work, omap_hsmmc_detect);
>>>>>>>
>>>>>>> +#ifdef CONFIG_PM
>>>>>>>  	if (mmc_slot(host).power_saving)
>>>>>>>  		mmc->ops	= &omap_hsmmc_ps_ops;
>>>>>>>  	else
>>>>>>> +#endif
>>>>>>>  		mmc->ops	= &omap_hsmmc_ops;
>>>>>>>
>>>>>>>  	/*
>>>>>>> --
>>>>>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"
>>>> in
>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>>>
>>>>> Regards,
>>>>> Ghorai
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"
>> in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>
>>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


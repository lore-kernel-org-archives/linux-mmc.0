From: Balaji T K <balajitk@ti.com>
Subject: Re: [PATCH v3 2/3] mmc: omap_hsmmc: Pin remux workaround to support
 SDIO interrupt on AM335x.
Date: Thu, 21 Nov 2013 17:28:33 +0530
Message-ID: <528DF569.4070501@ti.com>
References: <1384761240-11005-1-git-send-email-afenkart@gmail.com> <1384761240-11005-3-git-send-email-afenkart@gmail.com> <CAOf5uw=9KJ312PVzMVEHX-Lj=iYpeZOYFduB8iOu9o+-863CYw@mail.gmail.com> <CALtMJEBfeww=ymGMXWtwjtZrpqpFrkRPEOti_uPrE63SBk3Dtw@mail.gmail.com> <528A3EB2.1010103@ti.com> <20131119154909.GD10317@atomide.com> <528B8ADA.6030703@ti.com> <20131119161932.GE10317@atomide.com> <CALtMJECrCxtPY_dfy832-EsgXCNB6u+mW0w_yVDnDWMo5Up-NQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51308 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752241Ab3KUL6m (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 21 Nov 2013 06:58:42 -0500
In-Reply-To: <CALtMJECrCxtPY_dfy832-EsgXCNB6u+mW0w_yVDnDWMo5Up-NQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andreas Fenkart <afenkart@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Michael Trimarchi <michael@amarulasolutions.com>, Chris Ball <cjb@laptop.org>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, Daniel Mack <zonque@gmail.com>, linux-doc@vger.kernel.org, linux-mmc <linux-mmc@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Thursday 21 November 2013 05:07 PM, Andreas Fenkart wrote:
> 2013/11/19 Tony Lindgren <tony@atomide.com>:
>> * Balaji T K <balajitk@ti.com> [131119 08:00]:
>>> On Tuesday 19 November 2013 09:19 PM, Tony Lindgren wrote:
>>>> * Balaji T K <balajitk@ti.com> [131118 08:23]:
>>>>>
>>>>> few params were passed via platform data in non-DT case and never cached
>>>>> in internal data structure, with non-dt support going away soon, I am
>>>>> planning to cleanup pdata usage in the driver when it gets to DT only support.
>>>>
>>>> The issue of pdata tinkering needs to be fixed first as it will cause nasty
>>>> issues when the module is reprobed.
>>>
>>> Agree that pdata usage needs to be fixed, but currently module
>>> reprobe is working fine.
>>
>> OK. The sdio_irq should be just set in struct omap_hsmmc_host instead.

agree, sdio_irq should be cached in struct omap_hsmmc_host

>>
>>>> Note that it's still possible to pass platform data in the device tree case
>>>> as auxdata. And we probably need to do that for the pbias register handling
>>>> until we have a driver for that.
>>>>
>>>> Talking of the pbias driver, any news on it?
>>>
>>> Almost there, will post the patches soon.
>>> Do you have a branch with updated board files, for me to base pbias patches on
>>> else I can base the patches on rc1 too.
>>
>> Great. How about make the pbias driver DT only? Let's not touch the board-*.c
>> files any longer as those will be going away for v3.14. We can probably keep
>> the old callback support in place also, and then remove it for v3.15.
>
> Is there a dependency on the patches from Balaji or can the SDIO IRQ patches
> go in already?
>
Hi Andreas,

I could get sdio interrupt working on AM335x, will do more testing and get back
to you.

Pbias shouldn't have create any dependency. Just add sdio_irq to
struct omap_hsmmc_host as suggested by Tony.

Thanks and Regards,
Balaji T K

>>
>> And after that it would certainly make sense to rip out the platform data
>> fomr hsmmc driver just to get rid of the legacy support for multiplexing slots
>> that's not needed in this driver. That would allow replacing all mmc->slots[0]
>> accesses with something more standard.
>>
>
>
> rgds,
> Andi
>

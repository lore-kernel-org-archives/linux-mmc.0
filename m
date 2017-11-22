From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: More TMIO MMC variant. What is a preferred name?
Date: Wed, 22 Nov 2017 10:20:45 +0900
Message-ID: <CAK7LNAQT8q0YQzWMZ71o9vQ0N_zj=o7kutrqqOFtzekeMixT0w@mail.gmail.com>
References: <CAK7LNARB+-SzgNF+7KsG80o4Q=TZsEeyMLjR2Ve0bXCrQ5tc0w@mail.gmail.com>
 <20171108175320.wnq3d2x7lmpaya7s@ninjato> <CAK7LNASN8kjmiNHvX7zrgVv=5d81ovfGNRdHm8TXiJNgr+H9MA@mail.gmail.com>
 <20171120201142.n4l4jelxsmmtwjj6@tetsubishi> <CAPDyKFq_uVvBKBhATNYhq2mSMmNXA7tPSSPMESCnTDtQt9XrZA@mail.gmail.com>
 <20171121200111.vrpmsubme55356qv@ninjato> <CAPDyKFo6X+Z6bORzPow=79Q7jXZOu4SMA9dh1fDsD-_JrBRtgA@mail.gmail.com>
 <CAK7LNARpchnGL8ZGWcFs=bxmH2FK71Voyd5K1E6=3bHTjd-gyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from conssluserg-05.nifty.com ([210.131.2.90]:56078 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751429AbdKVBVv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Nov 2017 20:21:51 -0500
Received: from mail-yb0-f173.google.com (mail-yb0-f173.google.com [209.85.213.173]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id vAM1LQh0013962
        for <linux-mmc@vger.kernel.org>; Wed, 22 Nov 2017 10:21:26 +0900
Received: by mail-yb0-f173.google.com with SMTP id g2so1737983ybb.7
        for <linux-mmc@vger.kernel.org>; Tue, 21 Nov 2017 17:21:26 -0800 (PST)
In-Reply-To: <CAK7LNARpchnGL8ZGWcFs=bxmH2FK71Voyd5K1E6=3bHTjd-gyw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <horms+renesas@verge.net.au>, linux-mmc <linux-mmc@vger.kernel.org>, Marek Vasut <marek.vasut+renesas@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

2017-11-22 10:16 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> 2017-11-22 5:14 GMT+09:00 Ulf Hansson <ulf.hansson@linaro.org>:
>> On 21 November 2017 at 21:01, Wolfram Sang <wsa@the-dreams.de> wrote:
>>> Hi Ulf,
>>>
>>> thanks for the feedback!
>>>
>>>> So what do you think of this?:
>>>>
>>>> 1) Rename tmio_core.c to tmio.c, and fold in some more information
>>>> about the history of the IP in the header of the file. Yeah, "tmio"
>>>> may not be the absolutely correct name, but on the other hand it
>>>> preserves consistency and I there are no need to rename any functions.
>>>> 2) Rename tmio_mmc.h to tmio.h - and move potential tmio_mmc specific
>>>> bits to tmio_mmc.c.
>>>> 3) Rename renesas_sdhi_core.c to tmio_renesas_sdhi.c. Again, I don't
>>>> think we need any functions to be renamed because of this change.
>>>> 4) Rename renesas_sdhi.h to tmio_renesas_sdhi.h.
>>>
>>> I can agree to that. Clarifying 3), I think though, we should have:
>>>         tmio_sdhi.c
>>>
>>> and on top of that:
>>>
>>>         tmio_sdhi_internal_dmac.c
>>>         tmio_sdhi_sys_dmac.c
>>>
>>> ?
>>
>> Even better!
>>
>>>
>>>> Following the naming strategy from the above, I the new file name for
>>>> new tmio variant should be tmio_uniphier.c.
>>>
>>> Yes.
>>>
>>
>> Great!
>>
>> Br
>> Uffe
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
> In my understanding, TMIO is a name of MFD
> that includes some built-in peripherals:
> drivers/usb/host/ohci-tmio.c
> drivers/mtd/nand/tmio_nand.c
>
>
>
> If you use "tmio" as a prefix of a group of MMC drivers,
> it will look odd.
>
> # core
> obj-$(CONFIG_MMC_TMIO)          += tmio.o
> # TMIO-builtin
> obj-$(CONFIG_MMC_TMIO_MMC)      += tmio_mmc.o
> # Renesas SoCs
> obj-$(CONFIG_MMC_TMIO_SDHI)     += tmio_sdhi.o
> # UniPhier SoCs
> obj-$(CONFIG_MMC_TMIO_UNIPHIER) += tmio_uniphier.o
>
> This is funny,
> especially the relation between tmio.o and tmio_mmc.o
>
> The "mmc" in the "tmio_mmc.o"
> is not a platform name.
>
> This is even confusing.
>
>
>
>
>
>
> If we use "tmio_mmc" prefix (like "dw_mmc"),
>
> # core
> obj-$(CONFIG_MMC_TMIO)          += tmio_mmc.o
> # TMIO-builtin MMC
> obj-$(CONFIG_MMC_TMIO_TMIO)     += tmio_mmc_tmio.o
> # Reneses
> obj-$(CONFIG_MMC_TMIO_SDHI)     += tmio_mmc_sdhi.o
> # UniPhier
> obj-$(CONFIG_MMC_TMIO_UNIPHIER) += tmio_mmc_uniphier.o
>
>
> tmio_mmc_tmio.o  is a crazy name, but the syntax is clear.
>
> The first "tmio_mmc"  means the IP name
> (since we decide this is the right name)
>
> The second "tmio" is the platform name
> the comes from the TMIO MFD.
>
>
>
>
> Thought?
>
>
>
>
> --
> Best Regards
> Masahiro Yamada








> obj-$(CONFIG_MMC_TMIO)          += tmio.o


The module name "tmio.ko" sounds confusing to me.


If a user runs "insmod tmio"
it sounds like a driver for TMIO MFD is loaded,
but it is actually the core code of MMC.








-- 
Best Regards
Masahiro Yamada

From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: More TMIO MMC variant. What is a preferred name?
Date: Wed, 22 Nov 2017 22:22:08 +0900
Message-ID: <CAK7LNATH5KAOiX6bHVbypv=BGooimf61ty4XFh6naSRVJ_u=CQ@mail.gmail.com>
References: <CAK7LNARB+-SzgNF+7KsG80o4Q=TZsEeyMLjR2Ve0bXCrQ5tc0w@mail.gmail.com>
 <20171108175320.wnq3d2x7lmpaya7s@ninjato> <CAK7LNASN8kjmiNHvX7zrgVv=5d81ovfGNRdHm8TXiJNgr+H9MA@mail.gmail.com>
 <20171120201142.n4l4jelxsmmtwjj6@tetsubishi> <CAPDyKFq_uVvBKBhATNYhq2mSMmNXA7tPSSPMESCnTDtQt9XrZA@mail.gmail.com>
 <20171121200111.vrpmsubme55356qv@ninjato> <CAPDyKFo6X+Z6bORzPow=79Q7jXZOu4SMA9dh1fDsD-_JrBRtgA@mail.gmail.com>
 <CAK7LNARpchnGL8ZGWcFs=bxmH2FK71Voyd5K1E6=3bHTjd-gyw@mail.gmail.com> <20171122075937.knc2soqu5axdufzy@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from conssluserg-03.nifty.com ([210.131.2.82]:52375 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751244AbdKVNXH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Nov 2017 08:23:07 -0500
Received: from mail-yb0-f173.google.com (mail-yb0-f173.google.com [209.85.213.173]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id vAMDMowr026900
        for <linux-mmc@vger.kernel.org>; Wed, 22 Nov 2017 22:22:50 +0900
Received: by mail-yb0-f173.google.com with SMTP id w203so5866990ybe.9
        for <linux-mmc@vger.kernel.org>; Wed, 22 Nov 2017 05:22:50 -0800 (PST)
In-Reply-To: <20171122075937.knc2soqu5axdufzy@ninjato>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <horms+renesas@verge.net.au>, linux-mmc <linux-mmc@vger.kernel.org>, Marek Vasut <marek.vasut+renesas@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

2017-11-22 16:59 GMT+09:00 Wolfram Sang <wsa@the-dreams.de>:
>
>> If we use "tmio_mmc" prefix (like "dw_mmc"),
>>
>> # core
>> obj-$(CONFIG_MMC_TMIO)          += tmio_mmc.o
>> # TMIO-builtin MMC
>> obj-$(CONFIG_MMC_TMIO_TMIO)     += tmio_mmc_tmio.o
>> # Reneses
>> obj-$(CONFIG_MMC_TMIO_SDHI)     += tmio_mmc_sdhi.o
>> # UniPhier
>> obj-$(CONFIG_MMC_TMIO_UNIPHIER) += tmio_mmc_uniphier.o
>>
>>
>> tmio_mmc_tmio.o  is a crazy name, but the syntax is clear.
>>
>> The first "tmio_mmc"  means the IP name
>> (since we decide this is the right name)
>>
>> The second "tmio" is the platform name
>> the comes from the TMIO MFD.
>
> Also fine with me.
>

Then, all functions for the MFD-buitin one
start with tmio_tmio_mmc_ ...

Ugh.  No. Not fine.
I was kidding, sorry.


tmio_mmc_tmio.o is really ugly according to my common sense.


I'd like the IP name be something different from tmio,
but it seems NACK.
I have no more idea to suggest...


So, just keep everything as is.


I will borrow the core code from tmio_mmc_core.c
but I will name my driver as I like.



-- 
Best Regards
Masahiro Yamada

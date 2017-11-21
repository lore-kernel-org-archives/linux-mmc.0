From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: More TMIO MMC variant. What is a preferred name?
Date: Tue, 21 Nov 2017 21:14:04 +0100
Message-ID: <CAPDyKFo6X+Z6bORzPow=79Q7jXZOu4SMA9dh1fDsD-_JrBRtgA@mail.gmail.com>
References: <CAK7LNARB+-SzgNF+7KsG80o4Q=TZsEeyMLjR2Ve0bXCrQ5tc0w@mail.gmail.com>
 <20171108175320.wnq3d2x7lmpaya7s@ninjato> <CAK7LNASN8kjmiNHvX7zrgVv=5d81ovfGNRdHm8TXiJNgr+H9MA@mail.gmail.com>
 <20171120201142.n4l4jelxsmmtwjj6@tetsubishi> <CAPDyKFq_uVvBKBhATNYhq2mSMmNXA7tPSSPMESCnTDtQt9XrZA@mail.gmail.com>
 <20171121200111.vrpmsubme55356qv@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f46.google.com ([209.85.214.46]:40123 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751067AbdKUUOF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Nov 2017 15:14:05 -0500
Received: by mail-it0-f46.google.com with SMTP id 72so3547376itl.5
        for <linux-mmc@vger.kernel.org>; Tue, 21 Nov 2017 12:14:05 -0800 (PST)
In-Reply-To: <20171121200111.vrpmsubme55356qv@ninjato>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <horms+renesas@verge.net.au>, linux-mmc <linux-mmc@vger.kernel.org>, Marek Vasut <marek.vasut+renesas@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

On 21 November 2017 at 21:01, Wolfram Sang <wsa@the-dreams.de> wrote:
> Hi Ulf,
>
> thanks for the feedback!
>
>> So what do you think of this?:
>>
>> 1) Rename tmio_core.c to tmio.c, and fold in some more information
>> about the history of the IP in the header of the file. Yeah, "tmio"
>> may not be the absolutely correct name, but on the other hand it
>> preserves consistency and I there are no need to rename any functions.
>> 2) Rename tmio_mmc.h to tmio.h - and move potential tmio_mmc specific
>> bits to tmio_mmc.c.
>> 3) Rename renesas_sdhi_core.c to tmio_renesas_sdhi.c. Again, I don't
>> think we need any functions to be renamed because of this change.
>> 4) Rename renesas_sdhi.h to tmio_renesas_sdhi.h.
>
> I can agree to that. Clarifying 3), I think though, we should have:
>         tmio_sdhi.c
>
> and on top of that:
>
>         tmio_sdhi_internal_dmac.c
>         tmio_sdhi_sys_dmac.c
>
> ?

Even better!

>
>> Following the naming strategy from the above, I the new file name for
>> new tmio variant should be tmio_uniphier.c.
>
> Yes.
>

Great!

Br
Uffe

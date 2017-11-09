From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: More TMIO MMC variant. What is a preferred name?
Date: Thu, 9 Nov 2017 21:31:31 +0900
Message-ID: <CAK7LNASN8kjmiNHvX7zrgVv=5d81ovfGNRdHm8TXiJNgr+H9MA@mail.gmail.com>
References: <CAK7LNARB+-SzgNF+7KsG80o4Q=TZsEeyMLjR2Ve0bXCrQ5tc0w@mail.gmail.com>
 <20171108175320.wnq3d2x7lmpaya7s@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from conssluserg-03.nifty.com ([210.131.2.82]:37196 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754484AbdKIMcP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Nov 2017 07:32:15 -0500
Received: from mail-yw0-f175.google.com (mail-yw0-f175.google.com [209.85.161.175]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id vA9CWC4p014749
        for <linux-mmc@vger.kernel.org>; Thu, 9 Nov 2017 21:32:13 +0900
Received: by mail-yw0-f175.google.com with SMTP id i198so5117471ywe.7
        for <linux-mmc@vger.kernel.org>; Thu, 09 Nov 2017 04:32:13 -0800 (PST)
In-Reply-To: <20171108175320.wnq3d2x7lmpaya7s@ninjato>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <horms+renesas@verge.net.au>, linux-mmc <linux-mmc@vger.kernel.org>, Marek Vasut <marek.vasut+renesas@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Hi Wolfram,

Thanks for your comments.


2017-11-09 2:53 GMT+09:00 Wolfram Sang <wsa@the-dreams.de>:
> Yamada-san,
>
> Thank you for the detailed write up. I hope we find a good solution,
> too.
>
> I've got a few questions first:
>
>> I know this is a big churn, but I'd like
>> to propose renaming like follows in a long run:
>>
>> tmio_mmc_core.c      ->  mnsd.c              Core code of this IP
>> tmio_mmc.c           ->  mnsd-tmio.c         For MMC integrated in TMIO MFD
>> renesas_sdhi_core.c  ->  mnsd-renesas-core.c For Renesas SoCs
>> (or, mnsd-sdhi-core.c or whatever. please choose any favorite name)
>>                          mnsd-uniphier.c     For Socionext UniPhier SoCS
>
> Do you want to just change the filenames or the function names as well?

If we decide to rename files,
functions and macros should be also renamed for consistency.

(I know this is a very invasive...)


>> I see more strangeness.  Those mmc drivers must include <linux/mfd/tmio.h>,
>> but TMIO is unrelated to Renesas, Socionext.
>> We need to fix the interface.
>
> What kind of fix do you have in mind? Changing filenames or change
> everything which has TMIO or tmio in the name?

Sorry, I missed lots of legacy boards under arch/sh/boards/.

At first, I imagined <linux/mfd/tmio.h> was used
for passing parameters from MFD to tmio-mmc.
Then, I thought it would be possible to copy parameters
to tmio_mmc_host in drivers/mmc/host/tmio_mmc.c
But, actually renesas also depends on platform-data,
so it does not seem so easy as I had imagined first.


We could split tmio_mmc_data out to include/linux/platform_data/tmio-mmc.h
but ideal goal might be split DT drivers and legacy board drivers.
(just an idea, not looking into the detail.)


>> If I can get consensus, I am very happy to
>> contribute for better organizing this IP variants.
>>
>> CCing Marek Vasut, a contractor working for Renesas.
>> He and I are also working on SD card driver in U-Boot.
>> I want to introduce correct and systematic naming scheme
>> for a long-run maintainability and applicable to other projects
>> since Linux has a big influence in OSS.
>
> Can you explain a bit more why the long-run maintainability gets improved?
> I don't really see that yet and will try to explain below.
>
> Disclaimer: I am contracted by Renesas but the views I am going to share
> come from my personal point of view as the maintainer of this driver.
>
> Preface: For me, names are just names. We have a few examples where the
> "historical" names are kept because they just happened to be first. The
> AT24 driver supports way more than only Atmel chips, and all the STMPE
> have kept their names, although the SoC is called MXS these days. Which
> also proves that names are just names, IP cores and companies are easily
> renamed.
>
> If we can rename things easily to match reality, I am not against it. In
> this case, I wonder, though, if the rename is really easy? If you just
> change the filenames, then we got a strange mix, because the function
> names are still using tmio_*. If you change those function names, too,
> then the resulting change is very intrusive.

Right.  This is a discussion point.

I admit it it a huge churn, but (I hope) one-time churn.


All functions / macros are prefixed with tmio_,
so sed scripts will do a good job.
It is just renaming, so no functional change will be added.
If we find a build error (probably reported by 0-day bot),
it will be easy to fix.


> It could introduce errors,
> looking up git history becomes a tad more tedious, and users may get
> confused what is what. Seeing all this, I don't think such a change
> would be helpful for the long-run maintainability.


Probably this could be the last chance for matching the code to reality
if we had (or, maybe it is too late...).

So, before adding a new driver for this IP,
this is worth discussing.

For DW and SDHCI, the naming scheme is really clean.
Kconfig options are prefixed with CONFIG_MMC_DW / CONFIG_MMC_SDHCI.
Same for file names and function names.

It is true that names are just names, but having a good name-space
is helpful to understand the code structure.



If my suggestion is NACK, do you have any suggestion for naming
new drivers?

If we make 'tmio_mmc_core' is really the right name,
do we want to do like  CONFIG_MMC_TMIO_UNIPHIER, tmio_mmc_uniphier.c?
(then rename renesas ones likewise, or maybe not?)

Or, is it completely "don't care" things, like Renesas is currently doing?


Linux is in a special position in open source world.
Various projects get influence from Linux.
U-Boot borrow code, ideas, and names from Linux
(barebox is more linux-addicted), so if we fix the history,
I thought this should be discussed in Linux community.


> I'd be much happier with a paragraph at the beginning of the "TMIO" core
> file (or maybe all "TMIO" files, I don't care much) explaining the
> situation like you did with your mail. But keeping the code largely
> as-is.
>
> I am open for discussion, though.
>
> Again, this is my personal view. We will discuss things internally, too,
> to see if there is also an "official" statement from Renesas.

OK.  Thanks.


> Thanks,
>
>    Wolfram
>



-- 
Best Regards
Masahiro Yamada

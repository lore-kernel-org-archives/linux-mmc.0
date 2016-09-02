From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] mmc: host: sh_mobile_sdhi: don't populate unneeded functions
Date: Fri, 2 Sep 2016 11:48:39 +0200
Message-ID: <CAPDyKFpVtYtL97YQskPazJPQSHkVuF5BEaaGH_HE=xfkYUq=Rg@mail.gmail.com>
References: <20160824093438.2478-1-wsa+renesas@sang-engineering.com>
 <20160824093438.2478-3-wsa+renesas@sang-engineering.com> <CANqRtoTJWN52roRwJHh1cZrb2Jqf5OD-ffjKgiW4Y5jqCeVzhg@mail.gmail.com>
 <20160902052258.GA1601@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:37751 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751762AbcIBJsm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Sep 2016 05:48:42 -0400
Received: by mail-wm0-f42.google.com with SMTP id v143so22316551wmv.0
        for <linux-mmc@vger.kernel.org>; Fri, 02 Sep 2016 02:48:41 -0700 (PDT)
In-Reply-To: <20160902052258.GA1601@katana>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Magnus Damm <magnus.damm@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms@verge.net.au>

On 2 September 2016 at 07:23, Wolfram Sang <wsa@the-dreams.de> wrote:
> Magnus,
>
>> To my eye it looks like this patch might be adding a fix for a bug
>> introduced by another patch. R-Car Gen2 and later are quite recent
>> SoCs but I believe support for other mobile chips and earlier R-Car
>> SoCs also also covered by the SDHI driver. Also there are theTMIO
>> chips that share some software and are related but a bit different. So
>> in my opinion we need to thread lightly to avoid breakage.
>
> I'm very much with you. This is the very much reason I introduced
> TMIO_MMC_MIN_RCAR2 in 3d376fb2ea907f ("mmc: tmio/sdhi: introduce flag
> for RCar 2+ specific features") in the first place to be able to
> "protect" old hardware from new features. It was not done before! This
> is also the reason why we have commits like a21553c9e0c236 ("mmc:
> tmio/sdhi: distinguish between SCLKDIVEN and ILL_FUNC") documenting a
> difference between some old TMIO variant and our current SDHI. I spent
> quite some time finding old TMIO information somewhere for that.
>
>> My concern is what happened before this patch was applied. It looks
>> like the callbacks were installed for all hardware types which makes
>> me wonder because UHS/SDR support is only available for quite recent
>> hardware.
>
> I didn't protect these callbacks before because I assumed they are only
> called when SDR support is enabled via devicetree or platform data.
> Which is not the case for all the old platforms. I sadly missed that
> card_busy() is used when polling an SDIO card in case "broken-cd" is
> used. That was a detail I overlooked, sorry. Given my work outlined
> above I don't think one can deduce that I don't care about regressing
> old hardware, though.
>
>> The ->card_busy() callback is not yet in mainline or -next. It was
>> introduced in:
>> 0157290 mmc: host: sh_mobile_sdhi: move card_busy from tmio to sdhi
>
> Not quite, it was introduced with 452e5eef6d311e ("mmc: tmio: Add UHS-I
> mode support"). The commit you mentioned moved it from tmio*.c to
> sdhi*.c
>
>> If this patch is fixing a recent commit then perhaps some patches
>> should be squashed together to prevent bisection breakage or if a
>> patch is already part of mainline then a "Fixes:" tag might be
>> suitable.
>
> It can be argued that this tag could be added:
>
> Fixes: 452e5eef6d311e ("mmc: tmio: Add UHS-I mode support")
>
> I don't know how well it applies, though, because the code has been
> modified a lot recently. But we can try.

Please tell me if you would like me to drop any of the changes I
queued up in this series.

Of course, I can also amend the change log, just tell me.

Kind regards
Uffe

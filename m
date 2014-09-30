From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 3/4 v2] mmc: host: switch OF parser to use gpio descriptors
Date: Tue, 30 Sep 2014 16:01:03 +0200
Message-ID: <CACRpkdaH=FtB2+4cg2rQa_Md5HuRwz8VzAJ_GvM-gE3VQ8pEgQ@mail.gmail.com>
References: <1409137253-25189-1-git-send-email-linus.walleij@linaro.org>
	<1409137253-25189-3-git-send-email-linus.walleij@linaro.org>
	<CABxcv==ipqvs+XpuWMVjmLPTHArBa2Kqk2Zcxn5du5+oXK3RyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:50235 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937AbaI3OBF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Sep 2014 10:01:05 -0400
Received: by mail-ie0-f169.google.com with SMTP id tr6so4791595ieb.14
        for <linux-mmc@vger.kernel.org>; Tue, 30 Sep 2014 07:01:03 -0700 (PDT)
In-Reply-To: <CABxcv==ipqvs+XpuWMVjmLPTHArBa2Kqk2Zcxn5du5+oXK3RyQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@linaro.org>, Linux GPIO List <linux-gpio@vger.kernel.org>

On Tue, Sep 30, 2014 at 1:30 PM, Javier Martinez Canillas
<javier@dowhile0.org> wrote:
> On Wed, Aug 27, 2014 at 1:00 PM, Linus Walleij <linus.walleij@linaro.org> wrote:

>> This switches the central MMC OF parser to use gpio descriptors
>> instead of grabbing GPIOs explicitly from the device tree.
>> This strips out an unecessary use of the integer-based GPIO
>> API that we want to get rid of, cuts down on code as the
>> gpio descriptor code will handle active low flags.
>>
>> Acked-by: Alexandre Courbot <acourbot@nvidia.com>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>
> Card detection is failing in some boards because this patch changes
> some semantics. I tried to come up with a fix but I didn't find an
> obvious way to do it (more on that below).

I think some of this may be weird semantics: the CAP flags in the
MMC subsystem, MMC_CAP2_CD_ACTIVE_HIGH and
MMC_CAP2_RO_ACTIVE_HIGH are somewhat confusing since
the GPIO subsystem nowadays has its own concept of a line
active high or low.

The MMC caps make a lot of sense if the host has dedicated lines
to read CD and WP, and does not use a GPIO for this.

When a GPIO descriptor is in use, the thing gets a bit convoluted:
what if both the GPIO *and* the CAP flag is set to inversion?

So the old code did this with XOR:

        if (explicit_inv_cd ^ gpio_inv_cd)
            host->caps2 |= MMC_CAP2_CD_ACTIVE_HIGH;

Meaning double inversion -> no inversion.

I guess I was sort of hoping that nobody did this crazy thing.
Turns out I was wrong, so have to restore the old semantics...

I'm sending a patch for you to test.

Yours,
Linus Walleij

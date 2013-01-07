From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: mmci: Gate the clock when freq is 0
Date: Mon, 7 Jan 2013 11:29:01 +0100
Message-ID: <CAPDyKFoH2aOM+n0PB7qScbVOz_My=ZpAye3swgF6xiYBKou_=Q@mail.gmail.com>
References: <1355327421-20187-1-git-send-email-ulf.hansson@stericsson.com>
	<20121221162132.GI14363@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:42826 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933Ab3AGK3D (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Jan 2013 05:29:03 -0500
Received: by mail-wg0-f48.google.com with SMTP id dt10so9274216wgb.3
        for <linux-mmc@vger.kernel.org>; Mon, 07 Jan 2013 02:29:02 -0800 (PST)
In-Reply-To: <20121221162132.GI14363@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Ulf Hansson <ulf.hansson@stericsson.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>

On 21 December 2012 17:21, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Dec 12, 2012 at 04:50:21PM +0100, Ulf Hansson wrote:
>> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
>> index edc3e9b..bf07823 100644
>> --- a/drivers/mmc/host/mmci.c
>> +++ b/drivers/mmc/host/mmci.c
>> @@ -1147,6 +1147,15 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>               }
>>       }
>>
>> +     /*
>> +      * If clock = 0 and the block needs a certain value in the clreg
>> +      * to function, we need to gate the clock by removing MCI_PWR_ON.
>> +      * This is a special case for ST Micro variants, since the power
>> +      * register in the ARM legacy case is used for powering the cards.
>
> I wish you'd stop using "legacy" when talking about the ARM primecell.
> How can it be legacy when ARMs current development boards still use this
> primecell?
>
>> +      */
>> +     if (!ios->clock && variant->clkreg)
>> +             pwr &= ~MCI_PWR_ON;
>
> This is horrid.  You're overloading the clkreg default value with another
> meaning here - "if we have any bits set in the default value for the
> MCICLOCK register, the MCIPOWER register has special meanings for the
> power control bits".

I was hesitating when we decided to use the clkreg value due to what
you states here. Just to give you some more background.

By using clkreg default value you will get an implicit sequential
dependency that you will write the default value to MMCICLOCK reg,
_before_ writing the "power on" bit to the MMCIPOWER reg. Otherwise
you will not be able to update MMCICLK reg after the "power on" bit in
the MMCIPOWER reg has been set. That was the whole reason to why the
clkreg default value was invented.

Anyway, I still think your comment is valid so I suggest we add
another variant data which meaning will indicate whether the MMCIPOWER
register is used to control the actual power to the card. If that is
the case we must not use the MMCIPOWER to gate the clock. Does that
make sense?

>
> When you think about it as I've described it above, do you think this is
> an acceptable solution to this problem?

Kind regards
Ulf Hansson

From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: mmci: Gate the clock when freq is 0
Date: Mon, 7 Jan 2013 17:28:09 +0100
Message-ID: <CAPDyKFrA+7B5XTrJVw2g2UvnnSxbUV=KFZsM+gPNKYksQ7coDA@mail.gmail.com>
References: <1355327421-20187-1-git-send-email-ulf.hansson@stericsson.com>
	<20121221162132.GI14363@n2100.arm.linux.org.uk>
	<CAPDyKFoH2aOM+n0PB7qScbVOz_My=ZpAye3swgF6xiYBKou_=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:34562 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751019Ab3AGQ2L (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Jan 2013 11:28:11 -0500
Received: by mail-ie0-f182.google.com with SMTP id s9so23791439iec.41
        for <linux-mmc@vger.kernel.org>; Mon, 07 Jan 2013 08:28:10 -0800 (PST)
In-Reply-To: <CAPDyKFoH2aOM+n0PB7qScbVOz_My=ZpAye3swgF6xiYBKou_=Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Ulf Hansson <ulf.hansson@stericsson.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>

On 7 January 2013 11:29, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 21 December 2012 17:21, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> On Wed, Dec 12, 2012 at 04:50:21PM +0100, Ulf Hansson wrote:
>>> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
>>> index edc3e9b..bf07823 100644
>>> --- a/drivers/mmc/host/mmci.c
>>> +++ b/drivers/mmc/host/mmci.c
>>> @@ -1147,6 +1147,15 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>>               }
>>>       }
>>>
>>> +     /*
>>> +      * If clock = 0 and the block needs a certain value in the clreg
>>> +      * to function, we need to gate the clock by removing MCI_PWR_ON.
>>> +      * This is a special case for ST Micro variants, since the power
>>> +      * register in the ARM legacy case is used for powering the cards.
>>
>> I wish you'd stop using "legacy" when talking about the ARM primecell.
>> How can it be legacy when ARMs current development boards still use this
>> primecell?
>>
>>> +      */
>>> +     if (!ios->clock && variant->clkreg)
>>> +             pwr &= ~MCI_PWR_ON;
>>
>> This is horrid.  You're overloading the clkreg default value with another
>> meaning here - "if we have any bits set in the default value for the
>> MCICLOCK register, the MCIPOWER register has special meanings for the
>> power control bits".
>
> I was hesitating when we decided to use the clkreg value due to what
> you states here. Just to give you some more background.
>
> By using clkreg default value you will get an implicit sequential
> dependency that you will write the default value to MMCICLOCK reg,
> _before_ writing the "power on" bit to the MMCIPOWER reg. Otherwise
> you will not be able to update MMCICLK reg after the "power on" bit in
> the MMCIPOWER reg has been set. That was the whole reason to why the
> clkreg default value was invented.
>
> Anyway, I still think your comment is valid so I suggest we add
> another variant data which meaning will indicate whether the MMCIPOWER
> register is used to control the actual power to the card. If that is
> the case we must not use the MMCIPOWER to gate the clock. Does that
> make sense?
>
>>
>> When you think about it as I've described it above, do you think this is
>> an acceptable solution to this problem?

I just sent out a new patch to handle the clock gating for the ST
variants. I decided to add a new variant data which is only indicating
whether the power register should be used to gate the clock. It felt
like the most proper way of doing this. Please have look when you have
the time.

Thanks!
Ulf Hansson

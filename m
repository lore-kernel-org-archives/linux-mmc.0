From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: mediatek: fix request blocked by cancel_delayed_work
Date: Wed, 27 Apr 2016 14:33:58 +0200
Message-ID: <CAPDyKFrhR4P=X9VPoiSgkeQTrjinkp5YFH9MSsXkDwzd441A8w@mail.gmail.com>
References: <1460963609-16179-1-git-send-email-chaotian.jing@mediatek.com>
	<CAPDyKFrXVaq85sSQ+ib-U=rgdxB_k2tif0aHQi_0d8kZ2FZDcA@mail.gmail.com>
	<1461404630.7081.9.camel@mhfsdcap03>
	<CAPDyKFpO89QWHST8XoBvRO4Y+Fv4Umt43B35E2vhm-z2WmZXSw@mail.gmail.com>
	<1461758776.20837.7.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461758776.20837.7.camel@mhfsdcap03>
Sender: linux-kernel-owner@vger.kernel.org
To: Chaotian Jing <chaotian.jing@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Nicolas Boichat <drinkcat@chromium.org>, Douglas Anderson <dianders@chromium.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mediatek@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, srv_heupstream <srv_heupstream@mediatek.com>, Sascha Hauer <kernel@pengutronix.de>
List-Id: linux-mmc@vger.kernel.org

[...]

>> > Actually, this is a Bug of __mmc_switch(), Per JEDEC Spec, while switch
>> > speed mode, should not use CMD13 to get card status, as it's response
>> > cannot reflect that if card was busy now, for this CMD6 switch HS200
>>
>> There is a statement applicable to all HS modes, which says it's *not
>> recommended* but *if* used, CRC errors shall be ignored.
>>
> Yes, but if we ignore the CRC error check, how do we know current
> response is correct or incorrect ? if card is still busy but we get the
> response of 0x900 caused by latching error, then it still consider that
> card has already changed to trans state.

That's true. So perhaps we shouldn't ignore CRC errors, but instead
treat them as card is still busy and send a new CMD13?

Could you please try that and see how it works?

> So, it's better to never use CMD13 when change the speed mode.

Yes, that might be the case. My concern is only that we should avoid
adding unnecessary time-out for cards that is already working, as it
might effects the total initialization time of the card.

On the other hand, perhaps these card are working more because of
"luck" and thus the method to switch to HS mode are fragile and needs
to be fixed. :-)

>> That's what we have been doing so far, but perhaps that isn't good
>> enough for HS200/400.
>>
>> > case, I tried some Samsung/Sandisk/KSI eMMC, issue CMD13 will always get
>> > 0x800, even eMMC has already changed to transfer state and DAT0 is high,
>> > the response of CMD13 is also 0x800, and will never be 0x900.
>>
>> What do you mean by never? I assume it would when you extend the timeout?
>>
>> Does your host driver make sure to ignore CRC errors in this case?
>> Just to be sure, that isn't the problem.
>>
>> > So, in __mmc_switch(), it's a bug to use CMD13 to know that if card has
>> > already changed to transfer state.
>>
>> Whether it's a bug or not, it seems like we have eMMC cards that we
>> have issues to support because of the way we have interpreted the
>> spec. So let's try to fix them!
>>
>> > But, Our host do not support MMC_CAP_WAIT_WHILE_BUSY, that's why we hit
>> > this issue.
>>
>> Okay, I see.
>>
>> Let's try to change the behaviour in __mmc_switch() to prevent it to
>> send CMD13 before the cards stops signal busy on DAT0, when switching
>> to HS200/HS400 mode.
>> What I have in mind is:
>>
>> 1.
>> When the host controller doesn't support MMC_CAP_WAIT_WHILE_BUSY, we
>> would then to wait for a fixed timeout, before we send CMD13. In this
>> case, do you know if the "generic_cmd6_time" is working for your eMMC
>> devices that you had issues with?
>>
> In general, generic_cmd6_time is enough, unless the card has firmware
> issue itself,

Okay, so let's use that timeout value!

If another value is needed for a specific card, that would have to be
handled through a card quirk.

>> 2.
>> In additional to the above solution, we can for those hosts that
>> supports the ->card_busy() ops, but not MMC_CAP_WAIT_WHILE_BUSY,
>> invoke the ->card_busy() in a polling manner. Of course the above
>> timeout should also be considered as we need to stop polling at some
>> point.
>>
> this is what I want to do it, use the ops->card_busy() to check DAT0
> status. if a host do not support MMC_CAP_WAIT_WHILE_BUSY and there is
> no ops->card_busy(), then the only way is wait a fixed
> timeout(generic_cmd6_time).

Okay, great!

[...]

Kind regards
Uffe

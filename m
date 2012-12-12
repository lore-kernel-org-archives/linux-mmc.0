From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: FW: [PATCH] mmc: mmci: Gate the clock in runtime suspend to save power
Date: Wed, 12 Dec 2012 13:15:52 +0100
Message-ID: <CAPDyKFouunFUCLOhYA8KRfxpGCnxnDBfL0cJ4aRj1kPZLDe9=A@mail.gmail.com>
References: <25B60CDC2F704E4E9D88FFD52780CB4C08B00BD138@SC-VEXCH1.marvell.com>
	<CADz5_g+_wC7wWbiDx_MqG25FGQXwTaz0M_0AR65Um36jaq713A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:57734 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751494Ab2LLMPw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Dec 2012 07:15:52 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so778038iay.19
        for <linux-mmc@vger.kernel.org>; Wed, 12 Dec 2012 04:15:52 -0800 (PST)
In-Reply-To: <CADz5_g+_wC7wWbiDx_MqG25FGQXwTaz0M_0AR65Um36jaq713A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Liu <keyuan.liu@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 12 December 2012 12:39, Kevin Liu <keyuan.liu@gmail.com> wrote:
>> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-owner@vger.kernel.org] On Behalf Of Linus Walleij
>> Sent: Wednesday, December 12, 2012 2:54 PM
>> To: Russell King - ARM Linux; Ulf Hansson
>> Cc: linux-mmc@vger.kernel.org; Chris Ball; linux-arm-kernel@lists.infradead.org; Ulf Hansson
>> Subject: Re: [PATCH] mmc: mmci: Gate the clock in runtime suspend to save power
>>
>> On Tue, Dec 11, 2012 at 3:52 PM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>>> On Tue, Dec 11, 2012 at 03:17:54PM +0100, Ulf Hansson wrote:
>>>> From: Ulf Hansson <ulf.hansson@linaro.org>
>>>>
>>>> The amba bus is already performing same actions but for the apb_pclk.
>>>> So here we just make sure the clock to card is gated as well to save
>>>> more power. At runtime resume we will thus restore the clock again.
>>>
>>> And how exactly do you ensure the requirement that a certain number of
>>> clocks is supplied to the card after the last command before you cut
>>> the clock?
>>
>> Oh, that's gonna be a problem.
>>
>> So I can see a quite straight-forward way to do this actually:
>>
>> 1) Turn on MMC_CLKGATE for this driver (select from Kconfig)
>> which means that the ios will be called with f=0 whenever
>> the card is unused, taking into account the required number
>> of clocks to the card.
>>
>> 2) Implement handling of f=0 from the ios in the ios callback.
>> Then clk_disable(host->clk). I did a hack at this some months
>> back but never got around to finish it, sorry for not doing
>> that even though this clock gating was invented for the MMCI
>> in the first place :-(
>>
>> 3) In the suspend() callback, sleep until the clock indicates
>> that the card is declocked with something like:
>> while (clk_is_enabled(host->clk)) { sleep(1) }
>> However the clk framework does not have clk_is_enabled()
>> so you'd either have to add that or use a local atomic
>> variable host_clk_enabled set in (2).
>>
>> Should work, I think?
>>
>
> Since we use pm runtime with delay setting to 50ms, so there is no such problem?

Correct!

>
> Thanks
> Kevin
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


Kind regards
Ulf Hansson

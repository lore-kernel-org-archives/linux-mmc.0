From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/2] mmc: core: Remove all code related to MMC_CLKGATE
Date: Thu, 17 Oct 2013 14:29:02 +0200
Message-ID: <CAPDyKFpXBSpupQbCe86-Qoo87NwNN=7scAUk99Tohj6EEsDqpg@mail.gmail.com>
References: <1380552120-31003-1-git-send-email-ulf.hansson@linaro.org>
	<Pine.LNX.4.64.1309302301400.24147@axis700.grange>
	<CAPDyKFq17j7cOjDQogTofKQOTHyUMbQxg7eRS7OARL-0U7phZQ@mail.gmail.com>
	<Pine.LNX.4.64.1310011106270.27413@axis700.grange>
	<Pine.LNX.4.64.1310081424430.31629@axis700.grange>
	<CAPDyKFop-W-K7Hut7OwraYQ4En=9QMCXXHnUutA0c0VjOKMpaw@mail.gmail.com>
	<Pine.LNX.4.64.1310171208580.27369@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vb0-f51.google.com ([209.85.212.51]:41357 "EHLO
	mail-vb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754686Ab3JQM3D (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Oct 2013 08:29:03 -0400
Received: by mail-vb0-f51.google.com with SMTP id x16so1042302vbf.38
        for <linux-mmc@vger.kernel.org>; Thu, 17 Oct 2013 05:29:02 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1310171208580.27369@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Linus Walleij <linus.walleij@linaro.org>, Magnus Damm <magnus.damm@gmail.com>

Hi Guennadi,

Thanks for you response!

On 17 October 2013 12:59, Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> Hi Ulf
>
> On Thu, 17 Oct 2013, Ulf Hansson wrote:
>
>> >> > Looking into your two examples, sh_mmcif and sh_mobile_sdhci (using
>> >> > tmio), I realize that they use runtime PM in an awkward way.
>> >
>> > I'm not sure what exactly you find awkward there. I know that a lot of
>> > work has been invested in runtime PM and clock gating on those two
>> > drivers, and the results were rather good: we were able to runtime suspend
>> > and wake up controllers according to .power_mode as provided to drivers'
>> > .set_ios() methods. We were able to use power domains and show, that even
>> > when the whole domain is powered up and down as a result of our runtime
>> > PM, we still can communicate with MMC, SD, and SDIO cards in slots. We
>> > added support for regulators. We also added support for aggressive MMC
>> > clock gating, which allowed us to save power by gating the clock _when_ it
>> > was safe, as decided by higher level protocols.
>>
>> By comparing with other mmc host drivers you see that the runtime PM
>> implementation differs significantly for sh_mmcif and sh_mobile_sdhci.
>> I am not saying it is wrong, just question it to try to understand
>> why. And maybe we can improve something as well.
>>
>> >
>> > E.g. look at this comment in tmio_mmc_pio.c:
>> >
>> > /*
>> >  * We differentiate between the following 3 power states:
>> >  * 1. card slot powered off, controller stopped. This is used, when either there
>> >  *    is no card in the slot, or the card really has to be powered down.
>>
>> I guess the "card slot" be interpreted as the core power to the card, VCC/VDD?
>
> Yes, that's right.
>
>> >  * 2. card slot powered on, controller stopped. This is used, when a card is in
>> >  *    the slot, but no activity is currently taking place. This is a power-
>> >  *    saving mode with card-state preserved. This state can be entered, e.g.
>> >  *    when MMC clock-gating is used.
>> >  * 3. card slot powered on, controller running. This is the actual active state.
>> >  */
>>
>> Some questions/statements, please shoot them down if possible. :-)
>>
>> 1.
>> Is the controller involved in providing the actual power to the card
>> (VCC/VDD)?
>
> Not really, all is done, using external regulator drivers, even if the
> regulator and the SD/MMC controller are parts of the same SoC. But no,
> there are no registers in the SD/MMC controller itself that regulate power
> supply to the cards.
>
>> Looking at the code in .set_ios for sh_mmcif, it seems like
>> the external regulator (mmc->supply.vmmc) is the one that handles this
>> on it's own. Especially since power state 3) exists as well.
>>
>> If my assumption is correct, my best guess is that we shall be able to
>> rework the runtime PM support as my patchset for sh_mmcif tried to do.
>> Unless I missed something and there are some other obstacles to
>> consider from a power domain point of view.
>>
>> 2.
>> Regarding clock handling. Are there any specific reason to why you
>> prevent the power domain (though runtime PM) from being dropped while
>> the clock is enabled (through clk_enable)? That also seems like
>> unnecessary.
>
> I'm not quite sure which code path you mean, but normally if you have the
> clock running, this means, that you want to be able to communicate with
> the card, i.e. you need power too. And if you don't need to access the
> card, then you can disable the clock and power down the card.

I was thinking of the .set_ios function.

It is from here you do clk_enable|disable. We shall handle this from
the runtime callbacks instead. The clock needs to be enabled when
communicating with card, and if we make sure to fetch a
"runtime reference" (pm_runtime_get) during request handling, this
will fix this for us.

So, this will mean a great improvement since earlier you were always
keeping the clock enabled for the entire time the card was powered,
unless you used MMC_CLKGATE.

>
>> > enum tmio_mmc_power {
>> >         TMIO_MMC_OFF_STOP,      /* card power off, controller stopped */
>> >         TMIO_MMC_ON_STOP,       /* card power on, controller stopped */
>> >         TMIO_MMC_ON_RUN,        /* card power on, controller running */
>> > };
>> >
>> > Now, if you remove clock gating, would you still be able to really support
>> > all these modes? IIUC, the clock gating is there for higher level MMC/SD
>> > protocols (MMC, SD, SDHC, SDXC, SDIO,...) to inform the mmc core and
>> > controller drivers, that according to that protocol the clock can be
>> > switched off now. It seems to me, that you're just completely removing
>> > that functionality. Neither the mmc core nor low level controller drivers
>> > can know when the clock can be switched off. So, I don't see how runtime
>> > PM by itself can solve the problem. You can choose a different approach to
>> > signal idle / power-saving states from protocol drivers, but you anyway
>> > need to actually do that. In your patch "mmc: core: Remove MMC_CLKGATE"
>> > however, you just remove those calls from sd.c and mmc.c, so, I don't see
>> > how that functionality can be implemented after your proposed patches.
>>
>> Simply by using runtime PM autosuspend feature. We use a time-out
>> value greater then we ever will need, to complete a request according
>> to the MMC/SD/SDIO spec. 50 ms seems to be an accepted value here.
>
> Well, I'm not sufficiently familiar with all SD/MMC protocols to judge,
> whether there can be any states, when you need your clock running for an
> indefinitely long time. Maybe you're right and we can enter the gated
> clock state upon the autosuspend timer expiration for them. In the above
> example you'd then enter the TMIO_MMC_ON_STOP state upon such an
> autosuspend. And TMIO_MMC_OFF_STOP we would be entering upon an explicit
> call to .set_ios() with ios->power_mode == MMC_POWER_OFF. We would also
> have to take care not to use autosuspend for SDIO cards similarly to how
> the clock gating is currently disabled for them. If that's what you mean
> and if indeed we're sure, that there are no clock-on requirements during
> long inactivity periods for memory cards, then yes, I think just combining
> MMC_POWER_OFF and runtime PM autosuspend could provide the same level of
> flexibility, that the clock gating is currently providing. And even if
> there are such periods, protocol drivers can always increment the card's
> runtime PM use-count by calling mmc_get_card().

You are right regarding SDIO, but only in the case were the host
implements SDIO IRQ.

Though, the host must not use mmc_get_card, because that is something
completely different. mmc_get_card, make sure the card device, which
sits on the mmc_bus becomes active. It is separate from the host
device.

To solve the SDIO IRQ problem, there are two options.
1.
Keep the host device active as long as you have an SDIO IRQ enabled.
Thus do one more pm_runtime_get, on top of the others. From a power
save point of view this is not to prefer, but it works.

2. When entering runtime_suspend state, re-route the DAT1 line to a
GPIO IRQ and possibly also set it as a wakeup irq if you want to
listen on it during in system suspended state. In this case you are
able to fetch the SDIO IRQ, even if the clock and controller are
sleeping. Once woken up, in other words, being runtime_resumed, the
GPIO IRQ is detached.

So to conclude, since sh_mmcif, don't implement SDIO IRQ, we don't
need any adaptations for SDIO.

Kind regards
Uffe

>
> So, at the very least, I think, we should prevent SD host controllers from
> autosuspending, if an SDIO card is in the slot. Does your patch "[PATCH
> 2/2] mmc: core: Remove MMC_CLKGATE" do that or do you think each SD host
> controller driver should do that by itself?
>
> Thanks
> Guennadi
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> http://www.open-technology.de/

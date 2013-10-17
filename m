From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/2] mmc: core: Remove all code related to MMC_CLKGATE
Date: Thu, 17 Oct 2013 11:49:25 +0200
Message-ID: <CAPDyKFop-W-K7Hut7OwraYQ4En=9QMCXXHnUutA0c0VjOKMpaw@mail.gmail.com>
References: <1380552120-31003-1-git-send-email-ulf.hansson@linaro.org>
	<Pine.LNX.4.64.1309302301400.24147@axis700.grange>
	<CAPDyKFq17j7cOjDQogTofKQOTHyUMbQxg7eRS7OARL-0U7phZQ@mail.gmail.com>
	<Pine.LNX.4.64.1310011106270.27413@axis700.grange>
	<Pine.LNX.4.64.1310081424430.31629@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f173.google.com ([209.85.220.173]:40207 "EHLO
	mail-vc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752847Ab3JQJt0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Oct 2013 05:49:26 -0400
Received: by mail-vc0-f173.google.com with SMTP id if17so1050947vcb.32
        for <linux-mmc@vger.kernel.org>; Thu, 17 Oct 2013 02:49:25 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1310081424430.31629@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Linus Walleij <linus.walleij@linaro.org>, Magnus Damm <magnus.damm@gmail.com>

>> > Looking into your two examples, sh_mmcif and sh_mobile_sdhci (using
>> > tmio), I realize that they use runtime PM in an awkward way.
>
> I'm not sure what exactly you find awkward there. I know that a lot of
> work has been invested in runtime PM and clock gating on those two
> drivers, and the results were rather good: we were able to runtime suspend
> and wake up controllers according to .power_mode as provided to drivers'
> .set_ios() methods. We were able to use power domains and show, that even
> when the whole domain is powered up and down as a result of our runtime
> PM, we still can communicate with MMC, SD, and SDIO cards in slots. We
> added support for regulators. We also added support for aggressive MMC
> clock gating, which allowed us to save power by gating the clock _when_ it
> was safe, as decided by higher level protocols.

By comparing with other mmc host drivers you see that the runtime PM
implementation differs significantly for sh_mmcif and sh_mobile_sdhci.
I am not saying it is wrong, just question it to try to understand
why. And maybe we can improve something as well.

>
> E.g. look at this comment in tmio_mmc_pio.c:
>
> /*
>  * We differentiate between the following 3 power states:
>  * 1. card slot powered off, controller stopped. This is used, when either there
>  *    is no card in the slot, or the card really has to be powered down.

I guess the "card slot" be interpreted as the core power to the card, VCC/VDD?

>  * 2. card slot powered on, controller stopped. This is used, when a card is in
>  *    the slot, but no activity is currently taking place. This is a power-
>  *    saving mode with card-state preserved. This state can be entered, e.g.
>  *    when MMC clock-gating is used.
>  * 3. card slot powered on, controller running. This is the actual active state.
>  */

Some questions/statements, please shoot them down if possible. :-)

1.
Is the controller involved in providing the actual power to the card
(VCC/VDD)? Looking at the code in .set_ios for sh_mmcif, it seems like
the external regulator (mmc->supply.vmmc) is the one that handles this
on it's own. Especially since power state 3) exists as well.

If my assumption is correct, my best guess is that we shall be able to
rework the runtime PM support as my patchset for sh_mmcif tried to do.
Unless I missed something and there are some other obstacles to
consider from a power domain point of view.

2.
Regarding clock handling. Are there any specific reason to why you
prevent the power domain (though runtime PM) from being dropped while
the clock is enabled (through clk_enable)? That also seems like
unnecessary.

> enum tmio_mmc_power {
>         TMIO_MMC_OFF_STOP,      /* card power off, controller stopped */
>         TMIO_MMC_ON_STOP,       /* card power on, controller stopped */
>         TMIO_MMC_ON_RUN,        /* card power on, controller running */
> };
>
> Now, if you remove clock gating, would you still be able to really support
> all these modes? IIUC, the clock gating is there for higher level MMC/SD
> protocols (MMC, SD, SDHC, SDXC, SDIO,...) to inform the mmc core and
> controller drivers, that according to that protocol the clock can be
> switched off now. It seems to me, that you're just completely removing
> that functionality. Neither the mmc core nor low level controller drivers
> can know when the clock can be switched off. So, I don't see how runtime
> PM by itself can solve the problem. You can choose a different approach to
> signal idle / power-saving states from protocol drivers, but you anyway
> need to actually do that. In your patch "mmc: core: Remove MMC_CLKGATE"
> however, you just remove those calls from sd.c and mmc.c, so, I don't see
> how that functionality can be implemented after your proposed patches.

Simply by using runtime PM autosuspend feature. We use a time-out
value greater then we ever will need, to complete a request according
to the MMC/SD/SDIO spec. 50 ms seems to be an accepted value here.

Kind regards
Ulf Hansson

From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: wl1271: sdio: is fine-grained runtime_pm possible?
Date: Wed, 15 Jan 2014 11:46:42 +0100
Message-ID: <CAPDyKFqDG-s6AVYQ4bP4CE_w1a6EyjQCD_ha_p0PV=2Hun6vFw@mail.gmail.com>
References: <CAKZq+rdaCivZTFSTGt9_Q+3KFE9Ft0XfmWZ=1Vr7QcDDs9=Muw@mail.gmail.com>
	<867ga39raz.fsf@void.printf.net>
	<CAKZq+rf8HAhtjNw3CHPp2C0a2mv0d-zgN6VgdqC5rt4ysOkcpQ@mail.gmail.com>
	<CAPDyKFoyn=PChen-1daxjrH=k+Wuju0T9r5a3HQz5ytch0-LZg@mail.gmail.com>
	<CAKZq+rc5Tg+L02-x8hEWUEYoyXmtPg=Mg7scp8bj79u=fqqYcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f52.google.com ([209.85.216.52]:40075 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751004AbaAOKqn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jan 2014 05:46:43 -0500
Received: by mail-qa0-f52.google.com with SMTP id j15so735411qaq.11
        for <linux-mmc@vger.kernel.org>; Wed, 15 Jan 2014 02:46:42 -0800 (PST)
In-Reply-To: <CAKZq+rc5Tg+L02-x8hEWUEYoyXmtPg=Mg7scp8bj79u=fqqYcg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chao Xu <caesarxuchao@gmail.com>
Cc: Chris Ball <chris@printf.net>, Luciano Coelho <luciano.coelho@intel.com>, Ohad Ben-Cohen <ohad@wizery.com>, linux-mmc <linux-mmc@vger.kernel.org>

>> So, then it would be interesting to understand how the WLAN chip is
>> being powered? Can you tell us?
>>
> I check the Pandaboard datasheet (Figure13. PandaBoard WLAN/Bluetooth
> Interface Block Diagram). On the WLAN chip there is a WLAN_EN pin,
> which is connected to a gpio. As long as that gpio pin is high, the
> WLAN chip is powered on. So IMHO, powering up the WLAN chip is a
> separate issue from powering up the sdio.

No, I don't think so. Or, well it depends on what you mean with sdio. :-)

In this case, I think the WLAN_EN pin should be converted to a gpio
regulator. The regulator should then be handled from omap_hsmmc's
->set_ios callback.

This will then mean, once the SDIO func driver drops is runtime PM
reference the power will be cut to the WLAN chip. I guess this is
handled internally by the SDIO func driver as of today, right?

>> I would guess you have three entities of where runtime PM can be
>> interesting in these scenarios.
>>
>> 1. The sdio core layer uses runtime PM to let SDIO func drivers decide
>> whether the WLAN chip shall be powered or not.
>> mmc_sdio_runtime_suspend() and mmc_sdio_runtime_resume() are doing the
>> actual work for cutting and restoring the power.
>>
>> 2. The mmc host driver. Depending on hardware design; but very likely
>> you are able to handle runtime PM separate from the sdio core. The
>> important part is how you implement SDIO irqs. Since once your host
>> driver has put it's device into runtime suspend state, you can not
>> trust the controller to fetch the SDIO irqs. Some has solved this by
>> re-routing SDIO irq line (DAT1) to a GPIO irq while entering
>> runtime_suspend state, some have a complete separate line for SDIO irq
>> so the mmc controller don't need to bother about SDIO irqs at all.
>>
> OMAP4's spec also mentions that one should use GPIO to monitor the
> state of DAT1 pin if the power domain is off. So my takeaway is that
> through various tricks, SDIO irqs can be fetched when it's in runtime
> suspend state. And thus we can enable fine-grain runtime PM in mmc
> host driver, at least for omap_hsmmc.

Agree. Just to be clear, we have two separate devices being controlled
with runtime PM.

The sdio/mmc/sd controller device owned by omap_hsmmc, which resides
in a power domain.

The card device which represents the WLAN-chip/SDIO card, controlled
by the mmc core and the SDIO func driver.

>> For omap_hsmmc, I think runtime PM could be decoupled from the
>> host_ops->enable|disable, and instead use an autosuspend timeout,
>> similar how mmci is doing. Additionally, omap_hsmmc could likely do
>> clock gating in it ->runtime_suspend and ungating in it's
>> ->runtime_resume, to save more power when inactive.
> I take a quick look at mmci.c. Its runtime PM is what I think
> fine-grain. But I get confused. Why doesn't mmci worry about missing
> irq when it's powered off? Does it have a seperate sdio irq line as
> you mentioned above?

cw1200 is a WLAN chip connected on the ux500 boards, which uses mmci.
The cw1200 chip has in this case a separate SDIO irq line. Since this
is outside the SDIO spec, it makes more sense to handle this from the
SDIO func driver.

That is also why we never added SDIO irq support for mmci.

>> 3. If the WLAN chip supports some kind of low power mode, those shall
>> be handled from the SDIO func driver. Depending on what mode it
>> supports it might be feasible to use runtime PM.
>>
> Per Figure13 in Pandaboard datasheet, wl1271 uses GPIO53 as the
> WLAN_IRQ. So it doesn't use sdio to interrupt cpu. So I think when
> running on Pandaboard, the func driver can safely disable the sdio
> when it's not reading/writing through sdio.

Does it mean that DAT1 can be re-routed to GPIO53 or does it mean that
the WLAN chip has a separate line for SDIO irqs?

I am not sure what you mean by disable sdio here? Could you elaborate?
Maybe use the word "device" instead?

KInd regards
Ulf Hansson

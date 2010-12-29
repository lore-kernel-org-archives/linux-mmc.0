From: Arnd Hannemann <arnd@arndnet.de>
Subject: Re: [PATCH] [RFC] mmc: perform SDIO reset on power restore of host
Date: Wed, 29 Dec 2010 11:35:33 +0100
Message-ID: <4D1B0EF5.4080206@arndnet.de>
References: <1293535523-19191-1-git-send-email-arnd@arndnet.de> <AANLkTi=aWkV3gkK-O6ncbnkdyv+WTHqVcuSj+2NJztg7@mail.gmail.com> <4D19EE1C.9050801@arndnet.de> <AANLkTikN1iJ8TftWK3NENVQWZCF5YY7sETSvknBr6sk9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from slowhand.arndnet.de ([88.198.19.76]:39414 "EHLO mail.unitix.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750962Ab0L2Kff (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 29 Dec 2010 05:35:35 -0500
In-Reply-To: <AANLkTikN1iJ8TftWK3NENVQWZCF5YY7sETSvknBr6sk9@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

Hi Ohad,

Am 28.12.2010 15:24, schrieb Ohad Ben-Cohen:
>>> Do you mean that your card is always powered on regardless of
>>> mmc_power_off() invocations ?
>>
>> Yes, it seems so.
> 
> Ok, thanks for letting us know.
> 
> It bothered me that we didn't understand the issue you had, but now it
> seems that MMC_CAP_POWER_OFF_CARD is the right solution for you as
> well.
> 
>> Even if the card is kept powered, when mmc_power_off() is called, the
>> host controller will stop the SD bus clock. So I believe at least some
>> power is saved this way and MMC_CAP_POWER_OFF_CARD makes sense?
> 
> Well, with some SDIO cards, the host controller can use the recently
> added aggressive clock gating framework to stop the clock on
> inactivity, and not wait until the card is powered off.
> 
> Currently that clock gating framework is still disabled for SDIO
> cards, but this is just temporary until we sort out how to use it
> safely for SDIO as well.

So you suggest to don't set MMC_CAP_POWER_OFF_CARD for the boards which
keep the card powered, but instead wait for the clock gating framework?
 
> For example, the wl1271 card has asynchronous interrupts (via external
> irq) so we can safely stop its clock on inactivity.
> 
> Do you know if that's possible with your card as well ?

I don't think so, the card is a normal SDIO card which plugs into a normal
MMC/SD slot, no extra pins or such. However SDIO IRQs are available, but you
don't mean that, do you?

Thanks,
Arnd

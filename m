From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH] [RFC] mmc: perform SDIO reset on power restore of host
Date: Wed, 29 Dec 2010 14:11:10 +0200
Message-ID: <AANLkTi=g6fMQxJ4K4qneGmh_W5UXjLf0Z-38=HTjq6wL@mail.gmail.com>
References: <1293535523-19191-1-git-send-email-arnd@arndnet.de>
 <AANLkTi=aWkV3gkK-O6ncbnkdyv+WTHqVcuSj+2NJztg7@mail.gmail.com>
 <4D19EE1C.9050801@arndnet.de> <AANLkTikN1iJ8TftWK3NENVQWZCF5YY7sETSvknBr6sk9@mail.gmail.com>
 <4D1B0EF5.4080206@arndnet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f194.google.com ([209.85.210.194]:40458 "EHLO
	mail-iy0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752281Ab0L2MLb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 29 Dec 2010 07:11:31 -0500
Received: by iyf40 with SMTP id 40so4807980iyf.1
        for <linux-mmc@vger.kernel.org>; Wed, 29 Dec 2010 04:11:30 -0800 (PST)
In-Reply-To: <4D1B0EF5.4080206@arndnet.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Hannemann <arnd@arndnet.de>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

Hi Arnd,

On Wed, Dec 29, 2010 at 12:35 PM, Arnd Hannemann <arnd@arndnet.de> wrote:
> So you suggest to don't set MMC_CAP_POWER_OFF_CARD for the boards which
> keep the card powered

Yes, if you can't power off your card, it doesn't make a lot of sense
to set it MMC_CAP_POWER_OFF_CARD.

If the reason is to notify the host controller, via runtime PM, to
disable the clock to the card, we need first to see that it works
(have you tested it ? how ?): currently there are no host controllers
which employ runtime PM. It looks like sdhci is about to, but it is
still not clear how exactly - it is just being discussed.

Moreover, it seems that host controllers will ignore the card's
runtime PM status, in order to allow them to independently manage
their runtime PM status (and by that disable clocks more
aggressively).

So I'd wait to see how those discussions evolve (or jump in and have
my use case considered) but before that it won't make a lot of sense
to add MMC_CAP_POWER_OFF_CARD for cards that are always powered on,
because it is currently still not clear that it will yield any
benefit.

>> For example, the wl1271 card has asynchronous interrupts (via external
>> irq) so we can safely stop its clock on inactivity.
>>
>> Do you know if that's possible with your card as well ?
>
> I don't think so, the card is a normal SDIO card which plugs into a normal
> MMC/SD slot, no extra pins or such. However SDIO IRQs are available, but you
> don't mean that, do you?

Some cards do support asynchronous SDIO IRQs (do you know if yours too
btw ?). How this is going to be safely employed is still in
discussions...

Thanks,
Ohad.

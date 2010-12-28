From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH] [RFC] mmc: perform SDIO reset on power restore of host
Date: Tue, 28 Dec 2010 16:24:45 +0200
Message-ID: <AANLkTikN1iJ8TftWK3NENVQWZCF5YY7sETSvknBr6sk9@mail.gmail.com>
References: <1293535523-19191-1-git-send-email-arnd@arndnet.de>
 <AANLkTi=aWkV3gkK-O6ncbnkdyv+WTHqVcuSj+2NJztg7@mail.gmail.com> <4D19EE1C.9050801@arndnet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f194.google.com ([209.85.210.194]:64129 "EHLO
	mail-iy0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753561Ab0L1OZG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Dec 2010 09:25:06 -0500
Received: by iyf40 with SMTP id 40so4488190iyf.1
        for <linux-mmc@vger.kernel.org>; Tue, 28 Dec 2010 06:25:05 -0800 (PST)
In-Reply-To: <4D19EE1C.9050801@arndnet.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Hannemann <arnd@arndnet.de>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

Hi Arnd,

On Tue, Dec 28, 2010 at 4:03 PM, Arnd Hannemann <arnd@arndnet.de> wrote:
>> Do you mean that your card is always powered on regardless of
>> mmc_power_off() invocations ?
>
> Yes, it seems so.

Ok, thanks for letting us know.

It bothered me that we didn't understand the issue you had, but now it
seems that MMC_CAP_POWER_OFF_CARD is the right solution for you as
well.

> Even if the card is kept powered, when mmc_power_off() is called, the
> host controller will stop the SD bus clock. So I believe at least some
> power is saved this way and MMC_CAP_POWER_OFF_CARD makes sense?

Well, with some SDIO cards, the host controller can use the recently
added aggressive clock gating framework to stop the clock on
inactivity, and not wait until the card is powered off.

Currently that clock gating framework is still disabled for SDIO
cards, but this is just temporary until we sort out how to use it
safely for SDIO as well.

For example, the wl1271 card has asynchronous interrupts (via external
irq) so we can safely stop its clock on inactivity.

Do you know if that's possible with your card as well ?

Thanks,
Ohad.

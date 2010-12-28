From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH] [RFC] mmc: perform SDIO reset on power restore of host
Date: Tue, 28 Dec 2010 14:45:57 +0200
Message-ID: <AANLkTi=aWkV3gkK-O6ncbnkdyv+WTHqVcuSj+2NJztg7@mail.gmail.com>
References: <1293535523-19191-1-git-send-email-arnd@arndnet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f194.google.com ([209.85.210.194]:33664 "EHLO
	mail-iy0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753405Ab0L1MqT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Dec 2010 07:46:19 -0500
Received: by iyf40 with SMTP id 40so4462317iyf.1
        for <linux-mmc@vger.kernel.org>; Tue, 28 Dec 2010 04:46:18 -0800 (PST)
In-Reply-To: <1293535523-19191-1-git-send-email-arnd@arndnet.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Hannemann <arnd@arndnet.de>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On Tue, Dec 28, 2010 at 1:25 PM, Arnd Hannemann <arnd@arndnet.de> wrote:
> On some boards card power is hard wired to the slot
> and active regardless of host controller state.
...
> This was observed on AP4EVB with tmio_mmc and a b43 based
> SDIO card:
> http://marc.info/?l=linux-mmc&m=128854536521274&w=2

Do you mean that your card is always powered on regardless of
mmc_power_off() invocations ?

I always wondered why SDIO runtime PM didn't work with your card, so
thanks for the follow up on this.

That said, if you card can't be powered down, then it shouldn't be
MMC_CAP_POWER_OFF_CARD at all (which literally means that the card can
be powered down).

And if it isn't MMC_CAP_POWER_OFF_CARD, then runtime PM will stay
disabled for the card, so the problem you describe can't happen.

Thanks,
Ohad.

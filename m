From: Arnd Hannemann <arnd@arndnet.de>
Subject: Re: [PATCH] [RFC] mmc: perform SDIO reset on power restore of host
Date: Tue, 28 Dec 2010 15:03:08 +0100
Message-ID: <4D19EE1C.9050801@arndnet.de>
References: <1293535523-19191-1-git-send-email-arnd@arndnet.de> <AANLkTi=aWkV3gkK-O6ncbnkdyv+WTHqVcuSj+2NJztg7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from slowhand.arndnet.de ([88.198.19.76]:33384 "EHLO mail.unitix.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752156Ab0L1ODQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 28 Dec 2010 09:03:16 -0500
In-Reply-To: <AANLkTi=aWkV3gkK-O6ncbnkdyv+WTHqVcuSj+2NJztg7@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

Hi Ohad,

Am 28.12.2010 13:45, schrieb Ohad Ben-Cohen:
> On Tue, Dec 28, 2010 at 1:25 PM, Arnd Hannemann <arnd@arndnet.de> wrote:
>> On some boards card power is hard wired to the slot
>> and active regardless of host controller state.
> ...
>> This was observed on AP4EVB with tmio_mmc and a b43 based
>> SDIO card:
>> http://marc.info/?l=linux-mmc&m=128854536521274&w=2
> 
> Do you mean that your card is always powered on regardless of
> mmc_power_off() invocations ?

Yes, it seems so.

> I always wondered why SDIO runtime PM didn't work with your card, so
> thanks for the follow up on this.
> 
> That said, if you card can't be powered down, then it shouldn't be
> MMC_CAP_POWER_OFF_CARD at all (which literally means that the card can
> be powered down).
> 
> And if it isn't MMC_CAP_POWER_OFF_CARD, then runtime PM will stay
> disabled for the card, so the problem you describe can't happen.

Even if the card is kept powered, when mmc_power_off() is called, the
host controller will stop the SD bus clock. So I believe at least some
power is saved this way and MMC_CAP_POWER_OFF_CARD makes sense?

Thanks,
Arnd

From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: Re: [PATCH] mmc: mmci: Improve runtime PM support
Date: Mon, 24 Oct 2011 17:25:28 +0200
Message-ID: <4EA58368.6050704@stericsson.com>
References: <1319210754-22775-1-git-send-email-ulf.hansson@stericsson.com>	<20111021173637.GG21648@n2100.arm.linux.org.uk>	<CAKnu2MrOriMzJH9NcwUivWa0cinASa6wrRf4a69si4WUs-aTrQ@mail.gmail.com>	<CAAgDR1OT=+xgQTNwmTz=9XwzpbhjeZ6F-mxnVGhOAPSAR3JiFQ@mail.gmail.com>	<4EA51C4A.7040802@stericsson.com>	<20111024090432.GA9893@n2100.arm.linux.org.uk>	<4EA53181.2050700@stericsson.com>	<20111024094203.GI9893@n2100.arm.linux.org.uk>	<4EA538A3.9070501@stericsson.com>	<20111024101416.GK9893@n2100.arm.linux.org.uk>	<4EA55076.2010701@stericsson.com> <CACRpkdb7FwW=Qa2MiJkbezkBO3F+Y0j6-RWSiL8dfJXkbd4pHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog105.obsmtp.com ([207.126.144.119]:55696 "EHLO
	eu1sys200aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932306Ab1JXPZu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Oct 2011 11:25:50 -0400
In-Reply-To: <CACRpkdb7FwW=Qa2MiJkbezkBO3F+Y0j6-RWSiL8dfJXkbd4pHw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Sebastian Rasmussen <sebras@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Linus Walleij wrote:
> On Mon, Oct 24, 2011 at 1:48 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:
>> [Russell]
>>> The MCIPWR signal controls the external power switch.  This is the only
>>> signal for it.  This is the only connection for it.  There is no other
>>> control form for this power switch.
>>>
>> Then we are only left to use the variant struct I believe. In principle, a
>> flag in the variant struct, could indicate whether it is OK to disable the
>> vcore regulator and thus clear the MCIPWR when doing runtime_suspend.
> 
> Yep I think the best could be to add some variant named
> bool external_card_power; and then document in the kerneldoc that this
> means the driver can clear MMCIPWR without risk of cutting the power
> to the card.
> 
> This should be true for Ux500, U300 and Nomadik (just checked the designs -
> they all have external regulators).
> 

Could we assume that all boards which utilizes the ARM PL180 are using 
the MMCIPWR register to control power the card? Or should we add a new 
amba mmci platform member so this is configurable for each board?

An option could also be if we might want to simplify code to just skip 
the entire runtime_suspend|idle|resume function (ie stubb it or 
something) for these kind of boards?

What do you prefer?

> So the state save/restore and amba_vcore_disable(adev); should be done
> only for those variants.
> 
> However this:
> 
> clk_disable(host->clk);
> 
> We ought to be able to do for *all* variants, provided we can create
> pm_runtime_get/put and delay properly to cover all bus traffic
> (looks like the patch already does that), plus all the time the card is
> signalling busy. The best I can think of is to just return -EBUSY to runtime
> PM like this:
> 
> if ((readl(base + MMCISTATUS) & (MCI_CMDACTIVE | MCI_TXACTIVE| MCI_RXACTIVE))
>   return -EBUSY;
> 
> Yours,
> Linus Walleij
> 


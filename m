From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] mmc: mmci: Improve runtime PM support
Date: Mon, 24 Oct 2011 10:04:32 +0100
Message-ID: <20111024090432.GA9893@n2100.arm.linux.org.uk>
References: <1319210754-22775-1-git-send-email-ulf.hansson@stericsson.com> <20111021173637.GG21648@n2100.arm.linux.org.uk> <CAKnu2MrOriMzJH9NcwUivWa0cinASa6wrRf4a69si4WUs-aTrQ@mail.gmail.com> <CAAgDR1OT=+xgQTNwmTz=9XwzpbhjeZ6F-mxnVGhOAPSAR3JiFQ@mail.gmail.com> <4EA51C4A.7040802@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:39619 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752355Ab1JXJEp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Oct 2011 05:04:45 -0400
Content-Disposition: inline
In-Reply-To: <4EA51C4A.7040802@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: Sebastian Rasmussen <sebras@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Lee Jones <lee.jones@linaro.org>

On Mon, Oct 24, 2011 at 10:05:30AM +0200, Ulf Hansson wrote:
> Sebastian Rasmussen wrote:
>> Hi!
>>
>>> Err, no.  You're not allowed to power down the card between commands
>>> unless the card has been removed or been has finished with.
>>>
>>> If you power down the card (which you _are_ doing by writing zero to
>>> the MMCIPOWER register), then you have to do a full setup of the card
>>> when you resume.
>>
>> MCIPower is according to ARM PL180 TRM signalling to an external power
>> supply to turn on/off (MCIPWR), whether to use open-drain (MCIROD),
>> what voltage to use (MCIVDD) and whether the card is clocked (MCICLK).
>>
>> According ST-Ericsson's public PL180 derivative spec[1] it seems to work
>> roughly in same way (but renaming the register SDI_PWR and the signals
>> SDIPWR & SDICLK). However, there is no SDIVDD as the derivative can not
>> signal desired voltage level externally (there are no bits in SDI_PWR for this).
>> This makes it plausible that SDIPWR may not be routed externally either.
>> Can you verify this as there are no signal routing diagrams in the spec..?
>>
>
> The hole idea with this PM patch is to make sure the vcore regulator and  
> the clock are disabled in runtime_suspend to be able to save a huge  
> amount of current in "idle" mode.
>
> Disabling the vcore regulator will sooner or later (depending on your  
> regulator tree) mean that that power to the controller is actually cut,  
> which then means that all registers will be "cleared" including the  
> MCIPWR. So the actual reason for clearing the registers in the  
> runtime_suspend function is because of two reasons.
>
> 1. Set the controller in a known state so no "magic" things happens when  
> we are runtime suspended, for example getting an IRQ.
>
> 2. Save power by disabling the clock etc. The actual power to the  
> controller does not have to be cut just because we have disabled the  
> vore regulator.
>
> If the ARM PL180 TRM prevent us from from doing this kind of operations  
> in runtime_suspend, we must think of an alternative solution which just  
> apply for ST-Ericssons derivative of PL180. THIS IS VERY IMPORTANT to be  
> able to implement a proper power management solution.
>
> Please check this Russell, this is VERY IMPORTANT!

I repeat: if you cut power to the card, you have to re-initialize it.
Re-initialization takes quite a bit of time to re-detect and setup
the card.  You'd also need to re-configure things like the transfer
mode and so forth.

The other problem is if you're doing runtime-pm between commands,
the re-initialization takes multiple commands - we don't want to be
in the middle of a reinitialization while we're also doing something
with runtime-pm - nested initialization would not be a nice problem
to solve.

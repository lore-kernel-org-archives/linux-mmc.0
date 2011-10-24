From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: Re: [PATCH] mmc: mmci: Improve runtime PM support
Date: Mon, 24 Oct 2011 10:05:30 +0200
Message-ID: <4EA51C4A.7040802@stericsson.com>
References: <1319210754-22775-1-git-send-email-ulf.hansson@stericsson.com>	<20111021173637.GG21648@n2100.arm.linux.org.uk>	<CAKnu2MrOriMzJH9NcwUivWa0cinASa6wrRf4a69si4WUs-aTrQ@mail.gmail.com> <CAAgDR1OT=+xgQTNwmTz=9XwzpbhjeZ6F-mxnVGhOAPSAR3JiFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog115.obsmtp.com ([207.126.144.139]:47730 "EHLO
	eu1sys200aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753657Ab1JXIGB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Oct 2011 04:06:01 -0400
In-Reply-To: <CAAgDR1OT=+xgQTNwmTz=9XwzpbhjeZ6F-mxnVGhOAPSAR3JiFQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sebastian Rasmussen <sebras@gmail.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Lee Jones <lee.jones@linaro.org>

Sebastian Rasmussen wrote:
> Hi!
> 
>> Err, no.  You're not allowed to power down the card between commands
>> unless the card has been removed or been has finished with.
>>
>> If you power down the card (which you _are_ doing by writing zero to
>> the MMCIPOWER register), then you have to do a full setup of the card
>> when you resume.
> 
> MCIPower is according to ARM PL180 TRM signalling to an external power
> supply to turn on/off (MCIPWR), whether to use open-drain (MCIROD),
> what voltage to use (MCIVDD) and whether the card is clocked (MCICLK).
> 
> According ST-Ericsson's public PL180 derivative spec[1] it seems to work
> roughly in same way (but renaming the register SDI_PWR and the signals
> SDIPWR & SDICLK). However, there is no SDIVDD as the derivative can not
> signal desired voltage level externally (there are no bits in SDI_PWR for this).
> This makes it plausible that SDIPWR may not be routed externally either.
> Can you verify this as there are no signal routing diagrams in the spec..?
> 

The hole idea with this PM patch is to make sure the vcore regulator and 
the clock are disabled in runtime_suspend to be able to save a huge 
amount of current in "idle" mode.

Disabling the vcore regulator will sooner or later (depending on your 
regulator tree) mean that that power to the controller is actually cut, 
which then means that all registers will be "cleared" including the 
MCIPWR. So the actual reason for clearing the registers in the 
runtime_suspend function is because of two reasons.

1. Set the controller in a known state so no "magic" things happens when 
we are runtime suspended, for example getting an IRQ.

2. Save power by disabling the clock etc. The actual power to the 
controller does not have to be cut just because we have disabled the 
vore regulator.

If the ARM PL180 TRM prevent us from from doing this kind of operations 
in runtime_suspend, we must think of an alternative solution which just 
apply for ST-Ericssons derivative of PL180. THIS IS VERY IMPORTANT to be 
able to implement a proper power management solution.

Please check this Russell, this is VERY IMPORTANT!


> This leads me to believe that writing 0 to SDI_PWR/MMC in actual practice
> doesn't really do much but disabling the clock to the card (and for
> ST-Ericsson's PL180, disable direction signalling to the external level
> shifter). Clearing bit 8 of MCIClock/SDI_CLKCR also disables the clock.
> 
> I guess the patch would appeal more to Russell if mmci_runtime_suspend()
> only cleared MCIMask0/SDI_MASK0 and MCIClock/SDI_CLKCR and left
> MCIPower/SDI_PWR unchanged. It may be the case that the signal direction
> bits need to be cleared for the ST-Ericsson PL180, but I haven't yet verified
> this on my Snowball dev board yet.

This is according the comment above not feasible, since the vcore 
regulator to the controller is disabled all registers will be "cleared" 
anyway.

> 
>  / Sebastian
> 
> [1] http://www.stericsson.com/developers/DM00030004_AP9500_reference_manual_rev1.pdf
> 

BR
Ulf Hansson

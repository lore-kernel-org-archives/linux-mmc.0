From: Sebastian Rasmussen <sebras@gmail.com>
Subject: Re: [PATCH] mmc: mmci: Improve runtime PM support
Date: Sun, 23 Oct 2011 02:31:39 +0200
Message-ID: <CAAgDR1OT=+xgQTNwmTz=9XwzpbhjeZ6F-mxnVGhOAPSAR3JiFQ@mail.gmail.com>
References: <1319210754-22775-1-git-send-email-ulf.hansson@stericsson.com>
	<20111021173637.GG21648@n2100.arm.linux.org.uk>
	<CAKnu2MrOriMzJH9NcwUivWa0cinASa6wrRf4a69si4WUs-aTrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:62655 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753008Ab1JWAbk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 22 Oct 2011 20:31:40 -0400
Received: by ywm3 with SMTP id 3so577134ywm.19
        for <linux-mmc@vger.kernel.org>; Sat, 22 Oct 2011 17:31:40 -0700 (PDT)
In-Reply-To: <CAKnu2MrOriMzJH9NcwUivWa0cinASa6wrRf4a69si4WUs-aTrQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Lee Jones <lee.jones@linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>

Hi!

> Err, no.  You're not allowed to power down the card between commands
> unless the card has been removed or been has finished with.
>
> If you power down the card (which you _are_ doing by writing zero to
> the MMCIPOWER register), then you have to do a full setup of the card
> when you resume.

MCIPower is according to ARM PL180 TRM signalling to an external power
supply to turn on/off (MCIPWR), whether to use open-drain (MCIROD),
what voltage to use (MCIVDD) and whether the card is clocked (MCICLK).

According ST-Ericsson's public PL180 derivative spec[1] it seems to work
roughly in same way (but renaming the register SDI_PWR and the signals
SDIPWR & SDICLK). However, there is no SDIVDD as the derivative can not
signal desired voltage level externally (there are no bits in SDI_PWR for this).
This makes it plausible that SDIPWR may not be routed externally either.
Can you verify this as there are no signal routing diagrams in the spec..?

This leads me to believe that writing 0 to SDI_PWR/MMC in actual practice
doesn't really do much but disabling the clock to the card (and for
ST-Ericsson's PL180, disable direction signalling to the external level
shifter). Clearing bit 8 of MCIClock/SDI_CLKCR also disables the clock.

I guess the patch would appeal more to Russell if mmci_runtime_suspend()
only cleared MCIMask0/SDI_MASK0 and MCIClock/SDI_CLKCR and left
MCIPower/SDI_PWR unchanged. It may be the case that the signal direction
bits need to be cleared for the ST-Ericsson PL180, but I haven't yet verified
this on my Snowball dev board yet.

 / Sebastian

[1] http://www.stericsson.com/developers/DM00030004_AP9500_reference_manual_rev1.pdf

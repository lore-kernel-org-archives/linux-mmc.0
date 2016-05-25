From: Tor Krill <tor@openproducts.com>
Subject: Re: error -110 sending stop command
Date: Wed, 25 May 2016 09:22:05 +0200
Message-ID: <1464160925.3204.17.camel@openproducts.com>
References: <20160524093747.12bfe046@vostro.util.wtbts.net>
	 <20160524173727.63441f1c@vostro>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from op-mail.openproducts.com ([54.93.171.173]:60127 "EHLO
	op-mail.openproducts.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660AbcEYHWJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 May 2016 03:22:09 -0400
In-Reply-To: <20160524173727.63441f1c@vostro>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Timo Teras <timo.teras@iki.fi>, linux-mmc@vger.kernel.org
Cc: Richard Ash <richardashaudacity@googlemail.com>

Hi Timo and others,

Sorry for the late reply.

On tis, 2016-05-24 at 17:37 +0300, Timo Teras wrote:
> On Tue, 24 May 2016 09:37:46 +0300
> Timo Teras <timo.teras@iki.fi> wrote:
> 
> > I'm having the following errors on my SD-card when writing to them:
> > 
> > mmc0: Timeout waiting for hardware interrupt.
> > mmcblk0: error -110 sending stop command, original cmd response
> > 0x900,
> > card status 0x400e00
> > [...] 
> > 
> > Any suggestions how to debug this further? Perhaps some quirks to
> > test? Or already committed patches/fixes that might resolve this
> > issue?

As a comment on your first email. We still have problems with our board
and the eMMC on it. (A solid run clearfog and the  MicroSoM A388)

With any recent kernel we experience write operations that fail and
then the no response on the status poll. After this any communication
with the chip seems fruitless.

Since we could not rule out that this could be an issue with the
specific eMMC we are currently investigating if we can reproduce the
problems with an SD-card instead and have to wait for tests on new SOMs
without the eMMC. (These arrived yesterday and we should hopefully be
able to test these shortly)

> If I force PIO mode (sdhci.debug_quirks=0x60), I get:
> [  111.201763] mmc0: Timeout waiting for hardware interrupt.
> [  111.201887] mmc0: Got data interrupt 0x00000020 even though no
> data operation was in progress.
> [  111.202032] mmcblk0: error -110 sending stop command, original cmd
> response 0x900, card status 0x400e00    
> 
> And enabling SDHCI_QUIRK_NO_MULTIBLOCK (sdhci.debug_quirks=0x200000)
> seems to fix all immediate issues, but it also degrades the
> performance
> seriously.

This is somewhat analogous with what i have seen. We have stable
operation when we use the Marvell/solid-run provided SDK kernel 3.x
something.

I have also tried bisecting the kernel without any definite culprit
identified. I can however observe what seems to be a more stable system
on older versions of the kernel.

For some time i had this commit as a candidate for the problem:

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/
?id=d3df0465db00cf4ed9f90d0bfc3b827d32b9c796

But it turned out to be a false positive. After a few hours of testing
i got the same problem.

Thus it seems like timing/performance could be the problem here, at
least for us. As earlier mentioned, when enabling debug logging on the
subsystem the problem goes away or at least makes the bug less
frequently triggered.

But as said above, we are currently trying to isolate the problem to
sw/hw, controller, driver etc.

Best!

/Tor

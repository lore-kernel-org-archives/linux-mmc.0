From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: SDHCI: mdelay() in hot path in esdhc_pltfm_set_clock looses CAN
 (!) frames
Date: Tue, 7 Jul 2015 21:52:43 +0100
Message-ID: <20150707205243.GK7557@n2100.arm.linux.org.uk>
References: <CAOpc7mG7-RyZ2LSX8n1kh_KWaVf6N=Lo0LGt4ckLJWzp541FZg@mail.gmail.com>
 <CAOMZO5D02tarn9QrOuS3i1ekn=1Jupngo6RBOfyVm9QASPA23A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:54688 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933383AbbGGUwy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Jul 2015 16:52:54 -0400
Content-Disposition: inline
In-Reply-To: <CAOMZO5D02tarn9QrOuS3i1ekn=1Jupngo6RBOfyVm9QASPA23A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Holger Schurig <holgerschurig@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, open list <linux-kernel@vger.kernel.org>, Dong Aisheng <b29396@freescale.com>, Sascha Hauer <kernel@pengutronix.de>

On Tue, Jul 07, 2015 at 03:17:08PM -0300, Fabio Estevam wrote:
> On Tue, Jun 30, 2015 at 10:43 AM, Holger Schurig
> <holgerschurig@gmail.com> wrote:
> > So it seems that esdhc_pltfm_set_clock() somehow waits. And really
> > there is an mdelay(1) there. So it waits a whopping millisecond there!
> >
> > What's worse: I put a printk() into this function, just before the
> > mdelay(). And it get's called hundreds of times when I boot, or when I
> > update via rsync. And I believe that for each call the mdelay() kills
> > preemption.

The whole SDHCI thing remains a total trainwreck.  Sorry guys, that's
precisely what it is.  That damned driver needs rewriting to be a
library, the quirks need to be killed, and handled in specific driver
code for the variants with a library of core functions.

Then, the whole set_ios() thing in MMC needs killing and replaced with
a functional interface instead - "turn power on" "initialise/turn clock
on" "set clock speed" etc.

I suspect if that were to happen, then we'd get rid of a lot of those
mdelay()s you're seeing, because the problem sdhci has today is that
it's virtually impossible to work out what each set_ios() call into
the code is trying to achieve (well, we can work that out, what can't
be worked out is whether splitting the code is going to break some
random sdhci host, so the risk of causing breakage is high - hence
sdhci in its current form is basically unmaintainable.)

I've been saying this for quite some time - I put some work into it a
couple of years ago to try and clean up some of the crap there, but
since then people have continued with their same old ideas, adding
yet more quirk bits to those damned quirk variables, adding intercepts
for register accesses which all makes the issue worse, rather than
addressing the fundamental problem.

It needs a huge amount of effort put into it...

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.

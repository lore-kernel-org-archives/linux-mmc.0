From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 3/3] MMC: sdhci-dove: allow GPIOs to be used for card
 detection on Dove
Date: Mon, 26 Nov 2012 10:43:10 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1211260955070.11501@axis700.grange>
References: <20121122235426.GT3332@n2100.arm.linux.org.uk>
 <E1TbgcZ-0007Kt-35@rmk-PC.arm.linux.org.uk> <20121123083117.GA25754@S2100-06.ap.freescale.net>
 <20121123085726.GK5764@n2100.arm.linux.org.uk> <20121123121422.GA26168@S2100-06.ap.freescale.net>
 <20121123125507.GO5764@n2100.arm.linux.org.uk> <871ufh8lza.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:55190 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753624Ab2KZJnR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Nov 2012 04:43:17 -0500
In-Reply-To: <871ufh8lza.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Shawn Guo <shawn.guo@linaro.org>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Mike Rapoport <mike@compulab.co.il>, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org

Hi Chris

On Sun, 25 Nov 2012, Chris Ball wrote:

> Hi, adding Guennadi,
> 
> On Fri, Nov 23 2012, Russell King - ARM Linux wrote:
> > On Fri, Nov 23, 2012 at 08:14:27PM +0800, Shawn Guo wrote:
> >> On Fri, Nov 23, 2012 at 08:57:26AM +0000, Russell King - ARM Linux wrote:
> >> > Does this work with the sdhci stuff?
> >> 
> >> Honestly, I'm not sure, but I guess it does, since I have seen
> >> sdhci-pxav3 driver using the helpers.  Anyway, I'm going to adopt
> >> the helpers for sdhci-esdhc-imx driver to find it out.
> >
> > The thing that worries me is this:
> >
> > static void sdhci_tasklet_card(unsigned long param)
> > {
> > ...
> >         /* Check host->mrq first in case we are runtime suspended */
> >         if (host->mrq &&
> >             !(sdhci_readl(host, SDHCI_PRESENT_STATE) & SDHCI_CARD_PRESENT)) {
> >                 pr_err("%s: Card removed during transfer!\n",
> >                         mmc_hostname(host->mmc));
> >                 pr_err("%s: Resetting controller.\n",
> >                         mmc_hostname(host->mmc));
> >
> >                 sdhci_reset(host, SDHCI_RESET_CMD);
> >                 sdhci_reset(host, SDHCI_RESET_DATA);
> >
> >                 host->mrq->cmd->error = -ENOMEDIUM;
> >                 tasklet_schedule(&host->finish_tasklet);
> >         }
> > ...
> >         mmc_detect_change(host->mmc, msecs_to_jiffies(200));
> > }
> >
> >
> > That gets called whenever a card is inserted/removed by the SDHCI code (if
> > the SDHCI card detect is wired), or in my case by the interrupt routine
> > the code in my patch adds.
> >
> > The slot-gpio.c stuff directly calls into mmc_detect_change (a) with a
> > shorter delay, and (b) completely omits the above handling and resetting.
> > My guess from the above code is that it'll work fine 90% of the time
> > (because you'll remove the card without an active request), but the above
> > code looks like it's addressing a corner case which will be omitted with
> > the "generic" slot-gpio.c solution.
> >
> > So I don't think it's a good idea to use slot-gpio.c in this case.
> 
> Guennadi, what are your thoughts about consolidating this reset logic
> between the sdhci tasklet and slot-gpio?  It would certainly be nice to
> use slot-gpio in cases like this one, so it's worth fixing.

Sure, this can be added. As for how - I see at least two possibilities: 
(1) put the complete above block in a new mmc host operation and just call 
it from the GPIO card-detect ISR, (2) taking into account, that many 
(nearly all? all?) host drivers keep a pointer to the current mrq in their 
private data struct, we could instead add such a pointer to struct 
mmc_host, then the check "request in progress" could also be generalised, 
and the operation would just have to reset the host and complete the 
request (in the sdhci case schedule the task).

Note, that there's already a .hw_reset() operation, used by sdhci-pci only 
so far, still, it seems we cannot (easily) hijack it.

So, what would be the preferred way?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/

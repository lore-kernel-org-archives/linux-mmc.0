From: Bing Zhao <bzhao@marvell.com>
Subject: RE: [PATCH v2] sdio: skip initialization on powered resume
Date: Thu, 2 Sep 2010 15:58:03 -0700
Message-ID: <477F20668A386D41ADCC57781B1F704307D2F41B27@SC-VEXCH1.marvell.com>
References: <1283391692-14150-1-git-send-email-bzhao@marvell.com>
 <alpine.LFD.2.00.1009021344430.19366@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from dakia3.marvell.com ([65.219.4.28]:51917 "EHLO
	dakia3.marvell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754494Ab0IBW6F convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Sep 2010 18:58:05 -0400
In-Reply-To: <alpine.LFD.2.00.1009021344430.19366@xanadu.home>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Michal Miroslaw <mirqus@gmail.com>, Chris Ball <cjb@laptop.org>, Andrew Morton <akpm@linux-foundation.org>

Hi Nicolas,

Thanks for your comments.

> -----Original Message-----
> From: Nicolas Pitre [mailto:nico@fluxnic.net]
> Sent: Thursday, September 02, 2010 10:54 AM
> To: Bing Zhao
> Cc: linux-mmc@vger.kernel.org; Michal Miroslaw; Chris Ball; Andrew Morton
> Subject: Re: [PATCH v2] sdio: skip initialization on powered resume
> 
> On Wed, 1 Sep 2010, Bing Zhao wrote:
> 
> > Quoted Michal Miroslaw's comment:
> >
> > Simplified SDIO spec v.2.00 (section 6.14 - Bus State Diagram)
> > suggests, that initialization commands (CMD5, CMD3) are not accepted
> > in CMD state. As the card stays in that state on powered suspend (no
> > resetting CMD52 nor power cycle is issued) then reinitialization
> > should be entirely skipped on resume unless the power was lost between
> > suspend and resume (or card was temporarily removed from the slot).
> >
> > Signed-off-by: Bing Zhao <bzhao@marvell.com>
> 
> Comments below.
> 
> > +	/*
> > +	 * Simplified SDIO spec v2.00 (section 6.14 - Bus State Diagram)
> > +	 * suggests that initialization should be skipped on powered resume.
> > +	 */
> > +	if (!(host->pm_flags & MMC_PM_KEEP_POWER)) {
> > +		err = mmc_sdio_init_card(host, host->ocr, host->card,
> > +					host->pm_flags & MMC_PM_KEEP_POWER);
> > +	}
> 
> Please look at the if() condition, and at the last argument to
> mmc_sdio_init_card(), then ponder.

You are right. The last argument passed to mmc_sdio_init_card() is zero actually.

		err = mmc_sdio_init_card(host, host->ocr, host->card, 0);

> 
> I think the proper fix goes _inside_ mmc_sdio_init_card() as there are
> certainly still validation checks which are appropriate to perform.

When you have a thought for the fix, I can do the testing on my system.

Thanks,

Bing

> 
> 
> Nicolas

From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH v2] sdio: skip initialization on powered resume
Date: Thu, 02 Sep 2010 13:54:11 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1009021344430.19366@xanadu.home>
References: <1283391692-14150-1-git-send-email-bzhao@marvell.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:19920 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752825Ab0IBRyM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Sep 2010 13:54:12 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MRZ20.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0L84007KLSE9IZQ0@VL-MR-MRZ20.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Thu, 02 Sep 2010 13:54:10 -0400 (EDT)
In-reply-to: <1283391692-14150-1-git-send-email-bzhao@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Bing Zhao <bzhao@marvell.com>
Cc: linux-mmc@vger.kernel.org, Michal Miroslaw <mirqus@gmail.com>, Chris Ball <cjb@laptop.org>, Andrew Morton <akpm@linux-foundation.org>

On Wed, 1 Sep 2010, Bing Zhao wrote:

> Quoted Michal Miroslaw's comment:
> 
> Simplified SDIO spec v.2.00 (section 6.14 - Bus State Diagram)
> suggests, that initialization commands (CMD5, CMD3) are not accepted
> in CMD state. As the card stays in that state on powered suspend (no
> resetting CMD52 nor power cycle is issued) then reinitialization
> should be entirely skipped on resume unless the power was lost between
> suspend and resume (or card was temporarily removed from the slot).
> 
> Signed-off-by: Bing Zhao <bzhao@marvell.com>

Comments below.

> +	/*
> +	 * Simplified SDIO spec v2.00 (section 6.14 - Bus State Diagram)
> +	 * suggests that initialization should be skipped on powered resume.
> +	 */
> +	if (!(host->pm_flags & MMC_PM_KEEP_POWER)) {
> +		err = mmc_sdio_init_card(host, host->ocr, host->card,
> +					host->pm_flags & MMC_PM_KEEP_POWER);
> +	}

Please look at the if() condition, and at the last argument to 
mmc_sdio_init_card(), then ponder.

I think the proper fix goes _inside_ mmc_sdio_init_card() as there are 
certainly still validation checks which are appropriate to perform.


Nicolas

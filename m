From: Nicolas Pitre <nico@fluxnic.net>
Subject: RE: [PATCH v2] sdio: skip initialization on powered resume
Date: Thu, 02 Sep 2010 19:30:09 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1009021923171.19366@xanadu.home>
References: <1283391692-14150-1-git-send-email-bzhao@marvell.com>
 <alpine.LFD.2.00.1009021344430.19366@xanadu.home>
 <477F20668A386D41ADCC57781B1F704307D2F41B27@SC-VEXCH1.marvell.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:42768 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757157Ab0IBXaU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Sep 2010 19:30:20 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR006.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0L850038U7Y9X8F2@VL-MO-MR006.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Thu, 02 Sep 2010 19:30:09 -0400 (EDT)
In-reply-to: <477F20668A386D41ADCC57781B1F704307D2F41B27@SC-VEXCH1.marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Bing Zhao <bzhao@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Michal Miroslaw <mirqus@gmail.com>, Chris Ball <cjb@laptop.org>, Andrew Morton <akpm@linux-foundation.org>

On Thu, 2 Sep 2010, Bing Zhao wrote:

> > Please look at the if() condition, and at the last argument to
> > mmc_sdio_init_card(), then ponder.
> 
> You are right. The last argument passed to mmc_sdio_init_card() is zero actually.
> 
> 		err = mmc_sdio_init_card(host, host->ocr, host->card, 0);
> 
> > 
> > I think the proper fix goes _inside_ mmc_sdio_init_card() as there are
> > certainly still validation checks which are appropriate to perform.
> 
> When you have a thought for the fix, I can do the testing on my system.

I'm telling you that you should use the powered_resume argument of 
mmc_sdio_init_card() to skip problematic initializations inside 
mmc_sdio_init_card() when powered_resume is not zero.  Looking at the 
existing code should give you examples of how powered_resume is used and 
why.


Nicolas

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [RFC 0/4] mmc: tmio, sdhi: provide multiple irq handlers
Date: Mon, 15 Aug 2011 10:17:28 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1108150950330.7851@axis700.grange>
References: <1313387488-28175-1-git-send-email-horms@verge.net.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:64392 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303Ab1HOIRe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Aug 2011 04:17:34 -0400
In-Reply-To: <1313387488-28175-1-git-send-email-horms@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>

Hi Simon

On Mon, 15 Aug 2011, Simon Horman wrote:

> The SDHI driver already supports making use of up to three interrupt
> sources.
> 
> This series breaks up the existing interrupt handler into three handlers,
> one for card access, one for card detect interrupts, and one for SDIO
> interrupts.  A cover-all handler, which makes use of these new broken-out
> handlers is provided for for the case where there is only one interrupt
> source.

The idea is good, thanks for the patches. Only I'm not sure I find the way 
you split the patches extremely intuitive;-) How about:

[PATCH 1/x] cache IRQ masks
 * in this patch I'd propose to cache SD-card and SDIO IRQ masks in struct 
   tmio_mmc_host, instead of reading them every time from the hardware
[PATCH 2/x] split the ISR
 * in this patch you split the IRQ handler directly into the final form as 
   after the first your 3 patches, without intermediate steps, also adding 
   them to the header
[PATCH 3/x] SDHI: use specialized ISRs when available
 * you know what to do here:-) Also, I'd

#define SH_MOBILE_SDHI_IRQ_SDCARD	0
#define SH_MOBILE_SDHI_IRQ_CARD_DETECT	1
#define SH_MOBILE_SDHI_IRQ_SDIO		2

and use these defines both in platforms

	}, [1 + SH_MOBILE_SDHI_IRQ_SDCARD] = {
...

and in sh_mobile_sdhi.c, instead of going "case 2:" Please, also consider 
unfolding the loop over platform IRQs in probing, it might look better 
flat.

"card_access" in function names I would replace with "io" or "data," 
"card_irq" with "sdcard_irq" because I believe, that "SD card" is a proper 
identification to pure storage card in SD format, as opposed to SDIO 
cards.

Also, maybe you can double-check, whether you really need all those 
functions with names, beginning with a double underscore, and whether 
better names wouldn't be possible for them.

> This series also wires up the broken-out irq handlers in the SDHI driver
> 
> * Card portion tested on AP4/Mackerel
> * SDIO portion yet to be tested. I intend to schedule access to hardware
>   to test this if the review of these patches is positive.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/

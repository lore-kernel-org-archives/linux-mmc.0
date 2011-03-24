From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: outstanding tmio patches
Date: Thu, 24 Mar 2011 08:38:56 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1103240834240.15629@axis700.grange>
References: <Pine.LNX.4.64.1103231505450.6836@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:61001 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933338Ab1CXHjF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Mar 2011 03:39:05 -0400
In-Reply-To: <Pine.LNX.4.64.1103231505450.6836@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ian Molton <ian@mnementh.co.uk>, Magnus Damm <magnus.damm@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Paul Mundt <lethal@linux-sh.org>

A small update: two more patches have to be applied first, that are also 
still not in the mmc tree, submitted on the 7th of March:

[1/2] mmc: tmio: Improve DMA stability on sh-mobile
[2/2] mmc: tmio: use PIO for short transfers

On Wed, 23 Mar 2011, Guennadi Liakhovetski wrote:

> I thought it might help to list all the recent patches in the order they 
> should apply to make it a bit easier...
> 
> [1/6,v2] mmc: tmio: split core functionality, DMA and MFD glue
> [2/6] sh: ecovec: use the CONFIG_MMC_TMIO symbols instead of MFD
> [3/6,v2] mmc: tmio: convert the SDHI MMC driver from MFD to a standard platform driver
> [4/6] ARM: mach-shmobile: convert boards to use linux/mmc/sh_mobile_sdhi.h
> [5/6] sh: convert boards to use linux/mmc/sh_mobile_sdhi.h
> [6/6] mfd: remove now redundant sh_mobile_sdhi.h header
> 
> [1/4,v3] mmc: tmio: only access registers above 0xff, if available
> [2/4,v3] ARM: mach-shmobile: fix SDHI IO address-range
> [3/4,v3] sh: fix SDHI IO address-range
> [4/4,v3] mmc: tmio: remove work-around for unmasked SDIO interrupts
> 
> [PATCH/RFC,1/2,v2] mmc: tmio: fix power-mode interpretation
> [PATCH/RFC,2/2,v2] mmc: tmio: support aggressive clock gating
> 
> All available in the patchwork 
> https://patchwork.kernel.org/project/linux-mmc/list/. The last two 
> patches are somewhat risky, but given the timeframe, we could push them 
> and fix any unlikely regressions later.
> 
> Thanks
> Guennadi
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> http://www.open-technology.de/
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/

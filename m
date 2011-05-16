From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH] mmc: tmio: Fix build errors
Date: Tue, 17 May 2011 00:01:42 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1105162359510.29373@axis700.grange>
References: <642193.81570.qm@web29001.mail.ird.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:54881 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753700Ab1EPWBo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 May 2011 18:01:44 -0400
In-Reply-To: <642193.81570.qm@web29001.mail.ird.yahoo.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Paul Parsons <lost.distance@yahoo.com>
Cc: linux-mmc@vger.kernel.org, ian@mnementh.co.uk

On Mon, 16 May 2011, Paul Parsons wrote:

> > NAK. Are you trying to use DMA with TMIO on your platform?
> 
> Not that I am aware of.
> 
> > Then this is a 
> > wrong fix. Otherwise tmio_mmc_dma.c shouldn't be compiled
> > on your arch at 
> > all.
> 
> Then this must be is a config or Makefile bug, because the build is 
> certainly trying to compile tmio_mmc_dma.c
> 
> Looking at drivers/mmc/host/Makefile:
> 
> ifneq ($(CONFIG_MMC_SDHI),n)
> tmio_mmc_core-y                 += tmio_mmc_dma.o
> endif
> 
> My config doesn't define CONFIG_MMC_SDHI at all, thus the Makefile adds tmio_mmc_dma.o to the build?

hm, interesting... Then yes, then this is a bug and should be fixed:( 
Although I'm sure I tested a non-SDHI build... confused.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/

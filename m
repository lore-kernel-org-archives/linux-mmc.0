From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 0/3] mmc: sdhi / tmio: add DT DMA
Date: Fri, 26 Apr 2013 18:16:06 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1304261815410.32752@axis700.grange>
References: <1366991239-22602-1-git-send-email-g.liakhovetski@gmx.de>
 <20130426160200.GE4796@zurbaran>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:63195 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276Ab3DZQQu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 26 Apr 2013 12:16:50 -0400
In-Reply-To: <20130426160200.GE4796@zurbaran>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Vinod Koul <vinod.koul@intel.com>

On Fri, 26 Apr 2013, Samuel Ortiz wrote:

> Hi Guennadi,
> 
> On Fri, Apr 26, 2013 at 05:47:16PM +0200, Guennadi Liakhovetski wrote:
> > These 3 patches add Device Tree DMA support to the TMIO MMC driver, when 
> > used on SDHI platforms.
> > 
> > Samuel: these patches touch an mfd header file lightly, I think, it's 
> > better just to get your ack than to make a separate patch via your tree.
> Yes, that is fine with me.
> 
> For the mfd/tmio.h part:
> Acked-by: Samuel Ortiz <sameo@linux.intel.com>

Thanks!

Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/

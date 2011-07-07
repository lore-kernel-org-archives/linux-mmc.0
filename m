From: Vinod Koul <vkoul@infradead.org>
Subject: Re: [PATCH] ARM i.MX dma: Fix burstsize settings
Date: Thu, 07 Jul 2011 07:05:28 +0530
Message-ID: <1310002528.20150.3.camel@psiaudioba-mobl1>
References: <20110706091833.GT6069@pengutronix.de>
	 <20110706150356.GA11993@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:34181 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751971Ab1GGCkb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Jul 2011 22:40:31 -0400
In-Reply-To: <20110706150356.GA11993@opensource.wolfsonmicro.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, alsa-devel@alsa-project.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org

On Wed, 2011-07-06 at 08:03 -0700, Mark Brown wrote:
> On Wed, Jul 06, 2011 at 11:18:33AM +0200, Sascha Hauer wrote:
> > dmaengine expects the maxburst parameter in words, not bytes.
> > The imxdma driver and its users do this wrong. Fix this.
> > 
> > As a side note the imx-pcm-dma-mx2 driver was 'fixed' to work
> > with imx-dma. This broke the driver with imx-sdma support which
> > correctly takes the maxburst parameter in words. This patch
> > puts the sdma based sound back to work.
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>

> 
> Probably makes sense to send via the ARM tree unless there's merge
> issues?
Sure, I dont have naything on this driver in my next and previous
updates for Sascha went thru imx tree, so would make sense for these to
go that way as well

~Vinod Koul
Intel Corp.



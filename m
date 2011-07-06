From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ARM i.MX dma: Fix burstsize settings
Date: Wed, 6 Jul 2011 08:03:57 -0700
Message-ID: <20110706150356.GA11993@opensource.wolfsonmicro.com>
References: <20110706091833.GT6069@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:39619 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752572Ab1GFPEE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Jul 2011 11:04:04 -0400
Content-Disposition: inline
In-Reply-To: <20110706091833.GT6069@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, Vinod Koul <vinod.koul@intel.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org

On Wed, Jul 06, 2011 at 11:18:33AM +0200, Sascha Hauer wrote:
> dmaengine expects the maxburst parameter in words, not bytes.
> The imxdma driver and its users do this wrong. Fix this.
> 
> As a side note the imx-pcm-dma-mx2 driver was 'fixed' to work
> with imx-dma. This broke the driver with imx-sdma support which
> correctly takes the maxburst parameter in words. This patch
> puts the sdma based sound back to work.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Probably makes sense to send via the ARM tree unless there's merge
issues?

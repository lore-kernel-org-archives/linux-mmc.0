From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 11/20] ARM i.MX dma: Fix burstsize settings
Date: Thu, 14 Jul 2011 16:06:26 +0200
Message-ID: <20110714140626.GC6069@pengutronix.de>
References: <1310652263-27948-1-git-send-email-s.hauer@pengutronix.de>
 <1310652263-27948-11-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46393 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755149Ab1GNOG3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Jul 2011 10:06:29 -0400
Content-Disposition: inline
In-Reply-To: <1310652263-27948-11-git-send-email-s.hauer@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: juergen.lambrecht@gmail.com
Cc: Wolfram Sang <w.sang@pengutronix.de>, Vinod Koul <vinod.koul@intel.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org

On Thu, Jul 14, 2011 at 04:04:14PM +0200, Sascha Hauer wrote:
> From: Wolfram Sang <w.sang@pengutronix.de>
> 
> Already upstreamed.
> 
> dmaengine expects the maxburst parameter in words, not bytes.
> The imxdma driver and its users do this wrong. Fix this.
> 
> As a side note the imx-pcm-dma-mx2 driver was 'fixed' to work
> with imx-dma. This broke the driver with imx-sdma support which
> correctly takes the maxburst parameter in words. This patch
> puts the sdma based sound back to work.

Please ignore. I failed to make git-send-email ignore the cc list :(

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

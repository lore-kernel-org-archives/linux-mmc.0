From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 4/5] mmc: mxcmmc: enable DMA support on mpc512x
Date: Thu, 14 Mar 2013 21:11:39 +0100
Message-ID: <20130314201139.GS1906@pengutronix.de>
References: <1363279254-22351-1-git-send-email-agust@denx.de>
 <1363279254-22351-6-git-send-email-agust@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46736 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751288Ab3CNULk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Mar 2013 16:11:40 -0400
Content-Disposition: inline
In-Reply-To: <1363279254-22351-6-git-send-email-agust@denx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Anatolij Gustschin <agust@denx.de>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Markus Pargmann <mpa@pengutronix.de>, devicetree-discuss@lists.ozlabs.org

On Thu, Mar 14, 2013 at 05:40:53PM +0100, Anatolij Gustschin wrote:
> Add SDHC DMA channel description to the mpc512x device
> tree to enable slave channel requesting in the mxcmmc
> driver.
> 
> mpc512x DMA engine doesn't support endianness conversion
> when reading/writing data from peripheral's FIFO, so we
> have to swap data buffers before each DMA write and after
> each DMA read transfer manually.
> 
> Since chained SDHC DMA transfers are not supported on
> mpc512x, limit 'max_segs' tunable parameter to one and
> initialise it to 64 only when running on i.MX platforms.

They are also not supported on the older i.MX platforms. Shouldn't this
be handled in the DMA driver?

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v8 0/2] sDMA descriptor autoloading feature
Date: Fri, 27 Aug 2010 20:39:10 +0100
Message-ID: <20100827193910.GG23079@void.printf.net>
References: <i2x618f0c911004291034g7f5b377ds5efaf74c901bc036@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:37416 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752338Ab0H0TjL (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 27 Aug 2010 15:39:11 -0400
Content-Disposition: inline
In-Reply-To: <i2x618f0c911004291034g7f5b377ds5efaf74c901bc036@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Venkatraman S <svenkatr@ti.com>
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Madhusudhan Chikkature <madhu.cr@ti.com>, Tony Lindgren <tony@atomide.com>, Adrian Hunter <adrian.hunter@nokia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

Hi Venkatraman,

On Thu, Apr 29, 2010 at 11:04:34PM +0530, Venkatraman S wrote:
>     This patch series is the introduction of new sDMA feature: descriptor
> autoloading (v8) and it's adoption by the OMAP HSMMC driver.
> 
>    The previous version (v7) was blocked on achieving proper interrupt
> syncronisation
> between the MMC and DMA callback in the HSMMC driver.
>   Thanks to Adrian Hunter's patch, https://patchwork.kernel.org/patch/94670/
> this has been cleaned up.
> 
> Current version is based on for-next branch + Adrian Hunter's
> interrupt syncronisation patch
> (https://patchwork.kernel.org/patch/94670)
> 
> Changes since v7:
>   * Removed the 'fix race condition between DMA and HSMMC callback'
> part of the series
>   * Added memory barries in start and resume sglist transfer for cpu
> buffer syncronization
>   * Cleanup and comments
> 
> This has been tested on OMAP3430, OMAP3630 and OMAP4430 SDP
> for MMC file transfer and as boot file system.

The comments on this patchset were positive apart from some stylistic
changes -- would you like to resubmit a new patch?

Thanks,

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child

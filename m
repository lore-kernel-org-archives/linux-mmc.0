From: "Madhusudhan" <madhu.cr@ti.com>
Subject: RE: [PATCH v8 0/2] sDMA descriptor autoloading feature
Date: Tue, 4 May 2010 18:15:29 -0500
Message-ID: <00ea01caebdf$affcb8d0$544ff780@am.dhcp.ti.com>
References: <i2x618f0c911004291034g7f5b377ds5efaf74c901bc036@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55427 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934608Ab0EDXPj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 4 May 2010 19:15:39 -0400
In-Reply-To: <i2x618f0c911004291034g7f5b377ds5efaf74c901bc036@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Venkatraman S' <svenkatr@ti.com>, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: 'Tony Lindgren' <tony@atomide.com>, 'Adrian Hunter' <adrian.hunter@nokia.com>, 'Santosh Shilimkar' <santosh.shilimkar@ti.com>



> -----Original Message-----
> From: svenkatr@gmail.com [mailto:svenkatr@gmail.com] On Behalf Of
> Venkatraman S
> Sent: Thursday, April 29, 2010 12:35 PM
> To: linux-omap@vger.kernel.org; linux-mmc@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org
> Cc: Madhusudhan Chikkature; Tony Lindgren; Adrian Hunter; Santosh
> Shilimkar
> Subject: [PATCH v8 0/2] sDMA descriptor autoloading feature
> 
>     This patch series is the introduction of new sDMA feature: descriptor
> autoloading (v8) and it's adoption by the OMAP HSMMC driver.
> 
>    The previous version (v7) was blocked on achieving proper interrupt
> syncronisation
> between the MMC and DMA callback in the HSMMC driver.
>   Thanks to Adrian Hunter's patch,
> https://patchwork.kernel.org/patch/94670/
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
> 

The HSMMC driver changes look good to me. I can ACK that but am not a DMA
expert to review your changes to the DMA driver.

> Venkatraman S:
>     sDMA: descriptor autoloading feature
>     MMC: omap hsmmc adoption of descriptor autoloading feature
> 
>  arch/arm/plat-omap/dma.c              |  289
> ++++++++++++++++++++++++++++++++-
>  arch/arm/plat-omap/include/plat/dma.h |  170 +++++++++++++++++++
>  drivers/mmc/host/omap_hsmmc.c         |  148 ++++++++++++++---
>  3 files changed, 583 insertions(+), 24 deletions(-)


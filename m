From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 07/15] mmc: sdhi: Enable driver compilation with COMPILE_TEST
Date: Thu, 12 Dec 2013 00:05:36 +0100
Message-ID: <13209501.ngs8HJ5G2p@avalon>
References: <1385515117-23664-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <1488247.0AdahCZr3G@avalon> <52A8AD5B.70601@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:46204 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028Ab3LKXFY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Dec 2013 18:05:24 -0500
In-Reply-To: <52A8AD5B.70601@cogentembedded.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ian Molton <ian@mnementh.co.uk>, linux-mmc@vger.kernel.org

Hi Sergei,

On Wednesday 11 December 2013 22:22:19 Sergei Shtylyov wrote:
> On 11-12-2013 22:06, Laurent Pinchart wrote:
> >>> This helps increasing build testing coverage.
> >>> 
> >>> The driver doesn't compile on (at least) x86 due (possibly among others)
> >>> to missing readsw/writesw I/O accessors, restrict compilation to SUPERH
> >>> or ARM.
> >>> 
> >>> Whether the CTL_DMA_ENABLE register is part of the standard TMIO
> >>> controller or is Renesas-specific is unknown and impossible to test as
> >>> we have no current or planned TMIO DMA users other than SUPERH and
> >>> ARCH_SHMOBILE. Writing to the register is thus conditionally compiled
> >>> for SUPERH and ARCH_SHMOBILE only. Adding ARCH_SHMOBILE_MULTI to the
> >>> list would extend this to multiarch kernels, but would break the driver
> >>> for non-shmobile platforms if the register is Renesas-specific. We can
> >>> thus get rid of the conditional compilation completely without
> >>> introducing any further issue, and let future non-Renesas users deal
> >>> with the situation if it turns out to be a the problem.
> >>> 
> >>> Cc: Chris Ball <cjb@laptop.org>
> >>> Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> >>> Cc: Ian Molton <ian@mnementh.co.uk>
> >>> Cc: linux-mmc@vger.kernel.org
> >>> Signed-off-by: Laurent Pinchart
> >>> <laurent.pinchart+renesas@ideasonboard.com>
> >>> Acked-by: Simon Horman <horms@verge.net.au>
> 
> [...]
> 
> >>> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> >>> index 7fc5099..ca1315e 100644
> >>> --- a/drivers/mmc/host/Kconfig
> >>> +++ b/drivers/mmc/host/Kconfig
> >>> @@ -479,7 +479,8 @@ config MMC_TMIO
> >>> 
> >>>    config MMC_SDHI
> >>>    	tristate "SH-Mobile SDHI SD/SDIO controller support"
> >>> -	depends on SUPERH || ARCH_SHMOBILE
> >>> +	depends on SUPERH || ARM
> >>> +	depends on SUPERH || ARCH_SHMOBILE || COMPILE_TEST
> >>> 
> >>      Hm, why 2 "depends" lines with SUPERH in both?
> > 
> > The first line means "this driver requires SUPERH || ARM to be compiled",
> 
>     Then COMPILE_TEST should be there, no?

No, because the first line says that the driver is known *not* to compile on 
platforms other than ARM and SUPERH. Adding || COMPILE_TEST there would break 
compilation with allyesconfig and randconfig on those other platforms.

Stated differently, the first line restricts the driver from being compiled on 
architectures where it doesn't compile, regardless of COMPILE_TEST, and the 
second line restricts it to platform where hardware is known to exists, with 
COMPILE_TEST to optionally extend build coverage.

> > while the second line means "devices supported by this driver are only
> > found on SUPERH || ARCH_SHMOBILE platforms".

-- 
Regards,

Laurent Pinchart


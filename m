From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 07/15] mmc: sdhi: Enable driver compilation with COMPILE_TEST
Date: Wed, 11 Dec 2013 13:53:21 +0100
Message-ID: <2090378.13zHUAnprd@avalon>
References: <1385515117-23664-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <1385515117-23664-8-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:43013 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753152Ab3LKMxJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Dec 2013 07:53:09 -0500
In-Reply-To: <1385515117-23664-8-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ian Molton <ian@mnementh.co.uk>, linux-mmc@vger.kernel.org

Hi Chris,

Could you please pick this patch (and patch 08/15 in the same series) up for 
v3.14 ?

On Wednesday 27 November 2013 02:18:29 Laurent Pinchart wrote:
> This helps increasing build testing coverage.
> 
> The driver doesn't compile on (at least) x86 due (possibly among others)
> to missing readsw/writesw I/O accessors, restrict compilation to SUPERH
> or ARM.
> 
> Whether the CTL_DMA_ENABLE register is part of the standard TMIO
> controller or is Renesas-specific is unknown and impossible to test as
> we have no current or planned TMIO DMA users other than SUPERH and
> ARCH_SHMOBILE. Writing to the register is thus conditionally compiled
> for SUPERH and ARCH_SHMOBILE only. Adding ARCH_SHMOBILE_MULTI to the
> list would extend this to multiarch kernels, but would break the driver
> for non-shmobile platforms if the register is Renesas-specific. We can
> thus get rid of the conditional compilation completely without
> introducing any further issue, and let future non-Renesas users deal
> with the situation if it turns out to be a the problem.
> 
> Cc: Chris Ball <cjb@laptop.org>
> Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Cc: Ian Molton <ian@mnementh.co.uk>
> Cc: linux-mmc@vger.kernel.org
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Acked-by: Simon Horman <horms@verge.net.au>
> ---
>  drivers/mmc/host/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 7fc5099..ca1315e 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -479,7 +479,8 @@ config MMC_TMIO
> 
>  config MMC_SDHI
>  	tristate "SH-Mobile SDHI SD/SDIO controller support"
> -	depends on SUPERH || ARCH_SHMOBILE
> +	depends on SUPERH || ARM
> +	depends on SUPERH || ARCH_SHMOBILE || COMPILE_TEST
>  	select MMC_TMIO_CORE
>  	help
>  	  This provides support for the SDHI SD/SDIO controller found in
-- 
Regards,

Laurent Pinchart


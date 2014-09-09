From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 5/6 v4] ARM: shmobile: remove MMC_CAP2_NO_MULTI_READ from
 lager
Date: Tue, 9 Sep 2014 17:21:01 +0900
Message-ID: <20140909082058.GB5819@verge.net.au>
References: <87r3zvzohj.wl%kuninori.morimoto.gx@gmail.com>
 <87k35d70pz.wl%kuninori.morimoto.gx@gmail.com>
 <87d2b570l6.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:56433 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755870AbaIIIVE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Sep 2014 04:21:04 -0400
Content-Disposition: inline
In-Reply-To: <87d2b570l6.wl%kuninori.morimoto.gx@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <cjb@laptop.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>

On Mon, Sep 08, 2014 at 11:46:32PM -0700, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> sh_mobile_sdhi cares multiblock read bug.
> remove MMC_CAP2_NO_MULTI_READ flag from board code
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> ---
> v3 -> v4
> 
> - no change
> 
>  arch/arm/mach-shmobile/board-lager.c |    2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
> index e1d8215..f5a98e2 100644
> --- a/arch/arm/mach-shmobile/board-lager.c
> +++ b/arch/arm/mach-shmobile/board-lager.c
> @@ -630,7 +630,6 @@ static void __init lager_add_rsnd_device(void)
>  static struct sh_mobile_sdhi_info sdhi0_info __initdata = {
>  	.tmio_caps	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
>  			  MMC_CAP_POWER_OFF_CARD,
> -	.tmio_caps2	= MMC_CAP2_NO_MULTI_READ,
>  	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT |
>  			  TMIO_MMC_WRPROTECT_DISABLE,
>  };
> @@ -644,7 +643,6 @@ static struct resource sdhi0_resources[] __initdata = {
>  static struct sh_mobile_sdhi_info sdhi2_info __initdata = {
>  	.tmio_caps	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
>  			  MMC_CAP_POWER_OFF_CARD,
> -	.tmio_caps2	= MMC_CAP2_NO_MULTI_READ,
>  	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT |
>  			  TMIO_MMC_WRPROTECT_DISABLE,
>  };
> -- 
> 1.7.9.5
> 

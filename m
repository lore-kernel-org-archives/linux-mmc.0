From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH 2/8] s3c6410: sdhci: Adding additional data in sdhci platform data structure.
Date: Wed, 16 Sep 2009 01:43:59 +0100
Message-ID: <20090916004359.GP13508@trinity.fluff.org>
References: <1252392458-23921-1-git-send-email-thomas.ab@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from trinity.fluff.org ([89.16.178.74]:42388 "EHLO trinity.fluff.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751838AbZIPAn5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 15 Sep 2009 20:43:57 -0400
Content-Disposition: inline
In-Reply-To: <1252392458-23921-1-git-send-email-thomas.ab@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: thomas.ab@samsung.com
Cc: ben-linux@fluff.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Sep 08, 2009 at 03:47:38PM +0900, thomas.ab@samsung.com wrote:
> From: Thomas Abraham <thomas.ab@samsung.com>
> 
> This patch adds additional information about the parent clock
> name, sdhci clock name and desired sdhci operating frequency
> in the sdhci platform data structure.

This would have been better off being a series of adding the max field
and the clock fields seperately, and fixing up their platform data at
the same time.

The addiiton of the clock information is not necessary due to the
following:

1) There are four clock choices here, not just one.

2) The mmc_bus is a fixed clock name, it should not be up to the
   driver to change it, it is registered by the clock core code for
   the relevant architecture.

3) struct s3c_sdhci_platdata already has a `char **` pointer to an
   array of clock names for (1). Setup by functions such as the
   s3c_sdhci0_set_platdata. It does however seem to be missing a
   documentation point in the data.

I'd apply the max-frequency change, but not the clock change.
 
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> ---
>  arch/arm/plat-s3c/dev-hsmmc.c |    9 ++++++---
>  1 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/plat-s3c/dev-hsmmc.c b/arch/arm/plat-s3c/dev-hsmmc.c
> index 4c05b39..357ec60 100644
> --- a/arch/arm/plat-s3c/dev-hsmmc.c
> +++ b/arch/arm/plat-s3c/dev-hsmmc.c
> @@ -38,9 +38,12 @@ static struct resource s3c_hsmmc_resource[] = {
>  static u64 s3c_device_hsmmc_dmamask = 0xffffffffUL;
>  
>  struct s3c_sdhci_platdata s3c_hsmmc0_def_platdata = {
> -	.max_width	= 4,
> -	.host_caps	= (MMC_CAP_4_BIT_DATA |
> -			   MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED),
> +	.max_width		= 4,
> +	.host_caps		= (MMC_CAP_4_BIT_DATA |
> +				  MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED),
> +	.clk_parent_name	= "dout_mpll",
> +	.clk_source_name 	= "mmc_bus",
> +	.clk_speed		= 50*MHZ,
>  };
>  
>  struct platform_device s3c_device_hsmmc0 = {
> -- 
> 1.5.3.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.


From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH 5/8] s3c6410: sdhci: Removing unused host_caps entry from sdhci0 platform data
Date: Wed, 16 Sep 2009 01:50:41 +0100
Message-ID: <20090916005041.GS13508@trinity.fluff.org>
References: <1252392910-31200-1-git-send-email-thomas.ab@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from trinity.fluff.org ([89.16.178.74]:47305 "EHLO trinity.fluff.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751665AbZIPAui (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 15 Sep 2009 20:50:38 -0400
Content-Disposition: inline
In-Reply-To: <1252392910-31200-1-git-send-email-thomas.ab@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: thomas.ab@samsung.com
Cc: ben-linux@fluff.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Sep 08, 2009 at 03:55:10PM +0900, thomas.ab@samsung.com wrote:
> From: Thomas Abraham <thomas.ab@samsung.com>
> 
> This patch removes the unused 'host_caps' entry from the sdhci0
> platform data.

Hmm, I guess we can sort out the capabilities from the information
supplied elsewhere in the platfor data.

Please merge the changes into one patch with the remvoal of the field
from the platform data.
 
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> ---
>  arch/arm/plat-s3c/dev-hsmmc.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/plat-s3c/dev-hsmmc.c b/arch/arm/plat-s3c/dev-hsmmc.c
> index 357ec60..647ca09 100644
> --- a/arch/arm/plat-s3c/dev-hsmmc.c
> +++ b/arch/arm/plat-s3c/dev-hsmmc.c
> @@ -39,8 +39,6 @@ static u64 s3c_device_hsmmc_dmamask = 0xffffffffUL;
>  
>  struct s3c_sdhci_platdata s3c_hsmmc0_def_platdata = {
>  	.max_width		= 4,
> -	.host_caps		= (MMC_CAP_4_BIT_DATA |
> -				  MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED),
>  	.clk_parent_name	= "dout_mpll",
>  	.clk_source_name 	= "mmc_bus",
>  	.clk_speed		= 50*MHZ,
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


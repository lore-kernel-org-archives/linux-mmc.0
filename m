From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH] mmc: change CONFIG of MMC_SDHCI based drivers from
 'bool' to 'tristate'
Date: Mon, 28 Mar 2011 22:38:07 +0800
Message-ID: <20110328143806.GC18721@S2100-06.ap.freescale.net>
References: <1300114465-3769-1-git-send-email-shawn.guo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe002.messaging.microsoft.com ([216.32.180.12]:6880 "EHLO
	VA3EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754082Ab1C1Og7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Mar 2011 10:36:59 -0400
Content-Disposition: inline
In-Reply-To: <1300114465-3769-1-git-send-email-shawn.guo@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, cjb@laptop.org

Hi Chris,

Any comment on this one?

-- 
Regards,
Shawn

On Mon, Mar 14, 2011 at 10:54:25PM +0800, Shawn Guo wrote:
> The MMC_SDHCI based driver is either based on MMC_SDHCI_PLTFM or
> MMC_SDHCI_OF.  As both parent CONFIG are 'tristate', it may make
> sense to get all children drivers CONFIG as 'tristate'.
> 
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> ---
>  drivers/mmc/host/Kconfig |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index afe8c6f..f98adbf 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -91,7 +91,7 @@ config MMC_SDHCI_OF
>  	  If unsure, say N.
>  
>  config MMC_SDHCI_OF_ESDHC
> -	bool "SDHCI OF support for the Freescale eSDHC controller"
> +	tristate "SDHCI OF support for the Freescale eSDHC controller"
>  	depends on MMC_SDHCI_OF
>  	depends on PPC_OF
>  	select MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER
> @@ -101,7 +101,7 @@ config MMC_SDHCI_OF_ESDHC
>  	  If unsure, say N.
>  
>  config MMC_SDHCI_OF_HLWD
> -	bool "SDHCI OF support for the Nintendo Wii SDHCI controllers"
> +	tristate "SDHCI OF support for the Nintendo Wii SDHCI controllers"
>  	depends on MMC_SDHCI_OF
>  	depends on PPC_OF
>  	select MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER
> @@ -124,7 +124,7 @@ config MMC_SDHCI_PLTFM
>  	  If unsure, say N.
>  
>  config MMC_SDHCI_CNS3XXX
> -	bool "SDHCI support on the Cavium Networks CNS3xxx SoC"
> +	tristate "SDHCI support on the Cavium Networks CNS3xxx SoC"
>  	depends on ARCH_CNS3XXX
>  	depends on MMC_SDHCI_PLTFM
>  	help
> @@ -133,7 +133,7 @@ config MMC_SDHCI_CNS3XXX
>  	  If unsure, say N.
>  
>  config MMC_SDHCI_ESDHC_IMX
> -	bool "SDHCI platform support for the Freescale eSDHC i.MX controller"
> +	tristate "SDHCI platform support for the Freescale eSDHC i.MX controller"
>  	depends on MMC_SDHCI_PLTFM && (ARCH_MX25 || ARCH_MX35 || ARCH_MX5)
>  	select MMC_SDHCI_IO_ACCESSORS
>  	help
> @@ -143,7 +143,7 @@ config MMC_SDHCI_ESDHC_IMX
>  	  If unsure, say N.
>  
>  config MMC_SDHCI_DOVE
> -	bool "SDHCI support on Marvell's Dove SoC"
> +	tristate "SDHCI support on Marvell's Dove SoC"
>  	depends on ARCH_DOVE
>  	depends on MMC_SDHCI_PLTFM
>  	select MMC_SDHCI_IO_ACCESSORS
> -- 
> 1.7.1
> 


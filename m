From: Scott Wood <scottwood@freescale.com>
Subject: Re: [v4, 5/6] mmc: kconfig: select FSL_GUTS for MMC_SDHCI_OF_ESDHC
Date: Mon, 14 Dec 2015 16:14:19 -0600
Message-ID: <1450131259.15946.392.camel@freescale.com>
References: <1450067067-44869-1-git-send-email-yangbo.lu@freescale.com>
	 <1450067067-44869-6-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bl2on0118.outbound.protection.outlook.com ([65.55.169.118]:52352
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932273AbbLNWOt (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Dec 2015 17:14:49 -0500
In-Reply-To: <1450067067-44869-6-git-send-email-yangbo.lu@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yangbo Lu <yangbo.lu@freescale.com>, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Cc: X.Xie@freescale.com, LeoLi@freescale.com

On Mon, 2015-12-14 at 12:24 +0800, Yangbo Lu wrote:
> The sdhci-of-esdhc driver needs the GUTS driver support
> to access the global utilities registers for SVR value.
> So we select FSL_GUTS for MMC_SDHCI_OF_ESDHC here.
> 
> Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
> ---
> Changes for v2:
> 	- None
> Changes for v3:
> 	- None
> Changes for v4:
> 	- Added this patch
> ---
>  drivers/mmc/host/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 1526b8a..df57c14 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -142,6 +142,8 @@ config MMC_SDHCI_OF_ESDHC
>  	depends on MMC_SDHCI_PLTFM
>  	depends on PPC || ARCH_MXC || ARCH_LAYERSCAPE
>  	select MMC_SDHCI_IO_ACCESSORS
> +	select SOC_FSL
> +	select FSL_GUTS
>  	help
>  	  This selects the Freescale eSDHC controller support.
>  

What is "SOC_FSL"?  If you mean "FSL_SOC", why are you selecting it?

-Scott


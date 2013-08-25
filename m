From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc:host: Remove a duplicate line in Makefile
Date: Sat, 24 Aug 2013 22:52:43 -0400
Message-ID: <871u5itrb8.fsf@octavius.laptop.org>
References: <1374032299-21996-1-git-send-email-wei_wang@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:40877 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754920Ab3HYCww (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 24 Aug 2013 22:52:52 -0400
In-Reply-To: <1374032299-21996-1-git-send-email-wei_wang@realsil.com.cn> (wei
	wang's message of "Wed, 17 Jul 2013 11:38:19 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: wei_wang@realsil.com.cn
Cc: devel@linuxdriverproject.org, linux-mmc@vger.kernel.org, rogerable@realtek.com

Hi Wei,

On Tue, Jul 16 2013, wei_wang@realsil.com.cn wrote:
> From: Wei WANG <wei_wang@realsil.com.cn>
>
> Signed-off-by: Wei WANG <wei_wang@realsil.com.cn>
> ---
>  drivers/mmc/host/Makefile |    2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index d422e21..c41d0c3 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -52,8 +52,6 @@ obj-$(CONFIG_MMC_WMT)		+= wmt-sdmmc.o
>  
>  obj-$(CONFIG_MMC_REALTEK_PCI)	+= rtsx_pci_sdmmc.o
>  
> -obj-$(CONFIG_MMC_REALTEK_PCI)	+= rtsx_pci_sdmmc.o
> -
>  obj-$(CONFIG_MMC_SDHCI_PLTFM)		+= sdhci-pltfm.o
>  obj-$(CONFIG_MMC_SDHCI_CNS3XXX)		+= sdhci-cns3xxx.o
>  obj-$(CONFIG_MMC_SDHCI_ESDHC_IMX)	+= sdhci-esdhc-imx.o

Thanks, pushed to mmc-next for 3.12.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>

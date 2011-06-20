From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mmc: add dependence in Kconfig for pxav2/pxav3
Date: Mon, 20 Jun 2011 10:07:33 +0200
Message-ID: <201106201007.33908.arnd@arndb.de>
References: <1308552287-18752-1-git-send-email-zhangfei.gao@marvell.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:55431 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751540Ab1FTIH7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jun 2011 04:07:59 -0400
In-Reply-To: <1308552287-18752-1-git-send-email-zhangfei.gao@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhangfei Gao <zhangfei.gao@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Stephen Rothwell <sfr@canb.auug.org.au>

On Monday 20 June 2011 08:44:47 Zhangfei Gao wrote:
>         Without depends, MMC_SDHCI_PXAV3/2 can be chosen in other platfrom.
>         Build error will occur since plat/sdhci.h is located at arch/arm/plat-pxa/
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
> ---
>  drivers/mmc/host/Kconfig |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 198ddda..d33a3e2 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -183,6 +183,7 @@ config MMC_SDHCI_S3C
>  
>  config MMC_SDHCI_PXAV3
>         tristate "Marvell MMP2 SD Host Controller support (PXAV3)"
> +       depends on ARCH_MMP
>         select MMC_SDHCI
>         select MMC_SDHCI_PLTFM
>         default CPU_MMP2

Why not just move the header file to include/linux/platform_data/?

Then you can build the driver on all platforms, which improves the
build test coverage.

	Arnd

From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH] SDHCI: add no hi-speed bit quirk support
Date: Mon, 07 Jun 2010 17:02:39 +0900
Message-ID: <003e01cb0617$cff27920$6fd76b60$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:52187 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755329Ab0FGICm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Jun 2010 04:02:42 -0400
Received: from epmmp2 (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Sun Java(tm) System Messaging Server 7u3-15.01 64bit (built Feb 12 2010))
 with ESMTP id <0L3M00F4DX0G0MB0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 07 Jun 2010 17:02:40 +0900 (KST)
Received: from kgenekim ([12.23.103.96])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0L3M00F0EX0GUN@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 07 Jun 2010 17:02:40 +0900 (KST)
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: kyungmin.park@samsung.com
Cc: linux-mmc@vger.kernel.org

Kyungmin Park wrote:
>
> Some SDHCI controllr like s5pc110 doesn't have HISPD bit at HOSTCTL
register.
> 
typo

> Signed-off-by: Kyungmin Park <kyungmin.park <at> samsung.com>
> ---
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index c6d1bd8..cba08ce 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1164,7 +1164,8 @@ static void sdhci_set_ios(struct mmc_host *mmc,
struct mmc_ios *ios)
>  	else
>  		ctrl &= ~SDHCI_CTRL_4BITBUS;
> 
> -	if (ios->timing == MMC_TIMING_SD_HS)
> +	if (ios->timing == MMC_TIMING_SD_HS &&
> +	    !(host->quirks & SDHCI_QUIRK_NO_HISPD_BIT))

host->quirks |= SDHCI_QURIK_NO_HISPD_BIT missed in
drivers/mmc/host/sdhci-s3c.c

>  		ctrl |= SDHCI_CTRL_HISPD;
>  	else
>  		ctrl &= ~SDHCI_CTRL_HISPD;
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index c846813..a78152d 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -240,6 +240,8 @@ struct sdhci_host {
>  #define SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN		(1<<25)
>  /* Controller cannot support End Attribute in NOP ADMA descriptor */
>  #define SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC		(1<<26)
> +/* Controller doesn't have HISPD bit field in HI-SPEED SD card */
> +#define SDHCI_QUIRK_NO_HISPD_BIT			(1<<27)
> 
>  	int			irq;		/* Device IRQ */
>  	void __iomem *		ioaddr;		/* Mapped address */

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.


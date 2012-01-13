From: Huang Changming-R66093 <r66093@freescale.com>
Subject: RE: [PATCH 1/5 v2] ESDHC: add PIO mode support
Date: Fri, 13 Jan 2012 02:35:57 +0000
Message-ID: <8A2FC72B45BB5A4C9F801431E06AE48F11669338@039-SN1MPN1-005.039d.mgd.msft.net>
References: <1325827997-27490-1-git-send-email-r66093@freescale.com>
 <1325827997-27490-2-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from db3ehsobe001.messaging.microsoft.com ([213.199.154.139]:26160
	"EHLO DB3EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757177Ab2AMCgB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 12 Jan 2012 21:36:01 -0500
In-Reply-To: <1325827997-27490-2-git-send-email-r66093@freescale.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Anton Vorontsov <cbouatmailru@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi, Anton,
Could you have any comment about this serial patch?

Thanks
Jerry Huang
> -----Original Message-----
> From: Huang Changming-R66093
> Sent: Friday, January 06, 2012 1:33 PM
> To: linux-mmc@vger.kernel.org
> Cc: Huang Changming-R66093; Gao Guanhua-B22826; Chris Ball
> Subject: [PATCH 1/5 v2] ESDHC: add PIO mode support
> 
> From: Jerry Huang <Chang-Ming.Huang@freescale.com>
> 
> For some FSL ESDHC controller(e.g. P2020E, Rev1.0), the SDHC can not work
> on DMA mode because of the hardware bug, so we set a broken dma flag and
> use PIO mode.
> 
> Signed-off-by: Gao Guanhua <B22826@freescale.com>
> Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> CC: Chris Ball <cjb@laptop.org>
> ---
> changes for v2:
> 	- change the property to compatible for quirks
> 
>  drivers/mmc/host/sdhci-pltfm.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-
> pltfm.c index a9e12ea..ba36c36 100644
> --- a/drivers/mmc/host/sdhci-pltfm.c
> +++ b/drivers/mmc/host/sdhci-pltfm.c
> @@ -2,7 +2,7 @@
>   * sdhci-pltfm.c Support for SDHCI platform devices
>   * Copyright (c) 2009 Intel Corporation
>   *
> - * Copyright (c) 2007 Freescale Semiconductor, Inc.
> + * Copyright (c) 2007, 2011 Freescale Semiconductor, Inc.
>   * Copyright (c) 2009 MontaVista Software, Inc.
>   *
>   * Authors: Xiaobo Xie <X.Xie@freescale.com> @@ -71,6 +71,9 @@ void
> sdhci_get_of_property(struct platform_device *pdev)
>  		if (sdhci_of_wp_inverted(np))
>  			host->quirks |= SDHCI_QUIRK_INVERTED_WRITE_PROTECT;
> 
> +		if (of_device_is_compatible(np, "fsl,p2020-rev1-esdhc"))
> +			host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
> +
>  		clk = of_get_property(np, "clock-frequency", &size);
>  		if (clk && size == sizeof(*clk) && *clk)
>  			pltfm_host->clock = be32_to_cpup(clk);
> --
> 1.7.5.4



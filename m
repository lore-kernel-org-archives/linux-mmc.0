From: Huang Changming-R66093 <r66093@freescale.com>
Subject: RE: [PATCH 2/5 v2] ESDHC: set the timeout to the max value
Date: Fri, 13 Jan 2012 02:36:21 +0000
Message-ID: <8A2FC72B45BB5A4C9F801431E06AE48F1166934E@039-SN1MPN1-005.039d.mgd.msft.net>
References: <1325827997-27490-1-git-send-email-r66093@freescale.com>
 <1325827997-27490-2-git-send-email-r66093@freescale.com>
 <1325827997-27490-3-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from db3ehsobe001.messaging.microsoft.com ([213.199.154.139]:26425
	"EHLO DB3EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757177Ab2AMCgZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 12 Jan 2012 21:36:25 -0500
In-Reply-To: <1325827997-27490-3-git-send-email-r66093@freescale.com>
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
> Cc: Huang Changming-R66093; Gao Guanhua-B22826; Xie Xiaobo-R63061; Chris
> Ball
> Subject: [PATCH 2/5 v2] ESDHC: set the timeout to the max value
> 
> From: Jerry Huang <Chang-Ming.Huang@freescale.com>
> 
> When access the card on some FSL platform board (e.g p2020, p1010,
> mpc8536), the following error is reported with the timeout value
> calculated:
> 
> mmc0: Got data interrupt 0x00000020 even though no data operation was in
> progress.
> mmc0: Got data interrupt 0x00000020 even though no data operation was in
> progress.
> 
> So we skip the calculation of timeout and use the max value to fix it.
> 
> Signed-off-by: Gao Guanhua <B22826@freescale.com>
> Signed-off-by: Xie Xiaobo <X.Xie@freescale.com>
> Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> CC: Chris Ball <cjb@laptop.org>
> ---
> changes for v2:
> 	- change the property to compatible for quirks
> 
>  drivers/mmc/host/sdhci-pltfm.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-
> pltfm.c index ba36c36..1c254b1 100644
> --- a/drivers/mmc/host/sdhci-pltfm.c
> +++ b/drivers/mmc/host/sdhci-pltfm.c
> @@ -74,6 +74,11 @@ void sdhci_get_of_property(struct platform_device
> *pdev)
>  		if (of_device_is_compatible(np, "fsl,p2020-rev1-esdhc"))
>  			host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
> 
> +		if (of_device_is_compatible(np, "fsl,p2020-esdhc")
> +			|| of_device_is_compatible(np, "fsl,p1010-esdhc")
> +			|| of_device_is_compatible(np, "fsl,mpc8536-esdhc"))
> +			host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
> +
>  		clk = of_get_property(np, "clock-frequency", &size);
>  		if (clk && size == sizeof(*clk) && *clk)
>  			pltfm_host->clock = be32_to_cpup(clk);
> --
> 1.7.5.4



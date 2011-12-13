From: Huang Changming-R66093 <r66093@freescale.com>
Subject: RE: [PATCH] mmc: sdhci-pltfm: Added sdhci-adjust-timeout quirk
Date: Tue, 13 Dec 2011 08:00:19 +0000
Message-ID: <8A2FC72B45BB5A4C9F801431E06AE48F11644C44@039-SN1MPN1-006.039d.mgd.msft.net>
References: <y> <1323075320-9138-1-git-send-email-X.Xie@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from am1ehsobe002.messaging.microsoft.com ([213.199.154.205]:57000
	"EHLO AM1EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751872Ab1LMIAY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 13 Dec 2011 03:00:24 -0500
In-Reply-To: <1323075320-9138-1-git-send-email-X.Xie@freescale.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Cc: "avorontsov@ru.mvista.com" <avorontsov@ru.mvista.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Xie Xiaobo-R63061 <r63061@freescale.com>

Xiaobo, I have one other similar patch, but the property is 'sdhci,adjust-timeout'.
Maybe I can repost it with add your signed-off-by?

> -----Original Message-----
> From: linuxppc-dev-bounces+r66093=freescale.com@lists.ozlabs.org
> [mailto:linuxppc-dev-bounces+r66093=freescale.com@lists.ozlabs.org] On
> Behalf Of Xie Xiaobo
> Sent: Monday, December 05, 2011 4:55 PM
> To: linuxppc-dev@lists.ozlabs.org
> Cc: avorontsov@ru.mvista.com; linux-mmc@vger.kernel.org; Xie Xiaobo-
> R63061
> Subject: [PATCH] mmc: sdhci-pltfm: Added sdhci-adjust-timeout quirk
> 
> Some controller provides an incorrect timeout value for transfers,
> So it need the quirk to adjust timeout value to 0xE.
> E.g. eSDHC of MPC8536, P1010, and P2020.
> 
> Signed-off-by: Xie Xiaobo <X.Xie@freescale.com>
> ---
>  drivers/mmc/host/sdhci-pltfm.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-
> pltfm.c
> index a9e12ea..b5d6b3f 100644
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
>   * Authors: Xiaobo Xie <X.Xie@freescale.com>
> @@ -68,6 +68,9 @@ void sdhci_get_of_property(struct platform_device *pdev)
>  		if (of_get_property(np, "sdhci,1-bit-only", NULL))
>  			host->quirks |= SDHCI_QUIRK_FORCE_1_BIT_DATA;
> 
> +		if (of_get_property(np, "sdhci,sdhci-adjust-timeout", NULL))
> +			host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
> +
>  		if (sdhci_of_wp_inverted(np))
>  			host->quirks |= SDHCI_QUIRK_INVERTED_WRITE_PROTECT;
> 
> --
> 1.6.4
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev



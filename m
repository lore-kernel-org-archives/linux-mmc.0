From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v2 0/5] mmc: sdhci-esdhc-imx: add runtime pm support
Date: Tue, 5 Nov 2013 10:03:37 +0800
Message-ID: <20131105020335.GC19770@S2101-09.ap.freescale.net>
References: <1383554309-29065-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from am1ehsobe005.messaging.microsoft.com ([213.199.154.208]:29531
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750798Ab3KECDF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Nov 2013 21:03:05 -0500
Content-Disposition: inline
In-Reply-To: <1383554309-29065-1-git-send-email-b29396@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <b29396@freescale.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, cjb@laptop.org, s.hauer@pengutronix.de, ulf.hansson@linaro.org

On Mon, Nov 04, 2013 at 04:38:24PM +0800, Dong Aisheng wrote:
> We disable root clock in runtime pm to save power.
> 
> Patch 2~4 are some fixes needed for enable runtime pm or it may
> break the UHS cards(SD3.0/eMMC4.5).
> 
> Below are some tests result i ran which passed mmc_test tool after enable rpm:
> SDHC UHS1 on imx6q sabreauto
> eMMC 4.5 on imx6sl evk
> SDXC UHS1 on imx6sl evk
> eMMC DDR on imx6q sabresd
> SDHC on imx6q sabresd
> 
> ChangeLog:
> v1->v2: only patch 5 changed. Add pm_runtime_set_active
> 	based on Ulf's comments.
> 
> Dong Aisheng (5):
>   mmc: sdhci-pltfm: export pltfm suspend/resume api
>   mmc: sdhci-esdhc-imx: tuning bits should not be cleared during reset
>   mmc: sdhci-esdhc-imx: clear SDHCI_CTRL_EXEC_TUNING should not affect
>     other bits
>   mmc: sdhci-esdhc-imx: fix runtime pm unblance issue
>   mmc: sdhci-esdhc-imx: add runtime pm support

For the series,

Acked-by: Shawn Guo <shawn.guo@linaro.org>


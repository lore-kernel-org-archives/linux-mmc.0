From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH v3 0/4] Extend sdhci-esdhc-imx card_detect and
 write_protect support for mx5
Date: Tue, 21 Jun 2011 09:39:06 +0800
Message-ID: <20110621013905.GB6294@S2101-09.ap.freescale.net>
References: <1308566325-11600-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe001.messaging.microsoft.com ([216.32.180.11]:9482 "EHLO
	VA3EHSOBE008.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932079Ab1FUB3B (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jun 2011 21:29:01 -0400
Content-Disposition: inline
In-Reply-To: <1308566325-11600-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnaud Patard <arnaud.patard@rtp-net.org>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Wolfram Sang <w.sang@pengutronix.de>, Eric Benard <eric@eukrea.com>, linux-arm-kernel@lists.infradead.org, patches@linaro.org

Hi Arnaud,

Would you please give a test on the series, as it fixed the issue
you reported?  TIA.

-- 
Regards,
Shawn

On Mon, Jun 20, 2011 at 06:38:41PM +0800, Shawn Guo wrote:
> The card-present polling for sdhci based driver is very expensive
> in terms of the impact to system performance.  We observe a few
> system performance issues from Freescale and Linaro on mx5 platforms,
> which have been proved card polling related.
> 
> The patch set extends the current sdhci-esdhc-imx card_detect and
> write_protect support to cover mx5 platforms, and solves above
> performance issues.
> 
> Changes since v2:
>  * Fix the issue reported by Arnaud Patard:
>    http://article.gmane.org/gmane.linux.ports.arm.kernel/120790
> 
> Changes since v1:
>  * Rebase on today's linux-next
>  * Take the suggestion from Arnaud Patard to add default pdata in
>    imx_add_sdhci_esdhc_imx(), to avoid touching every single board
>    file for the platform_data changes
>  * Add comment for sdhci.c change
>  * Change ESDHC_CD(WP)_SIGNAL to ESDHC_CD(WP)_CONTROLLER for a more
>    descriptive name
>  * Add missing NONE case handling in esdhc_pltfm_get_ro
>  * Improve a couple comment wording per suggestion from Wolfram Sang
> 
> Shawn Guo (4):
>       mmc: sdhci: fix interrupt storm from card detection
>       mmc: sdhci-esdhc-imx: SDHCI_CARD_PRESENT does not get cleared
>       mmc: sdhci-esdhc-imx: remove "WP" from flag ESDHC_FLAG_GPIO_FOR_CD_WP
>       mmc: sdhci-esdhc-imx: extend card_detect and write_protect support for mx5
> 
>  arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c     |    3 +-
>  arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c     |    3 +-
>  arch/arm/mach-imx/mach-mx25_3ds.c                  |    2 +
>  arch/arm/mach-imx/mach-pcm043.c                    |    2 +
>  arch/arm/mach-mx5/board-mx51_babbage.c             |   14 +-
>  arch/arm/mach-mx5/board-mx53_loco.c                |    4 +
>  .../plat-mxc/devices/platform-sdhci-esdhc-imx.c    |   12 ++
>  arch/arm/plat-mxc/include/mach/esdhc.h             |   25 +++-
>  drivers/mmc/host/sdhci-esdhc-imx.c                 |  136 ++++++++++++--------
>  drivers/mmc/host/sdhci.c                           |   27 ++++-
>  10 files changed, 161 insertions(+), 67 deletions(-)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


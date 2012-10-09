From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] mmc: mxs: fix build regression from mismerge
Date: Tue, 9 Oct 2012 15:37:23 +0000
Message-ID: <201210091537.23659.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:63045 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754063Ab2JIPh3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Oct 2012 11:37:29 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Attila Kinali <attila@kinali.ch>, Lauri Hintsala <lauri.hintsala@bluegiga.com>, Marek Vasut <marex@denx.de>, Chris Ball <cjb@laptop.org>, Shawn Guo <shawn.guo@linaro.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>

>From all I can tell, the patches

fc108d24 "mmc: mxs-mmc: fix deadlock caused by recursion loop"
829c1bf4 "mmc: spi: Pull out parts shared between MMC and SPI"

came in through separate branches and cause this build error when
combined.

drivers/mmc/host/mxs-mmc.c: In function 'mxs_mmc_enable_sdio_irq':
drivers/mmc/host/mxs-mmc.c:527:78: error: 'struct mxs_mmc_host' has no member named 'base'
drivers/mmc/host/mxs-mmc.c:527:95: error: 'struct mxs_mmc_host' has no member named 'devid'

This does the obvious missing change.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Attila Kinali <attila@kinali.ch>
Cc: Lauri Hintsala <lauri.hintsala@bluegiga.com>
Cc: Marek Vasut <marex@denx.de>
Cc: Chris Ball <cjb@laptop.org>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index bb4c2bf..80d1e6d 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -525,7 +525,7 @@ static void mxs_mmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
 		writel(BM_SSP_CTRL0_SDIO_IRQ_CHECK,
 		       ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_SET);
 		writel(BM_SSP_CTRL1_SDIO_IRQ_EN,
-		       host->base + HW_SSP_CTRL1(host) + STMP_OFFSET_REG_SET);
+		       ssp->base + HW_SSP_CTRL1(ssp) + STMP_OFFSET_REG_SET);
 	} else {
 		writel(BM_SSP_CTRL0_SDIO_IRQ_CHECK,
 		       ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_CLR);

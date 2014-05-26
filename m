From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCHv5] mmc: remove MMC_CAP_ERASE to enable trim in eMMC/SD Device
Date: Mon, 26 May 2014 17:29:19 +0900
Message-ID: <1401092960-16547-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:17566 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751518AbaEZI3Z (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 26 May 2014 04:29:25 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N6600JMBA8ZQV70@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 26 May 2014 17:29:23 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Seungwon Jeon <tgih.jun@samsung.com>, Linus Walleij <linus.walleij@linaro.org>, Gwendal Grignou <gwendal@chromium.org>, Grant Grundler <grundler@chromium.org>, Puthikorn Voravootivat <puthik@chromium.org>

From: Puthikorn Voravootivat <puthik@chromium.org>

Remove MMC_CAP_ERASE from all host as it does not make
sense that the eMMC/SD device erase feature should be
controlled by the host cap. This make trim and/or discard
feature usable in the supported eMMC/SD device.

Signed-off-by: Puthikorn Voravootivat <puthik@chromium.org>
Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
---
v5 change:
Rebased on latest mmc-next.

v4 change:
Change commit message to mention SD cards.

v3 change:
As suggested by Jaehoon, this patch remove MMC_CAP_ERASE instead of
force enable it.

v2 change:
Instead of add MMC_CAP_ERASE just only for dw_mmc, this patch adds
this capability to all host.

 arch/arm/mach-ux500/board-mop500-sdi.c |    3 ---
 drivers/mmc/core/core.c                |    6 ++----
 drivers/mmc/host/omap_hsmmc.c          |    2 +-
 drivers/mmc/host/sdhci.c               |    2 +-
 include/linux/mmc/host.h               |    1 -
 5 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500-sdi.c b/arch/arm/mach-ux500/board-mop500-sdi.c
index fcbf3a1..6d9feb8 100644
--- a/arch/arm/mach-ux500/board-mop500-sdi.c
+++ b/arch/arm/mach-ux500/board-mop500-sdi.c
@@ -48,7 +48,6 @@ struct mmci_platform_data mop500_sdi0_data = {
 	.capabilities	= MMC_CAP_4_BIT_DATA |
 				MMC_CAP_SD_HIGHSPEED |
 				MMC_CAP_MMC_HIGHSPEED |
-				MMC_CAP_ERASE |
 				MMC_CAP_UHS_SDR12 |
 				MMC_CAP_UHS_SDR25,
 	.gpio_wp	= -1,
@@ -119,7 +118,6 @@ struct mmci_platform_data mop500_sdi2_data = {
 				MMC_CAP_8_BIT_DATA |
 				MMC_CAP_NONREMOVABLE |
 				MMC_CAP_MMC_HIGHSPEED |
-				MMC_CAP_ERASE |
 				MMC_CAP_CMD23,
 	.gpio_cd	= -1,
 	.gpio_wp	= -1,
@@ -154,7 +152,6 @@ struct mmci_platform_data mop500_sdi4_data = {
 				MMC_CAP_8_BIT_DATA |
 				MMC_CAP_NONREMOVABLE |
 				MMC_CAP_MMC_HIGHSPEED |
-				MMC_CAP_ERASE |
 				MMC_CAP_CMD23,
 	.gpio_cd	= -1,
 	.gpio_wp	= -1,
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 7dc0c85..e80daad 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2008,8 +2008,7 @@ int mmc_erase(struct mmc_card *card, unsigned int from, unsigned int nr,
 {
 	unsigned int rem, to = from + nr;
 
-	if (!(card->host->caps & MMC_CAP_ERASE) ||
-	    !(card->csd.cmdclass & CCC_ERASE))
+	if (!(card->csd.cmdclass & CCC_ERASE))
 		return -EOPNOTSUPP;
 
 	if (!card->erase_size)
@@ -2063,8 +2062,7 @@ EXPORT_SYMBOL(mmc_erase);
 
 int mmc_can_erase(struct mmc_card *card)
 {
-	if ((card->host->caps & MMC_CAP_ERASE) &&
-	    (card->csd.cmdclass & CCC_ERASE) && card->erase_size)
+	if ((card->csd.cmdclass & CCC_ERASE) && card->erase_size)
 		return 1;
 	return 0;
 }
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 6b7b755..d5b1286 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1964,7 +1964,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	mmc->max_seg_size = mmc->max_req_size;
 
 	mmc->caps |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
-		     MMC_CAP_WAIT_WHILE_BUSY | MMC_CAP_ERASE;
+		     MMC_CAP_WAIT_WHILE_BUSY;
 
 	mmc->caps |= mmc_slot(host).caps;
 	if (mmc->caps & MMC_CAP_8_BIT_DATA)
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 47055f3..edf8134 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2926,7 +2926,7 @@ int sdhci_add_host(struct sdhci_host *host)
 
 	mmc->max_busy_timeout = (1 << 27) / host->timeout_clk;
 
-	mmc->caps |= MMC_CAP_SDIO_IRQ | MMC_CAP_ERASE | MMC_CAP_CMD23;
+	mmc->caps |= MMC_CAP_SDIO_IRQ | MMC_CAP_CMD23;
 	mmc->caps2 |= MMC_CAP2_SDIO_IRQ_NOTHREAD;
 
 	if (host->quirks & SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12)
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 7960424..d626a89 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -242,7 +242,6 @@ struct mmc_host {
 #define MMC_CAP_AGGRESSIVE_PM	(1 << 7)	/* Suspend (e)MMC/SD at idle  */
 #define MMC_CAP_NONREMOVABLE	(1 << 8)	/* Nonremovable e.g. eMMC */
 #define MMC_CAP_WAIT_WHILE_BUSY	(1 << 9)	/* Waits while card is busy */
-#define MMC_CAP_ERASE		(1 << 10)	/* Allow erase/trim commands */
 #define MMC_CAP_1_8V_DDR	(1 << 11)	/* can support */
 						/* DDR mode at 1.8V */
 #define MMC_CAP_1_2V_DDR	(1 << 12)	/* can support */
-- 
1.7.9.5


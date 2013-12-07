From: <dinguyen@altera.com>
Subject: [PATCHv2 3/3] mmc: dw_mmc-exynos: Remove Exynos' custom prepare_command function
Date: Fri, 6 Dec 2013 21:20:24 -0600
Message-ID: <1386386424-859-4-git-send-email-dinguyen@altera.com>
References: <1386386424-859-1-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db8lp0184.outbound.messaging.microsoft.com ([213.199.154.184]:52637
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751441Ab3LGDWO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Dec 2013 22:22:14 -0500
In-Reply-To: <1386386424-859-1-git-send-email-dinguyen@altera.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinh.linux@gmail.com, arnd@arndb.de, cjb@laptop.org, jh80.chung@samsung.com, tgih.jun@samsung.com, heiko@sntech.de, dianders@chromium.org, alim.akhtar@samsung.com, bzhao@marvell.com
Cc: linux-mmc@vger.kernel.org, Dinh Nguyen <dinguyen@altera.com>

From: Dinh Nguyen <dinguyen@altera.com>

The Exynos prepare_command function is only checking when to set the
SDMMC_CMD_USE_HOLD_REG bit. Now that there is a generic way to check
on when to set SDMMC_CMD_USE_HOLD_REG bit.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
---
v2: none
---
 drivers/mmc/host/dw_mmc-exynos.c |   14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index 3423c5e..8ce24c8 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -167,19 +167,6 @@ static int dw_mci_exynos_resume_noirq(struct device *dev)
 #define dw_mci_exynos_resume_noirq	NULL
 #endif /* CONFIG_PM_SLEEP */
 
-static void dw_mci_exynos_prepare_command(struct dw_mci *host, u32 *cmdr)
-{
-	/*
-	 * Exynos4412 and Exynos5250 extends the use of CMD register with the
-	 * use of bit 29 (which is reserved on standard MSHC controllers) for
-	 * optionally bypassing the HOLD register for command and data. The
-	 * HOLD register should be bypassed in case there is no phase shift
-	 * applied on CMD/DATA that is sent to the card.
-	 */
-	if (SDMMC_CLKSEL_GET_DRV_WD3(mci_readl(host, CLKSEL)))
-		*cmdr |= SDMMC_CMD_USE_HOLD_REG;
-}
-
 static void dw_mci_exynos_set_ios(struct dw_mci *host, struct mmc_ios *ios)
 {
 	struct dw_mci_exynos_priv_data *priv = host->priv;
@@ -397,7 +384,6 @@ static const struct dw_mci_drv_data exynos_drv_data = {
 	.caps			= exynos_dwmmc_caps,
 	.init			= dw_mci_exynos_priv_init,
 	.setup_clock		= dw_mci_exynos_setup_clock,
-	.prepare_command	= dw_mci_exynos_prepare_command,
 	.set_ios		= dw_mci_exynos_set_ios,
 	.parse_dt		= dw_mci_exynos_parse_dt,
 	.execute_tuning		= dw_mci_exynos_execute_tuning,
-- 
1.7.9.5



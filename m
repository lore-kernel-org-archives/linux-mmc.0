From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH] mmc: tmio: don't wait on R-Car2+ when handling the clock
Date: Wed, 28 Jun 2017 17:23:11 +0200
Message-ID: <20170628152311.18935-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:56841 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751547AbdF1PXS (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 28 Jun 2017 11:23:18 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Dirk Behme <dirk.behme@de.bosch.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>

Our hardware engineers confirmed that it is unnecessary to wait when
turning the clock on/off. The documentation was a tad vague, so we
used to play safe.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Tested on H2 and M3-W. Based on top of mmc/next with Simon's Gen3 DMA patches.

 drivers/mmc/host/tmio_mmc_core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 77e7b56a909933..1851c883bfc82a 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -207,7 +207,10 @@ static void tmio_mmc_clk_start(struct tmio_mmc_host *host)
 {
 	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, CLK_CTL_SCLKEN |
 		sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
-	msleep(host->pdata->flags & TMIO_MMC_MIN_RCAR2 ? 1 : 10);
+
+	/* HW engineers overrode docs: no sleep needed on R-Car2+ */
+	if (!(host->pdata->flags & TMIO_MMC_MIN_RCAR2))
+		msleep(10);
 
 	if (host->pdata->flags & TMIO_MMC_HAVE_HIGH_REG) {
 		sd_ctrl_write16(host, CTL_CLK_AND_WAIT_CTL, 0x0100);
@@ -224,7 +227,10 @@ static void tmio_mmc_clk_stop(struct tmio_mmc_host *host)
 
 	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
 		sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
-	msleep(host->pdata->flags & TMIO_MMC_MIN_RCAR2 ? 5 : 10);
+
+	/* HW engineers overrode docs: no sleep needed on R-Car2+ */
+	if (!(host->pdata->flags & TMIO_MMC_MIN_RCAR2))
+		msleep(10);
 }
 
 static void tmio_mmc_set_clock(struct tmio_mmc_host *host,
-- 
2.11.0


From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH V2] mmc: renesas_sdhi_core: on R-Car 2+, make use of CBSY bit
Date: Wed, 28 Jun 2017 17:21:56 +0200
Message-ID: <20170628152156.18881-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:56830 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751511AbdF1PWF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 28 Jun 2017 11:22:05 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Dirk Behme <dirk.behme@de.bosch.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>

Most registers need to wait until the command is completed, not
necessarily until the bus is free. At least, R-Car 2+ SoCs can signal
that via the CBSY bit, so let's use it there instead of SCLKDIVEN to
save a little bit of delay.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Tested on H2 and M3-W.

Change since V1:

Rebased on top of mmc/next with Simon's Gen3 DMA patches.

 drivers/mmc/host/renesas_sdhi_core.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 569bcdd5e6537a..be806d3e9afeec 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -398,12 +398,14 @@ static void renesas_sdhi_hw_reset(struct tmio_mmc_host *host)
 		       sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_RVSCNTL));
 }
 
-static int renesas_sdhi_wait_idle(struct tmio_mmc_host *host)
+static int renesas_sdhi_wait_idle(struct tmio_mmc_host *host, u32 bit)
 {
 	int timeout = 1000;
+	/* CBSY is set when busy, SCLKDIVEN is cleared when busy */
+	u32 wait_state = (bit == TMIO_STAT_CMD_BUSY ? TMIO_STAT_CMD_BUSY : 0);
 
-	while (--timeout && !(sd_ctrl_read16_and_16_as_32(host, CTL_STATUS)
-			      & TMIO_STAT_SCLKDIVEN))
+	while (--timeout && (sd_ctrl_read16_and_16_as_32(host, CTL_STATUS)
+			      & bit) == wait_state)
 		udelay(1);
 
 	if (!timeout) {
@@ -416,17 +418,22 @@ static int renesas_sdhi_wait_idle(struct tmio_mmc_host *host)
 
 static int renesas_sdhi_write16_hook(struct tmio_mmc_host *host, int addr)
 {
+	u32 bit = TMIO_STAT_SCLKDIVEN;
+
 	switch (addr) {
 	case CTL_SD_CMD:
 	case CTL_STOP_INTERNAL_ACTION:
 	case CTL_XFER_BLK_COUNT:
-	case CTL_SD_CARD_CLK_CTL:
 	case CTL_SD_XFER_LEN:
 	case CTL_SD_MEM_CARD_OPT:
 	case CTL_TRANSACTION_CTL:
 	case CTL_DMA_ENABLE:
 	case EXT_ACC:
-		return renesas_sdhi_wait_idle(host);
+		if (host->pdata->flags & TMIO_MMC_MIN_RCAR2)
+			bit = TMIO_STAT_CMD_BUSY;
+		/* fallthrough */
+	case CTL_SD_CARD_CLK_CTL:
+		return renesas_sdhi_wait_idle(host, bit);
 	}
 
 	return 0;
-- 
2.11.0


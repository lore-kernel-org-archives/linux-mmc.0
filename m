From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 4/9] mmc: tmio: add flag to reduce delay after changing clock status
Date: Mon, 25 Jan 2016 20:15:11 +0100
Message-ID: <1453749316-1848-5-git-send-email-wsa@the-dreams.de>
References: <1453749316-1848-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:33075 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757858AbcAYTPZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 25 Jan 2016 14:15:25 -0500
In-Reply-To: <1453749316-1848-1-git-send-email-wsa@the-dreams.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Dirk Behme <dirk.behme@gmail.com>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

The docs for RCar Gen2 & 3 I have access to, mention delays of 5ms after
stop and 1ms after start. Make it possible to apply these values.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/tmio_mmc_pio.c | 7 ++++---
 include/linux/mfd/tmio.h        | 4 ++++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index a10fde40b6c3dd..ffff687e98b1e3 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -172,7 +172,8 @@ static void tmio_mmc_set_clock(struct tmio_mmc_host *host,
 		host->set_clk_div(host->pdev, (clk>>22) & 1);
 
 	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, clk & 0x1ff);
-	msleep(10);
+	if (!(host->pdata->flags & TMIO_MMC_FAST_CLK_CHG))
+		msleep(10);
 }
 
 static void tmio_mmc_clk_stop(struct tmio_mmc_host *host)
@@ -185,14 +186,14 @@ static void tmio_mmc_clk_stop(struct tmio_mmc_host *host)
 
 	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~0x0100 &
 		sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
-	msleep(10);
+	msleep(host->pdata->flags & TMIO_MMC_FAST_CLK_CHG ? 5 : 10);
 }
 
 static void tmio_mmc_clk_start(struct tmio_mmc_host *host)
 {
 	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, 0x0100 |
 		sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
-	msleep(10);
+	msleep(host->pdata->flags & TMIO_MMC_FAST_CLK_CHG ? 1 : 10);
 
 	/* implicit BUG_ON(!res) */
 	if (host->pdata->flags & TMIO_MMC_HAVE_HIGH_REG) {
diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
index 24b86d538e8852..05d58ee5e6a78f 100644
--- a/include/linux/mfd/tmio.h
+++ b/include/linux/mfd/tmio.h
@@ -65,6 +65,10 @@
  * Some controllers can support SDIO IRQ signalling.
  */
 #define TMIO_MMC_SDIO_IRQ		(1 << 2)
+
+/* Some controllers don't need to wait 10ms for clock changes */
+#define TMIO_MMC_FAST_CLK_CHG		(1 << 3)
+
 /*
  * Some controllers require waiting for the SD bus to become
  * idle before writing to some registers.
-- 
2.1.4


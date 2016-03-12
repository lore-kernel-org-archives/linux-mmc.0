From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 05/10] mmc: tmio: always start clock after frequency calculation
Date: Sat, 12 Mar 2016 10:15:07 +0100
Message-ID: <1457774112-16958-6-git-send-email-wsa@the-dreams.de>
References: <1457774112-16958-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:48796 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752098AbcCLJPb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 12 Mar 2016 04:15:31 -0500
In-Reply-To: <1457774112-16958-1-git-send-email-wsa@the-dreams.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-mmc@vger.kernel.org, Dirk Behme <dirk.behme@gmail.com>, Ben Hutchings <ben.hutchings@codethink.co.uk>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Starting the clock is always done after frequency change, so we can do
it directly after the clock calculation. This is the first part of doing
proper clock de-/activation at calculation time.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

New patch, was not in RFC.

 drivers/mmc/host/tmio_mmc_pio.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 4b5a7af2d2273f..e773969970e51b 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -154,6 +154,18 @@ static void tmio_mmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
 	}
 }
 
+static void tmio_mmc_clk_start(struct tmio_mmc_host *host)
+{
+	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, CLK_CTL_SCLKEN |
+		sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
+	msleep(host->pdata->flags & TMIO_MMC_FAST_CLK_CHG ? 1 : 10);
+
+	if (host->pdata->flags & TMIO_MMC_HAVE_HIGH_REG) {
+		sd_ctrl_write16(host, CTL_CLK_AND_WAIT_CTL, 0x0100);
+		msleep(10);
+	}
+}
+
 static void tmio_mmc_set_clock(struct tmio_mmc_host *host,
 				unsigned int new_clock)
 {
@@ -182,6 +194,8 @@ static void tmio_mmc_set_clock(struct tmio_mmc_host *host,
 	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, clk & CLK_CTL_DIV_MASK);
 	if (!(host->pdata->flags & TMIO_MMC_FAST_CLK_CHG))
 		msleep(10);
+
+	tmio_mmc_clk_start(host);
 }
 
 static void tmio_mmc_clk_stop(struct tmio_mmc_host *host)
@@ -196,18 +210,6 @@ static void tmio_mmc_clk_stop(struct tmio_mmc_host *host)
 	msleep(host->pdata->flags & TMIO_MMC_FAST_CLK_CHG ? 5 : 10);
 }
 
-static void tmio_mmc_clk_start(struct tmio_mmc_host *host)
-{
-	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, CLK_CTL_SCLKEN |
-		sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
-	msleep(host->pdata->flags & TMIO_MMC_FAST_CLK_CHG ? 1 : 10);
-
-	if (host->pdata->flags & TMIO_MMC_HAVE_HIGH_REG) {
-		sd_ctrl_write16(host, CTL_CLK_AND_WAIT_CTL, 0x0100);
-		msleep(10);
-	}
-}
-
 static void tmio_mmc_reset(struct tmio_mmc_host *host)
 {
 	/* FIXME - should we set stop clock reg here */
@@ -955,14 +957,12 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		tmio_mmc_clk_stop(host);
 		break;
 	case MMC_POWER_UP:
-		tmio_mmc_set_clock(host, ios->clock);
 		tmio_mmc_power_on(host, ios->vdd);
-		tmio_mmc_clk_start(host);
+		tmio_mmc_set_clock(host, ios->clock);
 		tmio_mmc_set_bus_width(host, ios->bus_width);
 		break;
 	case MMC_POWER_ON:
 		tmio_mmc_set_clock(host, ios->clock);
-		tmio_mmc_clk_start(host);
 		tmio_mmc_set_bus_width(host, ios->bus_width);
 		break;
 	}
@@ -1281,10 +1281,8 @@ int tmio_mmc_host_runtime_resume(struct device *dev)
 	tmio_mmc_reset(host);
 	tmio_mmc_clk_enable(host);
 
-	if (host->clk_cache) {
+	if (host->clk_cache)
 		tmio_mmc_set_clock(host, host->clk_cache);
-		tmio_mmc_clk_start(host);
-	}
 
 	tmio_mmc_enable_dma(host, true);
 
-- 
2.7.0


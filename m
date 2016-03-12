From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 06/10] mmc: tmio: stop clock when 0Hz is requested
Date: Sat, 12 Mar 2016 10:15:08 +0100
Message-ID: <1457774112-16958-7-git-send-email-wsa@the-dreams.de>
References: <1457774112-16958-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1457774112-16958-1-git-send-email-wsa@the-dreams.de>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-mmc@vger.kernel.org, Dirk Behme <dirk.behme@gmail.com>, Ben Hutchings <ben.hutchings@codethink.co.uk>
List-Id: linux-mmc@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Setting frequency to 0 is not enough, the clock explicitly has to be
disabled. Otherwise voltage switching (which needs SDCLK to be quiet)
fails for various cards.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

New patch, was not in RFC.

 drivers/mmc/host/tmio_mmc_pio.c | 50 +++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index e773969970e51b..8dee637638c31e 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -166,25 +166,39 @@ static void tmio_mmc_clk_start(struct tmio_mmc_host *host)
 	}
 }
 
+static void tmio_mmc_clk_stop(struct tmio_mmc_host *host)
+{
+	if (host->pdata->flags & TMIO_MMC_HAVE_HIGH_REG) {
+		sd_ctrl_write16(host, CTL_CLK_AND_WAIT_CTL, 0x0000);
+		msleep(10);
+	}
+
+	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
+		sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
+	msleep(host->pdata->flags & TMIO_MMC_FAST_CLK_CHG ? 5 : 10);
+}
+
 static void tmio_mmc_set_clock(struct tmio_mmc_host *host,
 				unsigned int new_clock)
 {
 	u32 clk = 0, clock;
 
-	if (new_clock) {
-		if (host->clk_update)
-			clock = host->clk_update(host, new_clock) / 512;
-		else
-			clock = host->mmc->f_min;
+	if (new_clock == 0) {
+		tmio_mmc_clk_stop(host);
+		return;
+	}
 
-		for (clk = 0x80000080; new_clock >= (clock << 1); clk >>= 1)
-			clock <<= 1;
+	if (host->clk_update)
+		clock = host->clk_update(host, new_clock) / 512;
+	else
+		clock = host->mmc->f_min;
 
-		/* 1/1 clock is option */
-		if ((host->pdata->flags & TMIO_MMC_CLK_ACTUAL) &&
-		   ((clk >> 22) & 0x1))
-			clk |= 0xff;
-	}
+	for (clk = 0x80000080; new_clock >= (clock << 1); clk >>= 1)
+		clock <<= 1;
+
+	/* 1/1 clock is option */
+	if ((host->pdata->flags & TMIO_MMC_CLK_ACTUAL) && ((clk >> 22) & 0x1))
+		clk |= 0xff;
 
 	if (host->set_clk_div)
 		host->set_clk_div(host->pdev, (clk >> 22) & 1);
@@ -198,18 +212,6 @@ static void tmio_mmc_set_clock(struct tmio_mmc_host *host,
 	tmio_mmc_clk_start(host);
 }
 
-static void tmio_mmc_clk_stop(struct tmio_mmc_host *host)
-{
-	if (host->pdata->flags & TMIO_MMC_HAVE_HIGH_REG) {
-		sd_ctrl_write16(host, CTL_CLK_AND_WAIT_CTL, 0x0000);
-		msleep(10);
-	}
-
-	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
-		sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
-	msleep(host->pdata->flags & TMIO_MMC_FAST_CLK_CHG ? 5 : 10);
-}
-
 static void tmio_mmc_reset(struct tmio_mmc_host *host)
 {
 	/* FIXME - should we set stop clock reg here */
-- 
2.7.0

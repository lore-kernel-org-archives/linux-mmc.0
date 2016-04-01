From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH v2 5/9] mmc: tmio: stop clock when 0Hz is requested
Date: Fri,  1 Apr 2016 17:44:35 +0200
Message-ID: <1459525479-20842-6-git-send-email-wsa@the-dreams.de>
References: <1459525479-20842-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:60306 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753736AbcDAPpI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 1 Apr 2016 11:45:08 -0400
In-Reply-To: <1459525479-20842-1-git-send-email-wsa@the-dreams.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-renesas-soc@vger.kernel.org, Ben Hutchings <ben.hutchings@codethink.co.uk>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Setting frequency to 0 is not enough, the clock explicitly has to be
disabled. Otherwise voltage switching (which needs SDCLK to be quiet)
fails for various cards.

Because we now do the 'new_clock == 0' check right at the beginning,
the indentation level of the rest of the code can be decreased a little.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/tmio_mmc_pio.c | 50 +++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index a05938da049bd6..8e2fef7c5e481c 100644
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


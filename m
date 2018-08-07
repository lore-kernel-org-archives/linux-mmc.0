From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [v0.1 PATCH 5/7] mmc: renesas_sdhi: merge clk_{start,stop} functions to set_clock
Date: Tue,  7 Aug 2018 15:17:20 +0900
Message-ID: <1533622642-13989-6-git-send-email-yamada.masahiro@socionext.com>
References: <1533622642-13989-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533622642-13989-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-renesas-soc@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Jassi Brar <jaswinder.singh@linaro.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

renesas_sdhi_clk_start() and renesas_sdhi_clk_stop() are now only
called from renesas_sdhi_set_clock().  Merge them.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mmc/host/renesas_sdhi_core.c | 39 +++++++++++-------------------------
 1 file changed, 12 insertions(+), 27 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 1f4c82e..a15fb2e 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -155,35 +155,16 @@ static unsigned int renesas_sdhi_clk_update(struct tmio_mmc_host *host,
 	return ret == 0 ? best_freq : clk_get_rate(priv->clk);
 }
 
-static void renesas_sdhi_clk_start(struct tmio_mmc_host *host)
-{
-	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, CLK_CTL_SCLKEN |
-		sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
-
-	/* HW engineers overrode docs: no sleep needed on R-Car2+ */
-	if (!(host->pdata->flags & TMIO_MMC_MIN_RCAR2))
-		usleep_range(10000, 11000);
-}
-
-static void renesas_sdhi_clk_stop(struct tmio_mmc_host *host)
-{
-	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
-		sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
-
-	/* HW engineers overrode docs: no sleep needed on R-Car2+ */
-	if (!(host->pdata->flags & TMIO_MMC_MIN_RCAR2))
-		usleep_range(10000, 11000);
-}
-
 static void renesas_sdhi_set_clock(struct tmio_mmc_host *host,
 				   unsigned int new_clock)
 {
 	u32 clk = 0, clock;
 
-	if (new_clock == 0) {
-		renesas_sdhi_clk_stop(host);
-		return;
-	}
+	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
+		sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
+
+	if (new_clock == 0)
+		goto out;
 
 	clock = renesas_sdhi_clk_update(host, new_clock) / 512;
 
@@ -194,13 +175,17 @@ static void renesas_sdhi_set_clock(struct tmio_mmc_host *host,
 	if ((host->pdata->flags & TMIO_MMC_CLK_ACTUAL) && ((clk >> 22) & 0x1))
 		clk |= 0xff;
 
-	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
-			sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
 	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, clk & CLK_CTL_DIV_MASK);
 	if (!(host->pdata->flags & TMIO_MMC_MIN_RCAR2))
 		usleep_range(10000, 11000);
 
-	renesas_sdhi_clk_start(host);
+	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, CLK_CTL_SCLKEN |
+		sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
+
+out:
+	/* HW engineers overrode docs: no sleep needed on R-Car2+ */
+	if (!(host->pdata->flags & TMIO_MMC_MIN_RCAR2))
+		usleep_range(10000, 11000);
 }
 
 static void renesas_sdhi_clk_disable(struct tmio_mmc_host *host)
-- 
2.7.4

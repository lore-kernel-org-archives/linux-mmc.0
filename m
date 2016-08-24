From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 1/2] mmc: host: sh_mobile_sdhi: move card_busy from tmio to sdhi
Date: Wed, 24 Aug 2016 11:34:37 +0200
Message-ID: <20160824093438.2478-2-wsa+renesas@sang-engineering.com>
References: <20160824093438.2478-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20160824093438.2478-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-mmc@vger.kernel.org

card_busy is only used/tested on SDHI for R-Car Gen2 and later.
Move it to the SDHI driver, so we can then activate it conditionally
depending on the SDHI type.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/sh_mobile_sdhi.c | 8 ++++++++
 drivers/mmc/host/tmio_mmc.h       | 1 +
 drivers/mmc/host/tmio_mmc_pio.c   | 9 +--------
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index c3b651bf89cb4a..c4e63b7790d719 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -213,6 +213,13 @@ static void sh_mobile_sdhi_clk_disable(struct tmio_mmc_host *host)
 	clk_disable_unprepare(priv->clk);
 }
 
+static int sh_mobile_sdhi_card_busy(struct mmc_host *mmc)
+{
+	struct tmio_mmc_host *host = mmc_priv(mmc);
+
+	return !(sd_ctrl_read16_and_16_as_32(host, CTL_STATUS) & TMIO_STAT_DAT0);
+}
+
 static int sh_mobile_sdhi_start_signal_voltage_switch(struct mmc_host *mmc,
 						      struct mmc_ios *ios)
 {
@@ -369,6 +376,7 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 	host->clk_update	= sh_mobile_sdhi_clk_update;
 	host->clk_disable	= sh_mobile_sdhi_clk_disable;
 	host->multi_io_quirk	= sh_mobile_sdhi_multi_io_quirk;
+	host->card_busy	= sh_mobile_sdhi_card_busy;
 	host->start_signal_voltage_switch = sh_mobile_sdhi_start_signal_voltage_switch;
 
 	/* Orginally registers were 16 bit apart, could be 32 or 64 nowadays */
diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 7f63ec05bdf41d..1f1cb2628f673b 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -158,6 +158,7 @@ struct tmio_mmc_host {
 	void (*clk_disable)(struct tmio_mmc_host *host);
 	int (*multi_io_quirk)(struct mmc_card *card,
 			      unsigned int direction, int blk_size);
+	int (*card_busy)(struct mmc_host *mmc);
 	int (*start_signal_voltage_switch)(struct mmc_host *mmc,
 					   struct mmc_ios *ios);
 };
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 92467efc4e2c9e..192817850dffac 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -960,20 +960,12 @@ static int tmio_multi_io_quirk(struct mmc_card *card,
 	return blk_size;
 }
 
-static int tmio_mmc_card_busy(struct mmc_host *mmc)
-{
-	struct tmio_mmc_host *host = mmc_priv(mmc);
-
-	return !(sd_ctrl_read16_and_16_as_32(host, CTL_STATUS) & TMIO_STAT_DAT0);
-}
-
 static struct mmc_host_ops tmio_mmc_ops = {
 	.request	= tmio_mmc_request,
 	.set_ios	= tmio_mmc_set_ios,
 	.get_ro         = tmio_mmc_get_ro,
 	.get_cd		= mmc_gpio_get_cd,
 	.enable_sdio_irq = tmio_mmc_enable_sdio_irq,
-	.card_busy	= tmio_mmc_card_busy,
 	.multi_io_quirk	= tmio_multi_io_quirk,
 };
 
@@ -1072,6 +1064,7 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
 		goto host_free;
 	}
 
+	tmio_mmc_ops.card_busy = _host->card_busy;
 	tmio_mmc_ops.start_signal_voltage_switch = _host->start_signal_voltage_switch;
 	mmc->ops = &tmio_mmc_ops;
 
-- 
2.9.3

From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH v3 1/2] mmc: tmio: add eMMC HS400 mode support
Date: Tue, 13 Feb 2018 13:33:57 +0100
Message-ID: <20180213123358.13212-2-horms+renesas@verge.net.au>
References: <20180213123358.13212-1-horms+renesas@verge.net.au>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20180213123358.13212-1-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

From: Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>

This patch adds processing for selecting HS400 mode.

Signed-off-by: Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
v3 [Simon Horman]
* Consolidate disable_scc and reset_hs400_mode into reset_hs400_tuning
  callback

v2 [Simon Horman]
* Updated to new version of BSP patch from BSP v3.6.0
* Dropped 4 and 8 tap differentiation as all SoCs currently supported
  by the driver in upstream use 4 taps for HS400.
* Minor cleanup

v1 [Simon Horman]
* Combined patches by Ai Kyuse and Masaharu Hayakawa.
* Rebase
* Minor clean-up

v0 [Masaharu Hayakawa]
---
 drivers/mmc/host/tmio_mmc.h      |  5 +++++
 drivers/mmc/host/tmio_mmc_core.c | 24 ++++++++++++++++++++++--
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index e7d651352dc9..bac620109a90 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -46,6 +46,7 @@
 #define CTL_DMA_ENABLE 0xd8
 #define CTL_RESET_SD 0xe0
 #define CTL_VERSION 0xe2
+#define CTL_SDIF_MODE 0xe6
 #define CTL_SDIO_REGS 0x100
 #define CTL_CLK_AND_WAIT_CTL 0x138
 #define CTL_RESET_SDIO 0x1e0
@@ -191,6 +192,10 @@ struct tmio_mmc_host {
 	/* Tuning values: 1 for success, 0 for failure */
 	DECLARE_BITMAP(taps, BITS_PER_BYTE * sizeof(long));
 	unsigned int tap_num;
+	unsigned long tap_set;
+
+	void (*prepare_hs400_tuning)(struct mmc_host *mmc, struct mmc_ios *ios);
+	void (*reset_hs400_tuning)(struct mmc_host *mmc);
 
 	const struct tmio_mmc_dma_ops *dma_ops;
 };
diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 33494241245a..889b4d43085b 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -199,6 +199,13 @@ static void tmio_mmc_set_clock(struct tmio_mmc_host *host,
 		tmio_mmc_clk_stop(host);
 		return;
 	}
+	/*
+	 * Both HS400 and HS200/SD104 set 200MHz, but some devices need to
+	 * set 400MHz to distinguish the CPG settings in HS400.
+	 */
+	if (host->mmc->ios.timing == MMC_TIMING_MMC_HS400 &&
+	    new_clock == 200000000)
+		new_clock = 400000000;
 
 	if (host->clk_update)
 		clock = host->clk_update(host, new_clock) / 512;
@@ -209,8 +216,13 @@ static void tmio_mmc_set_clock(struct tmio_mmc_host *host,
 		clock <<= 1;
 
 	/* 1/1 clock is option */
-	if ((host->pdata->flags & TMIO_MMC_CLK_ACTUAL) && ((clk >> 22) & 0x1))
-		clk |= 0xff;
+	if ((host->pdata->flags & TMIO_MMC_CLK_ACTUAL) &&
+	    ((clk >> 22) & 0x1)) {
+		if (!(host->mmc->ios.timing == MMC_TIMING_MMC_HS400))
+			clk |= 0xff;
+		else
+			clk &= ~0xff;
+	}
 
 	if (host->set_clk_div)
 		host->set_clk_div(host->pdev, (clk >> 22) & 1);
@@ -1001,6 +1013,9 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	struct device *dev = &host->pdev->dev;
 	unsigned long flags;
 
+	if (host->reset_hs400_tuning)
+		host->reset_hs400_tuning(mmc);
+
 	mutex_lock(&host->ios_lock);
 
 	spin_lock_irqsave(&host->lock, flags);
@@ -1051,6 +1066,11 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 			"%s.%d: IOS interrupted: clk %u, mode %u",
 			current->comm, task_pid_nr(current),
 			ios->clock, ios->power_mode);
+
+	/* HS400 Register setting */
+	if (ios->timing == MMC_TIMING_MMC_HS400 && host->prepare_hs400_tuning)
+		host->prepare_hs400_tuning(mmc, ios);
+
 	host->mrq = NULL;
 
 	host->clk_cache = ios->clock;
-- 
2.11.0

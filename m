From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH/RFT 1/3] mmc: tmio: Add eMMC HS400 mode support
Date: Tue,  5 Dec 2017 13:37:54 +0100
Message-ID: <20171205123756.18424-2-horms+renesas@verge.net.au>
References: <20171205123756.18424-1-horms+renesas@verge.net.au>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:60439 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752562AbdLEMiL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Dec 2017 07:38:11 -0500
In-Reply-To: <20171205123756.18424-1-horms+renesas@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Ai Kyuse <ai.kyuse.uw@renesas.com>, Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>, Simon Horman <horms+renesas@verge.net.au>

From: Ai Kyuse <ai.kyuse.uw@renesas.com>

Add eMMC HS400 support to the core TMIO code.

Regarding tuning: Tune in HS200 mode before changing to HS400 mode.  When
retuning, return to HS200 mode and tune.  HS400 and HS200/SDR104 have
different CPG settings, HS400 sets to 400MHz to distinguish the CPG
settings.

Signed-off-by: Ai Kyuse <ai.kyuse.uw@renesas.com>
Signed-off-by: Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
v1 [Simon Horman]
- Combined patches by Ai Kyuse and Masaharu Hayakawa.
- Rebase
- Minor clean-up

v0 [Ai Kyuse]
---
 drivers/mmc/host/tmio_mmc.h      |  5 +++++
 drivers/mmc/host/tmio_mmc_core.c | 29 +++++++++++++++++++++++++++--
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 3e6ff8921440..60f5935db368 100644
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
@@ -203,6 +204,10 @@ struct tmio_mmc_host {
 	/* Tuning values: 1 for success, 0 for failure */
 	DECLARE_BITMAP(taps, BITS_PER_BYTE * sizeof(long));
 	unsigned int tap_num;
+	unsigned long tap_set;
+	void (*prepare_hs400_tuning)(struct mmc_host *mmc, struct mmc_ios *ios);
+	void (*reset_hs400_mode)(struct mmc_host *mmc);
+	void (*disable_scc)(struct mmc_host *mmc);
 
 	const struct tmio_mmc_dma_ops *dma_ops;
 };
diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index d6ca57be16c2..a65c10302904 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -199,6 +199,13 @@ static void tmio_mmc_set_clock(struct tmio_mmc_host *host,
 		tmio_mmc_clk_stop(host);
 		return;
 	}
+	/*
+	 * Both HS400 and HS200/SD104 set 200MHz, but HS400 sets 400MHz
+	 * to distinguish the CPG settings.
+	 */
+	if (host->mmc->ios.timing == MMC_TIMING_MMC_HS400 &&
+			new_clock == 200000000)
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
@@ -1015,6 +1027,15 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	struct device *dev = &host->pdev->dev;
 	unsigned long flags;
 
+
+	if (ios->timing != MMC_TIMING_UHS_SDR104 &&
+	    ios->timing != MMC_TIMING_MMC_HS200 &&
+	    ios->timing != MMC_TIMING_MMC_HS400 && host->disable_scc)
+		host->disable_scc(mmc);
+
+	if (ios->timing != MMC_TIMING_MMC_HS400 && host->reset_hs400_mode)
+		host->reset_hs400_mode(mmc);
+
 	mutex_lock(&host->ios_lock);
 
 	spin_lock_irqsave(&host->lock, flags);
@@ -1065,6 +1086,10 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 			"%s.%d: IOS interrupted: clk %u, mode %u",
 			current->comm, task_pid_nr(current),
 			ios->clock, ios->power_mode);
+
+	if (ios->timing == MMC_TIMING_MMC_HS400 && host->prepare_hs400_tuning)
+		host->prepare_hs400_tuning(mmc, ios);
+
 	host->mrq = NULL;
 
 	host->clk_cache = ios->clock;
-- 
2.11.0


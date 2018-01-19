From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH v2 2/3] mmc: tmio: add eMMC HS400 mode support
Date: Fri, 19 Jan 2018 14:39:05 +0100
Message-ID: <20180119133906.11280-3-horms+renesas@verge.net.au>
References: <20180119133906.11280-1-horms+renesas@verge.net.au>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:47838 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754771AbeASNjV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Jan 2018 08:39:21 -0500
In-Reply-To: <20180119133906.11280-1-horms+renesas@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org

From: Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>

This patch adds processing for selecting HS400 mode.

Signed-off-by: Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
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
I believe that this is a pre-requisite for enabling HS400 as with HS400
enabled but without this patch I see:

* M3-W ES1.0 / Salvator-X

[    1.812758] renesas_sdhi_internal_dmac ee100000.sd: Got CD GPIO
[    1.818778] renesas_sdhi_internal_dmac ee100000.sd: Got WP GPIO
[    1.874951] renesas_sdhi_internal_dmac ee140000.sd: mmc0 base at 0xee140000 max clock rate 200 MHz
[    1.884950] renesas_sdhi_internal_dmac ee160000.sd: Got CD GPIO
[    1.891088] renesas_sdhi_internal_dmac ee160000.sd: Got WP GPIO
[    2.083508] mmc0: new HS400 MMC card at address 0001
[    2.084827] mmcblk0: mmc0:0001 eMMC   28.8 GiB
[    2.085234] mmcblk0boot0: mmc0:0001 eMMC   partition 1 4.00 MiB
[    2.085727] mmcblk0boot1: mmc0:0001 eMMC   partition 2 4.00 MiB
[    2.086398] mmcblk0rpmb: mmc0:0001 eMMC   partition 3 4.00 MiB, chardev (243:0)
[    2.097926]  mmcblk0: p1
[    2.360533] renesas_sdhi_internal_dmac ee100000.sd: Got CD GPIO
[    2.367633] renesas_sdhi_internal_dmac ee100000.sd: Got WP GPIO
[    2.424700] renesas_sdhi_internal_dmac ee100000.sd: mmc1 base at 0xee100000 max clock rate 200 MHz
[    2.436021] renesas_sdhi_internal_dmac ee160000.sd: Got CD GPIO
[    2.443100] renesas_sdhi_internal_dmac ee160000.sd: Got WP GPIO

* On H3 ES2.0 / Salvator-XS:

[    2.452354] renesas_sdhi_internal_dmac ee100000.sd: Got CD GPIO
[    2.458344] renesas_sdhi_internal_dmac ee100000.sd: Got WP GPIO
[    2.513917] renesas_sdhi_internal_dmac ee140000.sd: mmc0 base at 0xee140000 max clock rate 200 MHz
[    2.523564] renesas_sdhi_internal_dmac ee160000.sd: Got CD GPIO
[    2.529559] renesas_sdhi_internal_dmac ee160000.sd: Got WP GPIO
[    2.636678] renesas_sdhi_internal_dmac ee140000.sd: Tuning procedure failed
[    2.643739] mmc0: tuning execution failed: -5
[    2.648211] mmc0: error -5 whilst initialising MMC card
[    2.730078] renesas_sdhi_internal_dmac ee140000.sd: Tuning procedure failed
[    2.730085] mmc0: tuning execution failed: -5
[    2.730093] mmc0: error -5 whilst initialising MMC card
[    2.858718] renesas_sdhi_internal_dmac ee140000.sd: Tuning procedure failed
[    2.858725] mmc0: tuning execution failed: -5
[    2.858733] mmc0: error -5 whilst initialising MMC card
[    2.991258] renesas_sdhi_internal_dmac ee100000.sd: Got CD GPIO
[    2.998333] renesas_sdhi_internal_dmac ee100000.sd: Got WP GPIO
[    3.063121] renesas_sdhi_internal_dmac ee140000.sd: Tuning procedure failed
[    3.063128] mmc0: tuning execution failed: -5
[    3.063135] mmc0: error -5 whilst initialising MMC card
[    3.085170] renesas_sdhi_internal_dmac ee160000.sd: Got CD GPIO
[    3.092222] renesas_sdhi_internal_dmac ee160000.sd: Got WP GPIO

On H3 ES1.0 / Salvator-X I do not see any problems either with or without
this patch.

To assist testing and review I will make patches, including this one, to
enable HS400 on H3 / Salvator-X, M3-W 1.0 / Salvator-X and
H3 ES2.0 Salvator-XS available at:

https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git topic/hs400-v2
---
 drivers/mmc/host/tmio_mmc.h      |  6 ++++++
 drivers/mmc/host/tmio_mmc_core.c | 28 ++++++++++++++++++++++++++--
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index e7d651352dc9..8f163e7f71e0 100644
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
@@ -191,6 +192,11 @@ struct tmio_mmc_host {
 	/* Tuning values: 1 for success, 0 for failure */
 	DECLARE_BITMAP(taps, BITS_PER_BYTE * sizeof(long));
 	unsigned int tap_num;
+	unsigned long tap_set;
+
+	void (*disable_scc)(struct mmc_host *mmc);
+	void (*prepare_hs400_tuning)(struct mmc_host *mmc, struct mmc_ios *ios);
+	void (*reset_hs400_mode)(struct mmc_host *mmc);
 
 	const struct tmio_mmc_dma_ops *dma_ops;
 };
diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 41767d33ef97..2a84da51b08d 100644
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
@@ -1012,6 +1024,13 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	struct device *dev = &host->pdev->dev;
 	unsigned long flags;
 
+	if (host->disable_scc)
+		host->disable_scc(mmc);
+
+	/* reset HS400 mode */
+	if (ios->timing != MMC_TIMING_MMC_HS400 && host->reset_hs400_mode)
+		host->reset_hs400_mode(mmc);
+
 	mutex_lock(&host->ios_lock);
 
 	spin_lock_irqsave(&host->lock, flags);
@@ -1062,6 +1081,11 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
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


From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 06/41] mmc: host: omap_hsmmc: Add tuning support
Date: Fri, 19 May 2017 13:45:06 +0530
Message-ID: <20170519081541.26753-7-kishon@ti.com>
References: <20170519081541.26753-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170519081541.26753-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jonathan Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, nsekhar@ti.com, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

MMC tuning procedure is required to support SD card
UHS1-SDR104 mode and EMMC HS200 mode.

The tuning function omap_execute_tuning() will only be
called by the MMC/SD core if the corresponding speed modes
are supported by the OMAP silicon which is set in the mmc
host "caps" field.

Add a separate function to set the UHSMS field to one of
SDR104, SDR50, DDR50, SDR25 or SDR12 depending on the
inserted SD card. This is required for tuning to succeed in
the case of SDR104/HS200 or SDR50.

Signed-off-by: Balaji T K <balajitk@ti.com>
[rk@ti.com: disable DEB interrupt during tuning]
Signed-off-by: Ravikumar Kattekola <rk@ti.com>
Signed-off-by: Viswanath Puttagunta <vishp@ti.com>
Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
[kishon@ti.com : cleanup the tuning sequence]
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
[nsekhar@ti.com: add comment for tuning timeout]
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c | 200 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 200 insertions(+)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 77be27c8e18c..d8970a7ff4be 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/slab.h>
 #include <linux/debugfs.h>
 #include <linux/dmaengine.h>
 #include <linux/seq_file.h>
@@ -49,6 +50,7 @@
 /* OMAP HSMMC Host Controller Registers */
 #define OMAP_HSMMC_SYSSTATUS	0x0014
 #define OMAP_HSMMC_CON		0x002C
+#define OMAP_HSMMC_DLL		0x0034
 #define OMAP_HSMMC_SDMASA	0x0100
 #define OMAP_HSMMC_BLK		0x0104
 #define OMAP_HSMMC_ARG		0x0108
@@ -66,6 +68,7 @@
 #define OMAP_HSMMC_ISE		0x0138
 #define OMAP_HSMMC_AC12		0x013C
 #define OMAP_HSMMC_CAPA		0x0140
+#define OMAP_HSMMC_CAPA2	0x0144
 
 #define VS18			(1 << 26)
 #define VS30			(1 << 25)
@@ -114,6 +117,26 @@
 
 /* AC12 */
 #define AC12_V1V8_SIGEN		(1 << 19)
+#define AC12_SCLK_SEL		(1 << 23)
+#define AC12_UHSMC_MASK		(7 << 16)
+#define AC12_UHSMC_SDR12	(0 << 16)
+#define AC12_UHSMC_SDR25	(1 << 16)
+#define AC12_UHSMC_SDR50	(2 << 16)
+#define AC12_UHSMC_SDR104	(3 << 16)
+#define AC12_UHSMC_DDR50	(4 << 16)
+#define AC12_UHSMC_RES		(0x7 << 16)
+
+/* DLL */
+#define DLL_SWT			(1 << 20)
+#define DLL_FORCE_SR_C_SHIFT	13
+#define DLL_FORCE_SR_C_MASK	0x7f
+#define DLL_FORCE_VALUE		(1 << 12)
+#define DLL_CALIB		(1 << 1)
+
+#define MAX_PHASE_DELAY		0x7c
+
+/* CAPA2 */
+#define CAPA2_TSDR50		(1 << 13)
 
 /* Interrupt masks for IE and ISE register */
 #define CC_EN			(1 << 0)
@@ -202,6 +225,7 @@ struct omap_hsmmc_host {
 	unsigned int		dma_sg_idx;
 	unsigned char		bus_mode;
 	unsigned char		power_mode;
+	unsigned char		timing;
 	int			suspended;
 	u32			con;
 	u32			hctl;
@@ -225,6 +249,8 @@ struct omap_hsmmc_host {
 	struct omap_hsmmc_next	next_data;
 	struct	omap_hsmmc_platform_data	*pdata;
 
+	bool			is_tuning;
+
 	/* return MMC cover switch state, can be NULL if not supported.
 	 *
 	 * possible return values:
@@ -243,6 +269,7 @@ struct omap_mmc_of_data {
 
 static void omap_hsmmc_start_dma_transfer(struct omap_hsmmc_host *host);
 static void omap_hsmmc_conf_bus_power(struct omap_hsmmc_host *host, int iov);
+static void omap_hsmmc_disable_tuning(struct omap_hsmmc_host *host);
 
 static int omap_hsmmc_card_detect(struct device *dev)
 {
@@ -610,6 +637,15 @@ static void omap_hsmmc_enable_irq(struct omap_hsmmc_host *host,
 	u32 irq_mask = INT_EN_MASK;
 	unsigned long flags;
 
+	if (host->is_tuning)
+		/*
+		 * OMAP5/DRA74X/DRA72x Errata i802:
+		 * DCRC error interrupts (MMCHS_STAT[21] DCRC=0x1) can occur
+		 * during the tuning procedure. So disable it during the
+		 * tuning procedure.
+		 */
+		irq_mask &= ~(DCRC_EN | DEB_EN);
+
 	if (host->use_dma)
 		irq_mask &= ~(BRR_EN | BWR_EN);
 
@@ -959,6 +995,11 @@ omap_hsmmc_start_command(struct omap_hsmmc_host *host, struct mmc_command *cmd,
 			cmdreg &= ~(DDIR);
 	}
 
+	/* Tuning command is special. Data Present Select should be set */
+	if ((cmd->opcode == MMC_SEND_TUNING_BLOCK) ||
+	    (cmd->opcode == MMC_SEND_TUNING_BLOCK_HS200))
+		cmdreg |= DP_SELECT | DDIR;
+
 	if (host->use_dma)
 		cmdreg |= DMAE;
 
@@ -1667,6 +1708,41 @@ static void omap_hsmmc_request(struct mmc_host *mmc, struct mmc_request *req)
 	omap_hsmmc_start_command(host, req->cmd, req->data);
 }
 
+static void omap_hsmmc_set_timing(struct omap_hsmmc_host *host)
+{
+	u32 val;
+	struct mmc_ios *ios = &host->mmc->ios;
+
+	omap_hsmmc_stop_clock(host);
+
+	val = OMAP_HSMMC_READ(host->base, AC12);
+	val &= ~AC12_UHSMC_MASK;
+	switch (ios->timing) {
+	case MMC_TIMING_UHS_SDR104:
+	case MMC_TIMING_MMC_HS200:
+		val |= AC12_UHSMC_SDR104;
+		break;
+	case MMC_TIMING_UHS_DDR50:
+		val |= AC12_UHSMC_DDR50;
+		break;
+	case MMC_TIMING_UHS_SDR50:
+		val |= AC12_UHSMC_SDR50;
+		break;
+	case MMC_TIMING_UHS_SDR25:
+		val |= AC12_UHSMC_SDR25;
+		break;
+	case MMC_TIMING_UHS_SDR12:
+		val |= AC12_UHSMC_SDR12;
+		break;
+	default:
+		val |= AC12_UHSMC_RES;
+		break;
+	}
+	OMAP_HSMMC_WRITE(host->base, AC12, val);
+
+	omap_hsmmc_start_clock(host);
+}
+
 /* Routine to configure clock values. Exposed API to core */
 static void omap_hsmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
@@ -1676,6 +1752,7 @@ static void omap_hsmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	if (ios->power_mode != host->power_mode) {
 		switch (ios->power_mode) {
 		case MMC_POWER_OFF:
+			omap_hsmmc_disable_tuning(host);
 			omap_hsmmc_set_power(host, 0, 0);
 			break;
 		case MMC_POWER_UP:
@@ -1713,6 +1790,11 @@ static void omap_hsmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	omap_hsmmc_set_clock(host);
 
+	if (ios->timing != host->timing) {
+		omap_hsmmc_set_timing(host);
+		host->timing = ios->timing;
+	}
+
 	if (do_send_init_stream)
 		send_init_stream(host);
 
@@ -2011,6 +2093,122 @@ static int omap_hsmmc_card_busy(struct mmc_host *mmc)
 	return ret;
 }
 
+static inline void omap_hsmmc_set_dll(struct omap_hsmmc_host *host, int count)
+{
+	int i;
+	u32 dll;
+
+	dll = OMAP_HSMMC_READ(host->base, DLL);
+	dll |= DLL_FORCE_VALUE;
+	dll &= ~(DLL_FORCE_SR_C_MASK << DLL_FORCE_SR_C_SHIFT);
+	dll |= (count << DLL_FORCE_SR_C_SHIFT);
+	OMAP_HSMMC_WRITE(host->base, DLL, dll);
+
+	dll |= DLL_CALIB;
+	OMAP_HSMMC_WRITE(host->base, DLL, dll);
+	for (i = 0; i < 1000; i++) {
+		if (OMAP_HSMMC_READ(host->base, DLL) & DLL_CALIB)
+			break;
+	}
+	dll &= ~DLL_CALIB;
+	OMAP_HSMMC_WRITE(host->base, DLL, dll);
+}
+
+static void omap_hsmmc_disable_tuning(struct omap_hsmmc_host *host)
+{
+	int val;
+
+	val = OMAP_HSMMC_READ(host->base, AC12);
+	val &= ~(AC12_SCLK_SEL);
+	OMAP_HSMMC_WRITE(host->base, AC12, val);
+
+	val = OMAP_HSMMC_READ(host->base, DLL);
+	val &= ~(DLL_FORCE_VALUE | DLL_SWT);
+	OMAP_HSMMC_WRITE(host->base, DLL, val);
+}
+
+static int omap_hsmmc_execute_tuning(struct mmc_host *mmc, u32 opcode)
+{
+	u32 val;
+	u8 cur_match, prev_match = 0;
+	int ret;
+	u32 phase_delay = 0;
+	u32 start_window = 0, max_window = 0;
+	u32 length = 0, max_len = 0;
+	struct mmc_ios *ios = &mmc->ios;
+	struct omap_hsmmc_host *host;
+
+	/* clock tuning is not needed for upto 52MHz */
+	if (ios->clock <= OMAP_MMC_MAX_CLOCK)
+		return 0;
+
+	host = mmc_priv(mmc);
+
+	val = OMAP_HSMMC_READ(host->base, CAPA2);
+	if (ios->timing == MMC_TIMING_UHS_SDR50 && !(val & CAPA2_TSDR50))
+		return 0;
+
+	val = OMAP_HSMMC_READ(host->base, DLL);
+	val |= DLL_SWT;
+	OMAP_HSMMC_WRITE(host->base, DLL, val);
+
+	host->is_tuning =  true;
+
+	while (phase_delay <= MAX_PHASE_DELAY) {
+		omap_hsmmc_set_dll(host, phase_delay);
+
+		cur_match = !mmc_send_tuning(mmc, opcode, NULL);
+		if (cur_match) {
+			if (prev_match) {
+				length++;
+			} else {
+				start_window = phase_delay;
+				length = 1;
+			}
+		}
+
+		if (length > max_len) {
+			max_window = start_window;
+			max_len = length;
+		}
+
+		prev_match = cur_match;
+		phase_delay += 4;
+	}
+
+	host->is_tuning = false;
+
+	if (!max_len) {
+		dev_err(mmc_dev(host->mmc), "Unable to find match\n");
+		ret = -EIO;
+		goto tuning_error;
+	}
+
+	val = OMAP_HSMMC_READ(host->base, AC12);
+	if (!(val & AC12_SCLK_SEL)) {
+		ret = -EIO;
+		goto tuning_error;
+	}
+
+	phase_delay = max_window + 4 * ((3 * max_len) >> 2);
+	omap_hsmmc_set_dll(host, phase_delay);
+
+	omap_hsmmc_reset_controller_fsm(host, SRD);
+	omap_hsmmc_reset_controller_fsm(host, SRC);
+
+	return 0;
+
+tuning_error:
+	dev_err(mmc_dev(host->mmc),
+		"Tuning failed. Using fixed sampling clock\n");
+
+	omap_hsmmc_disable_tuning(host);
+	omap_hsmmc_reset_controller_fsm(host, SRD);
+	omap_hsmmc_reset_controller_fsm(host, SRC);
+
+	return ret;
+}
+
 static struct mmc_host_ops omap_hsmmc_ops = {
 	.post_req = omap_hsmmc_post_req,
 	.pre_req = omap_hsmmc_pre_req,
@@ -2022,6 +2220,7 @@ static struct mmc_host_ops omap_hsmmc_ops = {
 	.enable_sdio_irq = omap_hsmmc_enable_sdio_irq,
 	.start_signal_voltage_switch = omap_hsmmc_start_signal_voltage_switch,
 	.card_busy = omap_hsmmc_card_busy,
+	.execute_tuning = omap_hsmmc_execute_tuning,
 };
 
 #ifdef CONFIG_DEBUG_FS
@@ -2229,6 +2428,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	host->mapbase	= res->start + pdata->reg_offset;
 	host->base	= base + pdata->reg_offset;
 	host->power_mode = MMC_POWER_OFF;
+	host->timing	= 0;
 	host->next_data.cookie = 1;
 	host->pbias_enabled = 0;
 	host->vqmmc_enabled = 0;
-- 
2.11.0

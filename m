From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 07/11] mmc: host: omap_hsmmc: add tuning support
Date: Thu, 30 Jul 2015 13:16:30 +0530
Message-ID: <1438242394-25599-8-git-send-email-kishon@ti.com>
References: <1438242394-25599-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438242394-25599-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, ulf.hansson@linaro.org, afenkart@gmail.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: nsekhar@ti.com, kishon@ti.com, mugunthanvnm@ti.com
List-Id: linux-mmc@vger.kernel.org

From: Balaji T K <balajitk@ti.com>

MMC tuning procedure is required to support SD card
UHS1-SDR104 mode and EMMC HS200 mode.

The tuning function omap_execute_tuning() will only
be called by the MMC/SD core if the corresponding
speed modes are supported by the OMAP silicon which
is set in the mmc host "caps" field.

Signed-off-by: Balaji T K <balajitk@ti.com>
Signed-off-by: Viswanath Puttagunta <vishp@ti.com>
Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
[kishon@ti.com : cleanup the tuning sequence]
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |  234 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 232 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index e0bd8df..dcfa92e 100644
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
@@ -114,6 +117,7 @@
 
 /* AC12 */
 #define AC12_V1V8_SIGEN		(1 << 19)
+#define AC12_SCLK_SEL		(1 << 23)
 #define AC12_UHSMC_MASK		(7 << 16)
 #define AC12_UHSMC_SDR12	(0 << 16)
 #define AC12_UHSMC_SDR25	(1 << 16)
@@ -122,6 +126,18 @@
 #define AC12_UHSMC_DDR50	(4 << 16)
 #define AC12_UHSMC_RES		(0x7 << 16)
 
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
+
 /* Interrupt masks for IE and ISE register */
 #define CC_EN			(1 << 0)
 #define TC_EN			(1 << 1)
@@ -201,6 +217,7 @@ struct omap_hsmmc_host {
 	void	__iomem		*base;
 	resource_size_t		mapbase;
 	spinlock_t		irq_lock; /* Prevent races with irq handler */
+	struct completion	buf_ready;
 	unsigned int		dma_len;
 	unsigned int		dma_sg_idx;
 	unsigned char		bus_mode;
@@ -228,6 +245,9 @@ struct omap_hsmmc_host {
 	struct omap_hsmmc_next	next_data;
 	struct	omap_hsmmc_platform_data	*pdata;
 
+	u32			*tuning_data;
+	int			tuning_size;
+
 	/* return MMC cover switch state, can be NULL if not supported.
 	 *
 	 * possible return values:
@@ -244,8 +264,39 @@ struct omap_mmc_of_data {
 	u8 controller_flags;
 };
 
+static const u8 ref_tuning_4bits[] = {
+	0xff, 0x0f, 0xff, 0x00, 0xff, 0xcc, 0xc3, 0xcc,
+	0xc3, 0x3c, 0xcc, 0xff, 0xfe, 0xff, 0xfe, 0xef,
+	0xff, 0xdf, 0xff, 0xdd, 0xff, 0xfb, 0xff, 0xfb,
+	0xbf, 0xff, 0x7f, 0xff, 0x77, 0xf7, 0xbd, 0xef,
+	0xff, 0xf0, 0xff, 0xf0, 0x0f, 0xfc, 0xcc, 0x3c,
+	0xcc, 0x33, 0xcc, 0xcf, 0xff, 0xef, 0xff, 0xee,
+	0xff, 0xfd, 0xff, 0xfd, 0xdf, 0xff, 0xbf, 0xff,
+	0xbb, 0xff, 0xf7, 0xff, 0xf7, 0x7f, 0x7b, 0xde,
+};
+
+static const u8 ref_tuning_8bits[] = {
+	0xff, 0xff, 0x00, 0xff, 0xff, 0xff, 0x00, 0x00,
+	0xff, 0xff, 0xcc, 0xcc, 0xcc, 0x33, 0xcc, 0xcc,
+	0xcc, 0x33, 0x33, 0xcc, 0xcc, 0xcc, 0xff, 0xff,
+	0xff, 0xee, 0xff, 0xff, 0xff, 0xee, 0xee, 0xff,
+	0xff, 0xff, 0xdd, 0xff, 0xff, 0xff, 0xdd, 0xdd,
+	0xff, 0xff, 0xff, 0xbb, 0xff, 0xff, 0xff, 0xbb,
+	0xbb, 0xff, 0xff, 0xff, 0x77, 0xff, 0xff, 0xff,
+	0x77, 0x77, 0xff, 0x77, 0xbb, 0xdd, 0xee, 0xff,
+	0xff, 0xff, 0xff, 0x00, 0xff, 0xff, 0xff, 0x00,
+	0x00, 0xff, 0xff, 0xcc, 0xcc, 0xcc, 0x33, 0xcc,
+	0xcc, 0xcc, 0x33, 0x33, 0xcc, 0xcc, 0xcc, 0xff,
+	0xff, 0xff, 0xee, 0xff, 0xff, 0xff, 0xee, 0xee,
+	0xff, 0xff, 0xff, 0xdd, 0xff, 0xff, 0xff, 0xdd,
+	0xdd, 0xff, 0xff, 0xff, 0xbb, 0xff, 0xff, 0xff,
+	0xbb, 0xbb, 0xff, 0xff, 0xff, 0x77, 0xff, 0xff,
+	0xff, 0x77, 0x77, 0xff, 0x77, 0xbb, 0xdd, 0xee,
+};
+
 static void omap_hsmmc_start_dma_transfer(struct omap_hsmmc_host *host);
 static void omap_hsmmc_conf_bus_power(struct omap_hsmmc_host *host, int iov);
+static void omap_hsmmc_disable_tuning(struct omap_hsmmc_host *host);
 
 static int omap_hsmmc_card_detect(struct device *dev)
 {
@@ -600,8 +651,12 @@ static void omap_hsmmc_enable_irq(struct omap_hsmmc_host *host,
 {
 	u32 irq_mask = INT_EN_MASK;
 	unsigned long flags;
+	bool is_tuning;
 
-	if (host->use_dma)
+	is_tuning = (cmd->opcode == MMC_SEND_TUNING_BLOCK) ||
+		    (cmd->opcode == MMC_SEND_TUNING_BLOCK_HS200);
+
+	if (!is_tuning && host->use_dma)
 		irq_mask &= ~(BRR_EN | BWR_EN);
 
 	/* Disable timeout for erases */
@@ -947,7 +1002,11 @@ omap_hsmmc_start_command(struct omap_hsmmc_host *host, struct mmc_command *cmd,
 			cmdreg &= ~(DDIR);
 	}
 
-	if (host->use_dma)
+	/* Tuning command is special. Data Present Select should be set */
+	if ((cmd->opcode == MMC_SEND_TUNING_BLOCK) ||
+	    (cmd->opcode == MMC_SEND_TUNING_BLOCK_HS200))
+		cmdreg |= DP_SELECT | DDIR;
+	else if (host->use_dma)
 		cmdreg |= DMAE;
 
 	host->req_in_progress = 1;
@@ -1178,6 +1237,7 @@ static void omap_hsmmc_do_irq(struct omap_hsmmc_host *host, int status)
 	struct mmc_data *data;
 	int end_cmd = 0, end_trans = 0;
 	int error = 0;
+	int i;
 
 	data = host->data;
 	dev_vdbg(mmc_dev(host->mmc), "IRQ Status is %x\n", status);
@@ -1213,6 +1273,13 @@ static void omap_hsmmc_do_irq(struct omap_hsmmc_host *host, int status)
 		}
 	}
 
+	if (status & BRR_EN) {
+		for (i = 0; i < host->tuning_size / 4; i++)
+			host->tuning_data[i] =
+				OMAP_HSMMC_READ(host->base, DATA);
+		complete(&host->buf_ready);
+	}
+
 	OMAP_HSMMC_WRITE(host->base, STAT, status);
 	if (end_cmd || ((status & CC_EN) && host->cmd))
 		omap_hsmmc_cmd_done(host, host->cmd);
@@ -1712,6 +1779,7 @@ static void omap_hsmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	if (ios->power_mode != host->power_mode) {
 		switch (ios->power_mode) {
 		case MMC_POWER_OFF:
+			omap_hsmmc_disable_tuning(host);
 			mmc_pdata(host)->set_power(host->dev, 0, 0);
 			break;
 		case MMC_POWER_UP:
@@ -2026,6 +2094,166 @@ static int omap_hsmmc_card_busy(struct mmc_host *mmc)
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
+	const u8 *tuning_ref;
+	struct mmc_ios *ios = &mmc->ios;
+	struct omap_hsmmc_host *host;
+	struct mmc_command cmd = {0};
+	struct mmc_request mrq = {NULL};
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
+	switch (ios->bus_width) {
+	case MMC_BUS_WIDTH_8:
+		tuning_ref = ref_tuning_8bits;
+		host->tuning_size = sizeof(ref_tuning_8bits);
+		break;
+	case MMC_BUS_WIDTH_4:
+		tuning_ref = ref_tuning_4bits;
+		host->tuning_size = sizeof(ref_tuning_4bits);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	host->tuning_data = kzalloc(host->tuning_size, GFP_KERNEL);
+	if (!host->tuning_data)
+		return -ENOMEM;
+
+	val = OMAP_HSMMC_READ(host->base, DLL);
+	val |= DLL_SWT;
+	OMAP_HSMMC_WRITE(host->base, DLL, val);
+
+	while (phase_delay <= MAX_PHASE_DELAY) {
+		omap_hsmmc_set_dll(host, phase_delay);
+
+		cmd.opcode = opcode;
+		cmd.arg = 0;
+		cmd.flags = MMC_RSP_R1 | MMC_CMD_ADTC;
+		cmd.retries = 0;
+		cmd.data = NULL;
+		cmd.error = 0;
+
+		mrq.cmd = &cmd;
+		host->mrq = &mrq;
+		OMAP_HSMMC_WRITE(host->base, BLK, host->tuning_size);
+		set_data_timeout(host, 150000000, 0);
+		omap_hsmmc_start_command(host, &cmd, NULL);
+		host->cmd = NULL;
+		host->mrq = NULL;
+
+		ret = wait_for_completion_timeout(&host->buf_ready,
+						  msecs_to_jiffies(5000));
+		if (ret == 0) {
+			dev_err(mmc_dev(host->mmc), "Tuning BRR timeout");
+			ret = -ETIMEDOUT;
+			goto tuning_error;
+		}
+
+		host->req_in_progress = false;
+
+		cur_match = !memcmp(host->tuning_data, tuning_ref,
+				    host->tuning_size);
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
+	phase_delay = max_window + 4 * (max_len >> 1);
+	omap_hsmmc_set_dll(host, phase_delay);
+
+	omap_hsmmc_reset_controller_fsm(host, SRD);
+	omap_hsmmc_reset_controller_fsm(host, SRC);
+
+	kfree(host->tuning_data);
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
+	kfree(host->tuning_data);
+	return ret;
+}
+
 static struct mmc_host_ops omap_hsmmc_ops = {
 	.post_req = omap_hsmmc_post_req,
 	.pre_req = omap_hsmmc_pre_req,
@@ -2037,6 +2265,7 @@ static struct mmc_host_ops omap_hsmmc_ops = {
 	.enable_sdio_irq = omap_hsmmc_enable_sdio_irq,
 	.start_signal_voltage_switch = omap_hsmmc_start_signal_voltage_switch,
 	.card_busy = omap_hsmmc_card_busy,
+	.execute_tuning = omap_hsmmc_execute_tuning,
 };
 
 #ifdef CONFIG_DEBUG_FS
@@ -2264,6 +2493,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 		mmc->f_max = OMAP_MMC_MAX_CLOCK;
 
 	spin_lock_init(&host->irq_lock);
+	init_completion(&host->buf_ready);
 
 	host->fclk = devm_clk_get(&pdev->dev, "fck");
 	if (IS_ERR(host->fclk)) {
-- 
1.7.9.5

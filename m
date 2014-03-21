From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH 5/7] mmc: dw_mmc: exynos: support eMMC's HS400 mode
Date: Fri, 21 Mar 2014 23:04:27 +0900
Message-ID: <001f01cf450e$78f89750$6ae9c5f0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:26975 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965576AbaCUOE2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Mar 2014 10:04:28 -0400
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <chris@printf.net>, 'Kukjin Kim' <kgene.kim@samsung.com>, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Ulf Hansson' <ulf.hansson@linaro.org>, 'Alim Akhtar' <alim.akhtar@samsung.com>

Implements HS400 support for Exynos's host driver.
And this patch includes some updates as new mode is added.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/host/dw_mmc-exynos.c |  140 +++++++++++++++++++++++++++++++-------
 drivers/mmc/host/dw_mmc-exynos.h |   14 ++++
 drivers/mmc/host/dw_mmc.c        |    3 +-
 3 files changed, 130 insertions(+), 27 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index ce261c8..5c9dc9a 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -40,7 +40,12 @@ struct dw_mci_exynos_priv_data {
 	u32				sdr_timing;
 	u32				ddr_timing;
 	u32				hs200_timing;
+	u32				hs400_timing;
+	u32				tuned_sample;
 	u32				cur_speed;
+	u32				dqs_delay;
+	u32				saved_dqs_en;
+	u32				saved_strobe_ctrl;
 };
 
 static struct dw_mci_exynos_compatible {
@@ -90,6 +95,16 @@ static int dw_mci_exynos_priv_init(struct dw_mci *host)
 			   SDMMC_MPSCTRL_NON_SECURE_WRITE_BIT);
 	}
 
+	if (priv->ctrl_type >= DW_MCI_TYPE_EXYNOS5420) {
+		priv->saved_strobe_ctrl = mci_readl(host, HS400_DLINE_CTRL);
+		priv->saved_dqs_en = mci_readl(host, HS400_DQS_EN);
+		priv->saved_dqs_en |= AXI_NON_BLOCKING_WR;
+		mci_writel(host, HS400_DQS_EN, priv->saved_dqs_en);
+		if (!priv->dqs_delay)
+			priv->dqs_delay =
+				DQS_CTRL_GET_RD_DELAY(priv->saved_strobe_ctrl);
+	}
+
 	priv->ciu_div = dw_mci_exynos_get_ciu_div(host);
 
 	return 0;
@@ -109,6 +124,14 @@ static int dw_mci_exynos_setup_clock(struct dw_mci *host)
 	return 0;
 }
 
+static void dw_mci_exynos_set_clksel_timing(struct dw_mci *host, u32 timing)
+{
+	u32 clksel;
+	clksel = mci_readl(host, CLKSEL);
+	clksel = (clksel & ~SDMMC_CLKSEL_TIMING_MASK) | timing;
+	mci_writel(host, CLKSEL, clksel);
+}
+
 #ifdef CONFIG_PM_SLEEP
 static int dw_mci_exynos_suspend(struct device *dev)
 {
@@ -166,23 +189,39 @@ static void dw_mci_exynos_prepare_command(struct dw_mci *host, u32 *cmdr)
 		*cmdr |= SDMMC_CMD_USE_HOLD_REG;
 }
 
-static void dw_mci_exynos_set_ios(struct dw_mci *host, struct mmc_ios *ios)
+static void dw_mci_exynos_config_hs400(struct dw_mci *host, u32 timing)
 {
 	struct dw_mci_exynos_priv_data *priv = host->priv;
-	unsigned int wanted = ios->clock;
-	unsigned long actual;
+	u32 dqs, strobe;
 
-	if (ios->timing == MMC_TIMING_MMC_HS200) {
-		mci_writel(host, CLKSEL, priv->hs200_timing);
-	} else if (ios->timing == MMC_TIMING_MMC_DDR52) {
-		mci_writel(host, CLKSEL, priv->ddr_timing);
-		/* Should be double rate for DDR mode */
-		if (ios->bus_width == MMC_BUS_WIDTH_8)
-			wanted <<= 1;
+	/*
+	 * Not suppported to configure register
+	 * related to HS400
+	 */
+	if (priv->ctrl_type < DW_MCI_TYPE_EXYNOS5420)
+		return;
+
+	dqs = priv->saved_dqs_en;
+	strobe = priv->saved_strobe_ctrl;
+
+	if (timing == MMC_TIMING_MMC_HS400) {
+		dqs |= DATA_STROBE_EN;
+		strobe = DQS_CTRL_RD_DELAY(strobe, priv->dqs_delay);
 	} else {
-		mci_writel(host, CLKSEL, priv->sdr_timing);
+		dqs &= ~DATA_STROBE_EN;
 	}
 
+	mci_writel(host, HS400_DQS_EN, dqs);
+	mci_writel(host, HS400_DLINE_CTRL, strobe);
+}
+
+static void dw_mci_exynos_adjust_clock(struct dw_mci *host, unsigned int wanted)
+{
+	struct dw_mci_exynos_priv_data *priv = host->priv;
+	unsigned long actual;
+	u8 div;
+	int ret;
+
 	/*
 	 * Don't care if wanted clock is zero or
 	 * ciu clock is unavailable
@@ -194,18 +233,57 @@ static void dw_mci_exynos_set_ios(struct dw_mci *host, struct mmc_ios *ios)
 	if (wanted < EXYNOS_CCLKIN_MIN)
 		wanted = EXYNOS_CCLKIN_MIN;
 
-	if (wanted != priv->cur_speed) {
-		u8 div = dw_mci_exynos_get_ciu_div(host);
-		int ret = clk_set_rate(host->ciu_clk, wanted * div);
-		if (ret)
-			dev_warn(host->dev,
-				"failed to set clk-rate %u error: %d\n",
-				 wanted * div, ret);
-		actual = clk_get_rate(host->ciu_clk);
-		host->bus_hz = actual / div;
-		priv->cur_speed = wanted;
-		host->current_speed = 0;
+	if (wanted == priv->cur_speed)
+		return;
+
+	div = dw_mci_exynos_get_ciu_div(host);
+	ret = clk_set_rate(host->ciu_clk, wanted * div);
+	if (ret)
+		dev_warn(host->dev,
+			"failed to set clk-rate %u error: %d\n",
+			wanted * div, ret);
+	actual = clk_get_rate(host->ciu_clk);
+	host->bus_hz = actual / div;
+	priv->cur_speed = wanted;
+	host->current_speed = 0;
+}
+
+static void dw_mci_exynos_set_ios(struct dw_mci *host, struct mmc_ios *ios)
+{
+	struct dw_mci_exynos_priv_data *priv = host->priv;
+	unsigned int wanted = ios->clock;
+	u32 timing = ios->timing, clksel;
+
+	switch (timing) {
+	case MMC_TIMING_MMC_HS400:
+		/* Update tuned sample timing */
+		priv->hs400_timing = SDMMC_CLKSEL_UP_SAMPLE(
+				priv->hs400_timing, priv->tuned_sample);
+	case MMC_TIMING_MMC_HS400_TUNING:
+		clksel = priv->hs400_timing;
+		wanted <<= 1;
+		break;
+	case MMC_TIMING_MMC_HS200:
+		clksel = priv->hs200_timing;
+		break;
+	case MMC_TIMING_MMC_DDR52:
+		clksel = priv->ddr_timing;
+		/* Should be double rate for DDR mode */
+		if (ios->bus_width == MMC_BUS_WIDTH_8)
+			wanted <<= 1;
+		break;
+	default:
+		clksel = priv->sdr_timing;
 	}
+
+	/* Set clock timing for the requested speed mode*/
+	dw_mci_exynos_set_clksel_timing(host, clksel);
+
+	/* Configure setting for HS400 */
+	dw_mci_exynos_config_hs400(host, timing);
+
+	/* Configure clock rate */
+	dw_mci_exynos_adjust_clock(host, wanted);
 }
 
 static int dw_mci_exynos_dt_populate_timing(struct dw_mci *host,
@@ -261,6 +339,13 @@ static int dw_mci_exynos_parse_dt(struct dw_mci *host)
 	dw_mci_exynos_dt_populate_timing(host, priv->ctrl_type,
 			"samsung,dw-mshc-hs200-timing", &priv->hs200_timing);
 
+	ret = dw_mci_exynos_dt_populate_timing(host, priv->ctrl_type,
+			"samsung,dw-mshc-hs400-timing", &priv->hs400_timing);
+	if (!ret && of_property_read_u32(np,
+				"read-strobe-delay", &priv->dqs_delay))
+		dev_info(host->dev,
+			"read-strobe-delay is not found, assuming usage of default value\n");
+
 	host->priv = priv;
 
 	return 0;
@@ -275,7 +360,7 @@ static inline void dw_mci_exynos_set_clksmpl(struct dw_mci *host, u8 sample)
 {
 	u32 clksel;
 	clksel = mci_readl(host, CLKSEL);
-	clksel = (clksel & ~0x7) | SDMMC_CLKSEL_CCLK_SAMPLE(sample);
+	clksel = SDMMC_CLKSEL_UP_SAMPLE(clksel, sample);
 	mci_writel(host, CLKSEL, clksel);
 }
 
@@ -286,7 +371,7 @@ static inline u8 dw_mci_exynos_move_next_clksmpl(struct dw_mci *host)
 
 	clksel = mci_readl(host, CLKSEL);
 	sample = (clksel + 1) & 0x7;
-	clksel = (clksel & ~0x7) | sample;
+	clksel = SDMMC_CLKSEL_UP_SAMPLE(clksel, sample);
 	mci_writel(host, CLKSEL, clksel);
 	return sample;
 }
@@ -321,6 +406,7 @@ static int dw_mci_exynos_execute_tuning(struct dw_mci_slot *slot, u32 opcode,
 					struct dw_mci_tuning_data *tuning_data)
 {
 	struct dw_mci *host = slot->host;
+	struct dw_mci_exynos_priv_data *priv = host->priv;
 	struct mmc_host *mmc = slot->mmc;
 	const u8 *blk_pattern = tuning_data->blk_pattern;
 	u8 *blk_test;
@@ -378,10 +464,12 @@ static int dw_mci_exynos_execute_tuning(struct dw_mci_slot *slot, u32 opcode,
 	} while (start_smpl != smpl);
 
 	found = dw_mci_exynos_get_best_clksmpl(candiates);
-	if (found >= 0)
+	if (found >= 0) {
 		dw_mci_exynos_set_clksmpl(host, found);
-	else
+		priv->tuned_sample = found;
+	} else {
 		ret = -EIO;
+	}
 
 	kfree(blk_test);
 	return ret;
diff --git a/drivers/mmc/host/dw_mmc-exynos.h b/drivers/mmc/host/dw_mmc-exynos.h
index 78b3f20..478418a 100644
--- a/drivers/mmc/host/dw_mmc-exynos.h
+++ b/drivers/mmc/host/dw_mmc-exynos.h
@@ -14,6 +14,9 @@
 
 /* Extended Register's Offset */
 #define SDMMC_CLKSEL			0x09C
+#define SDMMC_HS400_DQS_EN		0x180
+#define SDMMC_HS400_ASYNC_FIFO_CTRL	0x184
+#define SDMMC_HS400_DLINE_CTRL		0x188
 
 /* CLKSEL register defines */
 #define SDMMC_CLKSEL_CCLK_SAMPLE(x)	(((x) & 7) << 0)
@@ -21,11 +24,22 @@
 #define SDMMC_CLKSEL_CCLK_DIVIDER(x)	(((x) & 7) << 24)
 #define SDMMC_CLKSEL_GET_DRV_WD3(x)	(((x) >> 16) & 0x7)
 #define SDMMC_CLKSEL_GET_DIV(x)		(((x) >> 24) & 0x7)
+#define SDMMC_CLKSEL_UP_SAMPLE(x, y)	(((x) & ~SDMMC_CLKSEL_CCLK_SAMPLE(7)) |\
+					 SDMMC_CLKSEL_CCLK_SAMPLE(y))
 #define SDMMC_CLKSEL_TIMING(x, y, z)	(SDMMC_CLKSEL_CCLK_SAMPLE(x) |	\
 					 SDMMC_CLKSEL_CCLK_DRIVE(y) |	\
 					 SDMMC_CLKSEL_CCLK_DIVIDER(z))
+#define SDMMC_CLKSEL_TIMING_MASK	SDMMC_CLKSEL_TIMING(0x7, 0x7, 0x7)
 #define SDMMC_CLKSEL_WAKEUP_INT		BIT(11)
 
+/* HS400 control defines */
+#define DATA_STROBE_EN			BIT(0)
+#define AXI_NON_BLOCKING_WR	BIT(7)
+
+/* Delay Line Control defines */
+#define DQS_CTRL_RD_DELAY(x, y)		(((x) & ~0x3FF) | ((y) & 0x3FF))
+#define DQS_CTRL_GET_RD_DELAY(x)	((x) & 0x3FF)
+
 /* Protector Register */
 #define SDMMC_EMMCP_BASE	0x1000
 #define SDMMC_MPSECURITY	(SDMMC_EMMCP_BASE + 0x0010)
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index aeb38f9..32dd81d 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -953,7 +953,8 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	regs = mci_readl(slot->host, UHS_REG);
 
 	/* DDR mode set */
-	if (ios->timing == MMC_TIMING_MMC_DDR52)
+	if (ios->timing == MMC_TIMING_MMC_DDR52 ||
+	    ios->timing == MMC_TIMING_MMC_HS400)
 		regs |= ((0x1 << slot->id) << 16);
 	else
 		regs &= ~((0x1 << slot->id) << 16);
-- 
1.7.4.1



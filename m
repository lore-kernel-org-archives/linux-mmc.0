From: Alim Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH  v3 2/4] mmc: dw_mmc: exynos: support eMMC's HS400 mode
Date: Wed, 31 Dec 2014 12:13:03 +0530
Message-ID: <1420008185-24758-3-git-send-email-alim.akhtar@samsung.com>
References: <1420008185-24758-1-git-send-email-alim.akhtar@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:41420 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750726AbaLaGws (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 31 Dec 2014 01:52:48 -0500
In-reply-to: <1420008185-24758-1-git-send-email-alim.akhtar@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: chris@printf.net, ulf.hansson@linaro.org, jh80.chung@samsung.com, tgih.jun@samsung.com, dianders@chromium.org, alim.akhtar@gmail.com, kgene@kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, a.kesavan@samsung.com

From: Seungwon Jeon <tgih.jun@samsung.com>

Implements HS400 support for exynos host driver.
And this patch includes some updates as new mode is added.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 .../devicetree/bindings/mmc/exynos-dw-mshc.txt     |    6 +
 drivers/mmc/host/dw_mmc-exynos.c                   |  177 +++++++++++++++-----
 drivers/mmc/host/dw_mmc-exynos.h                   |   17 +-
 drivers/mmc/host/dw_mmc.c                          |   16 +-
 drivers/mmc/host/dw_mmc.h                          |    2 +
 5 files changed, 178 insertions(+), 40 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
index 06455de..be30c94 100644
--- a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
+++ b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
@@ -34,6 +34,7 @@ Required Properties:
   valid values.
 
 * samsung,dw-mshc-hs200-timing: Similar with dw-mshc-sdr-timing.
+* samsung,dw-mshc-hs400-timing: Similar with dw-mshc-ddr-timing.
 
   Notes for the sdr-timing and ddr-timing values:
 
@@ -51,6 +52,9 @@ Required Properties:
       - if CIU clock divider value is 0 (that is divide by 1), both tx and rx
         phase shift clocks should be 0.
 
+* read-strobe-delay: RCLK (Data strobe) delay to control HS400 mode
+  (Latency value for delay line in Read path)
+
 Required properties for a slot (Deprecated - Recommend to use one slot per host):
 
 * gpios: specifies a list of gpios used for command, clock and data bus. The
@@ -83,5 +87,7 @@ Example:
 		samsung,dw-mshc-sdr-timing = <2 3 3>;
 		samsung,dw-mshc-ddr-timing = <1 2 3>;
 		samsung,dw-mshc-hs200-timing = <0 2 3>;
+		samsung,dw-mshc-hs400-timing = <0 2 1>;
+		read-strobe-delay = <90>;
 		bus-width = <8>;
 	};
diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index be6530e..d37a631 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -41,7 +41,12 @@ struct dw_mci_exynos_priv_data {
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
@@ -101,6 +106,16 @@ static int dw_mci_exynos_priv_init(struct dw_mci *host)
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
@@ -115,6 +130,25 @@ static int dw_mci_exynos_setup_clock(struct dw_mci *host)
 	return 0;
 }
 
+static void dw_mci_exynos_set_clksel_timing(struct dw_mci *host, u32 timing)
+{
+	struct dw_mci_exynos_priv_data *priv = host->priv;
+	u32 clksel;
+
+	if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS7 ||
+		priv->ctrl_type == DW_MCI_TYPE_EXYNOS7_SMU)
+		clksel = mci_readl(host, CLKSEL64);
+	else
+		clksel = mci_readl(host, CLKSEL);
+
+	clksel = (clksel & ~SDMMC_CLKSEL_TIMING_MASK) | timing;
+	if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS7 ||
+		priv->ctrl_type == DW_MCI_TYPE_EXYNOS7_SMU)
+		mci_writel(host, CLKSEL64, clksel);
+	else
+		mci_writel(host, CLKSEL, clksel);
+}
+
 #ifdef CONFIG_PM_SLEEP
 static int dw_mci_exynos_suspend(struct device *dev)
 {
@@ -190,35 +224,37 @@ static void dw_mci_exynos_prepare_command(struct dw_mci *host, u32 *cmdr)
 	}
 }
 
-static void dw_mci_exynos_set_ios(struct dw_mci *host, struct mmc_ios *ios)
+static void dw_mci_exynos_config_hs400(struct dw_mci *host, u32 timing)
 {
 	struct dw_mci_exynos_priv_data *priv = host->priv;
-	unsigned int wanted = ios->clock;
-	unsigned long actual;
+	u32 dqs, strobe;
 
-	if (ios->timing == MMC_TIMING_MMC_HS200) {
-		if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS7 ||
-			priv->ctrl_type == DW_MCI_TYPE_EXYNOS7_SMU)
-			mci_writel(host, CLKSEL64, priv->hs200_timing);
-		else
-			mci_writel(host, CLKSEL, priv->hs200_timing);
-	} else if (ios->timing == MMC_TIMING_MMC_DDR52) {
-		if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS7 ||
-			priv->ctrl_type == DW_MCI_TYPE_EXYNOS7_SMU)
-			mci_writel(host, CLKSEL64, priv->ddr_timing);
-		else
-			mci_writel(host, CLKSEL, priv->ddr_timing);
-		/* Should be double rate for DDR mode */
-		if (ios->bus_width == MMC_BUS_WIDTH_8)
-			wanted <<= 1;
+	/*
+	 * Exynos5420 and above controller supports HS400 mode
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
-		if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS7 ||
-			priv->ctrl_type == DW_MCI_TYPE_EXYNOS7_SMU)
-			mci_writel(host, CLKSEL64, priv->sdr_timing);
-		else
-			mci_writel(host, CLKSEL, priv->sdr_timing);
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
 	/*
 	 * Don't care if wanted clock is zero or
 	 * ciu clock is unavailable
@@ -230,18 +266,55 @@ static void dw_mci_exynos_set_ios(struct dw_mci *host, struct mmc_ios *ios)
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
+		clksel = SDMMC_CLKSEL_UP_SAMPLE(
+				priv->hs400_timing, priv->tuned_sample);
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
@@ -294,6 +367,14 @@ static int dw_mci_exynos_parse_dt(struct dw_mci *host)
 
 	dw_mci_exynos_dt_populate_timing(host, priv->ctrl_type,
 		"samsung,dw-mshc-hs200-timing", &priv->hs200_timing);
+
+	ret = dw_mci_exynos_dt_populate_timing(host, priv->ctrl_type,
+			"samsung,dw-mshc-hs400-timing", &priv->hs400_timing);
+	if (!ret && of_property_read_u32(np,
+				"read-strobe-delay", &priv->dqs_delay))
+		dev_info(host->dev,
+			"read-strobe-delay is not found, assuming usage of default value\n");
+
 	host->priv = priv;
 
 	return 0;
@@ -320,7 +401,9 @@ static inline void dw_mci_exynos_set_clksmpl(struct dw_mci *host, u8 sample)
 		clksel = mci_readl(host, CLKSEL64);
 	else
 		clksel = mci_readl(host, CLKSEL);
-	clksel = (clksel & ~0x7) | SDMMC_CLKSEL_CCLK_SAMPLE(sample);
+
+	clksel = SDMMC_CLKSEL_UP_SAMPLE(clksel, sample);
+
 	if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS7 ||
 		priv->ctrl_type == DW_MCI_TYPE_EXYNOS7_SMU)
 		mci_writel(host, CLKSEL64, clksel);
@@ -339,13 +422,16 @@ static inline u8 dw_mci_exynos_move_next_clksmpl(struct dw_mci *host)
 		clksel = mci_readl(host, CLKSEL64);
 	else
 		clksel = mci_readl(host, CLKSEL);
+
 	sample = (clksel + 1) & 0x7;
-	clksel = (clksel & ~0x7) | sample;
+	clksel = SDMMC_CLKSEL_UP_SAMPLE(clksel, sample);
+
 	if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS7 ||
 		priv->ctrl_type == DW_MCI_TYPE_EXYNOS7_SMU)
 		mci_writel(host, CLKSEL64, clksel);
 	else
 		mci_writel(host, CLKSEL, clksel);
+
 	return sample;
 }
 
@@ -378,6 +464,7 @@ out:
 static int dw_mci_exynos_execute_tuning(struct dw_mci_slot *slot)
 {
 	struct dw_mci *host = slot->host;
+	struct dw_mci_exynos_priv_data *priv = host->priv;
 	struct mmc_host *mmc = slot->mmc;
 	u8 start_smpl, smpl, candiates = 0;
 	s8 found = -1;
@@ -395,14 +482,27 @@ static int dw_mci_exynos_execute_tuning(struct dw_mci_slot *slot)
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
 
 	return ret;
 }
 
+int dw_mci_exynos_prepare_hs400_tuning(struct dw_mci *host,
+					struct mmc_ios *ios)
+{
+	struct dw_mci_exynos_priv_data *priv = host->priv;
+
+	dw_mci_exynos_set_clksel_timing(host, priv->hs400_timing);
+	dw_mci_exynos_adjust_clock(host, (ios->clock) << 1);
+
+	return 0;
+}
+
 /* Common capabilities of Exynos4/Exynos5 SoC */
 static unsigned long exynos_dwmmc_caps[4] = {
 	MMC_CAP_1_8V_DDR | MMC_CAP_8_BIT_DATA | MMC_CAP_CMD23,
@@ -419,6 +519,7 @@ static const struct dw_mci_drv_data exynos_drv_data = {
 	.set_ios		= dw_mci_exynos_set_ios,
 	.parse_dt		= dw_mci_exynos_parse_dt,
 	.execute_tuning		= dw_mci_exynos_execute_tuning,
+	.prepare_hs400_tuning	= dw_mci_exynos_prepare_hs400_tuning,
 };
 
 static const struct of_device_id dw_mci_exynos_match[] = {
diff --git a/drivers/mmc/host/dw_mmc-exynos.h b/drivers/mmc/host/dw_mmc-exynos.h
index c04ecef..e7faffe 100644
--- a/drivers/mmc/host/dw_mmc-exynos.h
+++ b/drivers/mmc/host/dw_mmc-exynos.h
@@ -12,21 +12,36 @@
 #ifndef _DW_MMC_EXYNOS_H_
 #define _DW_MMC_EXYNOS_H_
 
-/* Extended Register's Offset */
 #define SDMMC_CLKSEL			0x09C
 #define SDMMC_CLKSEL64			0x0A8
 
+/* Extended Register's Offset */
+#define SDMMC_HS400_DQS_EN		0x180
+#define SDMMC_HS400_ASYNC_FIFO_CTRL	0x184
+#define SDMMC_HS400_DLINE_CTRL		0x188
+
 /* CLKSEL register defines */
 #define SDMMC_CLKSEL_CCLK_SAMPLE(x)	(((x) & 7) << 0)
 #define SDMMC_CLKSEL_CCLK_DRIVE(x)	(((x) & 7) << 16)
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
index 2e8abc8..43a3a5b 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1084,7 +1084,8 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	regs = mci_readl(slot->host, UHS_REG);
 
 	/* DDR mode set */
-	if (ios->timing == MMC_TIMING_MMC_DDR52)
+	if (ios->timing == MMC_TIMING_MMC_DDR52 ||
+	    ios->timing == MMC_TIMING_MMC_HS400)
 		regs |= ((0x1 << slot->id) << 16);
 	else
 		regs &= ~((0x1 << slot->id) << 16);
@@ -1321,6 +1322,18 @@ static int dw_mci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	return err;
 }
 
+int dw_mci_prepare_hs400_tuning(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	struct dw_mci_slot *slot = mmc_priv(mmc);
+	struct dw_mci *host = slot->host;
+	const struct dw_mci_drv_data *drv_data = host->drv_data;
+
+	if (drv_data && drv_data->prepare_hs400_tuning)
+		return drv_data->prepare_hs400_tuning(host, ios);
+
+	return 0;
+}
+
 static const struct mmc_host_ops dw_mci_ops = {
 	.request		= dw_mci_request,
 	.pre_req		= dw_mci_pre_req,
@@ -1333,6 +1346,7 @@ static const struct mmc_host_ops dw_mci_ops = {
 	.card_busy		= dw_mci_card_busy,
 	.start_signal_voltage_switch = dw_mci_switch_voltage,
 	.init_card		= dw_mci_init_card,
+	.prepare_hs400_tuning	= dw_mci_prepare_hs400_tuning,
 };
 
 static void dw_mci_request_end(struct dw_mci *host, struct mmc_request *mrq)
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 18c4afe..d239867 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -271,5 +271,7 @@ struct dw_mci_drv_data {
 	void		(*set_ios)(struct dw_mci *host, struct mmc_ios *ios);
 	int		(*parse_dt)(struct dw_mci *host);
 	int		(*execute_tuning)(struct dw_mci_slot *slot);
+	int		(*prepare_hs400_tuning)(struct dw_mci *host,
+						struct mmc_ios *ios);
 };
 #endif /* _DW_MMC_H_ */
-- 
1.7.9.5


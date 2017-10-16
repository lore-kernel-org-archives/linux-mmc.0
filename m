From: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v6 05/12] mmc: mediatek: add pad_tune0 support
Date: Mon, 16 Oct 2017 09:46:32 +0800
Message-ID: <1508118399-21828-6-git-send-email-chaotian.jing@mediatek.com>
References: <1508118399-21828-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1508118399-21828-1-git-send-email-chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, yong mao <yong.mao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Phong LE <ple-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

from mt2701, the register of PAD_TUNE has been phased out,
while there is a new register of PAD_TUNE0

Signed-off-by: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 drivers/mmc/host/mtk-sd.c | 51 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index ab2fbbb..bcd83d6 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -75,6 +75,7 @@
 #define MSDC_PATCH_BIT   0xb0
 #define MSDC_PATCH_BIT1  0xb4
 #define MSDC_PAD_TUNE    0xec
+#define MSDC_PAD_TUNE0   0xf0
 #define PAD_DS_TUNE      0x188
 #define PAD_CMD_TUNE     0x18c
 #define EMMC50_CFG0      0x208
@@ -301,6 +302,7 @@ struct msdc_save_para {
 struct mtk_mmc_compatible {
 	u8 clk_div_bits;
 	bool hs400_tune; /* only used for MT8173 */
+	u32 pad_tune_reg;
 };
 
 struct msdc_tune_para {
@@ -362,21 +364,25 @@ struct msdc_host {
 static const struct mtk_mmc_compatible mt8135_compat = {
 	.clk_div_bits = 8,
 	.hs400_tune = false,
+	.pad_tune_reg = MSDC_PAD_TUNE,
 };
 
 static const struct mtk_mmc_compatible mt8173_compat = {
 	.clk_div_bits = 8,
 	.hs400_tune = true,
+	.pad_tune_reg = MSDC_PAD_TUNE,
 };
 
 static const struct mtk_mmc_compatible mt2701_compat = {
 	.clk_div_bits = 12,
 	.hs400_tune = false,
+	.pad_tune_reg = MSDC_PAD_TUNE0,
 };
 
 static const struct mtk_mmc_compatible mt2712_compat = {
 	.clk_div_bits = 12,
 	.hs400_tune = false,
+	.pad_tune_reg = MSDC_PAD_TUNE0,
 };
 
 static const struct of_device_id msdc_of_ids[] = {
@@ -581,6 +587,7 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
 	u32 flags;
 	u32 div;
 	u32 sclk;
+	u32 tune_reg = host->dev_comp->pad_tune_reg;
 
 	if (!hz) {
 		dev_dbg(host->dev, "set mclk to 0\n");
@@ -663,10 +670,10 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
 	 */
 	if (host->sclk <= 52000000) {
 		writel(host->def_tune_para.iocon, host->base + MSDC_IOCON);
-		writel(host->def_tune_para.pad_tune, host->base + MSDC_PAD_TUNE);
+		writel(host->def_tune_para.pad_tune, host->base + tune_reg);
 	} else {
 		writel(host->saved_tune_para.iocon, host->base + MSDC_IOCON);
-		writel(host->saved_tune_para.pad_tune, host->base + MSDC_PAD_TUNE);
+		writel(host->saved_tune_para.pad_tune, host->base + tune_reg);
 		writel(host->saved_tune_para.pad_cmd_tune,
 		       host->base + PAD_CMD_TUNE);
 	}
@@ -1224,6 +1231,7 @@ static irqreturn_t msdc_irq(int irq, void *dev_id)
 static void msdc_init_hw(struct msdc_host *host)
 {
 	u32 val;
+	u32 tune_reg = host->dev_comp->pad_tune_reg;
 
 	/* Configure to MMC/SD mode, clock free running */
 	sdr_set_bits(host->base + MSDC_CFG, MSDC_CFG_MODE | MSDC_CFG_CKPDN);
@@ -1239,7 +1247,7 @@ static void msdc_init_hw(struct msdc_host *host)
 	val = readl(host->base + MSDC_INT);
 	writel(val, host->base + MSDC_INT);
 
-	writel(0, host->base + MSDC_PAD_TUNE);
+	writel(0, host->base + tune_reg);
 	writel(0, host->base + MSDC_IOCON);
 	sdr_set_field(host->base + MSDC_IOCON, MSDC_IOCON_DDLSEL, 0);
 	writel(0x403c0046, host->base + MSDC_PATCH_BIT);
@@ -1259,7 +1267,7 @@ static void msdc_init_hw(struct msdc_host *host)
 	sdr_set_field(host->base + SDC_CFG, SDC_CFG_DTOC, 3);
 
 	host->def_tune_para.iocon = readl(host->base + MSDC_IOCON);
-	host->def_tune_para.pad_tune = readl(host->base + MSDC_PAD_TUNE);
+	host->def_tune_para.pad_tune = readl(host->base + tune_reg);
 	dev_dbg(host->dev, "init hardware done!");
 }
 
@@ -1402,18 +1410,19 @@ static int msdc_tune_response(struct mmc_host *mmc, u32 opcode)
 	struct msdc_delay_phase internal_delay_phase;
 	u8 final_delay, final_maxlen;
 	u32 internal_delay = 0;
+	u32 tune_reg = host->dev_comp->pad_tune_reg;
 	int cmd_err;
 	int i, j;
 
 	if (mmc->ios.timing == MMC_TIMING_MMC_HS200 ||
 	    mmc->ios.timing == MMC_TIMING_UHS_SDR104)
-		sdr_set_field(host->base + MSDC_PAD_TUNE,
+		sdr_set_field(host->base + tune_reg,
 			      MSDC_PAD_TUNE_CMDRRDLY,
 			      host->hs200_cmd_int_delay);
 
 	sdr_clr_bits(host->base + MSDC_IOCON, MSDC_IOCON_RSPL);
 	for (i = 0 ; i < PAD_DELAY_MAX; i++) {
-		sdr_set_field(host->base + MSDC_PAD_TUNE,
+		sdr_set_field(host->base + tune_reg,
 			      MSDC_PAD_TUNE_CMDRDLY, i);
 		/*
 		 * Using the same parameters, it may sometimes pass the test,
@@ -1437,7 +1446,7 @@ static int msdc_tune_response(struct mmc_host *mmc, u32 opcode)
 
 	sdr_set_bits(host->base + MSDC_IOCON, MSDC_IOCON_RSPL);
 	for (i = 0; i < PAD_DELAY_MAX; i++) {
-		sdr_set_field(host->base + MSDC_PAD_TUNE,
+		sdr_set_field(host->base + tune_reg,
 			      MSDC_PAD_TUNE_CMDRDLY, i);
 		/*
 		 * Using the same parameters, it may sometimes pass the test,
@@ -1462,12 +1471,12 @@ static int msdc_tune_response(struct mmc_host *mmc, u32 opcode)
 		final_maxlen = final_fall_delay.maxlen;
 	if (final_maxlen == final_rise_delay.maxlen) {
 		sdr_clr_bits(host->base + MSDC_IOCON, MSDC_IOCON_RSPL);
-		sdr_set_field(host->base + MSDC_PAD_TUNE, MSDC_PAD_TUNE_CMDRDLY,
+		sdr_set_field(host->base + tune_reg, MSDC_PAD_TUNE_CMDRDLY,
 			      final_rise_delay.final_phase);
 		final_delay = final_rise_delay.final_phase;
 	} else {
 		sdr_set_bits(host->base + MSDC_IOCON, MSDC_IOCON_RSPL);
-		sdr_set_field(host->base + MSDC_PAD_TUNE, MSDC_PAD_TUNE_CMDRDLY,
+		sdr_set_field(host->base + tune_reg, MSDC_PAD_TUNE_CMDRDLY,
 			      final_fall_delay.final_phase);
 		final_delay = final_fall_delay.final_phase;
 	}
@@ -1475,7 +1484,7 @@ static int msdc_tune_response(struct mmc_host *mmc, u32 opcode)
 		goto skip_internal;
 
 	for (i = 0; i < PAD_DELAY_MAX; i++) {
-		sdr_set_field(host->base + MSDC_PAD_TUNE,
+		sdr_set_field(host->base + tune_reg,
 			      MSDC_PAD_TUNE_CMDRRDLY, i);
 		mmc_send_tuning(mmc, opcode, &cmd_err);
 		if (!cmd_err)
@@ -1483,7 +1492,7 @@ static int msdc_tune_response(struct mmc_host *mmc, u32 opcode)
 	}
 	dev_dbg(host->dev, "Final internal delay: 0x%x\n", internal_delay);
 	internal_delay_phase = get_best_delay(host, internal_delay);
-	sdr_set_field(host->base + MSDC_PAD_TUNE, MSDC_PAD_TUNE_CMDRRDLY,
+	sdr_set_field(host->base + tune_reg, MSDC_PAD_TUNE_CMDRRDLY,
 		      internal_delay_phase.final_phase);
 skip_internal:
 	dev_dbg(host->dev, "Final cmd pad delay: %x\n", final_delay);
@@ -1545,12 +1554,13 @@ static int msdc_tune_data(struct mmc_host *mmc, u32 opcode)
 	u32 rise_delay = 0, fall_delay = 0;
 	struct msdc_delay_phase final_rise_delay, final_fall_delay = { 0,};
 	u8 final_delay, final_maxlen;
+	u32 tune_reg = host->dev_comp->pad_tune_reg;
 	int i, ret;
 
 	sdr_clr_bits(host->base + MSDC_IOCON, MSDC_IOCON_DSPL);
 	sdr_clr_bits(host->base + MSDC_IOCON, MSDC_IOCON_W_DSPL);
 	for (i = 0 ; i < PAD_DELAY_MAX; i++) {
-		sdr_set_field(host->base + MSDC_PAD_TUNE,
+		sdr_set_field(host->base + tune_reg,
 			      MSDC_PAD_TUNE_DATRRDLY, i);
 		ret = mmc_send_tuning(mmc, opcode, NULL);
 		if (!ret)
@@ -1565,7 +1575,7 @@ static int msdc_tune_data(struct mmc_host *mmc, u32 opcode)
 	sdr_set_bits(host->base + MSDC_IOCON, MSDC_IOCON_DSPL);
 	sdr_set_bits(host->base + MSDC_IOCON, MSDC_IOCON_W_DSPL);
 	for (i = 0; i < PAD_DELAY_MAX; i++) {
-		sdr_set_field(host->base + MSDC_PAD_TUNE,
+		sdr_set_field(host->base + tune_reg,
 			      MSDC_PAD_TUNE_DATRRDLY, i);
 		ret = mmc_send_tuning(mmc, opcode, NULL);
 		if (!ret)
@@ -1578,14 +1588,14 @@ static int msdc_tune_data(struct mmc_host *mmc, u32 opcode)
 	if (final_maxlen == final_rise_delay.maxlen) {
 		sdr_clr_bits(host->base + MSDC_IOCON, MSDC_IOCON_DSPL);
 		sdr_clr_bits(host->base + MSDC_IOCON, MSDC_IOCON_W_DSPL);
-		sdr_set_field(host->base + MSDC_PAD_TUNE,
+		sdr_set_field(host->base + tune_reg,
 			      MSDC_PAD_TUNE_DATRRDLY,
 			      final_rise_delay.final_phase);
 		final_delay = final_rise_delay.final_phase;
 	} else {
 		sdr_set_bits(host->base + MSDC_IOCON, MSDC_IOCON_DSPL);
 		sdr_set_bits(host->base + MSDC_IOCON, MSDC_IOCON_W_DSPL);
-		sdr_set_field(host->base + MSDC_PAD_TUNE,
+		sdr_set_field(host->base + tune_reg,
 			      MSDC_PAD_TUNE_DATRRDLY,
 			      final_fall_delay.final_phase);
 		final_delay = final_fall_delay.final_phase;
@@ -1599,6 +1609,7 @@ static int msdc_execute_tuning(struct mmc_host *mmc, u32 opcode)
 {
 	struct msdc_host *host = mmc_priv(mmc);
 	int ret;
+	u32 tune_reg = host->dev_comp->pad_tune_reg;
 
 	if (host->hs400_mode &&
 	    host->dev_comp->hs400_tune)
@@ -1616,7 +1627,7 @@ static int msdc_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	}
 
 	host->saved_tune_para.iocon = readl(host->base + MSDC_IOCON);
-	host->saved_tune_para.pad_tune = readl(host->base + MSDC_PAD_TUNE);
+	host->saved_tune_para.pad_tune = readl(host->base + tune_reg);
 	host->saved_tune_para.pad_cmd_tune = readl(host->base + PAD_CMD_TUNE);
 	return ret;
 }
@@ -1857,10 +1868,12 @@ static int msdc_drv_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM
 static void msdc_save_reg(struct msdc_host *host)
 {
+	u32 tune_reg = host->dev_comp->pad_tune_reg;
+
 	host->save_para.msdc_cfg = readl(host->base + MSDC_CFG);
 	host->save_para.iocon = readl(host->base + MSDC_IOCON);
 	host->save_para.sdc_cfg = readl(host->base + SDC_CFG);
-	host->save_para.pad_tune = readl(host->base + MSDC_PAD_TUNE);
+	host->save_para.pad_tune = readl(host->base + tune_reg);
 	host->save_para.patch_bit0 = readl(host->base + MSDC_PATCH_BIT);
 	host->save_para.patch_bit1 = readl(host->base + MSDC_PATCH_BIT1);
 	host->save_para.pad_ds_tune = readl(host->base + PAD_DS_TUNE);
@@ -1870,10 +1883,12 @@ static void msdc_save_reg(struct msdc_host *host)
 
 static void msdc_restore_reg(struct msdc_host *host)
 {
+	u32 tune_reg = host->dev_comp->pad_tune_reg;
+
 	writel(host->save_para.msdc_cfg, host->base + MSDC_CFG);
 	writel(host->save_para.iocon, host->base + MSDC_IOCON);
 	writel(host->save_para.sdc_cfg, host->base + SDC_CFG);
-	writel(host->save_para.pad_tune, host->base + MSDC_PAD_TUNE);
+	writel(host->save_para.pad_tune, host->base + tune_reg);
 	writel(host->save_para.patch_bit0, host->base + MSDC_PATCH_BIT);
 	writel(host->save_para.patch_bit1, host->base + MSDC_PATCH_BIT1);
 	writel(host->save_para.pad_ds_tune, host->base + PAD_DS_TUNE);
-- 
1.8.1.1.dirty

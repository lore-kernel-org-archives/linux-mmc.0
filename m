From: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v3 09/10] mmc: mediatek: add HS400 support
Date: Tue, 27 Oct 2015 14:24:29 +0800
Message-ID: <1445927070-5102-10-git-send-email-chaotian.jing@mediatek.com>
References: <1445927070-5102-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1445927070-5102-1-git-send-email-chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Seungwon Jeon <tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Barry Song <baohua-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Howard Chen <ibanezchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Kristina Martsenko <kristina.martsenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

add HS400 mode and tune support

Signed-off-by: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 drivers/mmc/host/mtk-sd.c | 249 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 244 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 5627644..39568cc 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -26,6 +26,7 @@
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
+#include <linux/slab.h>
 #include <linux/spinlock.h>
 
 #include <linux/mmc/card.h>
@@ -72,6 +73,8 @@
 #define MSDC_PATCH_BIT   0xb0
 #define MSDC_PATCH_BIT1  0xb4
 #define MSDC_PAD_TUNE    0xec
+#define PAD_DS_TUNE      0x188
+#define EMMC50_CFG0      0x208
 
 /*--------------------------------------------------------------------------*/
 /* Register Mask                                                            */
@@ -88,6 +91,7 @@
 #define MSDC_CFG_CKSTB          (0x1 << 7)	/* R  */
 #define MSDC_CFG_CKDIV          (0xff << 8)	/* RW */
 #define MSDC_CFG_CKMOD          (0x3 << 16)	/* RW */
+#define MSDC_CFG_HS400_CK_MODE  (0x1 << 18)	/* RW */
 
 /* MSDC_IOCON mask */
 #define MSDC_IOCON_SDR104CKS    (0x1 << 0)	/* RW */
@@ -205,6 +209,17 @@
 #define MSDC_PATCH_BIT_SPCPUSH    (0x1 << 29)	/* RW */
 #define MSDC_PATCH_BIT_DECRCTMO   (0x1 << 30)	/* RW */
 
+#define MSDC_PAD_TUNE_DATRRDLY	  (0x1f <<  8)	/* RW */
+#define MSDC_PAD_TUNE_CMDRDLY	  (0x1f << 16)  /* RW */
+
+#define PAD_DS_TUNE_DLY1	  (0x1f << 2)   /* RW */
+#define PAD_DS_TUNE_DLY2	  (0x1f << 7)   /* RW */
+#define PAD_DS_TUNE_DLY3	  (0x1f << 12)  /* RW */
+
+#define EMMC50_CFG_PADCMD_LATCHCK (0x1 << 0)   /* RW */
+#define EMMC50_CFG_CRCSTS_EDGE    (0x1 << 3)   /* RW */
+#define EMMC50_CFG_CFCSTS_SEL     (0x1 << 4)   /* RW */
+
 #define REQ_CMD_EIO  (0x1 << 0)
 #define REQ_CMD_TMO  (0x1 << 1)
 #define REQ_DAT_ERR  (0x1 << 2)
@@ -220,6 +235,7 @@
 #define CMD_TIMEOUT         (HZ/10 * 5)	/* 100ms x5 */
 #define DAT_TIMEOUT         (HZ    * 5)	/* 1000ms x5 */
 
+#define PAD_DELAY_MAX	32 /* PAD delay cells */
 /*--------------------------------------------------------------------------*/
 /* Descriptor Structure                                                     */
 /*--------------------------------------------------------------------------*/
@@ -266,6 +282,14 @@ struct msdc_save_para {
 	u32 pad_tune;
 	u32 patch_bit0;
 	u32 patch_bit1;
+	u32 pad_ds_tune;
+	u32 emmc50_cfg0;
+};
+
+struct msdc_delay_phase {
+	u8 maxlen;
+	u8 start;
+	u8 final_phase;
 };
 
 struct msdc_host {
@@ -300,6 +324,7 @@ struct msdc_host {
 	u32 sclk;		/* SD/MS bus clock frequency */
 	unsigned char timing;
 	bool vqmmc_enabled;
+	u32 hs400_ds_delay;
 	struct msdc_save_para save_para; /* used when gate HCLK */
 };
 
@@ -505,9 +530,15 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
 
 	flags = readl(host->base + MSDC_INTEN);
 	sdr_clr_bits(host->base + MSDC_INTEN, flags);
+	sdr_clr_bits(host->base + MSDC_CFG, MSDC_CFG_HS400_CK_MODE);
 	if (timing == MMC_TIMING_UHS_DDR50 ||
-	    timing == MMC_TIMING_MMC_DDR52) {
-		mode = 0x2; /* ddr mode and use divisor */
+	    timing == MMC_TIMING_MMC_DDR52 ||
+	    timing == MMC_TIMING_MMC_HS400) {
+		if (timing == MMC_TIMING_MMC_HS400)
+			mode = 0x3;
+		else
+			mode = 0x2; /* ddr mode and use divisor */
+
 		if (hz >= (host->src_clk_freq >> 2)) {
 			div = 0; /* mean div = 1/4 */
 			sclk = host->src_clk_freq >> 2; /* sclk = clk / 4 */
@@ -516,6 +547,14 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
 			sclk = (host->src_clk_freq >> 2) / div;
 			div = (div >> 1);
 		}
+
+		if (timing == MMC_TIMING_MMC_HS400 &&
+		    hz >= (host->src_clk_freq >> 1)) {
+			sdr_set_bits(host->base + MSDC_CFG,
+				     MSDC_CFG_HS400_CK_MODE);
+			sclk = host->src_clk_freq >> 1;
+			div = 0; /* div is ignore when bit18 is set */
+		}
 	} else if (hz >= host->src_clk_freq) {
 		mode = 0x1; /* no divisor */
 		div = 0;
@@ -894,7 +933,7 @@ static void msdc_data_xfer_next(struct msdc_host *host,
 				struct mmc_request *mrq, struct mmc_data *data)
 {
 	if (mmc_op_multi(mrq->cmd->opcode) && mrq->stop && !mrq->stop->error &&
-	    (!data->bytes_xfered || !mrq->sbc))
+	    !mrq->sbc)
 		msdc_start_command(host, mrq, mrq->stop);
 	else
 		msdc_request_done(host, mrq);
@@ -940,6 +979,8 @@ static bool msdc_data_xfer_done(struct msdc_host *host, u32 events,
 
 			if (events & MSDC_INT_DATTMO)
 				data->error = -ETIMEDOUT;
+			else if (events & MSDC_INT_DATCRCERR)
+				data->error = -EILSEQ;
 
 			dev_err(host->dev, "%s: cmd=%d; blocks=%d",
 				__func__, mrq->cmd->opcode, data->blocks);
@@ -1111,10 +1152,12 @@ static void msdc_init_hw(struct msdc_host *host)
 
 	writel(0, host->base + MSDC_PAD_TUNE);
 	writel(0, host->base + MSDC_IOCON);
-	sdr_set_field(host->base + MSDC_IOCON, MSDC_IOCON_DDLSEL, 1);
-	writel(0x403c004f, host->base + MSDC_PATCH_BIT);
+	sdr_set_field(host->base + MSDC_IOCON, MSDC_IOCON_DDLSEL, 0);
+	writel(0x403c0046, host->base + MSDC_PATCH_BIT);
 	sdr_set_field(host->base + MSDC_PATCH_BIT, MSDC_CKGEN_MSDC_DLY_SEL, 1);
 	writel(0xffff0089, host->base + MSDC_PATCH_BIT1);
+	sdr_set_bits(host->base + EMMC50_CFG0, EMMC50_CFG_CFCSTS_SEL);
+
 	/* Configure to enable SDIO mode.
 	 * it's must otherwise sdio cmd5 failed
 	 */
@@ -1172,6 +1215,7 @@ static void msdc_ops_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	switch (ios->power_mode) {
 	case MMC_POWER_UP:
 		if (!IS_ERR(mmc->supply.vmmc)) {
+			msdc_init_hw(host);
 			ret = mmc_regulator_set_ocr(mmc, mmc->supply.vmmc,
 					ios->vdd);
 			if (ret) {
@@ -1210,6 +1254,190 @@ end:
 	pm_runtime_put_autosuspend(host->dev);
 }
 
+static u32 test_delay_bit(u32 delay, u32 bit)
+{
+	bit %= PAD_DELAY_MAX;
+	return delay & (1 << bit);
+}
+
+static int get_delay_len(u32 delay, u32 start_bit)
+{
+	int i;
+
+	for (i = 0; i < (PAD_DELAY_MAX - start_bit); i++) {
+		if (test_delay_bit(delay, start_bit + i) == 0)
+			return i;
+	}
+	return PAD_DELAY_MAX - start_bit;
+}
+
+static struct msdc_delay_phase get_best_delay(struct msdc_host *host, u32 delay)
+{
+	int start = 0, len = 0;
+	int start_final = 0, len_final = 0;
+	u8 final_phase = 0xff;
+	struct msdc_delay_phase delay_phase;
+
+	if (delay == 0) {
+		dev_err(host->dev, "phase error: [map:%x]\n", delay);
+		delay_phase.final_phase = final_phase;
+		return delay_phase;
+	}
+
+	while (start < PAD_DELAY_MAX) {
+		len = get_delay_len(delay, start);
+		if (len_final < len) {
+			start_final = start;
+			len_final = len;
+		}
+		start += len ? len : 1;
+		if (len >= 8 && start_final < 4)
+			break;
+	}
+
+	/* The rule is that to find the smallest delay cell */
+	if (start_final == 0)
+		final_phase = (start_final + len_final / 3) % PAD_DELAY_MAX;
+	else
+		final_phase = (start_final + len_final / 2) % PAD_DELAY_MAX;
+	dev_info(host->dev, "phase: [map:%x] [maxlen:%d] [final:%d]\n",
+		 delay, len_final, final_phase);
+
+	delay_phase.maxlen = len_final;
+	delay_phase.start = start_final;
+	delay_phase.final_phase = final_phase;
+	return delay_phase;
+}
+
+static int msdc_tune_response(struct mmc_host *mmc, u32 opcode)
+{
+	struct msdc_host *host = mmc_priv(mmc);
+	u32 rise_delay = 0, fall_delay = 0;
+	struct msdc_delay_phase final_rise_delay, final_fall_delay;
+	u8 final_delay, final_maxlen;
+	int cmd_err;
+	int i;
+
+	sdr_clr_bits(host->base + MSDC_IOCON, MSDC_IOCON_RSPL);
+	for (i = 0 ; i < PAD_DELAY_MAX; i++) {
+		sdr_set_field(host->base + MSDC_PAD_TUNE,
+			      MSDC_PAD_TUNE_CMDRDLY, i);
+		mmc_send_tuning(mmc, opcode, &cmd_err);
+		if (!cmd_err)
+			rise_delay |= (1 << i);
+	}
+
+	sdr_set_bits(host->base + MSDC_IOCON, MSDC_IOCON_RSPL);
+	for (i = 0; i < PAD_DELAY_MAX; i++) {
+		sdr_set_field(host->base + MSDC_PAD_TUNE,
+			      MSDC_PAD_TUNE_CMDRDLY, i);
+		mmc_send_tuning(mmc, opcode, &cmd_err);
+		if (!cmd_err)
+			fall_delay |= (1 << i);
+	}
+
+	final_rise_delay = get_best_delay(host, rise_delay);
+	final_fall_delay = get_best_delay(host, fall_delay);
+
+	final_maxlen = max(final_rise_delay.maxlen, final_fall_delay.maxlen);
+	if (final_maxlen == final_rise_delay.maxlen) {
+		sdr_clr_bits(host->base + MSDC_IOCON, MSDC_IOCON_RSPL);
+		sdr_set_field(host->base + MSDC_PAD_TUNE, MSDC_PAD_TUNE_CMDRDLY,
+			      final_rise_delay.final_phase);
+		final_delay = final_rise_delay.final_phase;
+	} else {
+		sdr_set_bits(host->base + MSDC_IOCON, MSDC_IOCON_RSPL);
+		sdr_set_field(host->base + MSDC_PAD_TUNE, MSDC_PAD_TUNE_CMDRDLY,
+			      final_fall_delay.final_phase);
+		final_delay = final_fall_delay.final_phase;
+	}
+
+	return final_delay == 0xff ? -EIO : 0;
+}
+
+static int msdc_tune_data(struct mmc_host *mmc, u32 opcode)
+{
+	struct msdc_host *host = mmc_priv(mmc);
+	u32 rise_delay = 0, fall_delay = 0;
+	struct msdc_delay_phase final_rise_delay, final_fall_delay;
+	u8 final_delay, final_maxlen;
+	int i, ret;
+
+	sdr_clr_bits(host->base + MSDC_IOCON, MSDC_IOCON_DSPL);
+	sdr_clr_bits(host->base + MSDC_IOCON, MSDC_IOCON_W_DSPL);
+	for (i = 0 ; i < PAD_DELAY_MAX; i++) {
+		sdr_set_field(host->base + MSDC_PAD_TUNE,
+			      MSDC_PAD_TUNE_DATRRDLY, i);
+		ret = mmc_send_tuning(mmc, opcode, NULL);
+		if (!ret)
+			rise_delay |= (1 << i);
+	}
+
+	sdr_set_bits(host->base + MSDC_IOCON, MSDC_IOCON_DSPL);
+	sdr_set_bits(host->base + MSDC_IOCON, MSDC_IOCON_W_DSPL);
+	for (i = 0; i < PAD_DELAY_MAX; i++) {
+		sdr_set_field(host->base + MSDC_PAD_TUNE,
+			      MSDC_PAD_TUNE_DATRRDLY, i);
+		ret = mmc_send_tuning(mmc, opcode, NULL);
+		if (!ret)
+			fall_delay |= (1 << i);
+	}
+
+	final_rise_delay = get_best_delay(host, rise_delay);
+	final_fall_delay = get_best_delay(host, fall_delay);
+
+	final_maxlen = max(final_rise_delay.maxlen, final_fall_delay.maxlen);
+	/* Rising edge is more stable, prefer to use it */
+	if (final_rise_delay.maxlen >= 10)
+		final_maxlen = final_rise_delay.maxlen;
+	if (final_maxlen == final_rise_delay.maxlen) {
+		sdr_clr_bits(host->base + MSDC_IOCON, MSDC_IOCON_DSPL);
+		sdr_clr_bits(host->base + MSDC_IOCON, MSDC_IOCON_W_DSPL);
+		sdr_set_field(host->base + MSDC_PAD_TUNE,
+			      MSDC_PAD_TUNE_DATRRDLY,
+			      final_rise_delay.final_phase);
+		final_delay = final_rise_delay.final_phase;
+	} else {
+		sdr_set_bits(host->base + MSDC_IOCON, MSDC_IOCON_DSPL);
+		sdr_set_bits(host->base + MSDC_IOCON, MSDC_IOCON_W_DSPL);
+		sdr_set_field(host->base + MSDC_PAD_TUNE,
+			      MSDC_PAD_TUNE_DATRRDLY,
+			      final_fall_delay.final_phase);
+		final_delay = final_fall_delay.final_phase;
+	}
+
+	return final_delay == 0xff ? -EIO : 0;
+}
+
+static int msdc_execute_tuning(struct mmc_host *mmc, u32 opcode)
+{
+	struct msdc_host *host = mmc_priv(mmc);
+	int ret;
+
+	pm_runtime_get_sync(host->dev);
+	ret = msdc_tune_response(mmc, opcode);
+	if (ret == -EIO) {
+		dev_err(host->dev, "Tune response fail!\n");
+		goto out;
+	}
+	ret = msdc_tune_data(mmc, opcode);
+	if (ret == -EIO)
+		dev_err(host->dev, "Tune data fail!\n");
+
+out:
+	pm_runtime_mark_last_busy(host->dev);
+	pm_runtime_put_autosuspend(host->dev);
+	return ret;
+}
+
+static int msdc_prepare_hs400_tuning(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	struct msdc_host *host = mmc_priv(mmc);
+
+	writel(host->hs400_ds_delay, host->base + PAD_DS_TUNE);
+	return 0;
+}
+
 static void msdc_hw_reset(struct mmc_host *mmc)
 {
 	struct msdc_host *host = mmc_priv(mmc);
@@ -1226,6 +1454,8 @@ static struct mmc_host_ops mt_msdc_ops = {
 	.set_ios = msdc_ops_set_ios,
 	.start_signal_voltage_switch = msdc_ops_switch_volt,
 	.card_busy = msdc_card_busy,
+	.execute_tuning = msdc_execute_tuning,
+	.prepare_hs400_tuning = msdc_prepare_hs400_tuning,
 	.hw_reset = msdc_hw_reset,
 };
 
@@ -1300,6 +1530,11 @@ static int msdc_drv_probe(struct platform_device *pdev)
 		goto host_free;
 	}
 
+	if (!of_property_read_u32(pdev->dev.of_node, "hs400-ds-delay",
+				  &host->hs400_ds_delay))
+		dev_dbg(&pdev->dev, "hs400-ds-delay: %x\n",
+			host->hs400_ds_delay);
+
 	host->dev = &pdev->dev;
 	host->mmc = mmc;
 	host->src_clk_freq = clk_get_rate(host->src_clk);
@@ -1410,6 +1645,8 @@ static void msdc_save_reg(struct msdc_host *host)
 	host->save_para.pad_tune = readl(host->base + MSDC_PAD_TUNE);
 	host->save_para.patch_bit0 = readl(host->base + MSDC_PATCH_BIT);
 	host->save_para.patch_bit1 = readl(host->base + MSDC_PATCH_BIT1);
+	host->save_para.pad_ds_tune = readl(host->base + PAD_DS_TUNE);
+	host->save_para.emmc50_cfg0 = readl(host->base + EMMC50_CFG0);
 }
 
 static void msdc_restore_reg(struct msdc_host *host)
@@ -1420,6 +1657,8 @@ static void msdc_restore_reg(struct msdc_host *host)
 	writel(host->save_para.pad_tune, host->base + MSDC_PAD_TUNE);
 	writel(host->save_para.patch_bit0, host->base + MSDC_PATCH_BIT);
 	writel(host->save_para.patch_bit1, host->base + MSDC_PATCH_BIT1);
+	writel(host->save_para.pad_ds_tune, host->base + PAD_DS_TUNE);
+	writel(host->save_para.emmc50_cfg0, host->base + EMMC50_CFG0);
 }
 
 static int msdc_runtime_suspend(struct device *dev)
-- 
1.8.1.1.dirty

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

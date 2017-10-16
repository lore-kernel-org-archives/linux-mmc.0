From: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v6 06/12] mmc: mediatek: add async fifo and data tune support
Date: Mon, 16 Oct 2017 09:46:33 +0800
Message-ID: <1508118399-21828-7-git-send-email-chaotian.jing@mediatek.com>
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

mt2701/mt2712 supports async fifo & data tune, which can improve
host stability.

Signed-off-by: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 drivers/mmc/host/mtk-sd.c | 52 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index bcd83d6..8113bac 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -74,6 +74,7 @@
 #define MSDC_DMA_CFG     0x9c
 #define MSDC_PATCH_BIT   0xb0
 #define MSDC_PATCH_BIT1  0xb4
+#define MSDC_PATCH_BIT2  0xb8
 #define MSDC_PAD_TUNE    0xec
 #define MSDC_PAD_TUNE0   0xf0
 #define PAD_DS_TUNE      0x188
@@ -216,11 +217,20 @@
 #define MSDC_PATCH_BIT_SPCPUSH    (0x1 << 29)	/* RW */
 #define MSDC_PATCH_BIT_DECRCTMO   (0x1 << 30)	/* RW */
 
+#define MSDC_PATCH_BIT2_CFGRESP   (0x1 << 15)   /* RW */
+#define MSDC_PATCH_BIT2_CFGCRCSTS (0x1 << 28)   /* RW */
+#define MSDC_PB2_RESPWAIT         (0x3 << 2)    /* RW */
+#define MSDC_PB2_RESPSTSENSEL     (0x7 << 16)   /* RW */
+#define MSDC_PB2_CRCSTSENSEL      (0x7 << 29)   /* RW */
+
 #define MSDC_PAD_TUNE_DATWRDLY	  (0x1f <<  0)	/* RW */
 #define MSDC_PAD_TUNE_DATRRDLY	  (0x1f <<  8)	/* RW */
 #define MSDC_PAD_TUNE_CMDRDLY	  (0x1f << 16)  /* RW */
 #define MSDC_PAD_TUNE_CMDRRDLY	  (0x1f << 22)	/* RW */
 #define MSDC_PAD_TUNE_CLKTDLY	  (0x1f << 27)  /* RW */
+#define MSDC_PAD_TUNE_RXDLYSEL	  (0x1 << 15)   /* RW */
+#define MSDC_PAD_TUNE_RD_SEL	  (0x1 << 13)   /* RW */
+#define MSDC_PAD_TUNE_CMD_SEL	  (0x1 << 21)   /* RW */
 
 #define PAD_DS_TUNE_DLY1	  (0x1f << 2)   /* RW */
 #define PAD_DS_TUNE_DLY2	  (0x1f << 7)   /* RW */
@@ -294,6 +304,7 @@ struct msdc_save_para {
 	u32 pad_tune;
 	u32 patch_bit0;
 	u32 patch_bit1;
+	u32 patch_bit2;
 	u32 pad_ds_tune;
 	u32 pad_cmd_tune;
 	u32 emmc50_cfg0;
@@ -303,6 +314,8 @@ struct mtk_mmc_compatible {
 	u8 clk_div_bits;
 	bool hs400_tune; /* only used for MT8173 */
 	u32 pad_tune_reg;
+	bool async_fifo;
+	bool data_tune;
 };
 
 struct msdc_tune_para {
@@ -365,24 +378,32 @@ struct msdc_host {
 	.clk_div_bits = 8,
 	.hs400_tune = false,
 	.pad_tune_reg = MSDC_PAD_TUNE,
+	.async_fifo = false,
+	.data_tune = false,
 };
 
 static const struct mtk_mmc_compatible mt8173_compat = {
 	.clk_div_bits = 8,
 	.hs400_tune = true,
 	.pad_tune_reg = MSDC_PAD_TUNE,
+	.async_fifo = false,
+	.data_tune = false,
 };
 
 static const struct mtk_mmc_compatible mt2701_compat = {
 	.clk_div_bits = 12,
 	.hs400_tune = false,
 	.pad_tune_reg = MSDC_PAD_TUNE0,
+	.async_fifo = true,
+	.data_tune = true,
 };
 
 static const struct mtk_mmc_compatible mt2712_compat = {
 	.clk_div_bits = 12,
 	.hs400_tune = false,
 	.pad_tune_reg = MSDC_PAD_TUNE0,
+	.async_fifo = true,
+	.data_tune = true,
 };
 
 static const struct of_device_id msdc_of_ids[] = {
@@ -1252,8 +1273,29 @@ static void msdc_init_hw(struct msdc_host *host)
 	sdr_set_field(host->base + MSDC_IOCON, MSDC_IOCON_DDLSEL, 0);
 	writel(0x403c0046, host->base + MSDC_PATCH_BIT);
 	sdr_set_field(host->base + MSDC_PATCH_BIT, MSDC_CKGEN_MSDC_DLY_SEL, 1);
-	writel(0xffff0089, host->base + MSDC_PATCH_BIT1);
+	writel(0xffff4089, host->base + MSDC_PATCH_BIT1);
 	sdr_set_bits(host->base + EMMC50_CFG0, EMMC50_CFG_CFCSTS_SEL);
+	if (host->dev_comp->async_fifo) {
+		sdr_set_field(host->base + MSDC_PATCH_BIT2,
+			      MSDC_PB2_RESPWAIT, 3);
+		sdr_set_field(host->base + MSDC_PATCH_BIT2,
+			      MSDC_PB2_RESPSTSENSEL, 2);
+		sdr_set_field(host->base + MSDC_PATCH_BIT2,
+			      MSDC_PB2_CRCSTSENSEL, 2);
+		/* use async fifo, then no need tune internal delay */
+		sdr_clr_bits(host->base + MSDC_PATCH_BIT2,
+			     MSDC_PATCH_BIT2_CFGRESP);
+		sdr_set_bits(host->base + MSDC_PATCH_BIT2,
+			     MSDC_PATCH_BIT2_CFGCRCSTS);
+	}
+
+	if (host->dev_comp->data_tune) {
+		sdr_set_bits(host->base + tune_reg,
+			     MSDC_PAD_TUNE_RD_SEL | MSDC_PAD_TUNE_CMD_SEL);
+	} else {
+		/* choose clock tune */
+		sdr_set_bits(host->base + tune_reg, MSDC_PAD_TUNE_RXDLYSEL);
+	}
 
 	/* Configure to enable SDIO mode.
 	 * it's must otherwise sdio cmd5 failed
@@ -1268,6 +1310,8 @@ static void msdc_init_hw(struct msdc_host *host)
 
 	host->def_tune_para.iocon = readl(host->base + MSDC_IOCON);
 	host->def_tune_para.pad_tune = readl(host->base + tune_reg);
+	host->saved_tune_para.iocon = readl(host->base + MSDC_IOCON);
+	host->saved_tune_para.pad_tune = readl(host->base + tune_reg);
 	dev_dbg(host->dev, "init hardware done!");
 }
 
@@ -1480,7 +1524,7 @@ static int msdc_tune_response(struct mmc_host *mmc, u32 opcode)
 			      final_fall_delay.final_phase);
 		final_delay = final_fall_delay.final_phase;
 	}
-	if (host->hs200_cmd_int_delay)
+	if (host->dev_comp->async_fifo || host->hs200_cmd_int_delay)
 		goto skip_internal;
 
 	for (i = 0; i < PAD_DELAY_MAX; i++) {
@@ -1638,6 +1682,8 @@ static int msdc_prepare_hs400_tuning(struct mmc_host *mmc, struct mmc_ios *ios)
 	host->hs400_mode = true;
 
 	writel(host->hs400_ds_delay, host->base + PAD_DS_TUNE);
+	/* hs400 mode must set it to 0 */
+	sdr_clr_bits(host->base + MSDC_PATCH_BIT2, MSDC_PATCH_BIT2_CFGCRCSTS);
 	return 0;
 }
 
@@ -1876,6 +1922,7 @@ static void msdc_save_reg(struct msdc_host *host)
 	host->save_para.pad_tune = readl(host->base + tune_reg);
 	host->save_para.patch_bit0 = readl(host->base + MSDC_PATCH_BIT);
 	host->save_para.patch_bit1 = readl(host->base + MSDC_PATCH_BIT1);
+	host->save_para.patch_bit2 = readl(host->base + MSDC_PATCH_BIT2);
 	host->save_para.pad_ds_tune = readl(host->base + PAD_DS_TUNE);
 	host->save_para.pad_cmd_tune = readl(host->base + PAD_CMD_TUNE);
 	host->save_para.emmc50_cfg0 = readl(host->base + EMMC50_CFG0);
@@ -1891,6 +1938,7 @@ static void msdc_restore_reg(struct msdc_host *host)
 	writel(host->save_para.pad_tune, host->base + tune_reg);
 	writel(host->save_para.patch_bit0, host->base + MSDC_PATCH_BIT);
 	writel(host->save_para.patch_bit1, host->base + MSDC_PATCH_BIT1);
+	writel(host->save_para.patch_bit2, host->base + MSDC_PATCH_BIT2);
 	writel(host->save_para.pad_ds_tune, host->base + PAD_DS_TUNE);
 	writel(host->save_para.pad_cmd_tune, host->base + PAD_CMD_TUNE);
 	writel(host->save_para.emmc50_cfg0, host->base + EMMC50_CFG0);
-- 
1.8.1.1.dirty

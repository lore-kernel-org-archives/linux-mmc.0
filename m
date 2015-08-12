From: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 2/4] mmc: mediatek: Add HS400 support
Date: Wed, 12 Aug 2015 16:24:03 +0800
Message-ID: <1439367845-5891-3-git-send-email-chaotian.jing@mediatek.com>
References: <1439367845-5891-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1439367845-5891-1-git-send-email-chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, James Liao <jamesjj.liao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Wenbin Mei <sin_wenbinmei-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Hongzhou Yang <hongzhou.yang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "Joe.C" <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, bin.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Liuquan Ji <liuquan.ji-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Yong Mao <yong.mao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Support HS400 mode in driver

Signed-off-by: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 drivers/mmc/host/mtk-sd.c | 108 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 86 insertions(+), 22 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index eb44fe1..457d919 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -72,6 +72,8 @@
 #define MSDC_PATCH_BIT   0xb0
 #define MSDC_PATCH_BIT1  0xb4
 #define MSDC_PAD_TUNE    0xec
+#define PAD_DS_TUNE      0x188
+#define EMMC50_CFG0      0x208
 
 /*--------------------------------------------------------------------------*/
 /* Register Mask                                                            */
@@ -205,6 +207,14 @@
 #define MSDC_PATCH_BIT_SPCPUSH    (0x1 << 29)	/* RW */
 #define MSDC_PATCH_BIT_DECRCTMO   (0x1 << 30)	/* RW */
 
+#define PAD_DS_TUNE_DLY1	  (0x1f << 2)
+#define PAD_DS_TUNE_DLY2	  (0x1f << 7)
+#define PAD_DS_TUNE_DLY3	  (0x1f << 12)
+
+#define EMMC50_CFG_PADCMD_LATCHCK (0x1 << 0)
+#define EMMC50_CFG_CRCSTS_EDGE    (0x1 << 3)
+#define EMMC50_CFG_CFCSTS_SEL     (0x1 << 4)
+
 #define REQ_CMD_EIO  (0x1 << 0)
 #define REQ_CMD_TMO  (0x1 << 1)
 #define REQ_DAT_ERR  (0x1 << 2)
@@ -266,6 +276,8 @@ struct msdc_save_para {
 	u32 pad_tune;
 	u32 patch_bit0;
 	u32 patch_bit1;
+	u32 pad_ds_tune;
+	u32 emmc50_cfg0;
 };
 
 struct msdc_host {
@@ -295,14 +307,17 @@ struct msdc_host {
 	struct work_struct repeat_req;
 	struct mmc_request *repeat_mrq;
 	u32 tune_cmd_counter;
+	u32 tune_hs400_rw_counter;
 	int irq;		/* host interrupt */
 
 	struct clk *src_clk;	/* msdc source clock */
+	struct clk *src_clk_parent; /* src_clk's parent */
+	struct clk *hs400_src;	/* 400Mhz source clock */
 	struct clk *h_clk;      /* msdc h_clk */
 	u32 mclk;		/* mmc subsystem clock frequency */
 	u32 src_clk_freq;	/* source clock frequency */
 	u32 sclk;		/* SD/MS bus clock frequency */
-	bool ddr;
+	unsigned char timing;
 	bool vqmmc_enabled;
 	struct msdc_save_para save_para; /* used when gate HCLK */
 };
@@ -493,7 +508,7 @@ static void msdc_ungate_clock(struct msdc_host *host)
 		cpu_relax();
 }
 
-static void msdc_set_mclk(struct msdc_host *host, int ddr, u32 hz)
+static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
 {
 	u32 mode;
 	u32 flags;
@@ -509,8 +524,13 @@ static void msdc_set_mclk(struct msdc_host *host, int ddr, u32 hz)
 
 	flags = readl(host->base + MSDC_INTEN);
 	sdr_clr_bits(host->base + MSDC_INTEN, flags);
-	if (ddr) { /* may need to modify later */
-		mode = 0x2; /* ddr mode and use divisor */
+	if (timing == MMC_TIMING_UHS_DDR50 ||
+	    timing == MMC_TIMING_MMC_DDR52 ||
+	    timing == MMC_TIMING_MMC_HS400) { /* may need to modify later */
+		if (timing == MMC_TIMING_MMC_HS400)
+			mode = 0x3;
+		else
+			mode = 0x2; /* ddr mode and use divisor */
 		if (hz >= (host->src_clk_freq >> 2)) {
 			div = 0; /* mean div = 1/4 */
 			sclk = host->src_clk_freq >> 2; /* sclk = clk / 4 */
@@ -540,12 +560,12 @@ static void msdc_set_mclk(struct msdc_host *host, int ddr, u32 hz)
 		cpu_relax();
 	host->sclk = sclk;
 	host->mclk = hz;
-	host->ddr = ddr;
+	host->timing = timing;
 	/* need because clk changed. */
 	msdc_set_timeout(host, host->timeout_ns, host->timeout_clks);
 	sdr_set_bits(host->base + MSDC_INTEN, flags);
 
-	dev_dbg(host->dev, "sclk: %d, ddr: %d\n", host->sclk, ddr);
+	dev_dbg(host->dev, "sclk: %d, timing: %d\n", host->sclk, timing);
 }
 
 static inline u32 msdc_cmd_find_resp(struct msdc_host *host,
@@ -710,6 +730,7 @@ static void msdc_request_done(struct msdc_host *host, struct mmc_request *mrq)
 		}
 	}
 	host->tune_cmd_counter = 0;
+	host->tune_hs400_rw_counter = 0;
 	mmc_request_done(host->mmc, mrq);
 
 	pm_runtime_mark_last_busy(host->dev);
@@ -1132,6 +1153,7 @@ static void msdc_init_hw(struct msdc_host *host)
 	writel(0x403c0046, host->base + MSDC_PATCH_BIT);
 	sdr_set_field(host->base + MSDC_PATCH_BIT, MSDC_CKGEN_MSDC_DLY_SEL, 1);
 	writel(0xffff0089, host->base + MSDC_PATCH_BIT1);
+	sdr_set_bits(host->base + EMMC50_CFG0, EMMC50_CFG_CFCSTS_SEL);
 	/* Configure to enable SDIO mode.
 	 * it's must otherwise sdio cmd5 failed
 	 */
@@ -1163,11 +1185,14 @@ static void msdc_init_gpd_bd(struct msdc_host *host, struct msdc_dma *dma)
 	struct mt_bdma_desc *bd = dma->bd;
 	int i;
 
-	memset(gpd, 0, sizeof(struct mt_gpdma_desc));
+	memset(gpd, 0, sizeof(struct mt_gpdma_desc) * 2);
 
 	gpd->gpd_info = GPDMA_DESC_BDP; /* hwo, cs, bd pointer */
 	gpd->ptr = (u32)dma->bd_addr; /* physical address */
-
+	/* gpd->next is must set for desc DMA
+	 * That's why must alloc 2 gpd structure.
+	 */
+	gpd->next = (u32)dma->gpd_addr + sizeof(struct mt_gpdma_desc);
 	memset(bd, 0, sizeof(struct mt_bdma_desc) * MAX_BD_NUM);
 	for (i = 0; i < (MAX_BD_NUM - 1); i++)
 		bd[i].next = (u32)dma->bd_addr + sizeof(*bd) * (i + 1);
@@ -1177,14 +1202,9 @@ static void msdc_ops_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct msdc_host *host = mmc_priv(mmc);
 	int ret;
-	u32 ddr = 0;
 
 	pm_runtime_get_sync(host->dev);
 
-	if (ios->timing == MMC_TIMING_UHS_DDR50 ||
-	    ios->timing == MMC_TIMING_MMC_DDR52)
-		ddr = 1;
-
 	msdc_set_buswidth(host, ios->bus_width);
 
 	/* Suspend/Resume will do power off/on */
@@ -1222,8 +1242,8 @@ static void msdc_ops_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		break;
 	}
 
-	if (host->mclk != ios->clock || host->ddr != ddr)
-		msdc_set_mclk(host, ddr, ios->clock);
+	if (host->mclk != ios->clock || host->timing != ios->timing)
+		msdc_set_mclk(host, ios->timing, ios->clock);
 
 end:
 	pm_runtime_mark_last_busy(host->dev);
@@ -1290,7 +1310,6 @@ static void msdc_tune_request(struct msdc_host *host)
 {
 	u32 orig_rsmpl, orig_cksel;
 	u32 cur_rsmpl, cur_cksel = 0;
-	u32 ddr, clkmode;
 	struct mmc_ios ios = host->mmc->ios;
 
 	sdr_get_field(host->base + MSDC_IOCON, MSDC_IOCON_RSPL, &orig_rsmpl);
@@ -1318,9 +1337,38 @@ static void msdc_tune_request(struct msdc_host *host)
 		sdr_set_field(host->base + MSDC_IOCON, MSDC_IOCON_RSPL, 0);
 		sdr_set_field(host->base + MSDC_PATCH_BIT,
 			      MSDC_CKGEN_MSDC_DLY_SEL, 0);
-		sdr_get_field(host->base + MSDC_CFG, MSDC_CFG_CKMOD, &clkmode);
-		ddr = (clkmode == 2) ? 1 : 0;
-		msdc_set_mclk(host, ddr, host->mclk / 2);
+		msdc_set_mclk(host, host->timing, host->mclk / 2);
+	}
+}
+
+static void emmc_hs400_tune_rw(struct msdc_host *host)
+{
+	int cur_ds_dly1, cur_ds_dly3, orig_ds_dly1, orig_ds_dly3;
+
+	sdr_get_field(host->base + PAD_DS_TUNE, PAD_DS_TUNE_DLY1, &orig_ds_dly1);
+	sdr_get_field(host->base + PAD_DS_TUNE, PAD_DS_TUNE_DLY3, &orig_ds_dly3);
+
+	cur_ds_dly1 = orig_ds_dly1 - 1;
+	cur_ds_dly3 = orig_ds_dly3;
+	if (cur_ds_dly1 < 0) {
+		cur_ds_dly1 = 31;
+		cur_ds_dly3 = orig_ds_dly3 + 1;
+		if (cur_ds_dly3 >= 32)
+			cur_ds_dly3 = 0;
+	}
+
+	if (++host->tune_hs400_rw_counter >= 32 * 32) {
+		dev_warn(host->dev, "HS400 tune fail at %dhz\n", host->mclk);
+		host->tune_hs400_rw_counter = 0;
+		msdc_set_mclk(host, host->timing, host->mclk / 2);
+	} else {
+		sdr_set_field(host->base + PAD_DS_TUNE, PAD_DS_TUNE_DLY1, cur_ds_dly1);
+		if (cur_ds_dly3 != orig_ds_dly3) {
+			sdr_set_field(host->base + PAD_DS_TUNE, PAD_DS_TUNE_DLY3,
+				      cur_ds_dly3);
+		}
+		dev_dbg(host->dev, "cur_ds_dly1<0x%x>, cur_ds_dly3<0x%x>\n",
+				cur_ds_dly1, cur_ds_dly3);
 	}
 }
 
@@ -1336,10 +1384,15 @@ static void msdc_repeat_request(struct work_struct *work)
 	spin_unlock_irqrestore(&host->lock, flags);
 	msdc_send_stop(host);
 	msdc_wait_card_not_busy(host);
-	if (mrq->data && mrq->data->error == -ETIMEDOUT)
+	if (mrq->data && mrq->data->error == -ETIMEDOUT) {
 		mmc_hw_reset(host->mmc);
-	else
-		msdc_tune_request(host);
+	} else {
+		if (mrq->data && mrq->data->error == -EILSEQ &&
+		    host->timing == MMC_TIMING_MMC_HS400)
+			emmc_hs400_tune_rw(host);
+		else
+			msdc_tune_request(host);
+	}
 	msdc_reset_mrq(mrq);
 	msdc_ops_request(host->mmc, mrq);
 }
@@ -1389,6 +1442,13 @@ static int msdc_drv_probe(struct platform_device *pdev)
 	if (IS_ERR(host->src_clk)) {
 		ret = PTR_ERR(host->src_clk);
 		goto host_free;
+	} else {
+		host->src_clk_parent = clk_get_parent(host->src_clk);
+		host->hs400_src = devm_clk_get(&pdev->dev, "400Mhz_clk");
+		if (IS_ERR(host->hs400_src))
+			dev_dbg(&pdev->dev, "Cannot find 400Mhz_clk at dts!\n");
+		else if (clk_set_parent(host->src_clk_parent, host->hs400_src) < 0)
+				dev_err(host->dev, "Failed to set 400Mhz source clock!\n");
 	}
 
 	host->h_clk = devm_clk_get(&pdev->dev, "hclk");
@@ -1541,6 +1601,8 @@ static void msdc_save_reg(struct msdc_host *host)
 	host->save_para.pad_tune = readl(host->base + MSDC_PAD_TUNE);
 	host->save_para.patch_bit0 = readl(host->base + MSDC_PATCH_BIT);
 	host->save_para.patch_bit1 = readl(host->base + MSDC_PATCH_BIT1);
+	host->save_para.pad_ds_tune = readl(host->base + PAD_DS_TUNE);
+	host->save_para.emmc50_cfg0 = readl(host->base + EMMC50_CFG0);
 }
 
 static void msdc_restore_reg(struct msdc_host *host)
@@ -1551,6 +1613,8 @@ static void msdc_restore_reg(struct msdc_host *host)
 	writel(host->save_para.pad_tune, host->base + MSDC_PAD_TUNE);
 	writel(host->save_para.patch_bit0, host->base + MSDC_PATCH_BIT);
 	writel(host->save_para.patch_bit1, host->base + MSDC_PATCH_BIT1);
+	writel(host->save_para.pad_ds_tune, host->base + PAD_DS_TUNE);
+	writel(host->save_para.emmc50_cfg0, host->base + EMMC50_CFG0);
 }
 
 static int msdc_runtime_suspend(struct device *dev)
-- 
1.8.1.1.dirty

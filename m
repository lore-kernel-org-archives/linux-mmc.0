From: Chun-Hung Wu <chun-hung.wu@mediatek.com>
Subject: [PATCH 2/3] [2/3] mmc: mediatek: command queue support
Date: Fri, 1 Nov 2019 14:43:01 +0800
Message-ID: <1572590582-11056-2-git-send-email-chun-hung.wu@mediatek.com>
References: <1572590582-11056-1-git-send-email-chun-hung.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1572590582-11056-1-git-send-email-chun-hung.wu@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chaotian Jing <chaotian.jing@mediatek.com>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Pavel Machek <pavel@ucw.cz>, Kate Stewart <kstewart@linuxfoundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Pan Bian <bianpan2016@163.com>, Thomas Gleixner <tglx@linutronix.de>, Stanley Chu <stanley.chu@mediatek.com>, Kuohong Wang <kuohong.wang@mediatek.com>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, wsd_upstream@mediatek.com, linux-arm-kernel@lists.infradead.org, Chun-Hung Wu <chun-hung.wu@mediatek.com>
List-Id: linux-mmc@vger.kernel.org

Support command queue for mt6779 platform.

Change-Id: I56b866fa4097a3c0bee77f53486c470e4f1944b9
Feature:
Signed-off-by: Chun-Hung Wu <chun-hung.wu@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 151 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 141 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 189e426..b132397 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -31,6 +31,8 @@
 #include <linux/mmc/sdio.h>
 #include <linux/mmc/slot-gpio.h>
 
+#include "cqhci.h"
+
 #define MAX_BD_NUM          1024
 
 /*--------------------------------------------------------------------------*/
@@ -151,6 +153,7 @@
 #define MSDC_INT_DMA_BDCSERR    (0x1 << 17)	/* W1C */
 #define MSDC_INT_DMA_GPDCSERR   (0x1 << 18)	/* W1C */
 #define MSDC_INT_DMA_PROTECT    (0x1 << 19)	/* W1C */
+#define MSDC_INT_CMDQ           (0x1 << 28)	/* W1C */
 
 /* MSDC_INTEN mask */
 #define MSDC_INTEN_MMCIRQ       (0x1 << 0)	/* RW */
@@ -181,6 +184,7 @@
 /* SDC_CFG mask */
 #define SDC_CFG_SDIOINTWKUP     (0x1 << 0)	/* RW */
 #define SDC_CFG_INSWKUP         (0x1 << 1)	/* RW */
+#define SDC_CFG_WRDTOC          (0x1fff  << 2)  /* RW */
 #define SDC_CFG_BUSWIDTH        (0x3 << 16)	/* RW */
 #define SDC_CFG_SDIO            (0x1 << 19)	/* RW */
 #define SDC_CFG_SDIOIDE         (0x1 << 20)	/* RW */
@@ -228,6 +232,7 @@
 #define MSDC_PATCH_BIT_SPCPUSH    (0x1 << 29)	/* RW */
 #define MSDC_PATCH_BIT_DECRCTMO   (0x1 << 30)	/* RW */
 
+#define MSDC_PB1_BUSY_CHECK_SEL   (0x1 << 7)    /* RW */
 #define MSDC_PATCH_BIT1_STOP_DLY  (0xf << 8)    /* RW */
 
 #define MSDC_PATCH_BIT2_CFGRESP   (0x1 << 15)   /* RW */
@@ -431,6 +436,7 @@ struct msdc_host {
 	struct msdc_save_para save_para; /* used when gate HCLK */
 	struct msdc_tune_para def_tune_para; /* default tune setting */
 	struct msdc_tune_para saved_tune_para; /* tune result of CMD21/CMD19 */
+	struct cqhci_host *cq_host;
 };
 
 static const struct mtk_mmc_compatible mt8135_compat = {
@@ -527,6 +533,18 @@ struct msdc_host {
 	.use_internal_cd = true,
 };
 
+static const struct mtk_mmc_compatible mt6779_compat = {
+	.clk_div_bits = 12,
+	.hs400_tune = false,
+	.pad_tune_reg = MSDC_PAD_TUNE0,
+	.async_fifo = true,
+	.data_tune = true,
+	.busy_check = true,
+	.stop_clk_fix = true,
+	.enhance_rx = true,
+	.support_64g = true,
+};
+
 static const struct of_device_id msdc_of_ids[] = {
 	{ .compatible = "mediatek,mt8135-mmc", .data = &mt8135_compat},
 	{ .compatible = "mediatek,mt8173-mmc", .data = &mt8173_compat},
@@ -536,6 +554,7 @@ struct msdc_host {
 	{ .compatible = "mediatek,mt7622-mmc", .data = &mt7622_compat},
 	{ .compatible = "mediatek,mt8516-mmc", .data = &mt8516_compat},
 	{ .compatible = "mediatek,mt7620-mmc", .data = &mt7620_compat},
+	{ .compatible = "mediatek,mt6779-mmc", .data = &mt6779_compat},
 	{}
 };
 MODULE_DEVICE_TABLE(of, msdc_of_ids);
@@ -698,21 +717,21 @@ static void msdc_unprepare_data(struct msdc_host *host, struct mmc_request *mrq)
 	}
 }
 
-/* clock control primitives */
-static void msdc_set_timeout(struct msdc_host *host, u32 ns, u32 clks)
+static u64 msdc_timeout_cal(struct msdc_host *host, u64 ns, u64 clks)
 {
-	u32 timeout, clk_ns;
+	u64 timeout, clk_ns;
 	u32 mode = 0;
 
-	host->timeout_ns = ns;
-	host->timeout_clks = clks;
 	if (host->mmc->actual_clock == 0) {
 		timeout = 0;
 	} else {
-		clk_ns  = 1000000000UL / host->mmc->actual_clock;
-		timeout = (ns + clk_ns - 1) / clk_ns + clks;
+		clk_ns  = 1000000000ULL;
+		do_div(clk_ns, host->mmc->actual_clock);
+		timeout = ns + clk_ns - 1;
+		do_div(timeout, clk_ns);
+		timeout += clks;
 		/* in 1048576 sclk cycle unit */
-		timeout = (timeout + (0x1 << 20) - 1) >> 20;
+		timeout = DIV_ROUND_UP(timeout, (0x1 << 20));
 		if (host->dev_comp->clk_div_bits == 8)
 			sdr_get_field(host->base + MSDC_CFG,
 				      MSDC_CFG_CKMOD, &mode);
@@ -722,9 +741,30 @@ static void msdc_set_timeout(struct msdc_host *host, u32 ns, u32 clks)
 		/*DDR mode will double the clk cycles for data timeout */
 		timeout = mode >= 2 ? timeout * 2 : timeout;
 		timeout = timeout > 1 ? timeout - 1 : 0;
-		timeout = timeout > 255 ? 255 : timeout;
 	}
-	sdr_set_field(host->base + SDC_CFG, SDC_CFG_DTOC, timeout);
+	return timeout;
+}
+
+/* clock control primitives */
+static void msdc_set_timeout(struct msdc_host *host, u64 ns, u64 clks)
+{
+	u64 timeout;
+
+	host->timeout_ns = ns;
+	host->timeout_clks = clks;
+
+	timeout = msdc_timeout_cal(host, ns, clks);
+	sdr_set_field(host->base + SDC_CFG, SDC_CFG_DTOC,
+		      (u32)(timeout > 255 ? 255 : timeout));
+}
+
+static void msdc_set_busy_timeout(struct msdc_host *host, u64 ns, u64 clks)
+{
+	u64 timeout;
+
+	timeout = msdc_timeout_cal(host, ns, clks);
+	sdr_set_field(host->base + SDC_CFG, SDC_CFG_WRDTOC,
+		      (u32)(timeout > 8191 ? 8191 : timeout));
 }
 
 static void msdc_gate_clock(struct msdc_host *host)
@@ -1413,6 +1453,36 @@ static void msdc_enable_sdio_irq(struct mmc_host *mmc, int enb)
 		pm_runtime_put_noidle(host->dev);
 }
 
+#if IS_ENABLED(CONFIG_MMC_CQHCI)
+static irqreturn_t msdc_cmdq_irq(struct msdc_host *host, u32 intsts)
+{
+	int cmd_err = 0, dat_err = 0;
+
+	if (intsts & MSDC_INT_RSPCRCERR) {
+		cmd_err = (unsigned int)-EILSEQ;
+		dev_err(host->dev, "%s: CMD CRC ERR", __func__);
+	} else if (intsts & MSDC_INT_CMDTMO) {
+		cmd_err = (unsigned int)-ETIMEDOUT;
+		dev_err(host->dev, "%s: CMD TIMEOUT ERR", __func__);
+	}
+
+	if (intsts & MSDC_INT_DATCRCERR) {
+		dat_err = (unsigned int)-EILSEQ;
+		dev_err(host->dev, "%s: DATA CRC ERR", __func__);
+	} else if (intsts & MSDC_INT_DATTMO) {
+		dat_err = (unsigned int)-ETIMEDOUT;
+		dev_err(host->dev, "%s: DATA TIMEOUT ERR", __func__);
+	}
+
+	if (cmd_err || dat_err) {
+		dev_err(host->dev, "cmd_err = %d, dat_err =%d, intsts = 0x%x",
+			cmd_err, dat_err, intsts);
+	}
+
+	return cqhci_irq(host->mmc, 0, cmd_err, dat_err);
+}
+#endif
+
 static irqreturn_t msdc_irq(int irq, void *dev_id)
 {
 	struct msdc_host *host = (struct msdc_host *) dev_id;
@@ -1449,6 +1519,16 @@ static irqreturn_t msdc_irq(int irq, void *dev_id)
 		if (!(events & (event_mask & ~MSDC_INT_SDIOIRQ)))
 			break;
 
+#if IS_ENABLED(CONFIG_MMC_CQHCI)
+		if ((host->mmc->caps2 & MMC_CAP2_CQE) &&
+		    (events & MSDC_INT_CMDQ)) {
+			msdc_cmdq_irq(host, events);
+			/* clear interrupts */
+			writel(events, host->base + MSDC_INT);
+			return IRQ_HANDLED;
+		}
+#endif
+
 		if (!mrq) {
 			dev_err(host->dev,
 				"%s: MRQ=NULL; events=%08X; event_mask=%08X\n",
@@ -2132,6 +2212,36 @@ static int msdc_get_cd(struct mmc_host *mmc)
 		return !val;
 }
 
+static void msdc_cqe_enable(struct mmc_host *mmc)
+{
+	struct msdc_host *host = mmc_priv(mmc);
+
+	/* enable cmdq irq */
+	writel(MSDC_INT_CMDQ, host->base + MSDC_INTEN);
+	/* enable busy check */
+	sdr_set_bits(host->base + MSDC_PATCH_BIT1, MSDC_PB1_BUSY_CHECK_SEL);
+	/* default write data / busy timeout 20s */
+	msdc_set_busy_timeout(host, 20 * 1000000000ULL, 0);
+	/* default read data timeout 1s */
+	msdc_set_timeout(host, 1000000000ULL, 0);
+}
+
+void msdc_cqe_disable(struct mmc_host *mmc, bool recovery)
+{
+	struct msdc_host *host = mmc_priv(mmc);
+
+	/* disable cmdq irq */
+	sdr_clr_bits(host->base + MSDC_INTEN, MSDC_INT_CMDQ);
+	/* disable busy check */
+	sdr_clr_bits(host->base + MSDC_PATCH_BIT1, MSDC_PB1_BUSY_CHECK_SEL);
+
+	if (recovery) {
+		sdr_set_field(host->base + MSDC_DMA_CTRL,
+			      MSDC_DMA_CTRL_STOP, 1);
+		msdc_reset_hw(host);
+	}
+}
+
 static const struct mmc_host_ops mt_msdc_ops = {
 	.post_req = msdc_post_req,
 	.pre_req = msdc_pre_req,
@@ -2148,6 +2258,11 @@ static int msdc_get_cd(struct mmc_host *mmc)
 	.hw_reset = msdc_hw_reset,
 };
 
+static const struct cqhci_host_ops msdc_cmdq_ops = {
+	.enable         = msdc_cqe_enable,
+	.disable        = msdc_cqe_disable,
+};
+
 static void msdc_of_property_parse(struct platform_device *pdev,
 				   struct msdc_host *host)
 {
@@ -2299,6 +2414,22 @@ static int msdc_drv_probe(struct platform_device *pdev)
 		host->dma_mask = DMA_BIT_MASK(32);
 	mmc_dev(mmc)->dma_mask = &host->dma_mask;
 
+#if IS_ENABLED(CONFIG_MMC_CQHCI)
+	if (mmc->caps2 & MMC_CAP2_CQE) {
+		host->cq_host = devm_kzalloc(host->mmc->parent,
+					     sizeof(*host->cq_host),
+					     GFP_KERNEL);
+		host->cq_host->caps |= CQHCI_TASK_DESC_SZ_128;
+		host->cq_host->mmio = host->base + 0x800;
+		host->cq_host->ops = &msdc_cmdq_ops;
+		cqhci_init(host->cq_host, mmc, true);
+		mmc->max_segs = 128;
+		/* cqhci 16bit length */
+		/* 0 size, means 65536 so we don't have to -1 here */
+		mmc->max_seg_size = 64 * 1024;
+	}
+#endif
+
 	host->timeout_clks = 3 * 1048576;
 	host->dma.gpd = dma_alloc_coherent(&pdev->dev,
 				2 * sizeof(struct mt_gpdma_desc),
-- 
1.9.1

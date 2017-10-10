From: Chaotian Jing <chaotian.jing@mediatek.com>
Subject: [PATCH v4 11/12] mmc: mediatek: improve eMMC hs400 mode read performance
Date: Tue, 10 Oct 2017 17:30:30 +0800
Message-ID: <1507627831-29323-12-git-send-email-chaotian.jing@mediatek.com>
References: <1507627831-29323-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1507627831-29323-1-git-send-email-chaotian.jing@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Chaotian Jing <chaotian.jing@mediatek.com>, yong mao <yong.mao@mediatek.com>, Linus Walleij <linus.walleij@linaro.org>, Heiner Kallweit <hkallweit1@gmail.com>, Phong LE <ple@baylibre.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, srv_heupstream@mediatek.com
List-Id: linux-mmc@vger.kernel.org

enlarge outstanding value to improve read performance

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 3a1756a..4cffc04 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -81,6 +81,7 @@
 #define PAD_DS_TUNE      0x188
 #define PAD_CMD_TUNE     0x18c
 #define EMMC50_CFG0      0x208
+#define EMMC50_CFG3      0x220
 #define SDC_FIFO_CFG     0x228
 
 /*--------------------------------------------------------------------------*/
@@ -249,6 +250,8 @@
 #define EMMC50_CFG_CRCSTS_EDGE    (0x1 << 3)   /* RW */
 #define EMMC50_CFG_CFCSTS_SEL     (0x1 << 4)   /* RW */
 
+#define EMMC50_CFG3_OUTS_WR       (0x1f << 0)  /* RW */
+
 #define SDC_FIFO_CFG_WRVALIDSEL   (0x1 << 24)  /* RW */
 #define SDC_FIFO_CFG_RDVALIDSEL   (0x1 << 25)  /* RW */
 
@@ -318,6 +321,7 @@ struct msdc_save_para {
 	u32 pad_ds_tune;
 	u32 pad_cmd_tune;
 	u32 emmc50_cfg0;
+	u32 emmc50_cfg3;
 	u32 sdc_fifo_cfg;
 };
 
@@ -1761,6 +1765,9 @@ static int msdc_prepare_hs400_tuning(struct mmc_host *mmc, struct mmc_ios *ios)
 	writel(host->hs400_ds_delay, host->base + PAD_DS_TUNE);
 	/* hs400 mode must set it to 0 */
 	sdr_clr_bits(host->base + MSDC_PATCH_BIT2, MSDC_PATCH_BIT2_CFGCRCSTS);
+	/* to improve read performance, set outstanding to 2 */
+	sdr_set_field(host->base + EMMC50_CFG3, EMMC50_CFG3_OUTS_WR, 2);
+
 	return 0;
 }
 
@@ -2013,6 +2020,7 @@ static void msdc_save_reg(struct msdc_host *host)
 	host->save_para.pad_ds_tune = readl(host->base + PAD_DS_TUNE);
 	host->save_para.pad_cmd_tune = readl(host->base + PAD_CMD_TUNE);
 	host->save_para.emmc50_cfg0 = readl(host->base + EMMC50_CFG0);
+	host->save_para.emmc50_cfg3 = readl(host->base + EMMC50_CFG3);
 	host->save_para.sdc_fifo_cfg = readl(host->base + SDC_FIFO_CFG);
 }
 
@@ -2032,6 +2040,7 @@ static void msdc_restore_reg(struct msdc_host *host)
 	writel(host->save_para.pad_ds_tune, host->base + PAD_DS_TUNE);
 	writel(host->save_para.pad_cmd_tune, host->base + PAD_CMD_TUNE);
 	writel(host->save_para.emmc50_cfg0, host->base + EMMC50_CFG0);
+	writel(host->save_para.emmc50_cfg3, host->base + EMMC50_CFG3);
 	writel(host->save_para.sdc_fifo_cfg, host->base + SDC_FIFO_CFG);
 }
 
-- 
1.8.1.1.dirty

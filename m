From: NeilBrown <neil@brown.name>
Subject: [PATCH 3/5] mmc: mtk-sd: add support for config found in mt7620
 family SOCs.
Date: Tue, 16 Apr 2019 14:47:29 +1000
Message-ID: <155539004927.25108.8723794030985494935.stgit@noble.brown>
References: <155538933003.25108.3338569916935462285.stgit@noble.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <155538933003.25108.3338569916935462285.stgit@noble.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chaotian Jing <chaotian.jing@mediatek.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, thirtythreeforty@gmail.com
List-Id: linux-mmc@vger.kernel.org

mt7620 family MIPS SOCs contain the mtk-sd silicon.
Add support for this.

Signed-off-by: NeilBrown <neil@brown.name>

# Conflicts:
#	drivers/mmc/host/mtk-sd.c
---
 Documentation/devicetree/bindings/mmc/mtk-sd.txt |    1 +
 drivers/mmc/host/mtk-sd.c                        |   12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.txt b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
index ed61cd5a5b8f..b6daa9773b25 100644
--- a/Documentation/devicetree/bindings/mmc/mtk-sd.txt
+++ b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
@@ -15,6 +15,7 @@ Required properties:
 	"mediatek,mt2712-mmc": for mmc host ip compatible with mt2712
 	"mediatek,mt7622-mmc": for MT7622 SoC
 	"mediatek,mt7623-mmc", "mediatek,mt2701-mmc": for MT7623 SoC
+	"ralink,mt7620-sdhci", for MT7621 SoC (and others)
 
 - reg: physical base address of the controller and length
 - interrupts: Should contain MSDC interrupt number
diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 14e048239143..d379f2ece305 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -517,6 +517,17 @@ static const struct mtk_mmc_compatible mt8516_compat = {
 	.stop_clk_fix = true,
 };
 
+static const struct mtk_mmc_compatible mt7620_compat = {
+	.clk_div_bits = 8,
+	.hs400_tune = false,
+	.pad_tune_reg = MSDC_PAD_TUNE,
+	.async_fifo = false,
+	.data_tune = false,
+	.busy_check = false,
+	.stop_clk_fix = false,
+	.enhance_rx = false,
+};
+
 static const struct of_device_id msdc_of_ids[] = {
 	{ .compatible = "mediatek,mt8135-mmc", .data = &mt8135_compat},
 	{ .compatible = "mediatek,mt8173-mmc", .data = &mt8173_compat},
@@ -525,6 +536,7 @@ static const struct of_device_id msdc_of_ids[] = {
 	{ .compatible = "mediatek,mt2712-mmc", .data = &mt2712_compat},
 	{ .compatible = "mediatek,mt7622-mmc", .data = &mt7622_compat},
 	{ .compatible = "mediatek,mt8516-mmc", .data = &mt8516_compat},
+	{ .compatible = "ralink,mt7620-sdhci", .data = &mt7620_compat},
 	{}
 };
 MODULE_DEVICE_TABLE(of, msdc_of_ids);

From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2 1/4] mmc: meson-gx: use bitfield macros
Date: Sat, 25 Mar 2017 11:23:24 +0100
Message-ID: <ed2aa5cb-4cac-11b6-1be4-5d0e42001c45@gmail.com>
References: <aae9e7c7-d8a2-72b1-22f7-f0ad513d4667@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35166 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751159AbdCYK2h (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 25 Mar 2017 06:28:37 -0400
Received: by mail-wm0-f68.google.com with SMTP id z133so2339336wmb.2
        for <linux-mmc@vger.kernel.org>; Sat, 25 Mar 2017 03:28:35 -0700 (PDT)
In-Reply-To: <aae9e7c7-d8a2-72b1-22f7-f0ad513d4667@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

Use GENMASK consistently for all bit masks and switch to using the
bitfield macros GET_FIELD and PREP_FIELD. This hides parts of the
complexity of dealing with bit fields.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Reviewed-by: Kevin Hilman <khilman@baylibre.com>
---
v2:
- remove few unneeded defines
---
 drivers/mmc/host/meson-gx-mmc.c | 94 ++++++++++++++++++-----------------------
 1 file changed, 40 insertions(+), 54 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index b917765c..ab1f2d33 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -36,23 +36,19 @@
 #include <linux/clk-provider.h>
 #include <linux/regulator/consumer.h>
 #include <linux/interrupt.h>
+#include <linux/bitfield.h>
 
 #define DRIVER_NAME "meson-gx-mmc"
 
 #define SD_EMMC_CLOCK 0x0
-#define   CLK_DIV_SHIFT 0
-#define   CLK_DIV_WIDTH 6
-#define   CLK_DIV_MASK 0x3f
+#define   CLK_DIV_MASK GENMASK(5, 0)
 #define   CLK_DIV_MAX 63
-#define   CLK_SRC_SHIFT 6
-#define   CLK_SRC_WIDTH 2
-#define   CLK_SRC_MASK 0x3
+#define   CLK_SRC_MASK GENMASK(7, 6)
 #define   CLK_SRC_XTAL 0   /* external crystal */
 #define   CLK_SRC_XTAL_RATE 24000000
 #define   CLK_SRC_PLL 1    /* FCLK_DIV2 */
 #define   CLK_SRC_PLL_RATE 1000000000
-#define   CLK_PHASE_SHIFT 8
-#define   CLK_PHASE_MASK 0x3
+#define   CLK_CORE_PHASE_MASK GENMASK(9, 8)
 #define   CLK_PHASE_0 0
 #define   CLK_PHASE_90 1
 #define   CLK_PHASE_180 2
@@ -65,22 +61,17 @@
 #define SD_EMMC_START 0x40
 #define   START_DESC_INIT BIT(0)
 #define   START_DESC_BUSY BIT(1)
-#define   START_DESC_ADDR_SHIFT 2
-#define   START_DESC_ADDR_MASK (~0x3)
+#define   START_DESC_ADDR_MASK GENMASK(31, 2)
 
 #define SD_EMMC_CFG 0x44
-#define   CFG_BUS_WIDTH_SHIFT 0
-#define   CFG_BUS_WIDTH_MASK 0x3
+#define   CFG_BUS_WIDTH_MASK GENMASK(1, 0)
 #define   CFG_BUS_WIDTH_1 0x0
 #define   CFG_BUS_WIDTH_4 0x1
 #define   CFG_BUS_WIDTH_8 0x2
 #define   CFG_DDR BIT(2)
-#define   CFG_BLK_LEN_SHIFT 4
-#define   CFG_BLK_LEN_MASK 0xf
-#define   CFG_RESP_TIMEOUT_SHIFT 8
-#define   CFG_RESP_TIMEOUT_MASK 0xf
-#define   CFG_RC_CC_SHIFT 12
-#define   CFG_RC_CC_MASK 0xf
+#define   CFG_BLK_LEN_MASK GENMASK(7, 4)
+#define   CFG_RESP_TIMEOUT_MASK GENMASK(11, 8)
+#define   CFG_RC_CC_MASK GENMASK(15, 12)
 #define   CFG_STOP_CLOCK BIT(22)
 #define   CFG_CLK_ALWAYS_ON BIT(18)
 #define   CFG_CHK_DS BIT(20)
@@ -90,9 +81,8 @@
 #define   STATUS_BUSY BIT(31)
 
 #define SD_EMMC_IRQ_EN 0x4c
-#define   IRQ_EN_MASK 0x3fff
-#define   IRQ_RXD_ERR_SHIFT 0
-#define   IRQ_RXD_ERR_MASK 0xff
+#define   IRQ_EN_MASK GENMASK(13, 0)
+#define   IRQ_RXD_ERR_MASK GENMASK(7, 0)
 #define   IRQ_TXD_ERR BIT(8)
 #define   IRQ_DESC_ERR BIT(9)
 #define   IRQ_RESP_ERR BIT(10)
@@ -149,13 +139,12 @@ struct sd_emmc_desc {
 	u32 cmd_data;
 	u32 cmd_resp;
 };
-#define CMD_CFG_LENGTH_SHIFT 0
-#define CMD_CFG_LENGTH_MASK 0x1ff
+
+#define CMD_CFG_LENGTH_MASK GENMASK(8, 0)
 #define CMD_CFG_BLOCK_MODE BIT(9)
 #define CMD_CFG_R1B BIT(10)
 #define CMD_CFG_END_OF_CHAIN BIT(11)
-#define CMD_CFG_TIMEOUT_SHIFT 12
-#define CMD_CFG_TIMEOUT_MASK 0xf
+#define CMD_CFG_TIMEOUT_MASK GENMASK(15, 12)
 #define CMD_CFG_NO_RESP BIT(16)
 #define CMD_CFG_NO_CMD BIT(17)
 #define CMD_CFG_DATA_IO BIT(18)
@@ -164,15 +153,14 @@ struct sd_emmc_desc {
 #define CMD_CFG_RESP_128 BIT(21)
 #define CMD_CFG_RESP_NUM BIT(22)
 #define CMD_CFG_DATA_NUM BIT(23)
-#define CMD_CFG_CMD_INDEX_SHIFT 24
-#define CMD_CFG_CMD_INDEX_MASK 0x3f
+#define CMD_CFG_CMD_INDEX_MASK GENMASK(29, 24)
 #define CMD_CFG_ERROR BIT(30)
 #define CMD_CFG_OWNER BIT(31)
 
-#define CMD_DATA_MASK (~0x3)
+#define CMD_DATA_MASK GENMASK(31, 2)
 #define CMD_DATA_BIG_ENDIAN BIT(1)
 #define CMD_DATA_SRAM BIT(0)
-#define CMD_RESP_MASK (~0x1)
+#define CMD_RESP_MASK GENMASK(31, 1)
 #define CMD_RESP_SRAM BIT(0)
 
 static int meson_mmc_clk_set(struct meson_host *host, unsigned long clk_rate)
@@ -268,9 +256,8 @@ static int meson_mmc_clk_init(struct meson_host *host)
 	init.flags = 0;
 	init.parent_names = mux_parent_names;
 	init.num_parents = MUX_CLK_NUM_PARENTS;
-
 	host->mux.reg = host->regs + SD_EMMC_CLOCK;
-	host->mux.shift = CLK_SRC_SHIFT;
+	host->mux.shift = __bf_shf(CLK_SRC_MASK);
 	host->mux.mask = CLK_SRC_MASK;
 	host->mux.flags = 0;
 	host->mux.table = NULL;
@@ -290,8 +277,8 @@ static int meson_mmc_clk_init(struct meson_host *host)
 	init.num_parents = ARRAY_SIZE(clk_div_parents);
 
 	host->cfg_div.reg = host->regs + SD_EMMC_CLOCK;
-	host->cfg_div.shift = CLK_DIV_SHIFT;
-	host->cfg_div.width = CLK_DIV_WIDTH;
+	host->cfg_div.shift = __bf_shf(CLK_DIV_MASK);
+	host->cfg_div.width = __builtin_popcountl(CLK_DIV_MASK);
 	host->cfg_div.hw.init = &init;
 	host->cfg_div.flags = CLK_DIVIDER_ONE_BASED |
 		CLK_DIVIDER_ROUND_CLOSEST | CLK_DIVIDER_ALLOW_ZERO;
@@ -302,9 +289,9 @@ static int meson_mmc_clk_init(struct meson_host *host)
 
 	/* init SD_EMMC_CLOCK to sane defaults w/min clock rate */
 	clk_reg = 0;
-	clk_reg |= CLK_PHASE_180 << CLK_PHASE_SHIFT;
-	clk_reg |= CLK_SRC_XTAL << CLK_SRC_SHIFT;
-	clk_reg |= CLK_DIV_MAX << CLK_DIV_SHIFT;
+	clk_reg |= FIELD_PREP(CLK_CORE_PHASE_MASK, CLK_PHASE_180);
+	clk_reg |= FIELD_PREP(CLK_SRC_MASK, CLK_SRC_XTAL);
+	clk_reg |= FIELD_PREP(CLK_DIV_MASK, CLK_DIV_MAX);
 	clk_reg &= ~CLK_ALWAYS_ON;
 	writel(clk_reg, host->regs + SD_EMMC_CLOCK);
 
@@ -392,8 +379,8 @@ static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	val = readl(host->regs + SD_EMMC_CFG);
 	orig = val;
 
-	val &= ~(CFG_BUS_WIDTH_MASK << CFG_BUS_WIDTH_SHIFT);
-	val |= bus_width << CFG_BUS_WIDTH_SHIFT;
+	val &= ~CFG_BUS_WIDTH_MASK;
+	val |= FIELD_PREP(CFG_BUS_WIDTH_MASK, bus_width);
 
 	val &= ~CFG_DDR;
 	if (ios->timing == MMC_TIMING_UHS_DDR50 ||
@@ -432,8 +419,7 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
 	/* Setup descriptors */
 	dma_rmb();
 
-	cmd_cfg |= (cmd->opcode & CMD_CFG_CMD_INDEX_MASK) <<
-		   CMD_CFG_CMD_INDEX_SHIFT;
+	cmd_cfg |= FIELD_PREP(CMD_CFG_CMD_INDEX_MASK, cmd->opcode);
 	cmd_cfg |= CMD_CFG_OWNER;  /* owned by CPU */
 
 	/* Response */
@@ -454,30 +440,28 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
 	/* data? */
 	if (data) {
 		cmd_cfg |= CMD_CFG_DATA_IO;
-		cmd_cfg |= ilog2(SD_EMMC_CMD_TIMEOUT_DATA) <<
-			   CMD_CFG_TIMEOUT_SHIFT;
+		cmd_cfg |= FIELD_PREP(CMD_CFG_TIMEOUT_MASK,
+				      ilog2(SD_EMMC_CMD_TIMEOUT_DATA));
 
 		if (data->blocks > 1) {
 			cmd_cfg |= CMD_CFG_BLOCK_MODE;
-			cmd_cfg |= (data->blocks & CMD_CFG_LENGTH_MASK) <<
-				   CMD_CFG_LENGTH_SHIFT;
+			cmd_cfg |= FIELD_PREP(CMD_CFG_LENGTH_MASK,
+					      data->blocks);
 
 			/* check if block-size matches, if not update */
 			cfg = readl(host->regs + SD_EMMC_CFG);
-			blk_len = cfg & (CFG_BLK_LEN_MASK << CFG_BLK_LEN_SHIFT);
-			blk_len >>= CFG_BLK_LEN_SHIFT;
+			blk_len = FIELD_GET(CFG_BLK_LEN_MASK, cfg);
 			if (blk_len != ilog2(data->blksz)) {
 				dev_dbg(host->dev, "%s: update blk_len %d -> %d\n",
 					__func__, blk_len,
 					ilog2(data->blksz));
 				blk_len = ilog2(data->blksz);
-				cfg &= ~(CFG_BLK_LEN_MASK << CFG_BLK_LEN_SHIFT);
-				cfg |= blk_len << CFG_BLK_LEN_SHIFT;
+				cfg &= ~CFG_BLK_LEN_MASK;
+				cfg |= FIELD_PREP(CFG_BLK_LEN_MASK, blk_len);
 				writel(cfg, host->regs + SD_EMMC_CFG);
 			}
 		} else {
-			cmd_cfg |= (data->blksz & CMD_CFG_LENGTH_MASK) <<
-				   CMD_CFG_LENGTH_SHIFT;
+			cmd_cfg |= FIELD_PREP(CMD_CFG_LENGTH_MASK, data->blksz);
 		}
 
 		data->bytes_xfered = 0;
@@ -492,7 +476,8 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
 
 		cmd_data = host->bounce_dma_addr & CMD_DATA_MASK;
 	} else {
-		cmd_cfg |= ilog2(SD_EMMC_CMD_TIMEOUT) << CMD_CFG_TIMEOUT_SHIFT;
+		cmd_cfg |= FIELD_PREP(CMD_CFG_TIMEOUT_MASK,
+				      ilog2(SD_EMMC_CMD_TIMEOUT));
 	}
 
 	host->cmd = cmd;
@@ -664,9 +649,10 @@ static void meson_mmc_cfg_init(struct meson_host *host)
 {
 	u32 cfg = 0;
 
-	cfg |= ilog2(SD_EMMC_CFG_RESP_TIMEOUT) << CFG_RESP_TIMEOUT_SHIFT;
-	cfg |= ilog2(SD_EMMC_CFG_CMD_GAP) << CFG_RC_CC_SHIFT;
-	cfg |= ilog2(SD_EMMC_CFG_BLK_SIZE) << CFG_BLK_LEN_SHIFT;
+	cfg |= FIELD_PREP(CFG_RESP_TIMEOUT_MASK,
+			  ilog2(SD_EMMC_CFG_RESP_TIMEOUT));
+	cfg |= FIELD_PREP(CFG_RC_CC_MASK, ilog2(SD_EMMC_CFG_CMD_GAP));
+	cfg |= FIELD_PREP(CFG_BLK_LEN_MASK, ilog2(SD_EMMC_CFG_BLK_SIZE));
 
 	writel(cfg, host->regs + SD_EMMC_CFG);
 }
-- 
2.12.0



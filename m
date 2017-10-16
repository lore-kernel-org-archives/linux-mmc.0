From: Chaotian Jing <chaotian.jing@mediatek.com>
Subject: [PATCH v6 04/12] mmc: mediatek: make hs400_tune_response only for mt8173
Date: Mon, 16 Oct 2017 09:46:31 +0800
Message-ID: <1508118399-21828-5-git-send-email-chaotian.jing@mediatek.com>
References: <1508118399-21828-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1508118399-21828-1-git-send-email-chaotian.jing@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Chaotian Jing <chaotian.jing@mediatek.com>, yong mao <yong.mao@mediatek.com>, Linus Walleij <linus.walleij@linaro.org>, Heiner Kallweit <hkallweit1@gmail.com>, Phong LE <ple@baylibre.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, srv_heupstream@mediatek.com
List-Id: linux-mmc@vger.kernel.org

the origin design of hs400_tune_response is for mt8173 because of
mt8173 has a special design. for doing that, we add a new member
"compatible", by now it's only for mt8173.

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 643c795..ab2fbbb 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -300,6 +300,7 @@ struct msdc_save_para {
 
 struct mtk_mmc_compatible {
 	u8 clk_div_bits;
+	bool hs400_tune; /* only used for MT8173 */
 };
 
 struct msdc_tune_para {
@@ -360,18 +361,22 @@ struct msdc_host {
 
 static const struct mtk_mmc_compatible mt8135_compat = {
 	.clk_div_bits = 8,
+	.hs400_tune = false,
 };
 
 static const struct mtk_mmc_compatible mt8173_compat = {
 	.clk_div_bits = 8,
+	.hs400_tune = true,
 };
 
 static const struct mtk_mmc_compatible mt2701_compat = {
 	.clk_div_bits = 12,
+	.hs400_tune = false,
 };
 
 static const struct mtk_mmc_compatible mt2712_compat = {
 	.clk_div_bits = 12,
+	.hs400_tune = false,
 };
 
 static const struct of_device_id msdc_of_ids[] = {
@@ -666,7 +671,8 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
 		       host->base + PAD_CMD_TUNE);
 	}
 
-	if (timing == MMC_TIMING_MMC_HS400)
+	if (timing == MMC_TIMING_MMC_HS400 &&
+	    host->dev_comp->hs400_tune)
 		sdr_set_field(host->base + PAD_CMD_TUNE,
 			      MSDC_PAD_TUNE_CMDRRDLY,
 			      host->hs400_cmd_int_delay);
@@ -1594,7 +1600,8 @@ static int msdc_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	struct msdc_host *host = mmc_priv(mmc);
 	int ret;
 
-	if (host->hs400_mode)
+	if (host->hs400_mode &&
+	    host->dev_comp->hs400_tune)
 		ret = hs400_tune_response(mmc, opcode);
 	else
 		ret = msdc_tune_response(mmc, opcode);
-- 
1.8.1.1.dirty

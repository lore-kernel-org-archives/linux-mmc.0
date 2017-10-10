From: Chaotian Jing <chaotian.jing@mediatek.com>
Subject: [PATCH v4 07/12] mmc: mediatek: add busy_check support
Date: Tue, 10 Oct 2017 17:30:26 +0800
Message-ID: <1507627831-29323-8-git-send-email-chaotian.jing@mediatek.com>
References: <1507627831-29323-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1507627831-29323-1-git-send-email-chaotian.jing@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Chaotian Jing <chaotian.jing@mediatek.com>, yong mao <yong.mao@mediatek.com>, Linus Walleij <linus.walleij@linaro.org>, Heiner Kallweit <hkallweit1@gmail.com>, Phong LE <ple@baylibre.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, srv_heupstream@mediatek.com
List-Id: linux-mmc@vger.kernel.org

bit7 of PATCH_BIT1 has different meaning in new design, to
compatible with previous platform, clear this bit in new
platform.

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index ebec2b4..187fe8a 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -316,6 +316,7 @@ struct mtk_mmc_compatible {
 	bool pad_tune0;
 	bool async_fifo;
 	bool data_tune;
+	bool busy_check;
 };
 
 struct msdc_tune_para {
@@ -380,6 +381,7 @@ struct msdc_host {
 	.pad_tune0 = false,
 	.async_fifo = false,
 	.data_tune = false,
+	.busy_check = false,
 };
 
 static const struct mtk_mmc_compatible mt8173_compat = {
@@ -388,6 +390,7 @@ struct msdc_host {
 	.pad_tune0 = false,
 	.async_fifo = false,
 	.data_tune = false,
+	.busy_check = false,
 };
 
 static const struct mtk_mmc_compatible mt2701_compat = {
@@ -396,6 +399,7 @@ struct msdc_host {
 	.pad_tune0 = true,
 	.async_fifo = true,
 	.data_tune = true,
+	.busy_check = false,
 };
 
 static const struct mtk_mmc_compatible mt2712_compat = {
@@ -404,6 +408,7 @@ struct msdc_host {
 	.pad_tune0 = true,
 	.async_fifo = true,
 	.data_tune = true,
+	.busy_check = true,
 };
 
 static const struct of_device_id msdc_of_ids[] = {
@@ -1280,6 +1285,8 @@ static void msdc_init_hw(struct msdc_host *host)
 	sdr_set_field(host->base + MSDC_PATCH_BIT, MSDC_CKGEN_MSDC_DLY_SEL, 1);
 	writel(0xffff4089, host->base + MSDC_PATCH_BIT1);
 	sdr_set_bits(host->base + EMMC50_CFG0, EMMC50_CFG_CFCSTS_SEL);
+	if (host->dev_comp->busy_check)
+		sdr_clr_bits(host->base + MSDC_PATCH_BIT1, (1 << 7));
 	if (host->dev_comp->async_fifo) {
 		sdr_set_field(host->base + MSDC_PATCH_BIT2,
 			      MSDC_PB2_RESPWAIT, 3);
-- 
1.8.1.1.dirty

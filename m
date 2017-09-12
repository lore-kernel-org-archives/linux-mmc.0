From: Chaotian Jing <chaotian.jing@mediatek.com>
Subject: [PATCH 10/12] mmc: mediatek: add latch-ck support
Date: Tue, 12 Sep 2017 17:07:50 +0800
Message-ID: <1505207272-16983-11-git-send-email-chaotian.jing@mediatek.com>
References: <1505207272-16983-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([210.61.82.183]:23170 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751562AbdILJI1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Sep 2017 05:08:27 -0400
In-Reply-To: <1505207272-16983-1-git-send-email-chaotian.jing@mediatek.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Chaotian Jing <chaotian.jing@mediatek.com>, yong mao <yong.mao@mediatek.com>, Linus Walleij <linus.walleij@linaro.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Heiner Kallweit <hkallweit1@gmail.com>, Phong LE <ple@baylibre.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, srv_heupstream@mediatek.com

some platform(eg.mt2701) does not support "stop clk fix", in
this case, need set correct latch-ck to avoid crc error caused
by stop clock block-internally.

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 522fd0a..3328d59 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -378,6 +378,7 @@ struct msdc_host {
 	u32 sclk;		/* SD/MS bus clock frequency */
 	unsigned char timing;
 	bool vqmmc_enabled;
+	u32 latch_ck;
 	u32 hs400_ds_delay;
 	u32 hs200_cmd_int_delay; /* cmd internal delay for HS200/SDR104 */
 	u32 hs400_cmd_int_delay; /* cmd internal delay for HS400 */
@@ -1668,6 +1669,8 @@ static int msdc_tune_data(struct mmc_host *mmc, u32 opcode)
 	if (host->dev_comp->pad_tune0)
 		tune_reg = MSDC_PAD_TUNE0;
 
+	sdr_set_field(host->base + MSDC_PATCH_BIT, MSDC_INT_DAT_LATCH_CK_SEL,
+		      host->latch_ck);
 	sdr_clr_bits(host->base + MSDC_IOCON, MSDC_IOCON_DSPL);
 	sdr_clr_bits(host->base + MSDC_IOCON, MSDC_IOCON_W_DSPL);
 	for (i = 0 ; i < PAD_DELAY_MAX; i++) {
@@ -1783,6 +1786,9 @@ static void msdc_hw_reset(struct mmc_host *mmc)
 static void msdc_of_property_parse(struct platform_device *pdev,
 				   struct msdc_host *host)
 {
+	of_property_read_u32(pdev->dev.of_node, "mediatek,latch-ck",
+			     &host->latch_ck);
+
 	of_property_read_u32(pdev->dev.of_node, "hs400-ds-delay",
 			     &host->hs400_ds_delay);
 
-- 
1.8.1.1.dirty


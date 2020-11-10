Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3CEAC388F7
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Nov 2020 06:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D5702065C
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Nov 2020 06:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729564AbgKJGqn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 10 Nov 2020 01:46:43 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:53195 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726010AbgKJGqm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Nov 2020 01:46:42 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.09124708|-1;CH=blue;DM=|OVERLOAD|false|;DS=CONTINUE|ham_system_inform|0.0186312-0.000150051-0.981219;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047201;MF=frank@allwinnertech.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.IuoOt.3_1604990794;
Received: from allwinnertech.com(mailfrom:frank@allwinnertech.com fp:SMTPD_---.IuoOt.3_1604990794)
          by smtp.aliyun-inc.com(10.147.40.7);
          Tue, 10 Nov 2020 14:46:38 +0800
From:   Frank Lee <frank@allwinnertech.com>
To:     tiny.windzz@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, Yangtao Li <frank@allwinnertech.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Marek Vasut <marex@denx.de>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Douglas Anderson <dianders@chromium.org>
Subject: [RESEND PATCH 17/19] mmc: sunxi: add support for A100 mmc controller
Date:   Tue, 10 Nov 2020 14:46:31 +0800
Message-Id: <de4c37ee3a0f1734c4ae035c37b8a2c34b9641ca.1604988979.git.frank@allwinnertech.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1604988979.git.frank@allwinnertech.com>
References: <cover.1604988979.git.frank@allwinnertech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Yangtao Li <frank@allwinnertech.com>

This patch adds support for A100 MMC controller, which use word address
for internal dma.

Signed-off-by: Yangtao Li <frank@allwinnertech.com>
---
 drivers/mmc/host/sunxi-mmc.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index fc62773602ec..1518b64112b7 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -244,6 +244,7 @@ struct sunxi_idma_des {
 
 struct sunxi_mmc_cfg {
 	u32 idma_des_size_bits;
+	u32 idma_des_shift;
 	const struct sunxi_mmc_clk_delay *clk_delays;
 
 	/* does the IP block support autocalibration? */
@@ -343,7 +344,7 @@ static int sunxi_mmc_init_host(struct sunxi_mmc_host *host)
 	/* Enable CEATA support */
 	mmc_writel(host, REG_FUNS, SDXC_CEATA_ON);
 	/* Set DMA descriptor list base address */
-	mmc_writel(host, REG_DLBA, host->sg_dma);
+	mmc_writel(host, REG_DLBA, host->sg_dma >> host->cfg->idma_des_shift);
 
 	rval = mmc_readl(host, REG_GCTRL);
 	rval |= SDXC_INTERRUPT_ENABLE_BIT;
@@ -373,8 +374,10 @@ static void sunxi_mmc_init_idma_des(struct sunxi_mmc_host *host,
 
 		next_desc += sizeof(struct sunxi_idma_des);
 		pdes[i].buf_addr_ptr1 =
-			cpu_to_le32(sg_dma_address(&data->sg[i]));
-		pdes[i].buf_addr_ptr2 = cpu_to_le32((u32)next_desc);
+			cpu_to_le32(sg_dma_address(&data->sg[i]) >>
+				    host->cfg->idma_des_shift);
+		pdes[i].buf_addr_ptr2 = cpu_to_le32((u32)next_desc >>
+						    host->cfg->idma_des_shift);
 	}
 
 	pdes[0].config |= cpu_to_le32(SDXC_IDMAC_DES0_FD);
@@ -1178,6 +1181,23 @@ static const struct sunxi_mmc_cfg sun50i_a64_emmc_cfg = {
 	.needs_new_timings = true,
 };
 
+static const struct sunxi_mmc_cfg sun50i_a100_cfg = {
+	.idma_des_size_bits = 16,
+	.idma_des_shift = 2,
+	.clk_delays = NULL,
+	.can_calibrate = true,
+	.mask_data0 = true,
+	.needs_new_timings = true,
+};
+
+static const struct sunxi_mmc_cfg sun50i_a100_emmc_cfg = {
+	.idma_des_size_bits = 13,
+	.idma_des_shift = 2,
+	.clk_delays = NULL,
+	.can_calibrate = true,
+	.needs_new_timings = true,
+};
+
 static const struct of_device_id sunxi_mmc_of_match[] = {
 	{ .compatible = "allwinner,sun4i-a10-mmc", .data = &sun4i_a10_cfg },
 	{ .compatible = "allwinner,sun5i-a13-mmc", .data = &sun5i_a13_cfg },
@@ -1186,6 +1206,8 @@ static const struct of_device_id sunxi_mmc_of_match[] = {
 	{ .compatible = "allwinner,sun9i-a80-mmc", .data = &sun9i_a80_cfg },
 	{ .compatible = "allwinner,sun50i-a64-mmc", .data = &sun50i_a64_cfg },
 	{ .compatible = "allwinner,sun50i-a64-emmc", .data = &sun50i_a64_emmc_cfg },
+	{ .compatible = "allwinner,sun50i-a100-mmc", .data = &sun50i_a100_cfg },
+	{ .compatible = "allwinner,sun50i-a100-emmc", .data = &sun50i_a100_emmc_cfg },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sunxi_mmc_of_match);
-- 
2.28.0


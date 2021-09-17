Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC5FC4332F
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Sep 2021 12:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D348610C9
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Sep 2021 12:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244194AbhIQMkV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 17 Sep 2021 08:40:21 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:39374 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233162AbhIQMkU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Sep 2021 08:40:20 -0400
X-UUID: 3293024e88d54a11b24b152e45fa9f50-20210917
X-UUID: 3293024e88d54a11b24b152e45fa9f50-20210917
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <wenbin.mei@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1268936350; Fri, 17 Sep 2021 20:38:56 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 17 Sep 2021 20:38:55 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 17 Sep 2021 20:38:54 +0800
From:   Wenbin Mei <wenbin.mei@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Avri Altman <avri.altman@wdc.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Yue Hu <huyue2@yulong.com>, Bean Huo <beanhuo@micron.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] mmc: mediatek: Add HS400 online tuning support
Date:   Fri, 17 Sep 2021 20:38:51 +0800
Message-ID: <20210917123851.22741-4-wenbin.mei@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210917123851.22741-1-wenbin.mei@mediatek.com>
References: <20210917123851.22741-1-wenbin.mei@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

According to JEDEC Spec, there is no need to do tuning under HS400 mode
since the Rx signal is aligned with the DS signal. However, MediaTek's
IC need set its "DS delay" internally to ensure it can latch Rx signal
correctly.
In previous version, We provide an "hs400-ds-delay" in device tree to
cover different chipset/PCB design, and it works fine in most cases.
But, with the development of process technology and the big VCore
voltage scale range(may have 0.7V/0.6V/0.55V), it is difficult to find
a suitable "hs400-ds-delay" to cover all of IC corner
cases(SSSS/TTTT/FFFF).
So that We must have the ability to do hs400 online tuning.

Signed-off-by: Wenbin Mei <wenbin.mei@mediatek.com>
Reviewed-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 79 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 77 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 4dfc246c5f95..5f98f869545d 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -258,6 +258,7 @@
 #define MSDC_PAD_TUNE_RD_SEL	  (0x1 << 13)   /* RW */
 #define MSDC_PAD_TUNE_CMD_SEL	  (0x1 << 21)   /* RW */
 
+#define PAD_DS_TUNE_DLY_SEL       (0x1 << 0)	/* RW */
 #define PAD_DS_TUNE_DLY1	  (0x1f << 2)   /* RW */
 #define PAD_DS_TUNE_DLY2	  (0x1f << 7)   /* RW */
 #define PAD_DS_TUNE_DLY3	  (0x1f << 12)  /* RW */
@@ -301,6 +302,11 @@
 #define PAD_CMD_RD_RXDLY_SEL    (0x1 << 11)     /* RW */
 #define PAD_CMD_TX_DLY          (0x1f << 12)    /* RW */
 
+/* EMMC50_PAD_DS_TUNE mask */
+#define PAD_DS_DLY_SEL		(0x1 << 16)	/* RW */
+#define PAD_DS_DLY1		(0x1f << 10)	/* RW */
+#define PAD_DS_DLY3		(0x1f << 0)	/* RW */
+
 #define REQ_CMD_EIO  (0x1 << 0)
 #define REQ_CMD_TMO  (0x1 << 1)
 #define REQ_DAT_ERR  (0x1 << 2)
@@ -448,11 +454,13 @@ struct msdc_host {
 	bool vqmmc_enabled;
 	u32 latch_ck;
 	u32 hs400_ds_delay;
+	u32 hs400_ds_dly3;
 	u32 hs200_cmd_int_delay; /* cmd internal delay for HS200/SDR104 */
 	u32 hs400_cmd_int_delay; /* cmd internal delay for HS400 */
 	bool hs400_cmd_resp_sel_rising;
 				 /* cmd response sample selection for HS400 */
 	bool hs400_mode;	/* current eMMC will run at hs400 mode */
+	bool hs400_tuning;	/* hs400 mode online tuning */
 	bool internal_cd;	/* Use internal card-detect logic */
 	bool cqhci;		/* support eMMC hw cmdq */
 	struct msdc_save_para save_para; /* used when gate HCLK */
@@ -1190,7 +1198,8 @@ static bool msdc_cmd_done(struct msdc_host *host, int events,
 	if (!sbc_error && !(events & MSDC_INT_CMDRDY)) {
 		if (events & MSDC_INT_CMDTMO ||
 		    (cmd->opcode != MMC_SEND_TUNING_BLOCK &&
-		     cmd->opcode != MMC_SEND_TUNING_BLOCK_HS200))
+		     cmd->opcode != MMC_SEND_TUNING_BLOCK_HS200 &&
+		     !host->hs400_tuning))
 			/*
 			 * should not clear fifo/interrupt as the tune data
 			 * may have alreay come when cmd19/cmd21 gets response
@@ -1287,7 +1296,8 @@ static void msdc_cmd_next(struct msdc_host *host,
 	if ((cmd->error &&
 	    !(cmd->error == -EILSEQ &&
 	      (cmd->opcode == MMC_SEND_TUNING_BLOCK ||
-	       cmd->opcode == MMC_SEND_TUNING_BLOCK_HS200))) ||
+	       cmd->opcode == MMC_SEND_TUNING_BLOCK_HS200 ||
+	       host->hs400_tuning))) ||
 	    (mrq->sbc && mrq->sbc->error))
 		msdc_request_done(host, mrq);
 	else if (cmd == mrq->sbc)
@@ -2251,6 +2261,67 @@ static int msdc_prepare_hs400_tuning(struct mmc_host *mmc, struct mmc_ios *ios)
 	return 0;
 }
 
+static int msdc_execute_hs400_tuning(struct mmc_host *mmc, struct mmc_card *card)
+{
+	struct msdc_host *host = mmc_priv(mmc);
+	struct msdc_delay_phase dly1_delay;
+	u32 val, result_dly1 = 0;
+	u8 *ext_csd;
+	int i, ret;
+
+	if (host->top_base) {
+		sdr_set_bits(host->top_base + EMMC50_PAD_DS_TUNE,
+			     PAD_DS_DLY_SEL);
+		if (host->hs400_ds_dly3)
+			sdr_set_field(host->top_base + EMMC50_PAD_DS_TUNE,
+				      PAD_DS_DLY3, host->hs400_ds_dly3);
+	} else {
+		sdr_set_bits(host->base + PAD_DS_TUNE, PAD_DS_TUNE_DLY_SEL);
+		if (host->hs400_ds_dly3)
+			sdr_set_field(host->base + PAD_DS_TUNE,
+				      PAD_DS_TUNE_DLY3, host->hs400_ds_dly3);
+	}
+
+	host->hs400_tuning = true;
+	for (i = 0; i < PAD_DELAY_MAX; i++) {
+		if (host->top_base)
+			sdr_set_field(host->top_base + EMMC50_PAD_DS_TUNE,
+				      PAD_DS_DLY1, i);
+		else
+			sdr_set_field(host->base + PAD_DS_TUNE,
+				      PAD_DS_TUNE_DLY1, i);
+		ret = mmc_get_ext_csd(card, &ext_csd);
+		if (!ret)
+			result_dly1 |= (1 << i);
+	}
+	host->hs400_tuning = false;
+
+	dly1_delay = get_best_delay(host, result_dly1);
+	if (dly1_delay.maxlen == 0) {
+		dev_err(host->dev, "Failed to get DLY1 delay!\n");
+		goto fail;
+	}
+	if (host->top_base)
+		sdr_set_field(host->top_base + EMMC50_PAD_DS_TUNE,
+			      PAD_DS_DLY1, dly1_delay.final_phase);
+	else
+		sdr_set_field(host->base + PAD_DS_TUNE,
+			      PAD_DS_TUNE_DLY1, dly1_delay.final_phase);
+
+	if (host->top_base)
+		val = readl(host->top_base + EMMC50_PAD_DS_TUNE);
+	else
+		val = readl(host->base + PAD_DS_TUNE);
+
+	dev_info(host->dev, "Fianl PAD_DS_TUNE: 0x%x\n", val);
+
+	return 0;
+
+fail:
+	dev_err(host->dev, "Failed to tuning DS pin delay!\n");
+	return -EIO;
+}
+
 static void msdc_hw_reset(struct mmc_host *mmc)
 {
 	struct msdc_host *host = mmc_priv(mmc);
@@ -2377,6 +2448,7 @@ static const struct mmc_host_ops mt_msdc_ops = {
 	.card_busy = msdc_card_busy,
 	.execute_tuning = msdc_execute_tuning,
 	.prepare_hs400_tuning = msdc_prepare_hs400_tuning,
+	.execute_hs400_tuning = msdc_execute_hs400_tuning,
 	.hw_reset = msdc_hw_reset,
 };
 
@@ -2396,6 +2468,9 @@ static void msdc_of_property_parse(struct platform_device *pdev,
 	of_property_read_u32(pdev->dev.of_node, "hs400-ds-delay",
 			     &host->hs400_ds_delay);
 
+	of_property_read_u32(pdev->dev.of_node, "mediatek,hs400-ds-dly3",
+			     &host->hs400_ds_dly3);
+
 	of_property_read_u32(pdev->dev.of_node, "mediatek,hs200-cmd-int-delay",
 			     &host->hs200_cmd_int_delay);
 
-- 
2.25.1


Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EC718C3E;
	Sun, 29 Sep 2024 07:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727596000; cv=none; b=NN1lISPbu7Dy9LiXdXmEMYmQx8DTFPCsDMMZpAGb1Pgm6fw1iJzaNS8SV5pi2409CuxD5nGpmgjhZTqzDQg7NSUUCwtt9YW4tZjVcfN/8a1GKHow6uB8BpWyCed8cWYUE63yIO09HkLHoT7420NCFYAygsnHmo64rh5oEqnIQzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727596000; c=relaxed/simple;
	bh=PdEQYhFj1jJuw/eITC13f/HivlsvaGh8Z6WlXU/dJSM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LH0EJ46AWtMxxEjLMOTIhx+omFbt/3kCOTyW+0ek+1iptYE0YC+UP+F6mVzmpKSgxBHK4UCZwWecrIf/XCNN7nPWw5qhWyQuTYu7z/FYGSPGG8bAsVVQpNi/Y+MMWXez0DLz+PVxK449gIWd1EQTXRGrorLGXV5ai6fVjK8oHkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=LSx3Wef7; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="LSx3Wef7"
X-UUID: f2697f427e3611ef8b96093e013ec31c-20240929
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=X2SkVJ9ADr0WEnfqjxhVb4tsAJMhVLB/htiR/1Zf9Dw=;
	b=LSx3Wef7s/HcrPuo5AAfst0lfEYkYOJdxVn0CE9D+hPlsrpeyqpT8G4OZNJeWiLyLVXWoqvJRDlEmbs8uBZhiN4j1M00njXJNqfkQYFt5WSHL2BLNVVFUz01B1h1qL3UuSfGMcvxD2lg6c9aOuK+hz9A+c32FwwGCJxz+3FWG+s=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:178950c7-2a84-4420-a169-57f5efdbf770,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6dc6a47,CLOUDID:8ada6a18-b42d-49a6-94d2-a75fa0df01d2,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: f2697f427e3611ef8b96093e013ec31c-20240929
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <andy-ld.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1678616025; Sun, 29 Sep 2024 15:46:33 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sun, 29 Sep 2024 15:46:31 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sun, 29 Sep 2024 15:46:31 +0800
From: Andy-ld Lu <andy-ld.lu@mediatek.com>
To: <ulf.hansson@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<matthias.bgg@gmail.com>, <angelogioacchino.delregno@collabora.com>,
	<wenbin.mei@mediatek.com>
CC: <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, Andy-ld Lu <andy-ld.lu@mediatek.com>
Subject: [PATCH v2 1/2] mmc: mtk-sd: Add support for MT8196
Date: Sun, 29 Sep 2024 15:44:05 +0800
Message-ID: <20240929074558.2076-2-andy-ld.lu@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240929074558.2076-1-andy-ld.lu@mediatek.com>
References: <20240929074558.2076-1-andy-ld.lu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Mediatek SoC MT8196 features a new design for tx/rx path. The new tx
path incorporates register settings that are closely associated with
bus timing. And the difference between new rx path and older versions
is the usage of distinct register bits when setting the data sampling
edge as part of the tuning process.

Besides, there are modified register settings for STOP_DLY_SEL and
POP_EN_CNT, with two new fields added to the compatibility structure
to reflect the modifications.

For the changes mentioned in relation to the MT8196, the new compatible
string 'mediatek,mt8196-mmc' is introduced. This is to accommodate
different settings and workflows specific to the MT8196.

Signed-off-by: Andy-ld Lu <andy-ld.lu@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 162 +++++++++++++++++++++++++++++++++-----
 1 file changed, 141 insertions(+), 21 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 89018b6c97b9..4254b3012aeb 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -65,6 +65,7 @@
 #define SDC_RESP3        0x4c
 #define SDC_BLK_NUM      0x50
 #define SDC_ADV_CFG0     0x64
+#define MSDC_NEW_RX_CFG  0x68
 #define EMMC_IOCON       0x7c
 #define SDC_ACMD_RESP    0x80
 #define DMA_SA_H4BIT     0x8c
@@ -91,6 +92,7 @@
 #define EMMC_TOP_CONTROL	0x00
 #define EMMC_TOP_CMD		0x04
 #define EMMC50_PAD_DS_TUNE	0x0c
+#define LOOP_TEST_CONTROL	0x30
 
 /*--------------------------------------------------------------------------*/
 /* Register Mask                                                            */
@@ -202,9 +204,13 @@
 #define SDC_STS_CMDBUSY         BIT(1)	/* RW */
 #define SDC_STS_SWR_COMPL       BIT(31)	/* RW */
 
-#define SDC_DAT1_IRQ_TRIGGER	BIT(19)	/* RW */
 /* SDC_ADV_CFG0 mask */
+#define SDC_DAT1_IRQ_TRIGGER	BIT(19)	/* RW */
 #define SDC_RX_ENHANCE_EN	BIT(20)	/* RW */
+#define SDC_NEW_TX_EN		BIT(31)	/* RW */
+
+/* MSDC_NEW_RX_CFG mask */
+#define MSDC_NEW_RX_PATH_SEL	BIT(0)	/* RW */
 
 /* DMA_SA_H4BIT mask */
 #define DMA_ADDR_HIGH_4BIT      GENMASK(3, 0)	/* RW */
@@ -226,6 +232,7 @@
 
 /* MSDC_PATCH_BIT mask */
 #define MSDC_PATCH_BIT_ODDSUPP    BIT(1)	/* RW */
+#define MSDC_PATCH_BIT_RD_DAT_SEL BIT(3)	/* RW */
 #define MSDC_INT_DAT_LATCH_CK_SEL GENMASK(9, 7)
 #define MSDC_CKGEN_MSDC_DLY_SEL   GENMASK(14, 10)
 #define MSDC_PATCH_BIT_IODSSEL    BIT(16)	/* RW */
@@ -247,6 +254,8 @@
 #define MSDC_PB2_SUPPORT_64G      BIT(1)    /* RW */
 #define MSDC_PB2_RESPWAIT         GENMASK(3, 2)   /* RW */
 #define MSDC_PB2_RESPSTSENSEL     GENMASK(18, 16) /* RW */
+#define MSDC_PB2_POP_EN_CNT       GENMASK(23, 20) /* RW */
+#define MSDC_PB2_CFGCRCSTSEDGE    BIT(25)   /* RW */
 #define MSDC_PB2_CRCSTSENSEL      GENMASK(31, 29) /* RW */
 
 #define MSDC_PAD_TUNE_DATWRDLY	  GENMASK(4, 0)		/* RW */
@@ -311,6 +320,12 @@
 #define PAD_DS_DLY1		GENMASK(14, 10)	/* RW */
 #define PAD_DS_DLY3		GENMASK(4, 0)	/* RW */
 
+/* LOOP_TEST_CONTROL mask */
+#define TEST_LOOP_DSCLK_MUX_SEL        BIT(0)	/* RW */
+#define TEST_LOOP_LATCH_MUX_SEL        BIT(1)	/* RW */
+#define LOOP_EN_SEL_CLK                BIT(20)	/* RW */
+#define TEST_HS400_CMD_LOOP_MUX_SEL    BIT(31)	/* RW */
+
 #define REQ_CMD_EIO  BIT(0)
 #define REQ_CMD_TMO  BIT(1)
 #define REQ_DAT_ERR  BIT(2)
@@ -391,6 +406,7 @@ struct msdc_save_para {
 	u32 emmc_top_control;
 	u32 emmc_top_cmd;
 	u32 emmc50_pad_ds_tune;
+	u32 loop_test_control;
 };
 
 struct mtk_mmc_compatible {
@@ -402,9 +418,13 @@ struct mtk_mmc_compatible {
 	bool data_tune;
 	bool busy_check;
 	bool stop_clk_fix;
+	u8 stop_dly_sel;
+	u8 pop_en_cnt;
 	bool enhance_rx;
 	bool support_64g;
 	bool use_internal_cd;
+	bool support_new_tx;
+	bool support_new_rx;
 };
 
 struct msdc_tune_para {
@@ -621,6 +641,23 @@ static const struct mtk_mmc_compatible mt8516_compat = {
 	.stop_clk_fix = true,
 };
 
+static const struct mtk_mmc_compatible mt8196_compat = {
+	.clk_div_bits = 12,
+	.recheck_sdio_irq = false,
+	.hs400_tune = false,
+	.pad_tune_reg = MSDC_PAD_TUNE0,
+	.async_fifo = true,
+	.data_tune = true,
+	.busy_check = true,
+	.stop_clk_fix = true,
+	.stop_dly_sel = 1,
+	.pop_en_cnt = 2,
+	.enhance_rx = true,
+	.support_64g = true,
+	.support_new_tx = true,
+	.support_new_rx = true,
+};
+
 static const struct of_device_id msdc_of_ids[] = {
 	{ .compatible = "mediatek,mt2701-mmc", .data = &mt2701_compat},
 	{ .compatible = "mediatek,mt2712-mmc", .data = &mt2712_compat},
@@ -632,6 +669,7 @@ static const struct of_device_id msdc_of_ids[] = {
 	{ .compatible = "mediatek,mt8135-mmc", .data = &mt8135_compat},
 	{ .compatible = "mediatek,mt8173-mmc", .data = &mt8173_compat},
 	{ .compatible = "mediatek,mt8183-mmc", .data = &mt8183_compat},
+	{ .compatible = "mediatek,mt8196-mmc", .data = &mt8196_compat},
 	{ .compatible = "mediatek,mt8516-mmc", .data = &mt8516_compat},
 
 	{}
@@ -872,6 +910,42 @@ static int msdc_ungate_clock(struct msdc_host *host)
 				  (val & MSDC_CFG_CKSTB), 1, 20000);
 }
 
+static void msdc_new_tx_setting(struct msdc_host *host)
+{
+	if (host->top_base) {
+		sdr_set_bits(host->top_base + LOOP_TEST_CONTROL,
+			     TEST_LOOP_DSCLK_MUX_SEL);
+		sdr_set_bits(host->top_base + LOOP_TEST_CONTROL,
+			     TEST_LOOP_LATCH_MUX_SEL);
+		sdr_clr_bits(host->top_base + LOOP_TEST_CONTROL,
+			     TEST_HS400_CMD_LOOP_MUX_SEL);
+	}
+
+	switch (host->timing) {
+	case MMC_TIMING_LEGACY:
+	case MMC_TIMING_MMC_HS:
+	case MMC_TIMING_SD_HS:
+	case MMC_TIMING_UHS_SDR12:
+	case MMC_TIMING_UHS_SDR25:
+	case MMC_TIMING_UHS_DDR50:
+	case MMC_TIMING_MMC_DDR52:
+		if (host->top_base)
+			sdr_clr_bits(host->top_base + LOOP_TEST_CONTROL,
+				     LOOP_EN_SEL_CLK);
+		break;
+	case MMC_TIMING_UHS_SDR50:
+	case MMC_TIMING_UHS_SDR104:
+	case MMC_TIMING_MMC_HS200:
+	case MMC_TIMING_MMC_HS400:
+		if (host->top_base)
+			sdr_set_bits(host->top_base + LOOP_TEST_CONTROL,
+				     LOOP_EN_SEL_CLK);
+		break;
+	default:
+		break;
+	}
+}
+
 static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
 {
 	struct mmc_host *mmc = mmc_from_priv(host);
@@ -881,6 +955,7 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
 	u32 sclk;
 	u32 tune_reg = host->dev_comp->pad_tune_reg;
 	u32 val;
+	bool timing_changed = false;
 
 	if (!hz) {
 		dev_dbg(host->dev, "set mclk to 0\n");
@@ -890,6 +965,9 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
 		return;
 	}
 
+	if (host->timing != timing)
+		timing_changed = true;
+
 	flags = readl(host->base + MSDC_INTEN);
 	sdr_clr_bits(host->base + MSDC_INTEN, flags);
 	if (host->dev_comp->clk_div_bits == 8)
@@ -996,6 +1074,9 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
 		sdr_set_field(host->base + tune_reg,
 			      MSDC_PAD_TUNE_CMDRRDLY,
 			      host->hs400_cmd_int_delay);
+	if (timing_changed && host->dev_comp->support_new_tx)
+		msdc_new_tx_setting(host);
+
 	dev_dbg(host->dev, "sclk: %d, timing: %d\n", mmc->actual_clock,
 		timing);
 }
@@ -1704,6 +1785,17 @@ static void msdc_init_hw(struct msdc_host *host)
 		reset_control_deassert(host->reset);
 	}
 
+	/* New tx/rx enable bit need to be 0->1 for hardware check */
+	if (host->dev_comp->support_new_tx) {
+		sdr_clr_bits(host->base + SDC_ADV_CFG0, SDC_NEW_TX_EN);
+		sdr_set_bits(host->base + SDC_ADV_CFG0, SDC_NEW_TX_EN);
+		msdc_new_tx_setting(host);
+	}
+	if (host->dev_comp->support_new_rx) {
+		sdr_clr_bits(host->base + MSDC_NEW_RX_CFG, MSDC_NEW_RX_PATH_SEL);
+		sdr_set_bits(host->base + MSDC_NEW_RX_CFG, MSDC_NEW_RX_PATH_SEL);
+	}
+
 	/* Configure to MMC/SD mode, clock free running */
 	sdr_set_bits(host->base + MSDC_CFG, MSDC_CFG_MODE | MSDC_CFG_CKPDN);
 
@@ -1742,8 +1834,19 @@ static void msdc_init_hw(struct msdc_host *host)
 	sdr_set_bits(host->base + EMMC50_CFG0, EMMC50_CFG_CFCSTS_SEL);
 
 	if (host->dev_comp->stop_clk_fix) {
-		sdr_set_field(host->base + MSDC_PATCH_BIT1,
-			      MSDC_PATCH_BIT1_STOP_DLY, 3);
+		if (host->dev_comp->stop_dly_sel)
+			sdr_set_field(host->base + MSDC_PATCH_BIT1,
+				      MSDC_PATCH_BIT1_STOP_DLY,
+				      host->dev_comp->stop_dly_sel & 0xf);
+		else
+			sdr_set_field(host->base + MSDC_PATCH_BIT1,
+				      MSDC_PATCH_BIT1_STOP_DLY, 3);
+
+		if (host->dev_comp->pop_en_cnt)
+			sdr_set_field(host->base + MSDC_PATCH_BIT2,
+				      MSDC_PB2_POP_EN_CNT,
+				      host->dev_comp->pop_en_cnt & 0xf);
+
 		sdr_clr_bits(host->base + SDC_FIFO_CFG,
 			     SDC_FIFO_CFG_WRVALIDSEL);
 		sdr_clr_bits(host->base + SDC_FIFO_CFG,
@@ -2055,6 +2158,19 @@ static inline void msdc_set_data_delay(struct msdc_host *host, u32 value)
 	}
 }
 
+static inline void msdc_set_data_sample_edge(struct msdc_host *host, bool rising)
+{
+	u32 value = rising ? 0 : 1;
+
+	if (host->dev_comp->support_new_rx) {
+		sdr_set_field(host->base + MSDC_PATCH_BIT, MSDC_PATCH_BIT_RD_DAT_SEL, value);
+		sdr_set_field(host->base + MSDC_PATCH_BIT2, MSDC_PB2_CFGCRCSTSEDGE, value);
+	} else {
+		sdr_set_field(host->base + MSDC_IOCON, MSDC_IOCON_DSPL, value);
+		sdr_set_field(host->base + MSDC_IOCON, MSDC_IOCON_W_DSPL, value);
+	}
+}
+
 static int msdc_tune_response(struct mmc_host *mmc, u32 opcode)
 {
 	struct msdc_host *host = mmc_priv(mmc);
@@ -2210,8 +2326,7 @@ static int msdc_tune_data(struct mmc_host *mmc, u32 opcode)
 
 	sdr_set_field(host->base + MSDC_PATCH_BIT, MSDC_INT_DAT_LATCH_CK_SEL,
 		      host->latch_ck);
-	sdr_clr_bits(host->base + MSDC_IOCON, MSDC_IOCON_DSPL);
-	sdr_clr_bits(host->base + MSDC_IOCON, MSDC_IOCON_W_DSPL);
+	msdc_set_data_sample_edge(host, true);
 	for (i = 0; i < host->tuning_step; i++) {
 		msdc_set_data_delay(host, i);
 		ret = mmc_send_tuning(mmc, opcode, NULL);
@@ -2224,8 +2339,7 @@ static int msdc_tune_data(struct mmc_host *mmc, u32 opcode)
 	    (final_rise_delay.start == 0 && final_rise_delay.maxlen >= 4))
 		goto skip_fall;
 
-	sdr_set_bits(host->base + MSDC_IOCON, MSDC_IOCON_DSPL);
-	sdr_set_bits(host->base + MSDC_IOCON, MSDC_IOCON_W_DSPL);
+	msdc_set_data_sample_edge(host, false);
 	for (i = 0; i < host->tuning_step; i++) {
 		msdc_set_data_delay(host, i);
 		ret = mmc_send_tuning(mmc, opcode, NULL);
@@ -2237,12 +2351,10 @@ static int msdc_tune_data(struct mmc_host *mmc, u32 opcode)
 skip_fall:
 	final_maxlen = max(final_rise_delay.maxlen, final_fall_delay.maxlen);
 	if (final_maxlen == final_rise_delay.maxlen) {
-		sdr_clr_bits(host->base + MSDC_IOCON, MSDC_IOCON_DSPL);
-		sdr_clr_bits(host->base + MSDC_IOCON, MSDC_IOCON_W_DSPL);
+		msdc_set_data_sample_edge(host, true);
 		final_delay = final_rise_delay.final_phase;
 	} else {
-		sdr_set_bits(host->base + MSDC_IOCON, MSDC_IOCON_DSPL);
-		sdr_set_bits(host->base + MSDC_IOCON, MSDC_IOCON_W_DSPL);
+		msdc_set_data_sample_edge(host, false);
 		final_delay = final_fall_delay.final_phase;
 	}
 	msdc_set_data_delay(host, final_delay);
@@ -2267,8 +2379,7 @@ static int msdc_tune_together(struct mmc_host *mmc, u32 opcode)
 		      host->latch_ck);
 
 	sdr_clr_bits(host->base + MSDC_IOCON, MSDC_IOCON_RSPL);
-	sdr_clr_bits(host->base + MSDC_IOCON,
-		     MSDC_IOCON_DSPL | MSDC_IOCON_W_DSPL);
+	msdc_set_data_sample_edge(host, true);
 	for (i = 0; i < host->tuning_step; i++) {
 		msdc_set_cmd_delay(host, i);
 		msdc_set_data_delay(host, i);
@@ -2283,8 +2394,7 @@ static int msdc_tune_together(struct mmc_host *mmc, u32 opcode)
 		goto skip_fall;
 
 	sdr_set_bits(host->base + MSDC_IOCON, MSDC_IOCON_RSPL);
-	sdr_set_bits(host->base + MSDC_IOCON,
-		     MSDC_IOCON_DSPL | MSDC_IOCON_W_DSPL);
+	msdc_set_data_sample_edge(host, false);
 	for (i = 0; i < host->tuning_step; i++) {
 		msdc_set_cmd_delay(host, i);
 		msdc_set_data_delay(host, i);
@@ -2298,13 +2408,11 @@ static int msdc_tune_together(struct mmc_host *mmc, u32 opcode)
 	final_maxlen = max(final_rise_delay.maxlen, final_fall_delay.maxlen);
 	if (final_maxlen == final_rise_delay.maxlen) {
 		sdr_clr_bits(host->base + MSDC_IOCON, MSDC_IOCON_RSPL);
-		sdr_clr_bits(host->base + MSDC_IOCON,
-			     MSDC_IOCON_DSPL | MSDC_IOCON_W_DSPL);
+		msdc_set_data_sample_edge(host, true);
 		final_delay = final_rise_delay.final_phase;
 	} else {
 		sdr_set_bits(host->base + MSDC_IOCON, MSDC_IOCON_RSPL);
-		sdr_set_bits(host->base + MSDC_IOCON,
-			     MSDC_IOCON_DSPL | MSDC_IOCON_W_DSPL);
+		msdc_set_data_sample_edge(host, false);
 		final_delay = final_fall_delay.final_phase;
 	}
 
@@ -2324,8 +2432,7 @@ static int msdc_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	if (host->dev_comp->data_tune && host->dev_comp->async_fifo) {
 		ret = msdc_tune_together(mmc, opcode);
 		if (host->hs400_mode) {
-			sdr_clr_bits(host->base + MSDC_IOCON,
-				     MSDC_IOCON_DSPL | MSDC_IOCON_W_DSPL);
+			msdc_set_data_sample_edge(host, true);
 			msdc_set_data_delay(host, 0);
 		}
 		goto tune_done;
@@ -2995,6 +3102,8 @@ static void msdc_save_reg(struct msdc_host *host)
 			readl(host->top_base + EMMC_TOP_CMD);
 		host->save_para.emmc50_pad_ds_tune =
 			readl(host->top_base + EMMC50_PAD_DS_TUNE);
+		host->save_para.loop_test_control =
+			readl(host->top_base + LOOP_TEST_CONTROL);
 	} else {
 		host->save_para.pad_tune = readl(host->base + tune_reg);
 	}
@@ -3005,6 +3114,15 @@ static void msdc_restore_reg(struct msdc_host *host)
 	struct mmc_host *mmc = mmc_from_priv(host);
 	u32 tune_reg = host->dev_comp->pad_tune_reg;
 
+	if (host->dev_comp->support_new_tx) {
+		sdr_clr_bits(host->base + SDC_ADV_CFG0, SDC_NEW_TX_EN);
+		sdr_set_bits(host->base + SDC_ADV_CFG0, SDC_NEW_TX_EN);
+	}
+	if (host->dev_comp->support_new_rx) {
+		sdr_clr_bits(host->base + MSDC_NEW_RX_CFG, MSDC_NEW_RX_PATH_SEL);
+		sdr_set_bits(host->base + MSDC_NEW_RX_CFG, MSDC_NEW_RX_PATH_SEL);
+	}
+
 	writel(host->save_para.msdc_cfg, host->base + MSDC_CFG);
 	writel(host->save_para.iocon, host->base + MSDC_IOCON);
 	writel(host->save_para.sdc_cfg, host->base + SDC_CFG);
@@ -3023,6 +3141,8 @@ static void msdc_restore_reg(struct msdc_host *host)
 		       host->top_base + EMMC_TOP_CMD);
 		writel(host->save_para.emmc50_pad_ds_tune,
 		       host->top_base + EMMC50_PAD_DS_TUNE);
+		writel(host->save_para.loop_test_control,
+		       host->top_base + LOOP_TEST_CONTROL);
 	} else {
 		writel(host->save_para.pad_tune, host->base + tune_reg);
 	}
-- 
2.46.0


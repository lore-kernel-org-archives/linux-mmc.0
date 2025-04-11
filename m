Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA4828137E;
	Fri, 11 Apr 2025 05:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744350106; cv=none; b=RXxPeP666eWV/suQXT+RG67ggUlgSek2F02kJW9xMJyiB1o79RM7G8zAnSVpS7cj/YvVBlRB/StA3GUJndmlN5Y6TrAiA1XbrvWN8h1/h38dsV5JVNcTSlU63++BJjYLd7j4hU8JrIrFvISucA2QfOOw7MIZGnwoCNuw5JK8PmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744350106; c=relaxed/simple;
	bh=qriyPMO1ibC8ioDySsSvLU5ijXvqtxPCpFVSERXUKaU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=taJc2ja/b6SgWrrZNfphoeYQXu/mrmNzFEQ2Yu7Pm8GzbaBHI6NSutC67gKKD6em4imuhlAE1JISukd9VkKjYIsY/iRnj5g8M4gqhaCUleNF9Xt6m6ng6J/PYBpDte1NntIPzWvGC/no+KalOWVXDbAY/13PVTGWvqc4KANcWOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ZGSORI51; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ZGSORI51"
X-UUID: a42a5622169711f08eb9c36241bbb6fb-20250411
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=B5tqHLMKf7g8Wxc9Q71D/XsmV0B59emr8eOs+ci5NQI=;
	b=ZGSORI51ENGs8HTKctwhcJLU9SjYQXPhMCKsU0P5/Dp9cS32kGG1T0AKhZNeskanlGGicOVSESf9z9DJViPw3ROYboFuRqEYJ6qvWUxkGCImhqVR8WJG6d+6YBxW3fxPu7ixwrXQ1JCk3kX8HQ1ux5YmSgVmFbmfxrzzweaaVWY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:1ea20e90-0b09-4886-920f-3304685c8918,IP:0,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:0ef645f,CLOUDID:84397b8d-f5b8-47d5-8cf3-b68fe7530c9a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: a42a5622169711f08eb9c36241bbb6fb-20250411
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <axe.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 903616265; Fri, 11 Apr 2025 13:41:39 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Fri, 11 Apr 2025 13:41:38 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Fri, 11 Apr 2025 13:41:37 +0800
From: Axe Yang <axe.yang@mediatek.com>
To: Chaotian Jing <chaotian.jing@mediatek.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	<yong.mao@mediatek.com>, <qingliang.li@mediatek.com>,
	<andy-ld.lu@mediatek.com>, Wenbin Mei <wenbin.mei@mediatek.com>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	Axe Yang <axe.yang@mediatek.com>
Subject: [RESEND v2] mmc: mtk-sd: Add condition to enable 'single' burst type
Date: Fri, 11 Apr 2025 13:40:25 +0800
Message-ID: <20250411054134.31822-1-axe.yang@mediatek.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

This change add a condition for 'single' burst type selection.

Read AXI_LEN field from EMMC50_CFG2(AHB2AXI wrapper) register, if the
value is not 0, it means the HWIP is using AXI as AMBA bus, which do
not support 'single' burst type.

Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Axe Yang <axe.yang@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
This change dependents on 'mmc: mtk-sd: Cleanups for register R/W':

https://patchwork.kernel.org/project/linux-mediatek/cover/20250325110701.52623-1-angelogioacchino.delregno@collabora.com/
---
 drivers/mmc/host/mtk-sd.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index ceeae1aeac94..2e4bd5166c17 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -84,6 +84,7 @@
 #define EMMC51_CFG0	 0x204
 #define EMMC50_CFG0      0x208
 #define EMMC50_CFG1      0x20c
+#define EMMC50_CFG2      0x21c
 #define EMMC50_CFG3      0x220
 #define SDC_FIFO_CFG     0x228
 #define CQHCI_SETTING	 0x7fc
@@ -306,7 +307,10 @@
 /* EMMC50_CFG1 mask */
 #define EMMC50_CFG1_DS_CFG        BIT(28)  /* RW */
 
-#define EMMC50_CFG3_OUTS_WR       GENMASK(4, 0)  /* RW */
+/* EMMC50_CFG2 mask */
+#define EMMC50_CFG2_AXI_SET_LEN   GENMASK(27, 24) /* RW */
+
+#define EMMC50_CFG3_OUTS_WR       GENMASK(4, 0)   /* RW */
 
 #define SDC_FIFO_CFG_WRVALIDSEL   BIT(24)  /* RW */
 #define SDC_FIFO_CFG_RDVALIDSEL   BIT(25)  /* RW */
@@ -1917,9 +1921,13 @@ static void msdc_init_hw(struct msdc_host *host)
 	pb1_val |= FIELD_PREP(MSDC_PATCH_BIT1_CMDTA, 1);
 	pb1_val |= MSDC_PB1_DDR_CMD_FIX_SEL;
 
-	/* Set single burst mode, auto sync state clear, block gap stop clk */
-	pb1_val |= MSDC_PB1_SINGLE_BURST | MSDC_PB1_RSVD20 |
-		   MSDC_PB1_AUTO_SYNCST_CLR | MSDC_PB1_MARK_POP_WATER;
+	/* Support 'single' burst type only when AXI_LEN is 0 */
+	sdr_get_field(host->base + EMMC50_CFG2, EMMC50_CFG2_AXI_SET_LEN, &val);
+	if (!val)
+		pb1_val |= MSDC_PB1_SINGLE_BURST;
+
+	/* Set auto sync state clear, block gap stop clk */
+	pb1_val |= MSDC_PB1_RSVD20 | MSDC_PB1_AUTO_SYNCST_CLR | MSDC_PB1_MARK_POP_WATER;
 
 	/* Set low power DCM, use HCLK for GDMA, use MSDC CLK for everything else */
 	pb1_val |= MSDC_PB1_LP_DCM_EN | MSDC_PB1_RSVD3 |
-- 
2.46.0


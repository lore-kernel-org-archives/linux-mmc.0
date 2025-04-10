Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7182A130A54;
	Thu, 10 Apr 2025 07:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744271606; cv=none; b=ZYFUnWqZzJqPa+rFzFcjF7w9JjQCqw6Ruojtw0A3QwA4JboI+m0NAclUdZ/EFFjfJhLuRY3V0Ltw4J1O7S3r3XXt1fL7YfL5kUcqsijr4xlnen3xgkL1SJydIrKPHSqgyKB3WNj6ielADD0xCb7RLbGQe3IFuOpB/IFY5A8gZDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744271606; c=relaxed/simple;
	bh=4aM4/WrwSTdQGyJjo2GJ5AOuh9vyMVJsPtf0eP4y7GM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eVYWTeC9vxYwBM0dhwuZLHnaHpIFtP+VaP6KEPlMKNEzwdvjPEpA5AuBKiNE3eKyyvY4E7cn6cTr7CIMUvgn1QoZ0KTPbyCyWqMau3QjmMQLyqrrI5aZwZo3hdlKmZhVbvp4SYmzWySXxYA+HZtvewEDK1bQ8qVy9ysxU/ydxBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=MZhgFVaZ; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="MZhgFVaZ"
X-UUID: de2f5e2e15e011f0aae1fd9735fae912-20250410
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Tvm+drxaFLk25NxNGK6leQFz6UBSeg5ou+cb6osDu1M=;
	b=MZhgFVaZA4LfxPGca9jXrpLBNGPxDIGUR/fdehXTmMQ8KFzpTSlax7L+ECgI/atLDTR5hQM6s97gVjl0FzNfuq1VvL1lMwIBFZ8Fm6UE1us4Qa0RxQ1gFY9HMTLPJezGY21jRzblIDHhJ/pNmKt6Rh5FY4HcHCbPe1Yp77AcPvs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:bf93f68f-61e5-492a-ab45-5c351e19b710,IP:0,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:0ef645f,CLOUDID:c7dc708d-f5b8-47d5-8cf3-b68fe7530c9a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: de2f5e2e15e011f0aae1fd9735fae912-20250410
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <axe.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 154427312; Thu, 10 Apr 2025 15:53:19 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Thu, 10 Apr 2025 15:53:18 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Thu, 10 Apr 2025 15:53:17 +0800
From: Axe Yang <axe.yang@mediatek.com>
To: Chaotian Jing <chaotian.jing@mediatek.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	<yong.mao@mediatek.com>, <qingliang.li@mediatek.com>,
	<andy-ld.lu@mediatek.com>, Wenbin Mei <wenbin.mei@mediatek.com>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	Axe Yang <axe.yang@mediatek.com>
Subject: [PATCH v2] mmc: mtk-sd: Add condition to enable 'single' burst type
Date: Thu, 10 Apr 2025 15:52:47 +0800
Message-ID: <20250410075314.6439-1-axe.yang@mediatek.com>
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

Signed-off-by: Axe Yang <axe.yang@mediatek.com>
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


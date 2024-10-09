Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994EA193419;
	Wed,  9 Oct 2024 12:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728475359; cv=none; b=UlAv2yw81n7J+CA5JWTRu+E/nfb0SJdQ+y5Gre0/nghifbgS+m3W3n1DoO4drL+4gIIenOqyPX4mzNSmJj7nB3GvPDmYt4DIFe7qdW2UcY0+B9I/ryt74J0Y1TUXjOccxm0wopWvOsauW65ySPyWM0gnzOTFJHiIALfh3jqPcW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728475359; c=relaxed/simple;
	bh=dTDPMLoZorrqylWtp+YQ9hnQ5Pl0DFCJLiIGDQaWHao=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n2FWqamC4YxuAeadeL/+KSarRaZoSIVeWAboUMNzyJXrmjfdPKmGk2YnwwgsqS89QScY7EWe2JWfjx2G77Hx2XHHTO2kCP2QXEnu1zqNdF8PEolTp56ZDopsOvCUkZxKeTBhRpFiQKd3Zw9PsenZDBd8u16wbpk70GBCWVUhBCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=L/OOugeE; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="L/OOugeE"
X-UUID: 5dc2fcee863611ef8b96093e013ec31c-20241009
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=cCFgt0IrDJ3aytJWYF5ZrJUB8rR7Z0oxk791XYevk+s=;
	b=L/OOugeExjg8c9x5haP+r9RffuxJm7ib3Afc92VAOhc1KtZxM9eT9ihRBLXqc93zqB/NqBjQ/c8QeKeDFo932E8raInz4VLO5I1v1KqSYr5nSLjrH9GmK3kANfkC9OqzrpHNInJKL88ypjuznQFUvjamltmLfxzUxihOfWMnbAw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:6706dc4e-0100-4516-b6b5-f5ecd70db56c,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:a2178a26-5902-4533-af4f-d0904aa89b3c,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 5dc2fcee863611ef8b96093e013ec31c-20241009
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <andy-ld.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 890033064; Wed, 09 Oct 2024 20:02:33 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 9 Oct 2024 20:02:31 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 9 Oct 2024 20:02:31 +0800
From: Andy-ld Lu <andy-ld.lu@mediatek.com>
To: <ulf.hansson@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<matthias.bgg@gmail.com>, <angelogioacchino.delregno@collabora.com>,
	<wenbin.mei@mediatek.com>
CC: <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, Andy-ld Lu <andy-ld.lu@mediatek.com>
Subject: [PATCH v3 2/3] mmc: mtk-sd: Add two settings in platdata
Date: Wed, 9 Oct 2024 20:01:25 +0800
Message-ID: <20241009120203.14913-3-andy-ld.lu@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241009120203.14913-1-andy-ld.lu@mediatek.com>
References: <20241009120203.14913-1-andy-ld.lu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

There are modified register settings for STOP_DLY_SEL and POP_EN_CNT,
with two new fields added to the compatibility structure to reflect
the modifications.

For legacy SoCs, also add the original value of 'stop_dly_sel' to the
platdata, for unified code setting.

Signed-off-by: Andy-ld Lu <andy-ld.lu@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index fa4ac9f113bd..4c239a4cf8d9 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -255,6 +255,7 @@
 #define MSDC_PB2_SUPPORT_64G      BIT(1)    /* RW */
 #define MSDC_PB2_RESPWAIT         GENMASK(3, 2)   /* RW */
 #define MSDC_PB2_RESPSTSENSEL     GENMASK(18, 16) /* RW */
+#define MSDC_PB2_POP_EN_CNT       GENMASK(23, 20) /* RW */
 #define MSDC_PB2_CFGCRCSTSEDGE    BIT(25)   /* RW */
 #define MSDC_PB2_CRCSTSENSEL      GENMASK(31, 29) /* RW */
 
@@ -418,6 +419,8 @@ struct mtk_mmc_compatible {
 	bool data_tune;
 	bool busy_check;
 	bool stop_clk_fix;
+	u8 stop_dly_sel;
+	u8 pop_en_cnt;
 	bool enhance_rx;
 	bool support_64g;
 	bool use_internal_cd;
@@ -521,6 +524,7 @@ static const struct mtk_mmc_compatible mt2712_compat = {
 	.data_tune = true,
 	.busy_check = true,
 	.stop_clk_fix = true,
+	.stop_dly_sel = 3,
 	.enhance_rx = true,
 	.support_64g = true,
 };
@@ -534,6 +538,7 @@ static const struct mtk_mmc_compatible mt6779_compat = {
 	.data_tune = true,
 	.busy_check = true,
 	.stop_clk_fix = true,
+	.stop_dly_sel = 3,
 	.enhance_rx = true,
 	.support_64g = true,
 };
@@ -573,6 +578,7 @@ static const struct mtk_mmc_compatible mt7622_compat = {
 	.data_tune = true,
 	.busy_check = true,
 	.stop_clk_fix = true,
+	.stop_dly_sel = 3,
 	.enhance_rx = true,
 	.support_64g = false,
 };
@@ -586,6 +592,7 @@ static const struct mtk_mmc_compatible mt7986_compat = {
 	.data_tune = true,
 	.busy_check = true,
 	.stop_clk_fix = true,
+	.stop_dly_sel = 3,
 	.enhance_rx = true,
 	.support_64g = true,
 };
@@ -625,6 +632,7 @@ static const struct mtk_mmc_compatible mt8183_compat = {
 	.data_tune = true,
 	.busy_check = true,
 	.stop_clk_fix = true,
+	.stop_dly_sel = 3,
 	.enhance_rx = true,
 	.support_64g = true,
 };
@@ -638,6 +646,7 @@ static const struct mtk_mmc_compatible mt8516_compat = {
 	.data_tune = true,
 	.busy_check = true,
 	.stop_clk_fix = true,
+	.stop_dly_sel = 3,
 };
 
 static const struct mtk_mmc_compatible mt8196_compat = {
@@ -649,6 +658,8 @@ static const struct mtk_mmc_compatible mt8196_compat = {
 	.data_tune = true,
 	.busy_check = true,
 	.stop_clk_fix = true,
+	.stop_dly_sel = 1,
+	.pop_en_cnt = 2,
 	.enhance_rx = true,
 	.support_64g = true,
 	.support_new_tx = true,
@@ -1855,8 +1866,16 @@ static void msdc_init_hw(struct msdc_host *host)
 	sdr_set_bits(host->base + EMMC50_CFG0, EMMC50_CFG_CFCSTS_SEL);
 
 	if (host->dev_comp->stop_clk_fix) {
-		sdr_set_field(host->base + MSDC_PATCH_BIT1,
-			      MSDC_PATCH_BIT1_STOP_DLY, 3);
+		if (host->dev_comp->stop_dly_sel)
+			sdr_set_field(host->base + MSDC_PATCH_BIT1,
+				      MSDC_PATCH_BIT1_STOP_DLY,
+				      host->dev_comp->stop_dly_sel);
+
+		if (host->dev_comp->pop_en_cnt)
+			sdr_set_field(host->base + MSDC_PATCH_BIT2,
+				      MSDC_PB2_POP_EN_CNT,
+				      host->dev_comp->pop_en_cnt);
+
 		sdr_clr_bits(host->base + SDC_FIFO_CFG,
 			     SDC_FIFO_CFG_WRVALIDSEL);
 		sdr_clr_bits(host->base + SDC_FIFO_CFG,
-- 
2.46.0


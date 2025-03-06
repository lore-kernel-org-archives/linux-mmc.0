Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91623204C31;
	Thu,  6 Mar 2025 08:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741251052; cv=none; b=uKQkocLr5w4K8IdK9cvxX7d8Gf1Zdo8Z5VyYtXG/F1QtsVCyxJP0RcA2hs65+o0/nwee5ysRYAx2fdMnI9kkgSl3W9C+jLcrtMBA2H364Gh46xz7sogVUeH16AQs09/cS8FNq10+9gVUrybQEkbo4aSOelwQKWB03kzzpCeuNCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741251052; c=relaxed/simple;
	bh=f1FAL7pgFjsfu/PHchgQvCkDMKRRw5zrXEXnM4cI2Pw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GLtqEUhV6BT2x9HiqY46fkO8NetNJyF0Y6AP29ub2lmjY0YdUtYGLuGQ/AWkzcvpFGMQtlzyGjLJI88FQ0DzUaSiSvAYta1tZBOjLwRkIJgJLqfuzYtgKoejwKuj2FZVK1YR0cka4lEO2kVi92PoEZYfQPNEkZ003xH6fgSWQZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=llXdhcrm; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="llXdhcrm"
X-UUID: 1402c728fa6811efaae1fd9735fae912-20250306
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Zz2I7BU9rLfHfSph96G/PmbWf/qxl7KFg2teZ6A/Rts=;
	b=llXdhcrmzmOgBHto4nFwlf4lbe7vPxUfWdJd3S31z/Ipa65CSQ4q+XPUIAFDlc2ovfO3qn8fWCEYhW68HQ0wuNQtJaHXVwzbBMS09OnXIUlwa9sY4bBliDnly13/He1FwdCIOKnxpXBSS0CNQWxix+8PQsqtoORvIowGZQE3VOY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:4295f812-53f7-432f-a9c6-1e1a33a8d98a,IP:0,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:0ef645f,CLOUDID:5d1a078c-f5b8-47d5-8cf3-b68fe7530c9a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 1402c728fa6811efaae1fd9735fae912-20250306
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <axe.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1493921118; Thu, 06 Mar 2025 16:50:39 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 6 Mar 2025 16:50:37 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Thu, 6 Mar 2025 16:50:37 +0800
From: Axe Yang <axe.yang@mediatek.com>
To: Chaotian Jing <chaotian.jing@mediatek.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Wenbin Mei
	<wenbin.mei@mediatek.com>
CC: <yong.mao@mediatek.com>, <qingliang.li@mediatek.com>,
	<andy-ld.lu@mediatek.com>, <linux-mmc@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	Axe Yang <axe.yang@mediatek.com>
Subject: [PATCH 2/2] mmc: mtk-sd: add support to disable single burst
Date: Thu, 6 Mar 2025 16:48:06 +0800
Message-ID: <20250306085028.5024-3-axe.yang@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250306085028.5024-1-axe.yang@mediatek.com>
References: <20250306085028.5024-1-axe.yang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

Add support to disable 'single' burst type if the bus type is AXI.
Since the AMBA within some of the legacy and new designed MSDC IP
is AXI, this switch is necessary.

The burst type is not IC-specific, but host-specific. So we use a
devicetree property 'mediatek,disable-single-burst' to switch burst
type for specific MSDC host.

Signed-off-by: Axe Yang <axe.yang@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 345ea91629e0..ed46c69def1e 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -249,6 +249,7 @@
 #define MSDC_PATCH_BIT1_CMDTA     GENMASK(5, 3)    /* RW */
 #define MSDC_PB1_BUSY_CHECK_SEL   BIT(7)    /* RW */
 #define MSDC_PATCH_BIT1_STOP_DLY  GENMASK(11, 8)    /* RW */
+#define MSDC_PB1_SINGLE_BURST     BIT(16)   /* RW */
 
 #define MSDC_PATCH_BIT2_CFGRESP   BIT(15)   /* RW */
 #define MSDC_PATCH_BIT2_CFGCRCSTS BIT(28)   /* RW */
@@ -485,6 +486,7 @@ struct msdc_host {
 	u32 src_clk_freq;	/* source clock frequency */
 	unsigned char timing;
 	bool vqmmc_enabled;
+	bool disable_single_burst;
 	u32 latch_ck;
 	u32 hs400_ds_delay;
 	u32 hs400_ds_dly3;
@@ -1874,6 +1876,10 @@ static void msdc_init_hw(struct msdc_host *host)
 	writel(0xffff4089, host->base + MSDC_PATCH_BIT1);
 	sdr_set_bits(host->base + EMMC50_CFG0, EMMC50_CFG_CFCSTS_SEL);
 
+	if (host->disable_single_burst)
+		sdr_clr_bits(host->base + MSDC_PATCH_BIT1,
+			     MSDC_PB1_SINGLE_BURST);
+
 	if (host->dev_comp->stop_clk_fix) {
 		if (host->dev_comp->stop_dly_sel)
 			sdr_set_field(host->base + MSDC_PATCH_BIT1,
@@ -2820,6 +2826,10 @@ static void msdc_of_property_parse(struct platform_device *pdev,
 		host->cqhci = true;
 	else
 		host->cqhci = false;
+
+	host->disable_single_burst =
+		of_property_read_bool(pdev->dev.of_node,
+				      "mediatek,disable-single-burst");
 }
 
 static int msdc_of_clock_parse(struct platform_device *pdev,
-- 
2.46.0


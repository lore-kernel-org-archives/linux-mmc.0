Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E446A18C013;
	Thu, 26 Sep 2024 07:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727334309; cv=none; b=lY1g1EWuBRAM8l4HzjquBYH5i1x6LFoLI0MkATyWlq1sKBAmKRUoJMoqxn4L0lcwEwrElqy1K35Op6YpGDT+ixwwhXL+P/mhUDfkxTQd4s22Crz8LgXae2E5Ti3AuxFE1xcKU+/YrW3HthHSYx6iesEj44KhfQNZn7VysvtDU68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727334309; c=relaxed/simple;
	bh=CxmBokh2MPOx5G2rdwQzZy6sHx10A54rwtzhLl4VGMI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lIsBMfIT4CezR9J2BjBpULEye5zUyY8N6u0HbGNDFtRGK0ifM2nLWLsnk84+dTcwyo10nV8BDaymwIhyXrlQfSu1uq71t91q1qwKN9Zt2C/eyz4Mfd866XpzZLcTsiQN9fsDID0M7mPT9/IHfE6eoA0jaou1uQfSyyVHFvLnJyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=pFFHsbGF; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="pFFHsbGF"
X-UUID: a5c2143c7bd511efb66947d174671e26-20240926
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=hlnNEhXRofWMhAnm76CEKduewEiEJ3KrrHEcej/gPKY=;
	b=pFFHsbGFPWGqylBrtus1adQbZYPETocRhjR6iTUylt+sLoXOi7svGhGqwEUekps1Ix6PvEW82tsptiLFB2kxzl1hQig4bSM7ndCvB7HEgCafEd3S2qeVwXARMH6EK34JVGRK5/WWuda6BNhno8/6DnXZ+jlsIjh+M7IesEamoLo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:c725ec0b-aab0-41a4-90f7-fd91814793ad,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:c058979e-8e9a-4ac1-b510-390a86b53c0a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: a5c2143c7bd511efb66947d174671e26-20240926
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <andy-ld.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1424544824; Thu, 26 Sep 2024 15:05:01 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 26 Sep 2024 15:04:59 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 26 Sep 2024 15:04:59 +0800
From: Andy-ld Lu <andy-ld.lu@mediatek.com>
To: <ulf.hansson@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<matthias.bgg@gmail.com>, <wenbin.mei@mediatek.com>
CC: <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, Andy-ld Lu <andy-ld.lu@mediatek.com>
Subject: [PATCH 2/2] dt-bindings: mmc: mtk-sd: Add support for MT8196
Date: Thu, 26 Sep 2024 15:03:18 +0800
Message-ID: <20240926070405.20212-3-andy-ld.lu@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240926070405.20212-1-andy-ld.lu@mediatek.com>
References: <20240926070405.20212-1-andy-ld.lu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Extend the devicetree bindings to include the MT8196 mmc controller
by adding the compatible string 'mediatek,msdc-v2', which could be
also used for future compatible SoCs that support new tx/rx.

Add three properties for MT8196 settings:
- 'mediatek,prohibit-gate-cg', indicate if the source clock CG could
  be disabled when CPU access IP registers.

- 'mediatek,stop-dly-sel', configure read data clock stops at block gap.

- 'mediatek,pop-en-cnt', configure the margins of write and read
  pointers while begin to pop data transfer.

Signed-off-by: Andy-ld Lu <andy-ld.lu@mediatek.com>
---
 .../devicetree/bindings/mmc/mtk-sd.yaml       | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
index c532ec92d2d9..82d1a9fac67c 100644
--- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
+++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
@@ -25,6 +25,7 @@ properties:
           - mediatek,mt8173-mmc
           - mediatek,mt8183-mmc
           - mediatek,mt8516-mmc
+          - mediatek,msdc-v2
       - items:
           - const: mediatek,mt7623-mmc
           - const: mediatek,mt2701-mmc
@@ -154,6 +155,30 @@ properties:
     enum: [32, 64]
     default: 32
 
+  mediatek,stop-dly-sel:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Some SoCs need to set appropriate stop-dly-sel to configure read data clock
+      stops at block gap. The valid range is from 0 to 0xf.
+    minimum: 0
+    maximum: 0xf
+
+  mediatek,pop-en-cnt:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Some SoCs need to set appropriate pop-en-cnt to configure the margins of write
+      and read pointers while begin to pop data transfer. The valid range is from 0
+      to 0xf.
+    minimum: 0
+    maximum: 0xf
+
+  mediatek,prohibit-gate-cg:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Decide if source clock CG could be disabled when CPU access IP registers.
+      If present, source clock CG could not be disabled.
+      If not present, source clock CG could be disabled.
+
   resets:
     maxItems: 1
 
@@ -191,6 +216,7 @@ allOf:
             - mediatek,mt8188-mmc
             - mediatek,mt8195-mmc
             - mediatek,mt8516-mmc
+            - mediatek,msdc-v2
     then:
       properties:
         clocks:
-- 
2.46.0


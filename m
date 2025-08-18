Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D9C319847;
	Mon, 18 Aug 2025 11:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755517748; cv=none; b=t0RTOjjYfEMSuzynThY6RaQ055rKJ+nzZ3+CvujNBr9GxZ2LM8vTAbr36AZbvj/7yggVfKdX2JYkeD6JFlyYsLkFQz1m8BLXYXMFDnJvxBd2hrWyDObnOh4V8gD2TS+5zCOPtU4s8Tiu0DTLM9yiDxj0/fi1zm5j35hkmh8srF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755517748; c=relaxed/simple;
	bh=SAKxyLiHdmjapI/0v82ehEcOeJtGZPTqAaeUY42UAmE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k/Pqsxz3eN6hwy5KnhEGT7/KE0P/AMhYKiJgGmUr+J6ktt56IM7aXr/t6+sc5hnCfbtqrETmEEp6t5Hlt72aYKGM78Ib0Mj7xuLTF4O8tRmIjJ6ic0H+VYLDfqw3XRLD6MjO5p/a8pU1sYPD/2jSIuLB6UDpTg6XIibjJfrjV4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Ts5uEDSh; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Ts5uEDSh"
X-UUID: 543ec4de7c2911f08729452bf625a8b4-20250818
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=lyPRgtJIrl+DCxGXCftDbyg/RUx12+pyN49Ht/Rz3Ao=;
	b=Ts5uEDShSHdxHPRZ2FhRS2c1TFPtaL1BpYBKo8Wrn4bpNQ+ZhzSC+t+sApbc+VkFz2j6co1AHYNqgHhx6Eziz6KSrfGC5YZ+0gpL6mAs/9jpDACIzXhqBSorRLQelj0j3sKB+bPshGr+Zqnkhf5SORTqJA0kwtobjubl24JOy3Y=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3,REQID:93b5a144-6427-463a-969f-6aff181eb48e,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:f1326cf,CLOUDID:6e869844-18c5-4075-a135-4c0afe29f9d6,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:-5,Content:0|15|50,EDM:-3,IP:
	nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,L
	ES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 543ec4de7c2911f08729452bf625a8b4-20250818
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <mengqi.zhang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 217536809; Mon, 18 Aug 2025 19:48:59 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 18 Aug 2025 19:48:58 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 18 Aug 2025 19:48:57 +0800
From: Mengqi Zhang <mengqi.zhang@mediatek.com>
To: Chaotian Jing <chaotian.jing@mediatek.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Wenbin Mei
	<wenbin.mei@mediatek.com>
CC: <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, Mengqi Zhang
	<mengqi.zhang@mediatek.com>
Subject: [PATCH] dt-bindings: mmc: Add compatible for MT8189 SoC
Date: Mon, 18 Aug 2025 19:47:27 +0800
Message-ID: <20250818114855.8637-1-mengqi.zhang@mediatek.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add a compatible string for the MT8189 SoC's mtk-sd mmc controllers.

Signed-off-by: Mengqi Zhang <mengqi.zhang@mediatek.com>
---
 .../devicetree/bindings/mmc/mtk-sd.yaml       | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
index 6dd26ad31491..1285dddeaec9 100644
--- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
+++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
@@ -25,6 +25,7 @@ properties:
           - mediatek,mt8135-mmc
           - mediatek,mt8173-mmc
           - mediatek,mt8183-mmc
+          - mediatek,mt8189-mmc
           - mediatek,mt8196-mmc
           - mediatek,mt8516-mmc
       - items:
@@ -192,6 +193,7 @@ allOf:
             - mediatek,mt8183-mmc
             - mediatek,mt8186-mmc
             - mediatek,mt8188-mmc
+            - mediatek,mt8189-mmc
             - mediatek,mt8195-mmc
             - mediatek,mt8196-mmc
             - mediatek,mt8516-mmc
@@ -240,6 +242,7 @@ allOf:
               - mediatek,mt7986-mmc
               - mediatek,mt7988-mmc
               - mediatek,mt8183-mmc
+              - mediatek,mt8189-mmc
               - mediatek,mt8196-mmc
     then:
       properties:
@@ -319,6 +322,32 @@ allOf:
             - const: source_cg
             - const: crypto
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: mediatek,mt8189-mmc
+    then:
+      properties:
+        clocks:
+         items:
+            - description: source clock
+            - description: HCLK which used for host
+            - description: independent source clock gate
+            - description: bus clock used for internal register access
+            - description: peripheral bus clock gate
+            - description: AXI bus clock gate
+            - description: crypto clock used for data encrypt/decrypt (optional)
+        clock-names:
+          items:
+            - const: source
+            - const: hclk
+            - const: source_cg
+            - const: bus_clk
+            - const: pclk_cg
+            - const: axi_cg
+            - const: crypto
+
   - if:
       properties:
         compatible:
-- 
2.46.0


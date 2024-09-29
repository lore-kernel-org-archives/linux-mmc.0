Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F1513B2A8;
	Sun, 29 Sep 2024 07:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727596015; cv=none; b=IU6yA0kJmu38rAJuIYY9g1+jsP7bkIkUJHFxkjR3w/TjDnHNPMG6WVLCe04HOAb0/ptkOxfkku/5//rdbBxG6M55eJZ6qnfcCboqiF/DRK6MiFSPAwDW4kfYyABdXwBZzHkbtY+p/5UeNvEiB7R7VpN2gs3DNWAuTpye44DFHpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727596015; c=relaxed/simple;
	bh=yp08+//RSoqgXfqOEU/S3NLrgaJouz8zsYRlz4KGgp4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eKjxxYrJkyz9K3js/IE+8FaACG34SyMESDefBEMsAf6BLVJqXQOVIbKu3ND7vCXj4knSwYLKZ+HeBoYGs1aOwazZitdtx68Lp+Cjoq0hpi+JTpFFyC80XGylu0l7Lyln1Wj7gg7/tykV9CozEY2dDUx6VZ5DLYgdXRUM+T3GZyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=qOjjZtIw; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="qOjjZtIw"
X-UUID: fb0b9fb87e3611ef8b96093e013ec31c-20240929
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=r8TZngzN4fBlzJ+3/GEuV4pMEHO8a4/YigjdzIgfAg0=;
	b=qOjjZtIw0HgQyugPxvf5R4q3Qtv9PYWhel0xk1oxaWzKm8oqHqS2z+QYXiraRjOlyTvzIZ8lWXuUGbAMJoQcysMMzdLOVKvPVbUL8oY0xHStL1Z0fknncU4L1TWidhBRsSf92Zf0O2CZmHcd/uAYpDoH9844/gMp0A9mxaRz24E=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:3eee02eb-323a-4541-b133-53847ad6cc4a,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:0e39ba9e-8e9a-4ac1-b510-390a86b53c0a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: fb0b9fb87e3611ef8b96093e013ec31c-20240929
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <andy-ld.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 361085278; Sun, 29 Sep 2024 15:46:47 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sun, 29 Sep 2024 15:46:45 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sun, 29 Sep 2024 15:46:45 +0800
From: Andy-ld Lu <andy-ld.lu@mediatek.com>
To: <ulf.hansson@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<matthias.bgg@gmail.com>, <angelogioacchino.delregno@collabora.com>,
	<wenbin.mei@mediatek.com>
CC: <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, Andy-ld Lu <andy-ld.lu@mediatek.com>
Subject: [PATCH v2 2/2] dt-bindings: mmc: mtk-sd: Add support for MT8196
Date: Sun, 29 Sep 2024 15:44:06 +0800
Message-ID: <20240929074558.2076-3-andy-ld.lu@mediatek.com>
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
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--3.262000-8.000000
X-TMASE-MatchedRID: 4vekfgKkjb2jFYHTfcPkwnUh2OMdFI0JdER46uj876/oFeE5MSxNMeLz
	NWBegCW2wgn7iDBesS0nRE+fI6etklKI8qMY6HF7MGxmFQglB5et5WtO61sYkDS0ZY+wELuA1wq
	6eaS/JMBEcjFBF4nb7T9MP3O5iuBM7ziozp+iUBSNwFX5iWojOYSVUZZHNLr+RgV6Hsqyx11QaO
	NuZ6Jr4g9k3l8EaYIcDiKmdrlEg1g=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--3.262000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 7E9F5FBC0FD3DFB04D1DF69141D31E33C8E2900EA44CCA49FD8478C6D41A6FB42000:8

Extend the devicetree bindings to include the MT8196 mmc controller
by adding the compatible string 'mediatek,mt8196-mmc'.

Signed-off-by: Andy-ld Lu <andy-ld.lu@mediatek.com>
---
 Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
index c532ec92d2d9..9281a0326891 100644
--- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
+++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
@@ -24,6 +24,7 @@ properties:
           - mediatek,mt8135-mmc
           - mediatek,mt8173-mmc
           - mediatek,mt8183-mmc
+          - mediatek,mt8196-mmc
           - mediatek,mt8516-mmc
       - items:
           - const: mediatek,mt7623-mmc
@@ -190,6 +191,7 @@ allOf:
             - mediatek,mt8186-mmc
             - mediatek,mt8188-mmc
             - mediatek,mt8195-mmc
+            - mediatek,mt8196-mmc
             - mediatek,mt8516-mmc
     then:
       properties:
-- 
2.46.0


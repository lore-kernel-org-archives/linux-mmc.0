Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4591F9401;
	Fri, 11 Oct 2024 02:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728615003; cv=none; b=F0aY+E4Kg6GZM/u0haVZzyXmmHKrXd/TBN0Alb73bkqX5YStubL85l1MksB//eBl0rILspB9Cn8V340gDxQeOhyTvypY7Jtg7Gc2TLqcVDj4kerU1uiXCDU49x7X1xwY6HOIbQf0Z9/YRKOJFEY2UI9yRugHStun1w2Rk8miNwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728615003; c=relaxed/simple;
	bh=8qhybywX/Fey8YZ/6Jo9Yg8FOp4vK+Uw5xKGT4ZXbx4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z1SjwVSD9F7iiX6AoWxqQQChU8bZhWmOhELfA/va+zTKdkXKLFFC6l8RAbum2Z4Wd+i+s6tHwG2jn6VK0n2zGu/eTdqQcXXx7S4VHb91XGrE3uLoYfpho7FfshWLMdR/21F2Vzww6fQiXsIi1g93yQkqlEXE4EIXVF5eagOzfok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=XwzU1TTG; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="XwzU1TTG"
X-UUID: 7f416126877b11ef88ecadb115cee93b-20241011
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=SALh9hOsK54vErFDn29jQk1l94WOB1hPU+0EjGmHCWo=;
	b=XwzU1TTGfdXxOlEraQKor/+DNUi38Sp6EVCjB5NkbfAvUKAl1K1L0IleCFwA7Nq+7zyW41pdtN34BU6UhlFpCyyGzQcSXzGlGXxuYr4nBi4nepjfsLrIJQl3RcLPpkXF3e72HzdUwxV6g0aUuIejRQtMsdaKipDDjKelnIHQ0g8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:84c344ec-bbcc-447f-a785-675e1593ca98,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:e09a1165-444a-4b47-a99a-591ade3b04b2,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 7f416126877b11ef88ecadb115cee93b-20241011
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <andy-ld.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 9910094; Fri, 11 Oct 2024 10:49:55 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 11 Oct 2024 10:49:53 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 11 Oct 2024 10:49:52 +0800
From: Andy-ld Lu <andy-ld.lu@mediatek.com>
To: <ulf.hansson@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<matthias.bgg@gmail.com>, <angelogioacchino.delregno@collabora.com>,
	<wenbin.mei@mediatek.com>
CC: <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, Andy-ld Lu <andy-ld.lu@mediatek.com>,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v4 3/3] dt-bindings: mmc: mtk-sd: Add support for MT8196
Date: Fri, 11 Oct 2024 10:48:36 +0800
Message-ID: <20241011024906.8173-4-andy-ld.lu@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241011024906.8173-1-andy-ld.lu@mediatek.com>
References: <20241011024906.8173-1-andy-ld.lu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10-3.010100-8.000000
X-TMASE-MatchedRID: uVuWzlu52Rkh3Xy1KnQIRMnUT+eskUQPkos2tunL8DSKvSwHZ9zxVEgC
	lCIX2gewLYexjI/F2s5WZCdNM8s+D7BAQLqGlKivngIgpj8eDcAZ1CdBJOsoY8RB0bsfrpPInxM
	yeYT53RkzZYRPaI6cs3HdO5DeoK+VQnhvAgn814E14Xf/AzddUsWxi9xyl7z5uuTQ/d/i9EEpgu
	IlSZIj9U4rrOJPbCTVDpJPrFflb/Yc/j4aI5S1Lnr9GD0zfOvEAaqvv/mhgrEIcy9ODq9nmcPIN
	hwTXBeZ
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10-3.010100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 608E7277F4E668B5AC2F8EEEE4DFE76C873C22D78087C497745176D5C448464A2000:8

Extend the devicetree bindings to include the MT8196 mmc controller,
new tx/rx would be supported from MT8196, and the register settings
of STOP_DLY_SEL and POP_EN_CNT would also be variant.

Signed-off-by: Andy-ld Lu <andy-ld.lu@mediatek.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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


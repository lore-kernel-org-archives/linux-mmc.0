Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490F72E3369;
	Thu,  6 Mar 2025 08:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741251049; cv=none; b=h6QnCunPP9bKo7lOjr7U/ttnM0xOf6UkJTfQ/0rovvEe2m1DqDQZd/VJOpxiaeS62Ky9j7s3xLGvStnRhP/yajSJx3hR2frc3S7rov6Do7TEHp05vtBt1TINJF2AoNri1aY6pEf2YRXNOF934Nu2/4L8YC9IY3tB6kW5hpZnbEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741251049; c=relaxed/simple;
	bh=eo0o+rvg6o+QpEcefXMMEpNkvpXSgy0XOsxXwMvNYVI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=trFaw8BgBL72lWq2MCeUTTdzlnaAYI5yKJvK6KpxaXR738U6yyjStE5/H+nanhF65NOo7+Vox4wS/aaIi0p9I7+cy53YP/V4hDvTw16l7KOjni7BW/BaA8HujNnySxBTVDEL6hLS38kn3yeXuI4Q6mo7NFrJ/nmJ38z6sG9fsV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=PbHGUyWL; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="PbHGUyWL"
X-UUID: 1366947afa6811efaae1fd9735fae912-20250306
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=+L7XbtqDHwNvJUYAa1gSH9tcjYho7+xK58vS0fLoWWw=;
	b=PbHGUyWLkS78neyhusP+36+5eaglCBmiBvkfFR7EIngAe7RuFS/7QohJs6tRm6gD0dA1k6d7dxXLFp41K5dRs1RqQJqdk5c5ihyObwXjAO/ujXjSObtY0S+emqcmYLUBR3YgSO8Hn1zSn7b+LfohNBcXAsUnog427EYAAgjIx0M=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:262a9632-a172-4838-bc07-28e35c1ff6cb,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:90ccc249-a527-43d8-8af6-bc8b32d9f5e9,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 1366947afa6811efaae1fd9735fae912-20250306
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <axe.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 653749506; Thu, 06 Mar 2025 16:50:38 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 6 Mar 2025 16:50:36 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Thu, 6 Mar 2025 16:50:36 +0800
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
Subject: [PATCH 1/2] dt-bindings: mmc: mtk-sd: add single burst switch
Date: Thu, 6 Mar 2025 16:48:05 +0800
Message-ID: <20250306085028.5024-2-axe.yang@mediatek.com>
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

Add 'mediatek,disable-single-burst' setting. This property can be
used to switch bus burst type, from single burst to INCR, which is
determined by the bus type within the IP. Some versions of the IP
are using AXI bus, thus this switch is necessary as 'single' is not
the burst type supported by the bus.

Signed-off-by: Axe Yang <axe.yang@mediatek.com>
---
 Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
index 0debccbd6519..6076aff0a689 100644
--- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
+++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
@@ -100,6 +100,14 @@ properties:
     minimum: 0
     maximum: 0xffffffff
 
+  mediatek,disable-single-burst:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Burst type setting. For some versions of the IP that do not use
+      AHB bus, the burst type need to be switched to INCR.
+      If present, use INCR burst type.
+      If not present, use single burst type.
+
   mediatek,hs200-cmd-int-delay:
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
-- 
2.46.0


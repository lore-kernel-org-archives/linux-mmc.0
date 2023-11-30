Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="sUruE0R7"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74A610C6;
	Wed, 29 Nov 2023 22:15:22 -0800 (PST)
X-UUID: d5b2d24c8f4711eea33bb35ae8d461a2-20231130
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=kxQYsKa9TV61EUlxG60oM3DRsmXzoQm8uA+24Ky6RCA=;
	b=sUruE0R7KbAW3IhwkB854DayIBVfEA/uKGJ1AbqwLucMd33bYuTToAWTSbMtNJBz/1+uAEGrOhzao/+wya8qTb9FIyIVlMLliY6q70FQVtPI0BYSJLqkXu035axxtdu+kpJNHEbitiijrA5p571XL2Gq2TySK4Dh0NjHeM25Wwk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.34,REQID:893af131-3d97-46ef-af80-1c08f538a32a,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:abefa75,CLOUDID:8e4da660-c89d-4129-91cb-8ebfae4653fc,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d5b2d24c8f4711eea33bb35ae8d461a2-20231130
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <axe.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 927384717; Thu, 30 Nov 2023 14:15:18 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 30 Nov 2023 14:15:17 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 30 Nov 2023 14:15:16 +0800
From: Axe Yang <axe.yang@mediatek.com>
To: Chaotian Jing <chaotian.jing@mediatek.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Wenbin
 Mei <wenbin.mei@mediatek.com>
CC: <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Axe Yang
	<axe.yang@mediatek.com>
Subject: [PATCH v3 0/2] mmc: mediatek: add support for 64-steps tuning 
Date: Thu, 30 Nov 2023 14:15:11 +0800
Message-ID: <20231130061513.1296-1-axe.yang@mediatek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

Change in v3:
- use BIT_ULL() instead of BIT() to avoid potential left shift operations
  that could cause exceed boundary problem on 32-bit platforms

Change in v2:
- move the change made to document to the front
- change mediatek,tune-step dts property type to enum for better scalability

Axe Yang (2):
  dt-bindings: mmc: mtk-sd: add tuning steps related property
  mmc: mediatek: extend number of tuning steps

 .../devicetree/bindings/mmc/mtk-sd.yaml       |   9 +
 drivers/mmc/host/mtk-sd.c                     | 155 ++++++++++++------
 2 files changed, 116 insertions(+), 48 deletions(-)

-- 
2.25.1


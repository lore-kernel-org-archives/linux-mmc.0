Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006C0139B;
	Thu, 26 Sep 2024 07:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727334275; cv=none; b=c2z3c/pzej4scXjY4uzCbeivI6WuwbheQciKDUwM/uscrVhj3W0jknqSqHocPJCG8iuKgebg0lJydO3NmWGEFMWY93FktQkx7CisoOyYfp0qIyotG5bcgzJQhR2LhttC8i52iLAm3j8PykonWVWIBP9+ghcpC3CmCOL38Ek5Xwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727334275; c=relaxed/simple;
	bh=1XOIqL/2SpN3XIWVOjWZEKZ21s2pnEm2BRcsqxkaxFs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m7GPcTeDQWYpK6aeGSDKXBIH/pt9M7g4tgFUUQmabsvHFdxD8dJI9NIuQaThshPHKp6VHs/englGrwqwxaj3oxHj2kTkXVwghHfUn1dTVPm9s8VHvd6RNFe+X+jtN6bZFlCj9+j3D0EI+eJACKxuQdioyIPtND6tge1nyGyByvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ZBl8siqX; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ZBl8siqX"
X-UUID: 91ad1c767bd511efb66947d174671e26-20240926
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=u2VyllAmx1eNrj4fBWbMCyugVwolephg65owyjKq1Jk=;
	b=ZBl8siqXvwMQ0KYfY5y0untMcqNsed9PH0PtmapdYDVaaXbXNH3ZeIbV3aN5hwux6ZFAaWKBwfVefAUpZgefFc5RCXF6PV3iQlzxn/EcwfQtBfDLNpDCb8Wqs71b8NuDsh3uxP//BTPeNuUQiQUSHMzr+WdAMbwduSlpmoKrBVI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:e54bff40-6095-4f1f-abf9-e11d573064d7,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6dc6a47,CLOUDID:4156979e-8e9a-4ac1-b510-390a86b53c0a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 91ad1c767bd511efb66947d174671e26-20240926
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <andy-ld.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1415652439; Thu, 26 Sep 2024 15:04:27 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 26 Sep 2024 15:04:26 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 26 Sep 2024 15:04:25 +0800
From: Andy-ld Lu <andy-ld.lu@mediatek.com>
To: <ulf.hansson@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<matthias.bgg@gmail.com>, <wenbin.mei@mediatek.com>
CC: <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, Andy-ld Lu <andy-ld.lu@mediatek.com>
Subject: [PATCH 0/2] Add mtk-sd support for MT8196
Date: Thu, 26 Sep 2024 15:03:16 +0800
Message-ID: <20240926070405.20212-1-andy-ld.lu@mediatek.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

There are some new features for Mediatek SoC MT8196, which include new
command/data transmitting and receiving path (abbreviated as tx/rx), and
a new bus design that prevents the CPU from accessing the IP registers
unless the source clock control gate is enabled. Furthermore, some register
settings are also modified.

The driver code has to be adapted to implement the above changes, and the
compatible 'mediatek,msdc-v2' is added to driver and devicetree bindings,
for MT8196 and future compatible SoCs that support new tx/rx.

Andy-ld Lu (2):
  mmc: mtk-sd: Add support for MT8196
  dt-bindings: mmc: mtk-sd: Add support for MT8196

 .../devicetree/bindings/mmc/mtk-sd.yaml       |  26 +++
 drivers/mmc/host/mtk-sd.c                     | 179 +++++++++++++++---
 2 files changed, 182 insertions(+), 23 deletions(-)

-- 
2.46.0


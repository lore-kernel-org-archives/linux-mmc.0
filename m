Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262762063DB;
	Thu,  6 Mar 2025 08:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741251051; cv=none; b=tVBQcoo68setSnZQcuACTAHBdPosM5OP5DUhV8btTr+Ms3ec0i1yu7BzHafwoF2SEuyv0S/fShfwyeC29+0iCSCUoeWYr2rdU+41Z+BYz5L6q2d2BFpz2+rt3fDo+Wb8nc2xqZDCC9YFjBYzg3sYx0iMxSF8NtekyTVqpyfrfyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741251051; c=relaxed/simple;
	bh=ReONslqod6Z4YGoZjrEjAvDDP+jWFdGtk+9Np2uz1Ek=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pYzoepK6zxx6yeZBFFqk9hjFdeWdf2AueGKY3QLK3u4Das7y2BDVFbvxIyL87EgfAcNCUAchYcPSxXk+kksplgjJDGvVvMUk7T6F/VP7bz6jcMaG7SQtwBxvO8pCAhMw3dROUtlT42Wu5Tg+gQINDkX1Io1l+wG3kXhuXnZH4Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=uKOT+d7d; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="uKOT+d7d"
X-UUID: 12ce7f8cfa6811efaae1fd9735fae912-20250306
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=zZk3OkAU1AqUqDxdrw3CKq7flSmIjZeU0GWKHI9L5/M=;
	b=uKOT+d7d6kzJbGCB2W5s1xaEo1QKBmOQqHEDw7LslYWe4U1VgwPYoq9c6ohSse365c8nm5Y7sc+VG3TwirVGtGitq7oHBsk43sKtzFOmgfzplV4B41dJXNnMERQwjP+FeR388M6jWVIm8/jk/ZjjP2D6MXqae1ZMbB2HUc92ZIU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:125477f1-1a9a-41e6-96f3-dd0186cc03d8,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:668cfec5-16da-468a-87f7-8ca8d6b3b9f7,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 12ce7f8cfa6811efaae1fd9735fae912-20250306
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <axe.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 882433906; Thu, 06 Mar 2025 16:50:37 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 6 Mar 2025 16:50:35 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Thu, 6 Mar 2025 16:50:35 +0800
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
Subject: [PATCH 0/2] mmc: mtk-sd: add support for burst type switch
Date: Thu, 6 Mar 2025 16:48:04 +0800
Message-ID: <20250306085028.5024-1-axe.yang@mediatek.com>
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

Add a device tree property for MSDC node to switch burst type.
The default burst type is 'single', but for some versions of IP,
the AMBA type is AXI, which do not support 'single' burst type.

This series of changes provides a way to switch the burst type,
and is necessary as the AXI bus is being used more frequently
in the new versions of MSDC IP.

Axe Yang (2):
  dt-bindings: mmc: mtk-sd: add single burst switch
  mmc: mtk-sd: add support to disable single burst

 Documentation/devicetree/bindings/mmc/mtk-sd.yaml |  8 ++++++++
 drivers/mmc/host/mtk-sd.c                         | 10 ++++++++++
 2 files changed, 18 insertions(+)

-- 
2.46.0


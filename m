Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9553D64;
	Fri, 11 Oct 2024 02:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728614960; cv=none; b=GaHWXkRlwb7Sl+HeSEOlw1uWtEH/xAIPgdYyi+PM6GqxWzJ0wmJUWL6feXnton1UTsdRUpA0CASRIrDXxgiwIBrggOmO4ih7Le0VbbYYOt0O1w26rDHGgMTXr7g2DdZKcV4sza707i03jMJpLgNQmksOYHDyea8UZ2OwtmCptec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728614960; c=relaxed/simple;
	bh=maWhANOuzw7gl+gaiBH7l5dUr0vBF1MmNHN+8F1AxSI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SjRM9G+qs/QhGvLIz126dk9rFmH1MTHe5r5EEVgF0iOHb9xcl1q0YVWcBZfdUMHZ6LNi8mKsuqbnBKsO4yojQFxxugdOmMKpL/ALime9xt49CrnhPbde22OvGYg6T+ka33+yOmmiT2WbYpbzgRjpY/NmJQEsLpvl+1qdCM4sgEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ck1pptDq; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ck1pptDq"
X-UUID: 645111cc877b11ef8b96093e013ec31c-20241011
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=CTx2RnJfJO7puldyYO2urzSFdiG6+1YvJReMvVimZC8=;
	b=ck1pptDqy+BrYlwcBM/mI6gJL+dg+SXsjGI8PMLwfTKJEgJFxT5drnjUHeLP3N6Thko+EvIgSsLkjm4TEfoY4V/Ihthus2TCcBZfnpLKleI62Zli8OdFnkfiTJihELVmfjiz7Hf2YQ4XQjhRQWqobOGLzVqWWqZ7ZCOvZ/sJHBc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:ef0173b4-b54c-43fb-ba8b-5173af2af6a7,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:9cea9c26-5902-4533-af4f-d0904aa89b3c,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 645111cc877b11ef8b96093e013ec31c-20241011
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <andy-ld.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1738391102; Fri, 11 Oct 2024 10:49:10 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 11 Oct 2024 10:49:09 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 11 Oct 2024 10:49:08 +0800
From: Andy-ld Lu <andy-ld.lu@mediatek.com>
To: <ulf.hansson@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<matthias.bgg@gmail.com>, <angelogioacchino.delregno@collabora.com>,
	<wenbin.mei@mediatek.com>
CC: <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, Andy-ld Lu <andy-ld.lu@mediatek.com>
Subject: [PATCH v4 0/3] Add mtk-sd support for MT8196
Date: Fri, 11 Oct 2024 10:48:33 +0800
Message-ID: <20241011024906.8173-1-andy-ld.lu@mediatek.com>
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
two modified register settings.

The driver code has to be adapted to implement the above changes, and the
compatible string 'mediatek,mt8196-mmc' is added to driver and devicetree
bindings.

---
Changes in v4:
- Reorder the first two commits, and update the commit message to explain
  why the settings of stop_dly_sel and pop_en_cnt are variant.

Changes in v3:
- Separate the settings for stop_dly_sel and pop_en_cnt to a different
  commit; 
- Add the original value of stop_dly_sel to the platdata of legacy SoCs,
  for unified code setting;
- Change to return if host->top_base is NULL in msdc_new_tx_setting function,
  to simplify coding;
- Optimize the location of assignment for 'timing_changed' in msdc_set_mclk
  function.

Changes in v2:
- Use compatible string 'mediatek,mt8196-mmc' to replace 'mediatek,msdc-v2';
- Remove the 'mediatek,stop-dly-sel', 'mediatek,pop-en-cnt' and 'mediatek,
  prohibit-gate-cg' in devicetree bindings, due to SoC dependent;
- Add 'stop_dly_sel' and 'pop_en_cnt' to the compatiblity structure for
  different register settings;
- The SoC's upgraded version would discard the bus design that detect source
  clock CG when the CPU access the IP registers, so drop the related control
  flow with 'prohibit_gate_cg' flag.

Link to v1:
https://patchwork.kernel.org/patch/13812924

---
Andy-ld Lu (3):
  mmc: mtk-sd: Add stop_dly_sel and pop_en_cnt to platform data
  mmc: mtk-sd: Add support for MT8196
  dt-bindings: mmc: mtk-sd: Add support for MT8196

 .../devicetree/bindings/mmc/mtk-sd.yaml       |   2 +
 drivers/mmc/host/mtk-sd.c                     | 166 +++++++++++++++---
 2 files changed, 147 insertions(+), 21 deletions(-)

-- 
2.46.0


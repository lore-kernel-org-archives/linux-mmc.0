Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B183819068E;
	Wed,  9 Oct 2024 12:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728475342; cv=none; b=G82toymlM3ie2IvBqaclOYYwRyHL4amEM7fzIeX67Nx7Bp5wnXsaq2PplrZqwCyyukN9iUtDKYWdf/81VHTTF1KXkImxdNvuBB/B5LdjvZ5kr21CUOusta+Qc05aFwWlIpZpodY1wZo6GREmDvuWUY6QQmYYpTsX3bvmSZ78Q+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728475342; c=relaxed/simple;
	bh=JS05tjTZ6VGXiAeuh5EpRJiPd4v2JoHnLHFs0xLRpXA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fvsk1WfREo+Fe3m7dzRAiWqBiL9LIfaCrB40OO2jMRZzzMUE4O9BXe3mAUHPV+3O0WgdZd1CgwQfuDpydwJ480BA1SHUNZex7ZgB3Ybx6dwlKoFmDkbzda7rinVMO9JIivZ0DfH/JW/cZBtkPwxS3LKwPMEsAjPQhirCO2a2iCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=FFal7dpZ; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="FFal7dpZ"
X-UUID: 52335f4a863611ef8b96093e013ec31c-20241009
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=wft0wMYjRol19sQXS7lU7PGKjsnYG5Yenj+/tz3tTQ8=;
	b=FFal7dpZ0mU4QV8mNteFS69YCD4IM/KxlT1xJXqeXJQqK39BEj5tbJIJ6qbQiVf15rXDeAj3wkvwb+YNmMr0OfalAQrolFsEK+uxZHcHrW4Q3vazMbP3CjT4Mjq+sqBXpwRbLPsxEtDOnHkV2CN+wBEQsrckRkNqwNJqVBr26aw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:d9ea9141-0f78-4c11-8c3b-8ab414a5ec60,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:8dc5fe64-444a-4b47-a99a-591ade3b04b2,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 52335f4a863611ef8b96093e013ec31c-20241009
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <andy-ld.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 940317029; Wed, 09 Oct 2024 20:02:13 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 9 Oct 2024 20:02:09 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 9 Oct 2024 20:02:08 +0800
From: Andy-ld Lu <andy-ld.lu@mediatek.com>
To: <ulf.hansson@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<matthias.bgg@gmail.com>, <angelogioacchino.delregno@collabora.com>,
	<wenbin.mei@mediatek.com>
CC: <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, Andy-ld Lu <andy-ld.lu@mediatek.com>
Subject: [PATCH v3 0/3] Add mtk-sd support for MT8196
Date: Wed, 9 Oct 2024 20:01:23 +0800
Message-ID: <20241009120203.14913-1-andy-ld.lu@mediatek.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--4.718400-8.000000
X-TMASE-MatchedRID: 6Pyq8tKkRyftt0HEL3BUV7iMC5wdwKqdLoYOuiLW+uXfq/+cvg1NCKip
	18v0DWYVnxamL54dKNbAFycL8Ymu1rhhaFskSWDqYwaJXrf2IXSL6a+kPOEFsJ6fSoF3Lt+MMqR
	wky9xOk45imXDx6zyYOFr39PS7zaEgZI1n6aNUzbJ5W6OZe5hhYEcpMn6x9cZOW8XgChxVdgwfX
	HHXt4W1FoqhwIvssPy3c3CRAd2bOE2UEKHDN0wzBlckvO1m+JcTJDl9FKHbrmdohxAwFG9tKPFj
	JEFr+olwXCBO/GKkVqOhzOa6g8KraTORqtbRsP2nTRjrsQn0THUTvWJ9mbf13z4B5fjDcKL3YG1
	Y8RuI/JK31unxphxzudGiGOk5aHhKyVJb/VK9KDdknd0aVk9DuLDq7G+Ik/yv22xKJRyIGVDnOx
	ozmpp1r+WvXJiKHRLKUZy1dpMKy4=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.718400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 02CD6116B37BFC20CAFB3C4A291E803122577B9430CD7D288F9F17C22E29986A2000:8

There are some new features for Mediatek SoC MT8196, which include new
command/data transmitting and receiving path (abbreviated as tx/rx), and
two modified register settings.

The driver code has to be adapted to implement the above changes, and the
compatible string 'mediatek,mt8196-mmc' is added to driver and devicetree
bindings.

---
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
  mmc: mtk-sd: Add support for MT8196
  mmc: mtk-sd: Add two settings in platdata
  dt-bindings: mmc: mtk-sd: Add support for MT8196

 .../devicetree/bindings/mmc/mtk-sd.yaml       |   2 +
 drivers/mmc/host/mtk-sd.c                     | 166 +++++++++++++++---
 2 files changed, 147 insertions(+), 21 deletions(-)

-- 
2.46.0


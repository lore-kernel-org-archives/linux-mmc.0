Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C40379F6;
	Thu,  7 Nov 2024 01:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730944048; cv=none; b=mKuHL7I3jvYWmF/oycY2SxPpFDrNI37Y8ZGVqPBCM0yAgO0gZIu6U/RAhEeDFpjkMf60UbRv2b8pn8g6by1I/iQyNhX+/R2yxY6ryVRqa60UvnSJjOdGJ20qdDqYH8/FzWOkuBtb0fZ+Q9pn5VmYEP7spDs2dIcaY8bU1Vmt/9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730944048; c=relaxed/simple;
	bh=rRk6cq2F/tp4Zcn90ksnzekGavL+iUlCGiUtZ73axNE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UI2alLYEcYhD1QhCR5t9MdFPiZ/m+Fyt3AaluTON5Erg/8C7oZJEHT0I3o6vAar1Ma8g2VPfD9TmdoR9wbIa3HGQi8ItbirDlyHNZlYzExklJ0thYndyaOfBdZusbCSXDYVvsNRWEW5YaIjrg4+LD0ScwK1yDR7Ydm3K+j0mxD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=bYSeO+W5; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="bYSeO+W5"
X-UUID: 3b4858e69caa11efb88477ffae1fc7a5-20241107
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=3W5PDY06+vGKIgs/nnc6DCcFazFeqkExG65rOZ8TJMY=;
	b=bYSeO+W50cK/AvrjmSKscoWuKjivWQPfkz4a+5Af9bVyl27r8gXfGIuckiyXrMAv9sPSuAA5QZMdbpSfNu/e6WYzP0Tz9XRqWGJb4W5xAWq9wkGWjOC3S5yf8HdkmMlDiJh4s14wNgWg4Y1y59r83hmLs/hfyFEzu9nzrm2B+0k=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:263391a9-8d72-4741-aaea-a742953a93ae,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:b0fcdc3,CLOUDID:26c1ac06-6ce0-4172-9755-bd2287e50583,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 3b4858e69caa11efb88477ffae1fc7a5-20241107
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <andy-ld.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2031822430; Thu, 07 Nov 2024 09:47:22 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 7 Nov 2024 09:47:19 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 7 Nov 2024 09:47:19 +0800
From: Andy-ld Lu <andy-ld.lu@mediatek.com>
To: <angelogioacchino.delregno@collabora.com>, <ulf.hansson@linaro.org>,
	<matthias.bgg@gmail.com>, <wenbin.mei@mediatek.com>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	Andy-ld Lu <andy-ld.lu@mediatek.com>
Subject: [PATCH] mmc: mtk-sd: Fix error handle of probe function
Date: Thu, 7 Nov 2024 09:47:07 +0800
Message-ID: <20241107014714.24981-1-andy-ld.lu@mediatek.com>
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
X-TM-AS-Result: No-10--8.332800-8.000000
X-TMASE-MatchedRID: OLc6pRZQUVIxZlmZjLleZjPDkSOzeDWWq6/EYzBxkJgifM7JMNHW6xnH
	32sG9jpsk6w8yr9UCBOnpDsu3n08UYjHxngndevxjNvYZHpO13fRfRfl2l4F3mtl3YYsdIHcBtM
	QoGDRYEdfcTZ8crFLktWHvGFXsGeXsEBAuoaUqK/il2r2x2PwtQrefVId6fzVYdn5x3tXIpc7Qm
	s3AC7auwWJQuk93Z8PIHSszW9OO9ONBnVioBmwYZ4CIKY/Hg3AGdQnQSTrKGPEQdG7H66TyF82M
	XkEdQ770NH2Sv6E5SYne4LyJjwYxKLlHqJF1Ux2JFezMmuBWhtUQBzN9bOMTg==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--8.332800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 3EFFC2BAA1189F12C483A8F0D241AC66204B4ABBF44944DC8F2C2D7C342F09702000:8

In the probe function, it goes to 'release_mem' label and returns after
some procedure failure. But if the clocks (partial or all) have been
enabled previously, they would not be disabled in msdc_runtime_suspend,
since runtime PM is not yet enabled for this case.

That cause mmc related clocks always on during system suspend and block
suspend flow. Below log is from a SDCard issue of MT8196 chromebook, it
returns -ETIMEOUT while polling clock stable in the msdc_ungate_clock()
and probe failed, but the enabled clocks could not be disabled anyway.

[  129.059253] clk_chk_dev_pm_suspend()
[  129.350119] suspend warning: msdcpll is on
[  129.354494] [ck_msdc30_1_sel : enabled, 1, 1, 191999939,   ck_msdcpll_d2]
[  129.362787] [ck_msdcpll_d2   : enabled, 1, 1, 191999939,         msdcpll]
[  129.371041] [ck_msdc30_1_ck  : enabled, 1, 1, 191999939, ck_msdc30_1_sel]
[  129.379295] [msdcpll         : enabled, 1, 1, 383999878,          clk26m]

Add a new 'release_clk' label and reorder the error handle functions to
make sure the clocks be disabled after probe failure.

Signed-off-by: Andy-ld Lu <andy-ld.lu@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index a2750a45c1b7..022526a1f754 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -3007,7 +3007,7 @@ static int msdc_drv_probe(struct platform_device *pdev)
 	ret = msdc_ungate_clock(host);
 	if (ret) {
 		dev_err(&pdev->dev, "Cannot ungate clocks!\n");
-		goto release_mem;
+		goto release_clk;
 	}
 	msdc_init_hw(host);
 
@@ -3017,14 +3017,14 @@ static int msdc_drv_probe(struct platform_device *pdev)
 					     GFP_KERNEL);
 		if (!host->cq_host) {
 			ret = -ENOMEM;
-			goto release_mem;
+			goto release;
 		}
 		host->cq_host->caps |= CQHCI_TASK_DESC_SZ_128;
 		host->cq_host->mmio = host->base + 0x800;
 		host->cq_host->ops = &msdc_cmdq_ops;
 		ret = cqhci_init(host->cq_host, mmc, true);
 		if (ret)
-			goto release_mem;
+			goto release;
 		mmc->max_segs = 128;
 		/* cqhci 16bit length */
 		/* 0 size, means 65536 so we don't have to -1 here */
@@ -3064,9 +3064,10 @@ static int msdc_drv_probe(struct platform_device *pdev)
 end:
 	pm_runtime_disable(host->dev);
 release:
-	platform_set_drvdata(pdev, NULL);
 	msdc_deinit_hw(host);
+release_clk:
 	msdc_gate_clock(host);
+	platform_set_drvdata(pdev, NULL);
 release_mem:
 	if (host->dma.gpd)
 		dma_free_coherent(&pdev->dev,
-- 
2.46.0


Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815B642A8A;
	Mon, 11 Nov 2024 08:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731315052; cv=none; b=QceaftkjBXLKIlCMWHnmSEW103lmOt+hQvlbeDKTg7wbyEVCtE8YlOYZiD4QKYDe+KW8hwqxKqmkVGhiL4ECvkc2T8kov3mTftBIGPmtr1eJYwRi3EqmuhwpYVVsJvZwJ+cvl0N2b0JVnVLqGKfjGVLqYZWwsG/pv1EVRI2d9nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731315052; c=relaxed/simple;
	bh=HUVu5PzPWctsCfq0WgvE2365SU+hH9xVLEljiQJSADg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aeXQ6fBJK6JVYtCvNCOaAIDjmlVupbWTxf8nKuh+a4VsZdIJR8ytTF5ft1Hd7HSNBe1lLZl/BjhBhSOlK241GjkWk8bZuXco2pJpWpCLPmyaTciXqK7sxijYOOT/vTYBq55rt6RNK9eT7wWswkAshPmgcsmwCx4Rp0S2K0/+Jp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=QAmYd0nC; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="QAmYd0nC"
X-UUID: 08ed9a24a00a11efb88477ffae1fc7a5-20241111
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=5F4rAbapCjtRK+5E3cd9kMWPwT8eNM90FXJAZ2gUrmc=;
	b=QAmYd0nCfOuPJZe7seXjTcC0geKFkwYljm2hIcafUFXFoBnHsAAx6H7sW+8mLfd0BsHRP0Vkf8+FLH+G9kHpq3jRI5dXzoRwa+OLkPEYyAObDs3HQqvgC6UgHW5ibbdkblsUlukcRj7yy7To4P0k5UrThwZ0DoAsVhMc3DlAvh8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:fdaf42e2-9166-4f68-ae9e-1b2c4e8db7bf,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:b0fcdc3,CLOUDID:d8e7e206-6ce0-4172-9755-bd2287e50583,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:5,IP:nil,UR
	L:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:
	1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 08ed9a24a00a11efb88477ffae1fc7a5-20241111
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <andy-ld.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1010684209; Mon, 11 Nov 2024 16:50:43 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 11 Nov 2024 16:50:41 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 11 Nov 2024 16:50:41 +0800
From: Andy-ld Lu <andy-ld.lu@mediatek.com>
To: <angelogioacchino.delregno@collabora.com>, <matthias.bgg@gmail.com>,
	<ulf.hansson@linaro.org>, <wenbin.mei@mediatek.com>,
	<mengqi.zhang@mediatek.com>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	Andy-ld Lu <andy-ld.lu@mediatek.com>
Subject: [PATCH] mmc: mtk-sd: Fix MMC_CAP2_CRYPTO flag setting
Date: Mon, 11 Nov 2024 16:49:31 +0800
Message-ID: <20241111085039.26527-1-andy-ld.lu@mediatek.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Currently, the MMC_CAP2_CRYPTO flag is set by default for eMMC hosts.
However, this flag should not be set for hosts that do not support inline
encryption.

The 'crypto' clock, as described in the documentation, is used for data
encryption and decryption. Therefore, only hosts that are configured with
this 'crypto' clock should have the MMC_CAP2_CRYPTO flag set.

Fixes: 7b438d0377fb ("mmc: mtk-sd: add Inline Crypto Engine clock control")
Fixes: ed299eda8fbb ("mmc: mtk-sd: fix devm_clk_get_optional usage")
Signed-off-by: Andy-ld Lu <andy-ld.lu@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 022526a1f754..efb0d2d5716b 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -2907,7 +2907,8 @@ static int msdc_drv_probe(struct platform_device *pdev)
 		host->crypto_clk = devm_clk_get_optional(&pdev->dev, "crypto");
 		if (IS_ERR(host->crypto_clk))
 			return PTR_ERR(host->crypto_clk);
-		mmc->caps2 |= MMC_CAP2_CRYPTO;
+		else if (host->crypto_clk)
+			mmc->caps2 |= MMC_CAP2_CRYPTO;
 	}
 
 	host->irq = platform_get_irq(pdev, 0);
-- 
2.46.0


Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DDF17C2;
	Tue, 16 Jul 2024 01:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721093846; cv=none; b=Q43Ga5bDP91BpZYAsCltEy2rDuj1O0i4b7+/cjh4qTWkorF45o2YBGJdbv/VXCntYa9WMNNmS+wBkyoHSmfz64y/K2OXIkD5hJEggsPANbj1GwWZyd1OIvDCrmyCzzIO+WAadj7M1VzxIXQvUn8dK5pUM0hUDHF71da2FDFMNVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721093846; c=relaxed/simple;
	bh=q/n6ksZvJBJKfymbsjwlp7qF2wHA7VSx9k3YM3Da6yQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZXuV++y7C7yDpFkJEPKPgVPKZC/xswXw1eApqAu+nyQrfX6yQ/GuhirYA+hUn/ycdVXvlj9zPm3WUftWU1bRaps341xp2Z/EJbQFuoFXAaCUYe6brXRBSsx70e02jyX3y3vapwS3hqoK03E3bh2bEO1v3jM2KNYoUj9vdA9Byg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=nEO5P307; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="nEO5P307"
X-UUID: edcefd30431311ef87684b57767b52b1-20240716
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=ecczJKhQmZrvgk6AQTQATT11lmeJ+vbOQtxp2jxvHEM=;
	b=nEO5P307u69mZl6rmZ1EyoHzC45LoCh5rewn0HUlKAopIJK9jTgnLHGMrfAu+gPoDzw8ODlP2K9NnqoaEl8HR/ImIrSe67KQLVH0F7W9+t2IE1F0nnlGZCIw7RcgNU8ts9dP89Osgl1GoBI7ttGcKnmW+q1h0jxrpbCB6rdyLIc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.40,REQID:865add97-d7f6-4ec0-a40b-c8fa563a372b,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:ba885a6,CLOUDID:830085d1-436f-4604-ad9d-558fa44a3bbe,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: edcefd30431311ef87684b57767b52b1-20240716
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <mengqi.zhang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 458508838; Tue, 16 Jul 2024 09:37:14 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 16 Jul 2024 09:37:14 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 16 Jul 2024 09:37:14 +0800
From: Mengqi Zhang <mengqi.zhang@mediatek.com>
To: <ulf.hansson@linaro.org>, <chaotian.jing@mediatek.com>,
	<matthias.bgg@gmail.com>, <angelogioacchino.delregno@collabora.com>,
	<wenbin.mei@mediatek.com>
CC: <linux-mmc@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>, Mengqi
 Zhang <mengqi.zhang@mediatek.com>, <stable@vger.stable.com>
Subject: [v1, 1/1] mmc: mtk-sd: receive cmd8 data when hs400 tuning fail
Date: Tue, 16 Jul 2024 09:37:04 +0800
Message-ID: <20240716013704.10578-1-mengqi.zhang@mediatek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

When we use cmd8 as the tuning command in hs400 mode, the command
response sent back by some eMMC devices cannot be correctly sampled
by MTK eMMC controller at some weak sample timing. In this case,
command timeout error may occur. So we must receive the following
data to make sure the next cmd8 send correctly.

Signed-off-by: Mengqi Zhang <mengqi.zhang@mediatek.com>
Fixes: c4ac38c6539b ("mmc: mtk-sd: Add HS400 online tuning support")
Cc: stable@vger.stable.com
---
 drivers/mmc/host/mtk-sd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index a94835b8ab93..e386f78e3267 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -1230,7 +1230,7 @@ static bool msdc_cmd_done(struct msdc_host *host, int events,
 	}
 
 	if (!sbc_error && !(events & MSDC_INT_CMDRDY)) {
-		if (events & MSDC_INT_CMDTMO ||
+		if ((events & MSDC_INT_CMDTMO && !host->hs400_tuning) ||
 		    (!mmc_op_tuning(cmd->opcode) && !host->hs400_tuning))
 			/*
 			 * should not clear fifo/interrupt as the tune data
@@ -1323,9 +1323,9 @@ static void msdc_start_command(struct msdc_host *host,
 static void msdc_cmd_next(struct msdc_host *host,
 		struct mmc_request *mrq, struct mmc_command *cmd)
 {
-	if ((cmd->error &&
-	    !(cmd->error == -EILSEQ &&
-	      (mmc_op_tuning(cmd->opcode) || host->hs400_tuning))) ||
+	if ((cmd->error && !host->hs400_tuning &&
+	     !(cmd->error == -EILSEQ &&
+	     mmc_op_tuning(cmd->opcode))) ||
 	    (mrq->sbc && mrq->sbc->error))
 		msdc_request_done(host, mrq);
 	else if (cmd == mrq->sbc)
-- 
2.25.1


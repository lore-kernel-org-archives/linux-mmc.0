Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71255BAF0
	for <linux-mmc@vger.kernel.org>; Mon,  8 Apr 2024 10:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712572710; cv=none; b=urXagTNVv0JBx6B4FXikid94CgYUyVqRHFoMf/nEuTOLOgTWNGesWuxTRSQNBxFufFW/gxrHOo2mmVVYt1swjYvuAcqPN3aUawvHtSUHzNstCc7eQtgwBk5jA44DqLeH2vnXcVIbekL4O+r0qBKw+ZLI2RvPmXo5zolIy3s5Pao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712572710; c=relaxed/simple;
	bh=dUzHfeLBygLQWd+t47/7Q2hBIW6ugTjujS0nRAIPXbE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JQS+15WF/MpVH4QfGjHlUQgEeOq2l3xctjTDjh/+oToBIMdWWnEqvkYDCn0LeT0aOCXjJAyIhC0tV6/Li1Xzf24ZAUmn1TWgPzSpjau+7dou/6RfFNi8pISQRAAMGFBkDXPEI0W9W+l5sbu7z36H5kmQpLyE+2WhqLbfUL/BbGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Aj1C93UE; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Aj1C93UE"
X-UUID: 211a8740f59411ee935d6952f98a51a9-20240408
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=i1J16o8a/AiIgBIYW2eQoMmauzTJFPFFwzLx0A2U3Tk=;
	b=Aj1C93UEiaYW1mE5sUYIWNTAYZH/L/pom2J40XbGU/P8PwgvIaG5mekPUabISA+dicfrHAbuRUPT+LnQcTvIrtRkgzzPL4C0BJt0x2zNkMO4PZvJ1YKbSe4eyLdXxAZ6ZuD0sZWd+bCLkoqdXoh8NKJr1jeTJNsf5S97RL2hqt0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:941042fc-bf9d-4fa4-87f5-f981b4ae3aa5,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6f543d0,CLOUDID:7257d000-c26b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 211a8740f59411ee935d6952f98a51a9-20240408
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <joe.zhou@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1025582333; Mon, 08 Apr 2024 18:38:25 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 8 Apr 2024 18:38:20 +0800
Received: from mbjsdccf07.gcn.mediatek.inc (10.15.20.246) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 8 Apr 2024 18:38:19 +0800
From: Joe.Zhou <Joe.Zhou@mediatek.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: <linux-mmc@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	<wsd_upstream@mediatek.com>, "Peng . Zhou" <Peng.Zhou@mediatek.com>, "Sophie
 . Wang" <Sophie.Wang@mediatek.com>, "Wey . Zhang" <Wey.Zhang@mediatek.com>,
	"Yijian . Jia" <yijian.jia@mediatek.com>, "Sharp . Xia"
	<Sharp.Xia@mediatek.com>, Joe.Zhou <Joe.Zhou@mediatek.com>
Subject: [PATCH] mmc: race condition between "sdcard hot plug out" and "system reboot"
Date: Mon, 8 Apr 2024 18:38:24 +0800
Message-ID: <20240408103824.11476-1-Joe.Zhou@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--5.893800-8.000000
X-TMASE-MatchedRID: 4dLm6kicgxWvVT6bfkFW/ocU/ASc4KydJD5ItWH4fSKUvX/ci5TjsqP6
	lEvEjaSAqvr4KXCXxhMNdZsOPCvd7LuIV2AVynTksyNb+yeIRAohpWQUitAWG5kd+ko3Vgxl8U1
	60P1TrZB8lDLz8Vr1zLZMGUUyuIF5lwV2iaAfSWcURSScn+QSXt0H8LFZNFG7hqz53n/yPnql9x
	whgVpyoZb6UV+Zy7/DoltnS9/+IyJOSSqBsK+S9FbhgBx8Hi7b
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--5.893800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 9C3F4986530E6E5EA6FD323329A355320D03813A4A33CF50CA99282926EAA13D2000:8

In mmc driver, a race condition may occur between "sdcard hot plug out" and "system reboot".
How it happen?

sdcard hot pulg out:                SyS_reboot:
CPU0                               CPU1
mmc_sd_detect()                    _mmc_sd_suspend
{                                  {

......
#Step1: detect SD card removed
if (err) {                          ......
    #Step2: host->card is NULL
    mmc_sd_remove(host);
                                    #Step3:_mmc_sd_suspend claimed host
                                    mmc_claim_host(host);
                                    #Step4: use host->card(NULL pointer)
                                    if (mmc_card_suspended(host->card))
                                    ......
                                    }
    mmc_claim_host(host);
    mmc_detach_bus(host);
 }
 ......
 }
we can prevent it occuring by add claim for "host->card = NULL" and add "host->card" validity check in mmc_sd_suspend.

Signed-off-by: Joe.Zhou <Joe.Zhou@mediatek.com>
---
 drivers/mmc/core/sd.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 1c8148cdda50..38c0b271283a 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1593,7 +1593,9 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 static void mmc_sd_remove(struct mmc_host *host)
 {
 	mmc_remove_card(host->card);
+	mmc_claim_host(host);
 	host->card = NULL;
+	mmc_release_host(host);
 }
 
 /*
@@ -1702,18 +1704,19 @@ static int _mmc_sd_suspend(struct mmc_host *host)
 	int err = 0;
 
 	mmc_claim_host(host);
+	if (host->card) {
+		if (mmc_card_suspended(card))
+			goto out;
 
-	if (mmc_card_suspended(card))
-		goto out;
-
-	if (sd_can_poweroff_notify(card))
-		err = sd_poweroff_notify(card);
-	else if (!mmc_host_is_spi(host))
-		err = mmc_deselect_cards(host);
+		if (sd_can_poweroff_notify(card))
+			err = sd_poweroff_notify(card);
+		else if (!mmc_host_is_spi(host))
+			err = mmc_deselect_cards(host);
 
-	if (!err) {
-		mmc_power_off(host);
-		mmc_card_set_suspended(card);
+		if (!err) {
+			mmc_power_off(host);
+			mmc_card_set_suspended(card);
+		}
 	}
 
 out:
@@ -1729,7 +1732,7 @@ static int mmc_sd_suspend(struct mmc_host *host)
 	int err;
 
 	err = _mmc_sd_suspend(host);
-	if (!err) {
+	if (!err && host->card) {
 		pm_runtime_disable(&host->card->dev);
 		pm_runtime_set_suspended(&host->card->dev);
 	}
-- 
2.18.0


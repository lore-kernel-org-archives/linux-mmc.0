Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A38344DBD;
	Tue,  4 Aug 2026 01:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785807626; cv=none; b=ZoHgQGOW4/G0ryrKXvN9K6Tt6fMHZM0fKWr9VTK75oj59WUdN/55AehkDKwZGFSE90UI33ilrVvQfJGFzDGxG6EhSVaoybD/zcZbrIxkN4PNxu+FZIxmnemfB2OrU42T+PKzj4DT0/ZHYsF7IQH4Y0z/S/kvr0LHaKLZ/Z/XDEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785807626; c=relaxed/simple;
	bh=86YNWpTr5H2BVX5nBmndArnt6BVDTCQ48ruQpGq9GbA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J15JLu2DBR5klqXHJ3Jt7dE23vz7snoddufYA6po7eGcJcgkHN2inwoDdZ7Pp93YwT7EKQZWok2A6SlhoN4nYeWo/tTPNt4Iv0GaOoN+v5ikF3/s9paV6DLhmWyI/wFrPK29n4udlyI+IWGmmU6kmSJzRQVagDzp5mNBY5mtm8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 739b580c8fa511f1aa26b74ffac11d73-20260804
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:da68e7c7-64e4-420f-b145-637a34dede29,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:e7bac3a,CLOUDID:8d14d71818f1a3ad32b09e14a023bca4,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
	0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 739b580c8fa511f1aa26b74ffac11d73-20260804
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1555632735; Tue, 04 Aug 2026 09:40:19 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: ulfh@kernel.org,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH] mmc: via-sdmmc: Fix use-after-free in via_sd_remove due to race condition
Date: Tue,  4 Aug 2026 09:40:15 +0800
Message-Id: <94dac731cadea4732725a83bbbe1d8fe47636694.1785807411.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In via_init_mmc_host, &sdhost->carddet_work is bound with
via_sdc_card_detect, and via_sdc_isr can schedule this work on
system_wq when it handles a card insertion/removal interrupt.

If we remove the device, via_sd_remove makes cleanup and the memory
allocated for sdhost with devm_mmc_alloc_host() is released after the
remove callback returns, while the work mentioned above may still be
pending or running. The sequence of operations that may lead to a UAF
bug is as follows:

CPU0                                      CPU1

                                          | via_sdc_isr
                                          | schedule_work(&sdhost->carddet_work)
via_sd_remove                             |
mmc_remove_host(sdhost->mmc)              |
free_irq(pcidev->irq, sdhost)             |
timer_delete_sync(&sdhost->timer)         |
cancel_work_sync(&sdhost->finish_bh_work) |
                                          | via_sdc_card_detect
                                          | // use sdhost
// devm resources released after          |
// remove returns, sdhost is freed        |
                                          | // use sdhost (use-after-free)

Fix it by canceling the work after the IRQ handler that can schedule
it has been stopped, and before proceeding with the remaining cleanup
in via_sd_remove.

Fixes: f0bf7f61b840 ("mmc: Add new via-sdmmc host controller driver")
Assisted-by: Codex:deepseek-v4-flash
Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
 drivers/mmc/host/via-sdmmc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/via-sdmmc.c b/drivers/mmc/host/via-sdmmc.c
index 8c049f8355cd..be90fc767c74 100644
--- a/drivers/mmc/host/via-sdmmc.c
+++ b/drivers/mmc/host/via-sdmmc.c
@@ -1199,6 +1199,8 @@ static void via_sd_remove(struct pci_dev *pcidev)
 
 	free_irq(pcidev->irq, sdhost);
 
+	cancel_work_sync(&sdhost->carddet_work);
+
 	timer_delete_sync(&sdhost->timer);
 
 	cancel_work_sync(&sdhost->finish_bh_work);
-- 
2.25.1


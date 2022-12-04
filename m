Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125D4C4332F
	for <linux-mmc@archiver.kernel.org>; Sun,  4 Dec 2022 08:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiLDI1J (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 4 Dec 2022 03:27:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiLDI1I (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 4 Dec 2022 03:27:08 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737F4164BE
        for <linux-mmc@vger.kernel.org>; Sun,  4 Dec 2022 00:27:03 -0800 (PST)
X-UUID: e9db85f1f2084fb7a2180dea785bcf3c-20221204
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=4HfwTMVIfqnxQeM/flMEBiTJlOTdLbyktmNQbCgMZLs=;
        b=KWZ2wqBa3EvUKgBWo36d7HzBXuTCUjpkcwnzza3H7hu6U1v7EhrypWe3sHLq9RMel/LpxC3bN5FD9zKNk5+XunhCw+mhGjZqGcsBNzWSrKw8bK35Gt0UZZ7Nm3MiKazDwqKpCW5O44Vyhye594LqO8f5DeLZT8qr1qRlr6kUQew=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:1f677957-7dda-4cef-887e-eb7d492e9283,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.14,REQID:1f677957-7dda-4cef-887e-eb7d492e9283,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:dcaaed0,CLOUDID:4dab7b6c-41fe-47b6-8eb4-ec192dedaf7d,B
        ulkID:2212041626595PUUM0F0,BulkQuantity:0,Recheck:0,SF:28|17|19|48,TC:nil,
        Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: e9db85f1f2084fb7a2180dea785bcf3c-20221204
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1635992941; Sun, 04 Dec 2022 16:26:57 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Sun, 4 Dec 2022 16:26:55 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Sun, 4 Dec 2022 16:26:55 +0800
From:   Deren Wu <deren.wu@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     linux-mmc <linux-mmc@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH] mmc: vub300: fix warning - do not call blocking ops when !TASK_RUNNING
Date:   Sun, 4 Dec 2022 16:24:16 +0800
Message-ID: <87dc45b122d26d63c80532976813c9365d7160b3.1670140888.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

vub300_enable_sdio_irq() works with mutex and need TASK_RUNNING here.
Ensure that we mark current as TASK_RUNNING for sleepable context.

[   77.554641] do not call blocking ops when !TASK_RUNNING; state=1 set at [<ffffffff92a72c1d>] sdio_irq_thread+0x17d/0x5b0
[   77.554652] WARNING: CPU: 2 PID: 1983 at kernel/sched/core.c:9813 __might_sleep+0x116/0x160
[   77.554905] CPU: 2 PID: 1983 Comm: ksdioirqd/mmc1 Tainted: G           OE      6.1.0-rc5 #1
[   77.554910] Hardware name: Intel(R) Client Systems NUC8i7BEH/NUC8BEB, BIOS BECFL357.86A.0081.2020.0504.1834 05/04/2020
[   77.554912] RIP: 0010:__might_sleep+0x116/0x160
[   77.554920] RSP: 0018:ffff888107b7fdb8 EFLAGS: 00010282
[   77.554923] RAX: 0000000000000000 RBX: ffff888118c1b740 RCX: 0000000000000000
[   77.554926] RDX: 0000000000000001 RSI: 0000000000000004 RDI: ffffed1020f6ffa9
[   77.554928] RBP: ffff888107b7fde0 R08: 0000000000000001 R09: ffffed1043ea60ba
[   77.554930] R10: ffff88821f5305cb R11: ffffed1043ea60b9 R12: ffffffff93aa3a60
[   77.554932] R13: 000000000000011b R14: 7fffffffffffffff R15: ffffffffc0558660
[   77.554934] FS:  0000000000000000(0000) GS:ffff88821f500000(0000) knlGS:0000000000000000
[   77.554937] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   77.554939] CR2: 00007f8a44010d68 CR3: 000000024421a003 CR4: 00000000003706e0
[   77.554942] Call Trace:
[   77.554944]  <TASK>
[   77.554952]  mutex_lock+0x78/0xf0
[   77.554973]  vub300_enable_sdio_irq+0x103/0x3c0 [vub300]
[   77.554981]  sdio_irq_thread+0x25c/0x5b0
[   77.555006]  kthread+0x2b8/0x370
[   77.555017]  ret_from_fork+0x1f/0x30
[   77.555023]  </TASK>
[   77.555025] ---[ end trace 0000000000000000 ]---

Fixes: 88095e7b473a ("mmc: Add new VUB300 USB-to-SD/SDIO/MMC driver")
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 drivers/mmc/host/vub300.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
index 97beece62fec..b58a1a869ed8 100644
--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -2049,6 +2049,7 @@ static void vub300_enable_sdio_irq(struct mmc_host *mmc, int enable)
 		return;
 	kref_get(&vub300->kref);
 	if (enable) {
+		set_current_state(TASK_RUNNING);
 		mutex_lock(&vub300->irq_mutex);
 		if (vub300->irqs_queued) {
 			vub300->irqs_queued -= 1;
@@ -2064,6 +2065,7 @@ static void vub300_enable_sdio_irq(struct mmc_host *mmc, int enable)
 			vub300_queue_poll_work(vub300, 0);
 		}
 		mutex_unlock(&vub300->irq_mutex);
+		set_current_state(TASK_INTERRUPTIBLE);
 	} else {
 		vub300->irq_enabled = 0;
 	}
-- 
2.18.0

